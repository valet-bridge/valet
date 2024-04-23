#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamRegion;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_region);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Vest Agder',
  'Western Australia'
);

my %MULTI_TYPOS =
(
  'Vest Agder' => ['vest-agder'],
  'Western Australia' => ['wa']
);

my @SINGLE_WORDS = qw(
  Bali
  Florida
  Kepri
  Kedungwaru
  Lumajang
  Ratchaburi
  Victoria
);

my %SINGLE_TYPOS =
(
);


sub set_hashes_team_region
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
