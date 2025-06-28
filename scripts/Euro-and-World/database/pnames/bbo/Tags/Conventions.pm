#!perl

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
  blackwood => [
    '2wood',
    '4abl.wood',
    '7 cardblack wood',
    'b wood',
    'balck wood',
    'bl .wood',
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
    'flac wood',
    'm.wood',
    'min wood', 
    'minr wood', 
    'minor wood',
    'minör wood',
    'mn wood',
    'rkcb/wood'], 
  cappelletti => ['re cap'],
  drury => ['re-drury', 're.drury'],
  michaels => [
    'michaels unusual nt'],
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
  0314 1430 
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
  bergen => ['berg', 'berge', 'berger', 'bergin'],
  blackwood => ['black', 'bwood', 'mwood'], 
  cappelletti => ['capaletti', 'capp'],
  gerber => ['garber', 'gb', 'ger', 'gerb'],
  jacoby => [
    'jac', 'jacobi', 'jacobytransfer',
    'jakoby'],
  landy => ['landi'],
  lavinthal => ['lev', 'leventhal'],
  lebensohl => ['leb'],
  michaels => ['mic', 'michael', 'mick', 'mickael', 'micheal', 'mikael'],
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
