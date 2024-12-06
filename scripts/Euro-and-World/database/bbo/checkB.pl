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
# Also check that whether a tournament would have a compatible meet.

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

  my ($header_entry, $chapter_entry) = 
    $parseT->get_header_entry($tname, $edition, $chapter);

  $entryT->prune_using($header_entry, $chapter_entry);

  $entryT->check_fields($header_entry);
}

close $fh;
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


