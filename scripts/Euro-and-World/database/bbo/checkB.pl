#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib './Tags';
use lib './Connections';

use LinksT;
use DateCalc;
use Tags::Tname;
use Tags::Meet;
use Connections::Matrix;

# Quite duplicative to read the tournaments and meets twice,
# but it's only a checker...
use ParseT;
use EntryT;

my %PRACTICE_OK = (
  'ASEAN University Teams|2024' => 1,
  'ASEAN Youngsters Club Teams|2024' => 1,
  'Asian University Championship|2009' => 1,
  'Australia Challenge|2007' => 1,
  'Australia Practice|2016' => 1,
  'Bolivian Open Teams|2004' => 1,
  'Bolivian Open Teams|2023' => 1,
  'Chile Practice|2009' => 1,
  'Commonwealth Nations Bridge Championships|2018' => 1,
  'Danish Open Team Trials|2010' => 1,
  'Denmark Practice|2013' => 1,
  'Denmark Practice|2014' => 1,
  'Denmark Practice|2015' => 1,
  'European University Team Championship|2016' => 1,
  'France Practice|2007E' => 1,
  'France Practice|2008B' => 1,
  'France Practice|2017' => 1,
  'France Practice|2023' => 1,
  'French Women Trials|2015' => 1,
  'Grand Prix of Poland Teams|2013E' => 1,
  'Israel Festival Open Teams|2011' => 1,
  'Israel Practice|2019' => 1,
  'Italy Practice|2014' => 1,
  "Kepri Governor's Cup|2005" => 1,
  'Pan Arab Inter-Club Championship|2013' => 1,
  'Pan Arab Inter-Club Championship|2014' => 1,
  'Poland Practice|2017' => 1,
  'Rosenblum Cup|1998' => 1,
  'Russia Practice|2020' => 1,
  'Russia Practice|2021' => 1,
  'Sweden Practice|2017B' => 1,
  'Sweden Practice|2022' => 1,
  'Swedish Open Team Trials|2019' => 1,
  'Taiwan Practice|2007' => 1,
  'World Open Junior Teams|2011' => 1,
  'World Transnational Women Junior Teams|2024' => 1
);


use Whole;
my $whole = Whole->new();
$whole->init_hashes();

Connections::Matrix::set_matrix($whole);
$whole->check_static_consistency();

my $division_flag;
my $debug_division = '';

my (%links_t, %links_m);
my (%links_thash, %links_mhash);

# Check that tournaments and Tname/Meet have the same primary names.
# Also check whether a tournament would have a compatible meet.

die "perl checkB.pl t [INDONESIA]" unless ($#ARGV <= 1);
my $file = $ARGV[0];

if ($#ARGV == 1)
{
  $division_flag = 1;
  $debug_division = $ARGV[1];
}
else
{
  $division_flag = 0;
}

my %divisionsT;
LinksT::init_linksT(\%divisionsT);

my $parseT = ParseT->new();
$parseT->init_links($debug_division, $division_flag);

open my $fh, '<', $file or die "Cannot read tfile: $!";

my $entryT = EntryT->new();
my %origin_stats;

while ($entryT->read($fh))
{
  $entryT->format();

  my $meet = $entryT->header_field('MEET');
  my $tname = $entryT->header_field('TNAME');

  if ($meet eq '' && $tname eq '')
  {
    warn $entryT->bbono() . " not found at all" unless $division_flag;
    next;
  }

  my ($edition, $chapter);
  ($tname, $edition, $chapter) =
    $parseT->get_edition_and_chapter($meet, $tname, $entryT, 
      0, $division_flag);

  if ($tname eq '')
  {
    warn $entryT->bbono() . ": no TNAME found for meet $meet"
      unless $division_flag;
    next;
  }
  if ($edition eq '')
  {
    warn $entryT->bbono() . ": no EDITION found for meet $meet"
      unless $division_flag;
    next;
  }

  if ($entryT->bbono() eq 2782)
  {
    # print "HERE\n";
  }

  my ($header_entry, $chapter_entry) = 
    $parseT->get_header_entry($tname, $edition, $chapter);

  $entryT->prune_using($header_entry, $chapter_entry);

  $entryT->check_fields($header_entry, $chapter_entry,
    $edition, \%origin_stats);
}

close $fh;

find_likely_internationals(\%origin_stats);


exit;


sub set_linksT
{
  my ($meets, $tournaments, $key) = @_;

  %links_t = ();
  %links_m = ();
  %links_thash = ();
  %links_mhash = ();

  for my $meet (sort keys %$meets)
  {
    $links_mhash{$meet} = 1;
  }
  %{$links_m{$key}} = %$meets;

  for my $tournament (sort keys %$tournaments)
  {
    $links_thash{$tournament} = 1;
  }
  %{$links_t{$key}} = %$tournaments;
}



sub find_likely_internationals
{
  my $origin_stats = pop;

  for my $tname (sort keys %$origin_stats)
  {
    for my $edition (sort keys %{$origin_stats->{$tname}})
    {
      my $concat = "$tname|$edition";
      next if exists $PRACTICE_OK{$concat};

      my $nationals = $origin_stats->{$tname}{$edition}[0] // 0;
      next if $nationals == 0;

      my $others = $origin_stats->{$tname}{$edition}[1] // 0;

      if ($others == 0 || $nationals >= 4 * $others)
      {
        print "Candidate for International $tname, $edition " .
          "($nationals vs $others)\n";
      }
    }
  }
}
