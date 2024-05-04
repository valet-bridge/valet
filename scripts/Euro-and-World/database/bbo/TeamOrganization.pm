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
  EBU => ['eng bridge union']
);

my @SINGLE_WORDS = qw(
  EBU
  GABSI
);

my %SINGLE_TYPOS =
(
);


sub set_hashes_team_organization
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
