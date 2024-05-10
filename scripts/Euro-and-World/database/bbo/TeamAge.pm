#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamAge;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_age);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  U20 => ['u 20', 'u-20'],
  U21 => ['u 21', 'u-21'],
  U25 => ['u 25'],
  U26 => ['u-26']
);

my @SINGLE_WORDS = qw(
  Seniors Juniors Girls Youngsters Schools Kids
  U28 U26 U25 U21 U20 U16 U15
);

my %SINGLE_TYPOS =
(
  Seniors => [qw(senior senior's senioren seniori sr)],
  Juniors => [qw(juniiors juniores junior yuniors yunior jun)],
  Youngsters => [qw(youngster young youth genclik)],
  Schools => [qw(school)],
  U20 => [qw(u20s)],
  Girls => [qw(qirl)]
);


sub set_hashes_team_age
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
