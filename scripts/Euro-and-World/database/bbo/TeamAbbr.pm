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
  'Polo Club',
  'Sporting Club'
);

my %MULTI_TYPOS =
(
  'Bridge Club' => [
    'a.s.', 'a.s.d.', 'as. b.', 'ass. br.', 
    'b.akd', 'b.b.', 'b.c.',
    'b.b.k.', 'b.b.s.', 'b.b.s.k.', 
    'b.k', 'b.k.', 
    'b.s.', 'b.s', 'b.s.b.', 'b.s.b', 'b.s.k.', 'b.s.k', 'b.t',
    'b.bld.sk',
    'bld.', 'bld', 'bld sk', 'bld. sp', 'bld sp', 'bld.sp', 
    'bld.spor', 'bld. gsk',
    'bric iht', 'bric klb', 'bric kulubu', 
    'bridge cl', 'bridge clu', 
    'bridz klub', 
    'brýc sk', 'brýç sk', 'brýç s.k.', 'brýç spor', 'brýç ý. s.k', 
    'c. br.', 'card club',
    'genclik s', 'genç. hýz', 'gr.sp.ass.', 'g.s.b', 'gsd briç'
  ],

  'Sporting Club' => [
    'athletic c.',
    'bric sk', 'bric spor kl',
    'briç sk', 'briç skd', 'briç ýsk', 
    'brýç sk', 'brýç spor', 
    'spor bric', 'spor k.', 'spor kb', 'spor kulubu', 'spor kulübü', 
    'sports c', 
    'sports club', 
    's c', 's.k.', 's.s.', 's.s.d.',
    't.c.', 'tennis club'],

  'University Club' => ['ü.m.d']
);

my @SINGLE_WORDS = qw(
  Vakfi
);

my %SINGLE_TYPOS =
(
  'Bridge Club' => [qw(
    aba abi abk absk ahm ak asb asd ass assn asso assoc azs
    ba bbgsk bbs bbsgk bbsk bc bcm bcn 
    belediye beledýye belediyesi belediyespor 
    bgsk bilimsel bisk biskd bjk 
    bk bld bmsk bp bps
    br bri brýç bridgeclub bridgeklub 
    bs bsb bsbkisk bsbs bsc bsk bskd bsp bssk bt btsc 
    bþb bþbký buyuksehir býskd
    cbc cbe cfr ck club csb
    dbc dbk dgc 
    ebc eibc 
    fbc fc
    gençlik gkk gks gsb gsk gskd gsmks gtbc
    hesk
    ihs
    kcb kdi klubben klubberne ks ksb ksk
    maesa mbc
    nbc nbcbl ndbac nbi
    oaza obk 
    sb sbc sc sdgskd sk spor ss ssd
    tbc tc
    ybsk ýbsk ýbmsk)],
  'Sporting Club' => ['sporting', 'sprting'],
);


sub set_hashes_team_abbr
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
