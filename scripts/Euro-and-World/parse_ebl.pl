#!perl

use strict;
use warnings;
use v5.10;

use IO::Handle;
use File::Copy;
use File::Fetch;
use WWW::Mechanize;
use HTML::TreeBuilder;

die "perl get_ebl.pl" unless $#ARGV == -1;

my $mech = WWW::Mechanize->new();

open my $ff, '<', 'ebl/Versace.html' or die "Can't read";
my $html = join('', <$ff>);
close $ff;

$mech->update_html($html);
my $tree = HTML::TreeBuilder->new_from_content($mech->content);

# Find the specific <form> element
my $form = $tree->look_down(
    "_tag", "form",
    "action", "person.asp",
    "name", "controlfrm"
);

die "Form not found" unless $form;

my %player;
get_player($form, \%player);
print_player(\*STDOUT, \%player);

my (@played, @tournaments);
get_tournament_info($form, \@played, \@tournaments);
print_played(\*STDOUT, \@played, \@tournaments);
print_tournaments(\*STDOUT, \@tournaments);


sub get_player
{
  my ($form, $player_ref) = @_;

  # First <h3> element within the form
  my $name_pos = $form->look_down("_tag", "h3") or die "No name";
  get_name($name_pos, $player_ref);

  # First <div> with class "col-md-12"
  my $id_pos = $form->look_down("_tag", "div", "class", qr/col-md-12/)
    or die "No leading table";

  get_id($id_pos, $player_ref);

  my @sub_tables = $id_pos->look_down("_tag", "table");

  get_gender($sub_tables[1], $player_ref);
}


sub get_tournament_info
{
  my ($form, $played_ref, $tourn_ref) = @_;

  # Two <table>'s with class "table-edit"
  my @tables = $form->look_down("_tag", "table", "class", qr/table-edit/);
  die "No table 1" unless $tables[0];
  die "No table 2" unless $tables[1];

  get_played($tables[0], $played_ref, $tourn_ref);
  get_played($tables[1], $played_ref, $tourn_ref);
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

  $lines[1] =~ /(.*) \d\d\d\d - (.*)/;
  $$location_ref = $1;
  $$type_ref = $2;
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
  my ($table, $player_ref, $tournaments_ref) = @_;

  my $counter = 1 + $#$player_ref;
  my $row = 0;
  
  my @info;

  foreach my $td ($table->look_down("_tag", "td")) 
  {
    my $mod = $counter % 4;

    if ($mod == 1)
    {
       # The tournament name and link.
       my $a_tag = $td->look_down("_tag", "a");
       die "No link" unless $a_tag;

       my $link = $a_tag->attr('href');
       $link =~ /qtournid=(\d+)/;
       my $index = $1;

       my ($name, $location, $type);
       parse_tournament_name($a_tag,
         \$name, \$location, \$type);

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
      }

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
}


sub print_played
{
  my ($fh, $played_ref, $tourn_ref) = @_;

  for my $row (@$played_ref)
  {
    my $index = $row->{index};
    printf $fh ("TOURNAMENT %d|%d|%s\n",
      $index,
      $tourn_ref->[$index]{year},
      $row->{info});
  }
  print $fh "\n";
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
    die "Need 3 elements" unless $#elements == 2;

    $tref->[$elements[0]]{year} = $elements[1];
    $tref->[$elements[0]]{name} = $elements[2];
  }
    
  close $ft;
}


sub print_player
{
  my ($fh, $player_ref,) = @_;

  print $fh "NAME $player_ref->{name}\n";
  print $fh "COUNTRY $player_ref->{country}\n";
  print $fh "WBF $player_ref->{wbf_code}\n";
  print $fh "GENDER $player_ref->{gender}\n";
}

