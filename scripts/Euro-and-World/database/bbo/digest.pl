#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';

use ParseT;
use EntryT;
use RegCounter;

my $EXPLORE_TOURNAMENTS = 0;
my $VERBOSE = 1;

# Parse the raw output of cook.pl
# Recognize and check tournaments

die "perl digest.pl cooked.txt" unless $#ARGV == 0;
my $file = $ARGV[0];

my $parseT = ParseT->new();
$parseT->init_links();

open my $fh, '<', $file or die "Cannot read tfile: $!";

my $num_matches = 0;
my %hist_matches;

my %data;

my $entryT = EntryT->new();
while ($entryT->read($fh))
{
  my $meet = $entryT->field('TITLE_MEET');
  my $tname = $entryT->field('TITLE_TNAME');
  next if $meet eq '' && $tname eq '';

  if ($entryT->bbono() eq 1265)
  {
    print "HERE\n";
  }

  if ($EXPLORE_TOURNAMENTS == 1)
  {
    if ($parseT->is_tournament($tname))
    {
      print "===\n\nAs read\n\n";
      print $entryT->str_as_read();
    }
    next;
  }


  # This could set tname if it was previously unset!
  my ($edition, $chapter);
  ($tname, $edition, $chapter) =
    $parseT->get_edition_and_chapter($meet, $tname, $entryT);

  next if $edition eq '';

  if ($EXPLORE_TOURNAMENTS == 2)
  {
    print $entryT->str_as_read();
    next;
  }

  my ($header_entry, $chapter_entry) = 
    $parseT->set_header_entry($tname, $edition, $chapter);

  $entryT->prune_using($header_entry, $chapter_entry);

  $entryT->update_tournaments(\%data, $tname, $edition, $chapter,
    $header_entry, $chapter_entry);

  $num_matches++;
  $hist_matches{$tname}++;
}

close $fh;

for my $date_start (sort keys %data)
{
if ($date_start eq '2014-05-01')
{
  print "HERE\n";
}
  for my $dno (0 .. $#{$data{$date_start}})
  {
    my $datum = $data{$date_start}[$dno];
    print $datum->{HEADER}->str_header();

    for my $chapter (sort keys %{$datum->{CHAPTER}})
    {
      my $cptr = $datum->{CHAPTER}{$chapter};
      print $cptr->{HEADER}->str_chapter();

      for my $i (0 .. $#{$cptr->{LIST}})
      {
        $cptr->{LIST}[$i]->fix_list_tags();
      }

      my $reg_counter = RegCounter->new();
      for my $i (0 .. $#{$cptr->{LIST}})
      {
        $reg_counter->register($cptr->{LIST}[$i]);
      }
      $reg_counter->analyze();

      print $reg_counter->str_analysis() . "\n" if $VERBOSE;

      # This will use 'major' and 'minor' if present.
      $reg_counter->align($cptr->{HEADER});
      print $reg_counter->str_field_map() if $VERBOSE;

      $reg_counter->fix_counters($cptr->{LIST});

      $reg_counter->sort_counters($cptr->{LIST});

      for my $i (0 .. $#{$cptr->{LIST}})
      {
        print $cptr->{LIST}[$i]->str_as_read();
      }
    }
  }
}

for my $key (sort keys %hist_matches)
{
  printf("%-32s %4d\n", $key, $hist_matches{$key});
}

print '-' x 37 . "\n";
printf("%-32s %4d\n", "Number of matches", $num_matches);

