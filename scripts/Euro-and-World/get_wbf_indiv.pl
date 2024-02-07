#!perl

use strict;
use warnings;
use v5.10;

use IO::Handle;
use File::Copy;
use File::Fetch;
use HTML::TreeBuilder;

die "perl get_wbf_indiv.pl" unless $#ARGV == -1;

my $TOURN_FIRST = 1;
my $TOURN_LAST = 9999;

my $sprefix = "http://www.worldbridge.org/pairschampRPperson/?qtournid=";
my $outdir = "wbf_indiv/";

my $output_file = "windiv2.txt"; # Is appended
my $output_bak = "windiv2.bak";

# Where the fetch ends up.
my $fetched = 'wbf_indiv/file_default';


# Tournament numbers to try.

my $number_file = 'database/names/wbf/manual/indiv2.txt';

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


for my $tno (@tournaments)
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

  my @individuals;
  if (! get_individuals($tree, \@individuals))
  {
    say "No content table";
    next;
  }

  print_individuals($fh, \@individuals);

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


sub parse_country
{
  my ($td, $ctr_ref) = @_;

  my $text = $td->as_text;
  my @a = split /-/, $text;
  return 0 unless $#a == 0;

  $$ctr_ref = $a[0];
  return 1;
}


sub get_individuals
{
  my ($table, $pairs_ref) = @_;

  my $content = $table->look_down(
    _tag => 'table', 
    cellspacing => "0");

  return 0 unless $content;

  my @rows = $table->look_down(_tag => 'tr');

  for my $row (@rows)
  {
    my @tds = $row->look_down(_tag => 'td');
    next unless $#tds == 7;

    my ($player, $qid);
    next unless parse_qryid($tds[2], \$player, \$qid);

    my $ctr;
    next unless parse_country($tds[5], \$ctr);

    push @$pairs_ref, {
      player => $player,
      pid => $qid,
      country => $ctr};
  }
  return 1;
}


sub print_individuals
{
  my ($fh, $pref) = @_;

  for my $player (@$pref)
  {
    print $fh "PLAYER $player->{player}\n";
    print $fh "ID $player->{pid}\n";
    print $fh "COUNTRY $player->{country}\n";
    print $fh "\n";
  }
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
