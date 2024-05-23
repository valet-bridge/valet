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
    'a.s.', 'a.s.d.', 'ass. br.', 'as. b.', 'athletic c.',
    'b.akd', 'b.b.', 'b.c.', 'b.c',
    'b.s.b', 'b.b.k.', 'b.b.s.', 'b.b.s.k.', 'b.s.', 'b.s', 'b.s.b.', 
    'bld', 'bld.',
    'b.s.k.', 'b.s.k', 'b.seh bel', 'b. shr bld', 'b.k', 'b.k.', 
    'bld sk', 'bld sp', 'b.bld.sk',
    'bld.sp', 'bld.spor', 'bld. gsk',
    'br.', 'bric iht.', 'bric klb', 'bric kulubu', 
    'bridge clu', 'bridge cl', 'bridz klub', 'brýç spor', 
    'brýç s.k.', 'bsb bk', 
    'c. br.',
    'card club',
    'gr.sp.ass.', 'g.s.b.', 'g.s.b', 'g.s.',
    'kontrat bsk',
    'y.þehýr bld'],

  'Sporting Club' => [
    'bric sk', 'briç sk', 'briç skd', 'bric spor kl',
    'briç ýsk', 'brýç sk', 'brýç spor', 'spor bric', 
    "sport' c", 'sports c', 'spor kb', 's c',
    's.k.', 'spor kulubu', 'spor kulübü', 's.s.', 's.s.d.',
    'sports club', 'spor k.',
    't.c.', 'tennis club', 't.c.p.'],

  'University Club' => ['ü.m.d']
);

my @SINGLE_WORDS = qw(
  Vakfi
);

my %SINGLE_TYPOS =
(
  'Bridge Club' => [qw(aba abk abi absk ak ahm 
    asb asd ass assn asso assoc azs
    ba bbgsk bbs bbsk bc bcm bcn belediye beledýye belediyespor
    bilimsel bjk bk bld bmsk bps
    br brýç bridgeclub bridgeklub 
    bs bsb bsc bsk bskd bsp bt
    bþb bþbký bsbkisk bssk buyuksehir ybsk bsbs btsc 
    cbc cfr club csb
    dbc dbk dgc 
    ebc eibc 
    fbc fc
    gençlik gkk gsb gsk gskd gtbc
    kcb kdi klubben klubberne ks ksb ksk
    mbc
    nbi nbcbl
    oaza obk 
    sb sbc sc sdgskd sk spor ss ssd
    tbc tc
    ýbmsk ýbsk)],
  'Sporting Club' => ['sporting', 'sprting'],
);


sub set_hashes_team_abbr
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
