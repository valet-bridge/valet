#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Age;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Juniors => ['junior series'],
  Seniors => ['over 60', 'senior*', "seniors'"],
  U16 => ['u-16'],
  U18 => ['jhs'],
  U20 => ['u 20', 'u-20', 'junior u20'],
  U21 => ['u 21', 'u-21', 'under 21'],
  U25 => ['u 25'],
  U26 => ['u-26', 'under 26', 'undar 26', 'u 26'],
  U28 => ['under 28'],
  O55 => ['over 55']
);

my @SINGLE_WORDS = qw(
  Seniors Juniors Girls Youngsters Schools Kids
  U36 U28 U26 U25 U21 U20 U18 U16 U15
  O55
);

my %SINGLE_TYPOS =
(
  Seniors => [qw(senior senior's seniori seniorit 
    senjoorid senyor sr seniiors)],
  Juniors => [qw(juniiors juniores junior jrs jr jt junioor
    junios juniot juniours junniors junor
    yuniors yunior juniorit jun juniorerna)],
  Youngsters => [qw(youngster young youth yoth younth
    yongster yougerters genclik gençlik gençlýk genç genc)],
  Schools => [qw(school)],
  U16 => ['boys'],
  U20 => [qw(u20s)],
  U26 => ['students'],
  Girls => [qw(girl gir jenter dziewczêta)]
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
