#!perl

use strict;
use warnings;
use v5.10;

use IO::Handle;
use File::Copy;
use WWW::Mechanize;
use HTML::TreeBuilder;

die "perl get_ebl.pl" unless $#ARGV == -1;

my $PLAYER_FIRST = 222112;
my $PLAYER_LAST = 230000;

my $sprefix = "http://db.eurobridge.org/Repository/scripts/person.asp";
my $outdir = "ebl/";

my $output_file = "ebl.txt"; # Is appended
my $output_bak = "ebl.bak";

my $tournament_file = "ebf_tournaments.txt"; # Is appended
my $tournament_bak = "ebf_tournaments.bak";


# Player file.

my $fp;
if (-e $output_file)
{
  copy($output_file, $output_bak) or die "File copy failed: $!";
  open $fp, '>>', $output_file or die
    "Cannot open $output_file for appending: $!";
}
else
{
  open $fp, '>', $output_file or die
    "Cannot open $output_file for appending: $!";
}


# Tournament file.

my $ft;
my @tournaments;
if (-e $tournament_file)
{
  copy($tournament_file, $tournament_bak) or die "File copy failed: $!";

  read_tournaments($tournament_file, \@tournaments, $ft);

  open $ft, '>>', $tournament_file or die
    "Cannot open $tournament_file for appending: $!";
}
else
{
  open $ft, '>', $tournament_file or die
    "Cannot open $tournament_file for appending: $!";
}


my $mech = WWW::Mechanize->new();
  
$mech->cookie_jar(HTTP::Cookies->new());
$mech->get('http://www.eurobridge.org/person/?qryid=1132');

$mech->agent('Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0');
$mech->add_header('Accept-Language' => 'en-US,en;q=0.5');
$mech->add_header('Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8');
$mech->add_header('User-Agent' => 'Mozilla/5.0');
$mech->add_header('Referer' => 'http://db.eurobridge.org/Repository/scripts/person.asp?qryid=1132');

my %form_data = ( 
  qsortadmin => '1', 
  qshowcontrol => '---11------' );

