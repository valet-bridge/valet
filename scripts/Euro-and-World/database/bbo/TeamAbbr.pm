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
  'Bridge Club' => [
    'a.s.', 'a.s.d.', 'ass. br.',
    'b.b.', 'b.c.', 'b.c',
    'b.b.k.', 'b.b.s.', 'b.b.s.k.', 'b.s.', 'b.s.b.',
    'b.seh bel', 'b. shr bld', 'bld.spor', 
    'br.', 'bric iht.', 'bric klb', 'bric kulubu', 
    'bridge clu', 'bridz klub', 'bsb bk', 
    'c. br.',
    'gr.sp.ass.', 'g.s.b.',
    'kontrat bsk'],

  'Sporting Club' => [
    'bric sk', 'briç sk', 'briç skd',
    'briç ýsk', 'brýç sk', 'brýç spor', 'spor bric', 
    "sport' c", 'sports c', 'spor kb', 's c',
    's.k.', 'spor kulubu', 'spor kulübü',
    'tennis club']
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Bridge Club' => [qw(aba abk abi absk ahm asd ass assn asso assoc azs
    bbgsk bbs bbsk bc bcn belediye beledýye bilimsel bjk bk bld bmsk 
    br bridgeclub bridgeklub 
    bs bsb bsc bsk bskd bþb bþbký bsbkisk buyuksehir ybsk bsbs btsc 
    cfr club 
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
