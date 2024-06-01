#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Abbr;

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
    'bel. spor',
    'b.k', 'b.k.', 
    'b.s.', 'b.s', 'b.s.b.', 'b.s.b', 'b.s.k.', 'b.s.k', 'b.t',
    'b.bld.sk',
    'bld.', 'bld', 'bld sk', 'bld. sp', 'bld sp', 'bld.sp', 
    'bld.spor', 'bld. gsk',
    'bric iht', 'bric klb', 'bric kulubu', 
    'bridge cl', 'bridge clu', 
    'bridz klub', 
    'brýc sk', 'brýç sk', 'brýç s.k.', 'brýç spor', 'brýç ý. s.k', 
    'c. br.', 'card club', 'c b c',
    'genclik s', 'genç. hýz', 'gr.sp.ass.', 'g.s.b', 'gsd briç'
  ],

  'Sporting Club' => [
    'athletic c.',
    'bel',
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
    aba abk absk ak asb asd ass assn 
    ba bbgsk bbsgk bbsk bc bcm bcn beld belediye beledýye belediyespor 
    bgsk bilimsel bisk biskd bjk bk bld bmsk bp bps
    br bri brýç bridgeclub bridgeklub bs bsb bsc bsk bskd bsp bssk 
    bt btsc bþb buyuksehir býskd
    cbc cbe cfr ck club csb
    dbc 
    ebc eibc 
    fbc fc
    gençlik gkk gks gsb gsk gskd gsmks gtbc
    hesk
    ihs
    kcb kdi klubben ks ksb ksk
    maesa mbc
    nbc ndbac nbi
    oaza obk 
    sb sbc sc sdgskd sk spor ss ssd
    tbc tc
    ýbsk ýbmsk)],
  'Sporting Club' => ['sporting', 'sprting'],
);


sub set_hashes_team_abbr
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
