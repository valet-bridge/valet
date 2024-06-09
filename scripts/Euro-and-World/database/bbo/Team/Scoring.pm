#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Scoring;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_scoring);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  IMP => ['butler scoring', "IMP's"]
);

my @SINGLE_WORDS = qw(
  MP IMP BAM Patton
);

my %SINGLE_TYPOS =
(
  MP => [qw(matchpoints)],
  IMP => [qw(ýmp imps impy)],
);


sub set_hashes_team_scoring
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
