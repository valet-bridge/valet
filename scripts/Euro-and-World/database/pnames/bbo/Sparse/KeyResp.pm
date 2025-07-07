#!perl

package Sparse::KeyResp;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(look_for_responses);

use lib '..';
use Units;

my %SINGLETS = 
(
  '01234' => { SIMPLE => '01234' },
  '0134' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '0314' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '03142' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '03142021' => { ALWAYS => '0314-22' },
  '0314202122' => { ALWAYS => '0314-22' },
  '031402' => { ALWAYS => '0314-22' },
  '031420' => { ALWAYS => '0314-22' },
  '0314202' => { ALWAYS => '0314-22' },
  '031421' => { ALWAYS => '0314-22' },
  '031422' => { ALWAYS => '0314-22' },
  '03142222' => { ALWAYS => '0314-22' },
  '0314322' => { ALWAYS => '0314-22' },
  '0314225' => { ALWAYS => '0314-22' },
  '031425' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '0314252' => { ALWAYS => '0314-22' },
  '03142525' => { ALWAYS => '0314-22' },
  '031452' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '03145252' => { ALWAYS => '0314-22' },
  '0341' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '04123' => { ALWAYS => '04123' },
  '0413' => { SIMPLE => '0413', COMPLEX => '0413-22'},
  '041322' => { ALWAYS => '041322' },
  '0431' => { SIMPLE => '0413', COMPLEX => '0413-22'},
  '1403' => { SIMPLE => '1430', COMPLEX => '1430-22'},
  '140322' => { ALWAYS => '1430-22' },
  '14032222' => { ALWAYS => '1430-22' },
  '1403225' => { ALWAYS => '1430-22' },
  '140323' => { ALWAYS => '1430-22' },
  '140325' => { SIMPLE => '1430', COMPLEX => '1430-22'},
  '14032525' => { ALWAYS => '1430-22' },
  '140352' => { SIMPLE => '1430', COMPLEX => '1430-22'},
  '140422' => { ALWAYS => '1430-22' },
  '1430' => { SIMPLE => '1430', COMPLEX => '1430-22'},
  '143002' => { ALWAYS => '1430-22' },
  '143022' => { ALWAYS => '1430-22' },
  '1430225' => { ALWAYS => '1430-22' },
  '143025' => { SIMPLE => '1430', COMPLEX => '1430-22'},
  '14302525' => { ALWAYS => '1430-22' },
  '143052' => { SIMPLE => '1430', COMPLEX => '1430-22'},
  '3014' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '30142' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '301422' => { ALWAYS => '0314-22' },
  '3041' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '304102' => { ALWAYS => '0314-22' },
  '30412' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '304120' => { ALWAYS => '0314-22' },
  '3041202' => { ALWAYS => '0314-22' },
  '304122' => { ALWAYS => '0314-22' },
  '304125' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '30415' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '304152' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '30422' => { ALWAYS => '0314-22'},
  '310422' => { ALWAYS => '1304-22'},
  '314' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '31422' => { ALWAYS => '0314-22' },
  '31425' => { SIMPLE => '0314', COMPLEX => '0314-22'},
  '4103' => { SIMPLE => '1430', COMPLEX => '1430-22'},
  '410322' => { ALWAYS => '1430-22' },
  '4130' => { SIMPLE => '1430', COMPLEX => '1430-22'},
  '41302' => { SIMPLE => '1430', COMPLEX => '1430-22'},
  '413022' => { ALWAYS => '1430-22' },
  '413052' => { ALWAYS => '1430-22' },
  '430' => { SIMPLE => '1430', COMPLEX => '1430-22'},
);

# These can turn a SIMPLE into a COMPLEX

my %STRAGGLERS =
(
  123 => 1,
  a => 1,
  ace => 1,
  clés => 1,
  cles => 1,
  five => 1,
  d => 1,
  dam => 1,
  k => 1,
  king => 1,
  kings => 1,
  q => 1,
  queen => 1,
);

# These can be building blocks such as '14 30 ...'

my %BLOCKS =
(
  '03' => 1,
  '30' => 1,
  '14' => 1,
  '22' => 1,
  '40' => 1,
  '41' => 1,
  '341' => 1,
  '341' => 1,
);


# TODO 0123 and 4123 can be preceded by 4/0


sub print_streak
{
  my ($units, $streak, $integer_counts, $identifier) = @_;

  my $text = '';
  for my $elem (@$streak)
  {
    my $v = $units->value($elem);
    $integer_counts->{$v}++;
    $text .= $v . ' ';
  }
  print "CAND: $text\n";

  $units->print_context(0, $units->last(), $identifier);
  print "\n";
}


sub include_straggler
{
  my ($units, $index) = @_;

  my $found = 0;
  my $next = $index;
  do
  {
    my $s = $units->find_next_substantial($next+1);
    return $next if $s < 0;
    # return $next unless exists $STRAGGLERS{lc($units->value($s))};
    if (! exists $STRAGGLERS{lc($units->value($s))})
    {
      # print "NONSEQ ", $units->value($s), "\n";
      return $next;
    }
    $next = $s;
  }
}


sub fix_keycard_streak
{
  my ($units, $first, $last, $chain_stats) = @_;

  if ($last > $first)
  {
    $units->collapse($first, $last, 'KEYCARD', 'Keycard Responses',
      $chain_stats);
  }
  else
  {
    $units->reslot($first, 'KEYCARD', 'Keycard Responses', $chain_stats);
  }
}


sub look_for_responses
{
  my ($units, $streaks, $integer_counts, $chain_stats) = @_;

  return -1 unless $#$streaks >= 0;
  for my $streak_no (0 .. $#$streaks)
  {
    my $streak = $streaks->[$streak_no];
    my $index = $streak->[0];
    my $value = $units->value($index);

    if ($#$streak == 0)
    {
      if (exists $SINGLETS{$value})
      {
        my $last = include_straggler($units, $index);
        fix_keycard_streak($units, $index, $last, $chain_stats);
        return $streak_no;
      }
      elsif (length($value) >= 9)
      {
        $units->reslot($index, 'FLUFF', 'Big Integer', $chain_stats);
      }
      else
      {
        $integer_counts->{$value}++;
      }
      next;
    }

    if (exists $SINGLETS{$value})
    {
      print_streak($units, $streak, $integer_counts, 'MULTI');
    }
    elsif (exists $BLOCKS{$value})
    {
      print_streak($units, $streak, $integer_counts, 'BLOCK');
    }
    else
    {
      print_streak($units, $streak, $integer_counts, 'ORIG');
    }
  }
}

1;
