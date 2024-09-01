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
  my $tname = $entryT->field('TITLE_TNAME');
  next if $tname eq '';

  if ($entryT->bbono() eq 31218)
  {
    # print "HERE\n";
  }

  my ($edition, $chapter) = 
    $parseT->get_edition_and_chapter($tname, $entryT);

  next if $edition eq '';

  my ($header_entry, $chapter_entry) = 
    $parseT->set_header_entry($tname, $edition, $chapter);

  # print "===\n\nAs read\n\n";
  # print $entryT->str_as_read();

  $entryT->prune_using($header_entry, $chapter_entry);

  $entryT->update_tournaments(\%data, $tname, $edition, $chapter,
    $header_entry, $chapter_entry);

  $num_matches++;
  $hist_matches{$tname}++;
}

close $fh;

for my $date_start (sort keys %data)
{
if ($date_start eq '2013-07-20')
{
  # print "HERE\n";
}
  for my $dno (0 .. $#{$data{$date_start}})
  {
    my $datum = $data{$date_start}[$dno];
    print $datum->{HEADER}->str_header();

    for my $chapter (sort keys %{$datum->{CHAPTER}})
    {
      my $cptr = $datum->{CHAPTER}{$chapter};

      # print "$chapter\n" unless $chapter eq 'SINGLE';
      print $cptr->{HEADER}->str_chapter();

      for my $i (0 .. $#{$cptr->{LIST}})
      {
        $cptr->{LIST}[$i]->fix_list_tags();
      }

      for my $i (0 .. $#{$cptr->{LIST}})
      {
        print $cptr->{LIST}[$i]->str_as_read();
      }
    }
  }
}

for my $key (sort keys %hist_matches)
{
  printf("%-30s %4d\n", $key, $hist_matches{$key});
}

print '-' x 35 . "\n";
printf("%-30s %4d\n", "Number of matches", $num_matches);

