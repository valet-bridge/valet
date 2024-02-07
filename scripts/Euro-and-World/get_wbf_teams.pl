#!perl

use strict;
use warnings;
use v5.10;

use IO::Handle;
use File::Copy;
use File::Fetch;
use HTML::TreeBuilder;

die "perl get_wbf_teams.pl" unless $#ARGV == -1;

my $TOURN_FIRST = 2393;
my $TOURN_LAST = 2393;

my $sprefix = "http://www.worldbridge.org/teamchampRPperson/?qtournid=";
my $outdir = "wbf_teams/";

my $teamprefix = "http://www.worldbridge.org/TeamChampMembers/" .
  '?qteamid=XXX&qmenudetid=YYY';

my $output_file = "wteamsnew.txt"; # Is appended
my $output_bak = "wpteamsnew.bak";

# Where the fetch ends up.
my $fetched = 'wbf_teams/file_default';


# Tournament numbers to try.

my $number_file = 'database/names/wbf/manual/teams.txt';

my @tournaments;
read_tourn_numbers($number_file, \@tournaments);


# Tournament file.

my $fh;
if (-e $output_file)
{
  copy($output_file, $output_bak) or die "File copy failed: $!";

  open $fh, '>>', $output_file or die
    "Cannot open $output_file for appending: $!";
}
else
{
  open $fh, '>', $output_file or die
    "Cannot open $output_file for appending: $!";
}


for my $tno (sort @tournaments)
{
  next unless $tno >= $TOURN_FIRST && $tno <= $TOURN_LAST;

  my $url = $sprefix . $tno;
  say "Tournament $tno, $url";

  my $ff = File::Fetch->new(uri => $url); 
  my $where = $ff->fetch(to => $outdir) or next;

  my $tree = HTML::TreeBuilder->new;
  $tree->parse_file($where);

  # print $tree->as_HTML('<>&', "  ", {});
  # exit;

  # my $tree = HTML::TreeBuilder->new;
  # $tree->parse_file($fetched);

  # print $tree->as_HTML('<>&', "  ", {});
  # exit;

  my $table = navigate_to_table($tree);

  my %header;
  if (! get_header($table, \%header))
  {
    say "No header";
    next;
  }

  print $fh "TITLE $header{title}\n";
  print $fh "ID $tno\n";
  print $fh "DETAILS $header{details}\n\n";

  my @team_numbers;
  get_team_numbers($tree, \@team_numbers);

  print "Number of teams: ", $#team_numbers, "\n";

  for my $entry (@team_numbers)
  {
    my $team_no = $entry->{teamid};
    my $menu_no = $entry->{menuid};

    my (@team, $name, $restriction);
    get_team($team_no, $menu_no, \@team, \$name, \$restriction);
    print_team($fh, \@team, $name, $restriction);

  }

  sleep(4);
}

close $fh;

exit;


sub navigate_to_table
{
  my $tree = pop;

  # Find the specific table
  my $table = $tree->look_down(
    _tag => 'table', 
    cellspacing => "5");
  die "No table" unless $table;
  return $table;
}


sub get_header
{
  my ($table, $header_ref) = @_;

  my $title = $table->look_down(
    _tag => 'span',
    class => qr/titleLevel2/);
  die "No title" unless $title;
  $header_ref->{title} = $title->as_text;
  $header_ref->{title} =~ s/^\s+|\s+$//g;

  my $details = $table->look_down(
    _tag => 'span',
    class => qr/titleLevel3/);
  die "No title details" unless $details;
  $header_ref->{details} = $details->as_text;
  $header_ref->{details} =~ s/^\s+|\s+$//g;
}


sub parse_qryid
{
  my ($td, $pref, $qref) = @_;

  my $a_tag = $td->look_down(_tag => 'a');
  return 0 unless $a_tag;

  my $player = $td->as_text;

  my $pid;
  return 0 unless ($pid) = $a_tag->attr('href') =~ /qryid=(\d+)/;
  
  $$pref = $player;
  $$qref = $pid;
  return 1;
}


sub parse_countries
{
  my ($td, $ctr1_ref, $ctr2_ref) = @_;

  my $text = $td->as_text;
  my @a = split /-/, $text;
  return 0 unless $#a == 1;

  $$ctr1_ref = $a[0];
  $$ctr2_ref = $a[1];
  return 1;
}


