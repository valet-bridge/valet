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

my @HEADER_ORDERED = qw(
  MEET
  MEET_ORDINAL
  TOURNAMENT_NAME
  ORDINAL
  
  ORIGIN
  ORGANIZATION
  SPONSOR
  PERSON
  CLUB

  ZONE
  COUNTRY
  NATIONALITY
  REGION
  CITY
  LOCALITY
  CLUB

  FORM
  SCORING

  AGE
  GENDER

  YEAR
  DATE_START
  DATE_END
);

my %HEADER_ORDERED_HASH;
$HEADER_ORDERED_HASH{$_} = 1 for @HEADER_ORDERED;

my @CHAPTER_ORDERED = qw(
  YEAR
  YEAR_MONTH
  MONTH_DAY
  DAY
  DATE_START
  DATE_END
  WEEKDAY
  WEEKEND
  STAGE
  MOVEMENT
  COLOR
);

my %CHAPTER_ORDERED_HASH;
$CHAPTER_ORDERED_HASH{$_} = 1 for @CHAPTER_ORDERED;


# Parse the raw output of cook.pl
# Recognize and check tournaments
# Optional second element is number or e.g. AFRICA (see ParseT.pm).

die "perl digest.pl cooked.txt" unless ($#ARGV == 0 || $#ARGV == 1);
my $file = $ARGV[0];

my $debug_flag = 0;
my $debug_bbono;
my $division_flag = 0;
my $debug_division;

if ($#ARGV == 1)
{
  if ($ARGV[1] =~ /^\d+$/)
  {
    $debug_flag = 1;
    $debug_bbono = $ARGV[1];
  }
  else
  {
    $division_flag = 1;
    $debug_division = $ARGV[1];
  }
}

my $parseT = ParseT->new();
$parseT->init_links($debug_division, $division_flag);

open my $fh, '<', $file or die "Cannot read tfile: $!";

my $num_matches = 0;
my %hist_matches;

my %data;
my (@times, $t0);

my $entryT = EntryT->new();
while ($entryT->read($fh))
{
  if ($debug_flag && defined $debug_bbono)
  {
    next unless $entryT->bbono() eq $debug_bbono;
  }

  if ($entryT->bbono() eq 27485)
  {
    print "HERE\n";
  }

  $t0 = time();
  $times[0] += time() - $t0;

  $t0 = time();
  $entryT->format();
  $times[1] += time() - $t0;

  my $meet = $entryT->header_field('MEET');
  my $tname = $entryT->header_field('TNAME');
  print "Starting with:\nMeet $meet\nTname $tname\n\n" if $debug_flag;

  if ($meet eq '' && $tname eq '')
  {
    warn $entryT->bbono() . " not found at all" unless $division_flag;
    next;
  }

  if ($EXPLORE_TOURNAMENTS == 1)
  {
    if ($parseT->is_tournament($tname))
    {
      print "===\n\nAs read\n\n";
      print $entryT->str_as_read();
    }
  }

  # This could set tname if it was previously unset!
  my ($edition, $chapter);

  $t0 = time();
  ($tname, $edition, $chapter) =
    $parseT->get_edition_and_chapter($meet, $tname, $entryT, 
      $debug_flag, $division_flag);
  $times[2] += time() - $t0;

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

  if ($debug_flag)
  {
    print "Meet $meet\nTname $tname\n";
    print $entryT->str_as_read();
    print "Tname $tname\nEdition $edition\nChapter $chapter\n";
  }

  if ($EXPLORE_TOURNAMENTS == 2)
  {
    print $entryT->str_as_read();
    next;
  }

  $t0 = time();
  my ($header_entry, $chapter_entry) = 
    $parseT->get_header_entry($tname, $edition, $chapter);
  $times[3] += time() - $t0;

  $t0 = time();
  $entryT->prune_using($header_entry, $chapter_entry);
  $times[4] += time() - $t0;

  $t0 = time();
  $entryT->update_tournaments(\%data, $tname, $edition, $chapter,
    $header_entry, $chapter_entry);
  $times[5] += time() - $t0;

  $num_matches++;
  $hist_matches{$tname}++;
}

close $fh;
exit if $debug_flag;

# for my $i (0 .. $#times)
# {
  # printf "Time $i: %.3f seconds\n", $times[$i];
# }
# $parseT->print_times();
# exit;

# Print complete tournaments sorted by their first entry date.
# Keep track of (tournament, entry) pairs for this purpose.
my %te_seen;
my %te_list;
for my $date_start (keys %data)
{
  my $len = $#{$data{$date_start}};
  if ($len > 0)
  {
    @{$data{$date_start}} = sort
    {
      $a->{TNAME} cmp $b->{TNAME} ||
      $a->{EDITION} cmp $b->{EDITION} ||
      $a->{CHAPTER} cmp $b->{CHAPTER}
    } @{$data{$date_start}};
  }

  for my $i (0 .. $len)
  {
    my $datum = $data{$date_start}[$i];
    $te_seen{$datum->{TNAME}}{$datum->{EDITION}} = 0;
    push @{$te_list{$datum->{TNAME}}{$datum->{EDITION}}},
      { DATE_START => $date_start, 
        CHAPTER => $datum->{CHAPTER},
        INDEX => $i};
  }
}

for my $date_start (sort keys %data)
{
  if ($date_start eq '1999-06-11')
  {
    print "HERE\n";
  }

  my $dlist = $data{$date_start};
  for my $dno (0 .. $#$dlist)
  {
    my $datum = $dlist->[$dno];
    next if ($te_seen{$datum->{TNAME}}{$datum->{EDITION}});
    $te_seen{$datum->{TNAME}}{$datum->{EDITION}} = 1;

    print str_header($datum->{HEADER_REF});

    my @tlist = sort { $a->{CHAPTER} cmp $b->{CHAPTER} }
      @{$te_list{$datum->{TNAME}}{$datum->{EDITION}}};

    for my $t_ref (@tlist)
    {
      my $datum_t = $data{$t_ref->{DATE_START}}[$t_ref->{INDEX}];

      my $reg_counter = RegCounter->new();

      # Deal with 'ignore' and '|' formats for 'major' and 'minor'.
      my %pre_map;
      $reg_counter->make_pre_map($datum_t->{CHAPTER_REF}, \%pre_map);

      for my $bbo (@{$datum_t->{BBOLIST}})
      {
        $bbo->apply_pre_map(\%pre_map);
        $reg_counter->register($bbo, $datum_t->{CHAPTER_REF},
          $datum->{HEADER_REF}{TOURNAMENT_NAME});
      }
      $reg_counter->analyze(
        $datum_t->{HEADER_REF},
        $datum_t->{CHAPTER_REF});

      # This will use 'major' and 'minor' if present.
      # $reg_counter->align($datum_t->{CHAPTER_REF});

      # $reg_counter->fix_counters($datum_t->{BBOLIST});
      $reg_counter->fix_counters_new($datum_t->{CHAPTER_REF},
        \%pre_map, $datum_t->{BBOLIST});

      my $chapter_str = str_chapter($datum_t->{CHAPTER_REF});
      if (! exists $datum_t->{CHAPTER_REF}{groupon})
      {
        # $reg_counter->sort_counters($datum_t->{BBOLIST});
        $reg_counter->sort_counters_new($datum_t->{CHAPTER_REF},
          $datum_t->{BBOLIST});
        print_chapter_verse($chapter_str, 
          $reg_counter, $datum_t->{BBOLIST});
      }
      elsif ($datum_t->{CHAPTER_REF}{groupon} eq 'AUTO')
      {
        # For now
        # $reg_counter->sort_counters($datum_t->{BBOLIST});
        $reg_counter->sort_counters_new($datum_t->{CHAPTER_REF},
          $datum_t->{BBOLIST});
        print_chapter_verse($chapter_str, 
          $reg_counter, $datum_t->{BBOLIST});
      }
      else
      {
        # For now
        $reg_counter->sort_counters_new($datum_t->{CHAPTER_REF},
          $datum_t->{BBOLIST});
        print_chapter_verse($chapter_str, 
          $reg_counter, $datum_t->{BBOLIST});
      }
    }
  }
}

for my $key (sort keys %hist_matches)
{
  printf("%-43s %4d\n", $key, $hist_matches{$key});
}

print '-' x 48 . "\n";
printf("%-42s %5d\n", "Number of matches", $num_matches);

exit;


sub str_header
{
  my ($header) = @_;

  my $s = '';
  for my $key (@HEADER_ORDERED)
  {
    $s .= "$key $header->{$key}\n" if exists $header->{$key};
  }

  for my $key (keys %$header)
  {
    warn "Unprinted field $key" unless exists $HEADER_ORDERED_HASH{$key};
  }

  return "$s\n";
}


sub str_chapter
{
  my ($chapter) = @_;

  my $s = '';
  for my $key (@CHAPTER_ORDERED)
  {
    $s .= "$key $chapter->{$key}\n" if exists $chapter->{$key};
  }

  for my $key (keys %$chapter)
  {
    warn "Unprinted field $key" unless 
      exists $CHAPTER_ORDERED_HASH{$key} || $key =~ /^[a-z]*$/;
  }

  return "$s\n";
}


sub print_chapter_verse
{
  my ($chapter_str, $reg_counter, $bbo_list) = @_;

  print $chapter_str;
  print $reg_counter->str_analysis() . "\n" if $VERBOSE;
  print $reg_counter->str_field_map() if $VERBOSE;

  for my $bbo (@$bbo_list)
  {
    print $bbo->str_as_read();
  }
}

