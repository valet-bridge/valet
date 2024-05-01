#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamAbbr;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_abbr);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Bridge Club',
  'Sporting Club'
);

my %MULTI_TYPOS =
(
  'Bridge Club' => ['b.b.k.', 'b.s.b', 'b.seh bel', 'b. shr bld',
    'bld.spor', 'bric klb', 'bric kulubu', 'bric sk', 'briç sk', 
    'brýç sk', 'bric sk', 'briç sk', 'bric sk', 'briç ýsk', 
    'bric kulubu', 'bridz klub', 'b.b.s.k', 
    'bsb bk', 'spor kulubu', 'spor kulübü'],
  'Sporting Club' => ["sport' c"]
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Bridge Club' => [qw(aba bþb bþbký bsbkisk belediye beledýye 
    buyuksehir ybsk
    bbsk bc bcn bk bmsk bridgeclub bridgeklub bs bsb bsc bsk 
    bsbs btsc cLUB gsk gskd klubben klubberne ksb sdgskd sk)]
);


sub set_hashes_team_abbr
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