sub get_team_numbers
{
  my ($table, $team_numbers_ref) = @_;

  my $content = $table->look_down(
    _tag => 'table', 
    cellspacing => "6");

  return 0 unless $content;

  my @rows = $table->look_down(_tag => 'tr');

  my @team_list;

  for my $row (@rows)
  {
    my @tds = $row->look_down(_tag => 'td');

    for my $td (@tds)
    {
      my $a_tag = $td->look_down(_tag => 'a');
      next unless $a_tag;

      my $pid;
      next unless ($pid) = $a_tag->attr('href') =~ /qteamid=(\d+)/;

      my $detid;
      next unless ($detid) = $a_tag->attr('href') =~ /qmenudetid=(\d+)/;

      $team_list[$pid] = $detid;
    }
  }

  for my $i (0 .. $#team_list)
  {
    push @$team_numbers_ref, { teamid => $i, menuid => $team_list[$i] }
        if defined $team_list[$i];
  }

  return 1;
}


sub get_team
{
  my ($team_no, $menu_no, $team_ref, $name_ref, $restriction_ref) = @_;

  my $url = $teamprefix;
  $url =~ s/XXX/$team_no/;
  $url =~ s/YYY/$menu_no/;

  # say "  Team $team_no, $url";
  say "  Team $team_no";

# if ($team_no != 1351)
# {
  # print "Skipping\n";
  # return;
# }

  my $ff = File::Fetch->new(uri => $url); 
  my $where = $ff->fetch(to => $outdir) or next;

  my $tree = HTML::TreeBuilder->new;
  $tree->parse_file($where);

  # print $tree->as_HTML('<>&', "  ", {});
  # exit;

  my $table = $tree->look_down(_tag => 'table', id => 'champlist');
  return 0 unless $table;


  # Get name and series

  my @name_header = $table->look_down(
    _tag => 'td',
    class => 'page-titleLevel2');

  return 0 unless $#name_header >= 0;

  $$name_ref = $name_header[0]->as_text;
  $$name_ref =~ s/^\s+|\s+$//;

  my @headers = $table->look_down(
    _tag => 'td',
    class => 'rtext-TextLevelB');

  return 0 unless $#headers >= 1;

  $$restriction_ref = $headers[1]->as_text;
  $$restriction_ref =~ s/^\s+|\s+$//;


  # Get players

  my @rows = $table->look_down(_tag => 'tr');
   
  for my $row (@rows)
  {
    my @tds = $row->look_down(_tag => 'td');
# print "Entering, $#tds\n";
    next unless ($#tds == 1 || $#tds == 2); # Could have flag as #0

    my $start = 0;
    my $a_tag = $tds[0]->look_down(_tag => 'a');
    if (! $a_tag)
    {
      # Try to skip over #0, perhaps a flag.
      $a_tag = $tds[1]->look_down(_tag => 'a');
      $start = 1;
    }
    next unless $a_tag;
# print "Still here\n";

    my $pid;
    next unless ($pid) = $a_tag->attr('href') =~ /qryid=(\d+)/;

    my $name = $tds[$start]->as_text;

    my $function = $tds[$start+1]->as_text;

# print "Pushing $name, $pid, $function\n";
    push @$team_ref, {
      player => $name,
      pid => $pid,
      function => $function
    };
  }

  return 1;
}


sub print_team
{
  my ($fh, $pref, $name, $restriction) = @_;
  
  print $fh "NAME $name\n";
  print $fh "RESTRICTION $restriction\n";

  for my $pno (0 .. $#$pref)
  {
    my $player = $pref->[$pno];

    print $fh "PLAYER$pno $player->{player}\n";
    print $fh "ID$pno $player->{pid}\n";
    print $fh "FUNCTION$pno $player->{function}\n";
  }
  print $fh "\n";
}


sub read_tourn_numbers
{
  my ($number_file, $tref) = @_;

  open my $ft, '<', $number_file or die "Cannot open $number_file: $!";

  my $line;
  while ($line = <$ft>)
  {
    chomp $line;
    next unless $line =~ /^TOURNAMENT (\d+)/;
    push @$tref, $1;
  }

  close $ft;
}