my $missing_tourn_no;
if ($#tournaments > 10000)
{
  $missing_tourn_no = $#tournaments + 1;
}
else
{
  # Should be higher than the highest one in use.
  $missing_tourn_no = 10000;
}

for my $pno ($PLAYER_FIRST .. $PLAYER_LAST)
{
  say "Player $pno";

  $form_data{qryid} = $pno;
  $mech->post($sprefix, \%form_data);
  if (! $mech->success)
  {
    print "Player probably does not exist\n";
    next;
  }

  my $tree = HTML::TreeBuilder->new_from_content($mech->content);

  # Find the specific <form> element
  my $form = $tree->look_down(
      "_tag", "form",
      "action", "person.asp",
      "name", "controlfrm"
  );

  die "Form not found" unless $form;

  my %player;
  $player{ebl} = $pno;

  if (! get_player($form, \%player))
  {
    print "Player is probably empty\n";
    next;
  }

  print_player($fp, \%player);

  if ($player{gender} eq '?')
  {
    # Probably no playing record
    print $fp "\n";
    sleep(3);
    next;
  }

  my @played;
  get_tournament_info($ft, $form, \@played, \@tournaments,
    \$missing_tourn_no);
  print_played($fp, \@played, \@tournaments);

  sleep(5);
}

close $fp;
close $ft;

exit;


sub get_player
{
  my ($form, $player_ref) = @_;

  # First <h3> element within the form
  my $name_pos = $form->look_down("_tag", "h3") or return 0;

  get_name($name_pos, $player_ref);

  # First <div> with class "col-md-12"
  my $id_pos = $form->look_down("_tag", "div", "class", qr/col-md-12/)
    or die "No leading table";

  get_id($id_pos, $player_ref);

  my @sub_tables = $id_pos->look_down("_tag", "table");

  if ($#sub_tables >= 1)
  {
    get_gender($sub_tables[1], $player_ref);
  }
  else
  {
    # Probably no playing record.
    $player_ref->{gender} = '?';
  }

  return 1;
}


sub get_tournament_info
{
  my ($ft, $form, $played_ref, $tourn_ref, $missing_no_ref) = @_;

  # Two <table>'s with class "table-edit"
  my @tables = $form->look_down("_tag", "table", "class", qr/table-edit/);

  my @headings = $form->look_down("_tag", "th", 
    sub { $_[0]->look_down("_tag", "img", "onclick", qr/.+/) } );
  my @head_texts = map {$_->as_text } @headings;

  die "Mismatch" unless $#tables == $#head_texts;

  my $team_index = -1;
  my $pair_index = -1;
  for my $i (0 .. $#head_texts)
  {
    if ($head_texts[$i] =~ /Playing Record \(Team Events\)/i)
    {
      $team_index = $i;
    }
    elsif ($head_texts[$i] =~ /Playing Record \(Pairs or Individual Events\)/i)
    {
      $pair_index = $i;
    }
  }

  if ($team_index == -1 && $pair_index == -1)
  {
    return;
  }

  if ($team_index != -1)
  {
    get_played($ft, $tables[$team_index], $played_ref, $tourn_ref,
      $missing_no_ref);
  }

  if ($pair_index != -1)
  {
    get_played($ft, $tables[$pair_index], $played_ref, $tourn_ref,
      $missing_no_ref);
  }
}


sub get_name
{
  my ($pos, $player_ref) = @_;
  $player_ref->{name} = $pos->as_text;
}


sub get_id
{
  my ($pos, $player_ref) = @_;

  my $counter = 0; 
  foreach my $td ($pos->look_down("_tag", "div", "class", qr/col-md-6/)) 
  {
    if ($counter == 1)
    {
      my $country = $td->as_text;
      $country =~ s/\x{A0}//g; # &nbsp
      $player_ref->{country} = $country;
    }
    elsif ($counter == 3)
    {
      $player_ref->{wbf_code} = $td->as_text;
    }
    $counter++;
    return if $counter == 4;
  }
}


sub get_gender
{
  my ($pos, $player_ref) = @_;

  foreach my $td ($pos->look_down("_tag", "td")) 
  {
    if ($td->as_text =~ /Women/i)
    {
      $player_ref->{gender} = 'F';
      return;
    }
  }
  $player_ref->{gender} = 'M';
}


sub parse_tournament_name
{
  my ($a_tag, $name_ref, $location_ref, $type_ref) = @_;

  # If we don't preserve the newline, the text
  # becomes harder to parse.
  my $html_with_newlines = $a_tag->as_HTML;
  $html_with_newlines =~ s/<br ?\/?>/\|/gi;

  my $new_tree = HTML::TreeBuilder->new;
  $new_tree->parse_content($html_with_newlines);
  my $text = $new_tree->as_text;
  
  my @lines = split /\|/, $text;
  $$name_ref = $lines[0];

  if ($lines[1] =~ /(.*) \d\d\d\d - (.*)/)
  {
    $$location_ref = $1;
    $$type_ref = $2;
  }
  elsif ($lines[1] =~ /(.*) - (.*)/)
  {
    $$location_ref = "";
    $$type_ref = $2;
  }
  else
  {
    die "Could not get location-like field";
  }

}


sub parse_info
{
  my ($pos, $info_ref) = @_;

  # If we don't preserve the newline, the text
  # becomes harder to parse.
  my $html_with_newlines = $pos->as_HTML;
  $html_with_newlines =~ s/<br ?\/?>/\|/gi;

  my $new_tree = HTML::TreeBuilder->new;
  $new_tree->parse_content($html_with_newlines);
  my $text = $new_tree->as_text;
  
  my @lines = split /\|/, $text;
  $$info_ref = $lines[0];
  $$info_ref =~ s/\x{A0}/ /g; # &nbsp
  $$info_ref =~ s/^\s+|\s+$//g;
}


sub get_played
{
  my ($ft, $table, $player_ref, $tournaments_ref, $missing_no_ref) = @_;

  my $row = 1 + $#$player_ref;
  my $counter = 0;
  
  my @info;

  foreach my $td ($table->look_down("_tag", "td")) 
  {
    my $mod = $counter % 4;

    if ($mod == 1)
    {
       # The tournament name and link.
       my $a_tag = $td->look_down("_tag", "a");
       my ($name, $location, $type, $index);
       if ($a_tag)
       {
         my $link = $a_tag->attr('href');
         $link =~ /qtournid=(\d+)/;
         $index = $1;

         parse_tournament_name($a_tag, \$name, \$location, \$type);
       }
       else
       {
         # This is a kludge, as the tournament may well be present
         # as an "un-numbered" entry.  Here we just add it, and we
         # deal with it later in a separate script that renumbers
         # these tournaments.
         $index = $$missing_no_ref;
         $$missing_no_ref++;
         print "Warning: Missing tournament link\n";

         parse_tournament_name($td, \$name, \$location, \$type);
       }

       $info[1] = $name;
       $info[4] = $location;
       $info[5] = $index;
    }
    elsif ($mod == 3)
    {
      # For teams: Team name
      # For pairs: Partner name
      my $info;
      parse_info($td, \$info);
      $info[3] = $info;
    }
    else
    {
      # If we don't preserve the newline, the text
      # becomes harder to parse.
      my $html_with_newlines = $td->as_HTML;
      $html_with_newlines =~ s/<br ?\/?>/\n/gi;

      my $new_tree = HTML::TreeBuilder->new;
      $new_tree->parse_content($html_with_newlines);
      $info[$mod] = $new_tree->as_text;
    }


    $counter++;

    if ($mod == 3)
    {
      my $index = $info[5];

      $player_ref->[$row]{index} = $index;
      $player_ref->[$row]{position} = $info[2];
      $player_ref->[$row]{info} = $info[3];

      if (defined $tournaments_ref->[$index])
      {
         die "Year mismatch\n"
           if ($tournaments_ref->[$index]{year} ne $info[0]);
         die "Name mismatch\n"
           if ($tournaments_ref->[$index]{name} ne $info[1]);
         die "Location mismatch\n"
           if ($tournaments_ref->[$index]{location} ne $info[4]);
      }
      else
      {
        $tournaments_ref->[$index]{year} = $info[0];
        $tournaments_ref->[$index]{name} = $info[1];
        $tournaments_ref->[$index]{location} = $info[4];

        printf $ft ("TOURNAMENT %d|%d|%s|%s\n",
          $index, 
          $tournaments_ref->[$index]{year},
          $tournaments_ref->[$index]{location},
          $tournaments_ref->[$index]{name});
        
        $ft->flush or die "Could not flush filehandle: $!";
      }

      @info = ();
      $row++;
    }
  }
}


sub print_tournaments
{
  my ($fh, $tourn_ref) = @_;

  for my $index (0 .. $#$tourn_ref)
  {
    next unless defined $tourn_ref->[$index];

    printf $fh ("TOURNAMENT %d|%d|%s\n",
      $index, 
      $tourn_ref->[$index]{year},
      $tourn_ref->[$index]{name});
  }

  $fh->flush or die "Could not flush filehandle: $!";
}


sub print_played
{
  my ($fp, $played_ref, $tourn_ref) = @_;

  for my $row (@$played_ref)
  {
    my $index = $row->{index};
    printf $fp ("TOURNAMENT %d|%d|%s\n",
      $index,
      $tourn_ref->[$index]{year},
      $row->{info});
  }
  print $fp "\n";
}


sub read_tournaments
{
  my($tournament_file, $tref) = @_;

  open my $ft, '<', $tournament_file or 
    die "Can't open $tournament_file for reading: $!";

  my $line;
  while ($line = <$ft>)
  {
    chomp $line;
    next unless $line =~ /^TOURNAMENT (.*)$/;

    my @elements = split /\|/, $1;
    die "Need 4 elements" unless $#elements == 3;

    $tref->[$elements[0]]{year} = $elements[1];
    $tref->[$elements[0]]{location} = $elements[2];
    $tref->[$elements[0]]{name} = $elements[3];
  }
    
  close $ft;
}


sub print_player
{
  my ($fh, $player_ref,) = @_;

  print $fh "NAME $player_ref->{name}\n";
  print $fh "COUNTRY $player_ref->{country}\n";
  print $fh "EBL $player_ref->{ebl}\n";
  print $fh "WBF $player_ref->{wbf_code}\n";
  print $fh "GENDER $player_ref->{gender}\n";
}

