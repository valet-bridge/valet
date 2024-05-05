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
  'Bridge Club' => ['a.s.d',
    'b.b.k.', 'b.s.b', 'b.seh bel', 'b. shr bld',
    'bld.spor', 'bric klb', 'bric kulubu', 'bric sk', 'briç sk', 
    'brýç sk', 'bric sk', 'briç sk', 'bric sk', 'briç ýsk', 
    'bridge clu',
    'bric kulubu', 'bridz klub', 'b.b.s.k', 'bsb bk', 
    'g.s.b',
    'kontrat bsk', 'spor kulubu', 'spor kulübü'],
  'Sporting Club' => ["sport' c", 'sports c', 'spor kb', 's c',
    'tennis club']
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Bridge Club' => [qw(aba abi absk ahm asd ass assn asso assoc azs
    bbgsk bbsk bc bcn belediye beledýye bilimsel bjk bk bld bmsk 
    bridgeclub bridgeklub 
    bs bsb bsc bsk bskd bþb bþbký bsbkisk buyuksehir ybsk bsbs 
    btsc cfr club 
    dbc dbk dgc eibc fbc
    gsk gskd gtbc
    klubben klubberne ks ksb ksk
    nbi nbcbl
    obk 
    sbc sc sdgskd sk spor
    tbc tc)]
);


sub set_hashes_team_abbr
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
