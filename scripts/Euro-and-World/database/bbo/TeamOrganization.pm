#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamOrganization;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_organization);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  EBU => ['eng bridge union'],
  JBA => ['j.b.a.'],
);

my @SINGLE_WORDS = qw(
  APBF
  AZS
  CBAI
  EBU
  GABSI
  JBA
  MCBA
  NIBU
  PTBA
  SBU
  WBU
);

my %SINGLE_TYPOS =
(
  APBF => ['PABF'],
  CBAI => ['cabi']
);


sub set_hashes_team_organization
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
