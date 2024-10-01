#!perl

package Scoring::Study;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';


our @ISA = qw(Exporter);
our @EXPORT = qw(study);

my @LOCAL_SUBS =
(
  # { START => , END => , TEXT => '',
    # CORR => '' },

  # Lots of "Grand Prix of Poland Pairs" are entered as BAM
  # (and sometimes IMPs), I believe incorrectly.

  { START =>  1116, END =>  1118, TEXT => 'BAM', CORR => 'MP' },
  { START =>  1120, END =>  1128, TEXT => 'BAM', CORR => 'MP' },
  { START =>  3077, END =>  3078, TEXT => 'BAM', CORR => 'MP' },
  { START =>  3453, END =>  3455, TEXT => 'BAM', CORR => 'MP' },
  { START =>  4979, END =>  4982, TEXT => 'IMP', CORR => 'MP' }, # IMP!
  { START =>  8351, END =>  8353, TEXT => 'BAM', CORR => 'MP' },
  { START =>  9230, END =>  9241, TEXT => 'BAM', CORR => 'MP' },
  { START => 10194, END => 10194, TEXT => 'IMP', CORR => 'MP' }, # IMP!
  { START => 11229, END => 11247, TEXT => 'IMP', CORR => 'MP' }, # IMP!
  { START => 12222, END => 12253, TEXT => 'BAM', CORR => 'MP' },
  { START => 12739, END => 12756, TEXT => 'BAM', CORR => 'MP' },
  { START => 12983, END => 13010, TEXT => 'BAM', CORR => 'MP' },
  { START => 14200, END => 14275, TEXT => 'BAM', CORR => 'MP' },
  { START => 15457, END => 15461, TEXT => 'BAM', CORR => 'MP' },
  { START => 15462, END => 15463, TEXT => 'IMP', CORR => 'MP' }, # IMP!
  { START => 16307, END => 16377, TEXT => 'BAM', CORR => 'MP' },
  { START => 16829, END => 16842, TEXT => 'BAM', CORR => 'MP' },
  { START => 17625, END => 17633, TEXT => 'BAM', CORR => 'MP' },
  { START => 20051, END => 20063, TEXT => 'BAM', CORR => 'MP' },
  { START => 21520, END => 21553, TEXT => 'BAM', CORR => 'MP' },
  { START => 21960, END => 21975, TEXT => 'BAM', CORR => 'MP' },
  { START => 22437, END => 22453, TEXT => 'BAM', CORR => 'MP' },
  { START => 23503, END => 23508, TEXT => 'IMP', CORR => 'MP' }, # IMP!
  { START => 23594, END => 23598, TEXT => 'BAM', CORR => 'MP' },
  { START => 23823, END => 23837, TEXT => 'BAM', CORR => 'MP' },
  { START => 25456, END => 25467, TEXT => 'BAM', CORR => 'MP' },
  { START => 26446, END => 26514, TEXT => 'BAM', CORR => 'MP' },
  { START => 27263, END => 27274, TEXT => 'BAM', CORR => 'MP' },
  { START => 27419, END => 27436, TEXT => 'BAM', CORR => 'MP' },
  { START => 28295, END => 28314, TEXT => 'BAM', CORR => 'MP' },
  { START => 28467, END => 28479, TEXT => 'BAM', CORR => 'MP' },
  { START => 29182, END => 29191, TEXT => 'BAM', CORR => 'MP' },
  { START => 29546, END => 29552, TEXT => 'BAM', CORR => 'MP' },
  { START => 30673, END => 30704, TEXT => 'BAM', CORR => 'MP' },
  { START => 31409, END => 31416, TEXT => 'BAM', CORR => 'MP' },
  { START => 31521, END => 31604, TEXT => 'BAM', CORR => 'MP' },
  { START => 32120, END => 32134, TEXT => 'BAM', CORR => 'MP' },
  { START => 32643, END => 32645, TEXT => 'BAM', CORR => 'MP' },
  { START => 33817, END => 33829, TEXT => 'BAM', CORR => 'MP' },
  { START => 34365, END => 34372, TEXT => 'BAM', CORR => 'MP' },
  { START => 34548, END => 34554, TEXT => 'BAM', CORR => 'MP' },
  { START => 35734, END => 35746, TEXT => 'BAM', CORR => 'MP' },
  { START => 37029, END => 37069, TEXT => 'BAM', CORR => 'MP' },
  { START => 37612, END => 37621, TEXT => 'BAM', CORR => 'MP' },
  { START => 38008, END => 38028, TEXT => 'BAM', CORR => 'MP' },
  { START => 40982, END => 40998, TEXT => 'BAM', CORR => 'MP' },
  { START => 42370, END => 42385, TEXT => 'BAM', CORR => 'MP' },
  { START => 43307, END => 43311, TEXT => 'BAM', CORR => 'MP' },
  { START => 43325, END => 43341, TEXT => 'BAM', CORR => 'MP' },
  { START => 44725, END => 44741, TEXT => 'BAM', CORR => 'MP' },
  { START => 44958, END => 44959, TEXT => 'BAM', CORR => 'MP' },

  { START =>  4285, END =>  4286, TEXT => 'BAM', CORR => 'MP' },
  { START => 10140, END => 10141, TEXT => 'BAM', CORR => 'MP' },
  { START => 10161, END => 10169, TEXT => 'BAM', CORR => 'MP' },
  { START => 13235, END => 13242, TEXT => 'BAM', CORR => 'MP' },
  { START => 16511, END => 16537, TEXT => 'BAM', CORR => 'MP' },

  { START => 11213, END => 11227, TEXT => 'BAM', CORR => 'Patton' },
  { START => 15441, END => 15453, TEXT => 'BAM', CORR => 'Patton' },
  { START => 20025, END => 20044, TEXT => 'BAM', CORR => 'Patton' },
  { START => 25436, END => 25451, TEXT => 'BAM', CORR => 'Patton' },
  { START => 30617, END => 30654, TEXT => 'BAM', CORR => 'Patton' },
  { START => 35703, END => 35712, TEXT => 'BAM', CORR => 'Patton' },
  { START => 40957, END => 40967, TEXT => 'IMP', CORR => 'Patton' },

  { START => 30808, END => 30840, TEXT => 'BAM', CORR => 'MP' },

  { START => 32745, END => 32746, TEXT => 'BAM', CORR => 'MP' },
  { START => 33281, END => 33285, TEXT => 'BAM', CORR => 'MP' },

  { START => 36516, END => 36516, TEXT => 'BAM', CORR => 'MP' },

  # In Finland they use B for Barometer, I think.
  { START => 15747, END => 15786, TEXT => 'BAM', CORR => 'MP' },
  { START => 25865, END => 25921, TEXT => 'BAM', CORR => 'MP' },
  { START => 26966, END => 27009, TEXT => 'BAM', CORR => 'IMP' },
  { START => 30627, END => 30670, TEXT => 'BAM', CORR => 'MP' },
  { START => 41675, END => 41707, TEXT => 'BAM', CORR => 'MP' },
  { START => 44253, END => 44304, TEXT => 'BAM', CORR => 'MP' },

  # Australia
  { START =>  1244, END =>  1248, TEXT => 'MP', CORR => 'IMP' },
  { START => 13315, END => 13319, TEXT => 'MP', CORR => 'IMP' },
  { START => 13321, END => 13324, TEXT => 'MP', CORR => 'IMP' },
  { START => 13351, END => 13353, TEXT => 'MP', CORR => 'IMP' },
  { START => 13355, END => 13357, TEXT => 'MP', CORR => 'IMP' },
  { START => 16490, END => 16508, TEXT => 'MP', CORR => 'IMP' },
  { START => 32882, END => 32908, TEXT => 'MP', CORR => 'IMP' },
);


sub local_substitutions
{
  my ($text, $bbono) = @_;

  for my $entry (@LOCAL_SUBS)
  {
    if ($bbono >= $entry->{START} && $bbono <= $entry->{END})
    {
      $text =~ s/$entry->{TEXT}/$entry->{CORR}/i;
    }
  }
  return $text;
}


sub study
{
  my ($text, $result, $bbono) = @_;

  if (! defined $text)
  {
    $result->{SCORING} = '';
    return;
  }

  if ($text eq 'I')
  {
    $result->{SCORING} = 'IMP';
  }
  elsif ($text eq 'P')
  {
    $result->{SCORING} = 'MP';
  }
  elsif ($text eq 'B')
  {
    $result->{SCORING} = 'BAM';
  }
  else
  {
    die "$bbono: Unknown scoring $text";
  }

  $result->{SCORING} = local_substitutions($result->{SCORING}, $bbono);
}


1;
