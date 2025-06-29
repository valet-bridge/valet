#!perl

# These are conventions that are names after people.

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Conventions;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  bergen => [
    '2sas fit(bergen)',
    'berg rais',
    'bergan raises',
    'bergen/j-2nt',
    'bergen - hebung',
    'bergen.inv',
    'bergen inv',
    'bergen j2nt',
    'bergen jumps',
    'bergen races',
    'bergen rai',
    'bergen raise',
    'bergen raises',
    'inv bergen',
    'mod-bergen raises',
    'no bergen',
    'r-berg',
    'r bergen',
    're bergen',
    'rev.berg',
    'rev berg',
    'rev-bergen',
    'rev.bergen',
    'rev bergen',
    'rev bergen raises',
    'reverse bergen',
    'saltos bergen',
    'v.m.bergen',
    ],
  blackwood => [
    '2wood',
    '4abl.wood',
    '7 cardblack wood',
    'b wood',
    'balck wood',
    'bl .wood',
    'bl 5 cles',
    'blac wood', 
    'black wood', 
    'black- wood',
    'black-wood',
    'black.wood',
    'black/kc',
    'blackfoot wood',
    'blak kwood',
    'blak wood',
    'blak-wood',
    'blalk wood',
    'bleack wood',
    'blk wood',
    'blk.wood',
    'blk -woods',
    'bllacki wood',
    'b.wood',
    'b-wood', 
    'b/wood', 
    'b /wood', 
    'bk wood',
    'bkw en clés',
    'bl. wood', 
    'bl.wood', 
    'bl-wood', 
    'bl/wood', 
    'bl wood',
    'bolak wood',
    'bulk wood',
    'bw 5 cles',
    'bw 5 clés',
    'flac wood',
    'rkcb/wood'], 
  cappelletti => ['re cap'],
  drury => [
    '(rev) drury',
    '2 drury',
    '2d drury',
    '2t(drury',
    '2way drury',
    '2way dury',
    'drury 2d podlimit',
    'drury fit',
    'drury fitté',
    'drury inv',
    'inv. drury',
    'no drury',
    'po drury i pro 2 karo z dolem',
    're-drury', 
    're.drury',
    'rev.dury',
    'rev. drury',
    'rev drury',
    'reverse_drury',
    'reverse drury',
    ],
  ghestem => ['mod ghestem'],
  michaels => [
    'michaels unusual nt'],
  ogust => ['ogust responses'],
  stayman => [
    'majorst.man',
    's-man',
    's.man',
    's/man',
    'st.man',  
    'st-man',  
    'st. man',  
    'st/man',
    'st man',
    'stay-man', 
    'stav man', 
    'stay man', 
    'stay men', 
    'sty-man',
    'sty man'],
  voidwood => [
    'v.wood', 
    'v wood', 
    'void wood', 
    'void-wood',
    'void_wood',
    'woid-vood',
    'woid wood',
    'woit wood',
    'woýd wood'],
);

my @SINGLE_WORDS = qw(
  albarran
  baron benjamin bergen bil blackwood
  cappelletti crowhurst
  drury
  ekren english
  fantunes fishbein
  hamilton
  jacoby josephine
  gazzilli gerber ghestem goren
  jassem jordan
  landy lavinthal lebensohl lightner
  michaels muiderberg
  ogust
  rusinow
  smolen stayman stenberg
  texas truscott
  voidwood
  walsh wilkosz woolsey
);

my %SINGLE_TYPOS =
(
  bergen => [
    'berg', 'bergan', 'berge', 'bergenr', 'berger', 'bergin', 
    'bergn', 'bergrais', 'berguen'],
  blackwood => ['black', 'bw5', 'bw5cles', 'bwood',
    'rkblackwood'], 
  cappelletti => ['capaletti', 'capp'],
  drury => ['2wdrury', '2wrdrury', '2wydrury', 'drrury', 'durrury',
    'rdrury', 'revdrury', 'rvrsdrury'],
  gerber => ['garber', 'gb', 'ger', 'gerb'],
  ghestem => ['gest', 'gestam', 'gestem', 'gesthem', 'ghest', 'ghestam'],
  jacoby => [
    'jac', 'jacobi', 'jacobytransfer',
    'jakoby'],
  landy => ['landi'],
  lavinthal => ['lev', 'leventhal'],
  lebensohl => ['leb'],
  michaels => ['mic', 'michael', 'mick', 'mickael', 'micheal', 'mikael'],
  ogust => ['ougust'],
  smolen => ['smol', 'smollen'],
  stayman => [
    'sayman', 
    'staman',
    'stay', 
    'staym',
    'steaman'], 
  texas => ['tex'],
  voidwood => ['wwood'],
  wilkosz => ['wilk'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
