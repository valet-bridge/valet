#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Components::Destroy;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'BBO Operator',
  'Empty Words',
  'Generic Team',
  'Undecipherable Team',
  


  '1v4', '2v3', '3x12', '4x12', '4v5', 
  '#7836 teams', '#8405 teams',
  '4 bd', '40 boards', 'bds 1 to 18', 'bds 19-46', 'bds 31-60',
  'eve 17-32', 'rundy 14-16',
  's5r38t2', 's5r40t2', 's5r4t2', 's5r43_t2', 's5r42t2', 's5r45t2',
  's5r2t2', 's1r7', 's2r1', 
  'k-8',
  '3way match 3 to 1 a', '3way match 3 to 1 b',
  'IIa',
  'dno_4',
  'g_m_',
  'sede', 
);

my %MULTI_TYPOS =
(
  'BBO Operator' => ['BBO1', 'BBO2', 'BB02', 'BBO3', 'BBO4', 
    'BBO5', 'BB05', 'BBO6', 'BBO7', 'BBO8', 'BBO9',
    '*BBO1', '*BBO2', '*BBO3', '*BBO4',
    'BBO 1', 'BBO 2', 'BBO 3', 'BBO 4', 'BBO 5', 'BBO - 2'],
  'Empty Words' => ['Around 52 cards in 80 years',
    'before bermuda bowl', 'bridge master champion', 
    'bridge master champions', 'by joe pochron',
    'champion of champions', 'de bridge', 'de vigraph', 'div a retour', 
    'eng comment', 'eng comments', 'eng comment in',
    'extra match', 'for 3rd pair', 'for pau', 'for the', 'in the', 
    'main event', 'match retour', 'pour pau',
    'special tournament', 'sports event', 'swe comment', 
    'swe comments', 'sw comment', 'sw comments',
    'the 80 grand challenge', 'the combat of system',
    'untitled match', 'warm up', 'Welcome to'],
  'Generic Team' => ['bridge tem', 'bridge tea'],
  'Undecipherable Team' => ['a-hvv', 'a-srr', 'b-srk', 'g-dkr',
    'i-aaa', 'i-vvu', 't-dbi', 't-rsb', 'v-dkm', 'v-ivi', 'v-jgd', 'y-ivz',
    'dhzhy', 'dhzy', 'gdcd', 'gzzj', 'hssqx', 'jy',
    'kj', 'kjy', 'lqsw', 'ly', 'lylw', 'mktx', 'qc', 'qy', 'pn',
    'scdhzy', 'scmy', 'sdlsjy', 'sey', 'sft', 'sjcd', 'sjsd',
    'sxsdlsjy', 'szqy',
    'xdsjjt', 'xhld', 'xmxv', 'xnmf', 'xnwy', 'ycd', 'yy', 'zkwx', 'zqjk',
    'abc_n', 'cd', 'jj', 'jk', 'pk', 'sv',
    'ÄÏÄþÑÅÂ×', 'ÉîÛÚÁª²©', 'ÊÀ¼Í³©´ï', 'º£ÄÏÊÓ´°', 'ÖÐ¹úÆ½°²',
    '¥æ¤j', 'ªþ¾ô±¡¸', 'µæ', '§N¥ú', '°¨¥d³q', '¥©§J¤O', '¶Rµæ']
);

my @SINGLE_WORDS = qw(
  afternoon 
  celebrations closed combat compared
  duplicate duplicato
  eagles elite étoile evening 
  hawks 
  interland
  multievent
  naturalists nature
  popular
  retour retur
  science scientists show
  transfer 

  Fluff
  Uninformative
);

my %SINGLE_TYPOS =
(
  multievent => ['multieventof'],
  naturalists => ['nauralists'],
  scientists => ['scientist'],

  Fluff => ['aa', 'abd', 'aft', 'and', 'as', 'at', 'av',
    'b!', 'bbo', 'bboz', 'bt', 'bv', 'by',
    'de', 'des', 'ds', 'du', 'dw', 'dwii', 'enc', 'eve', 'ew', 'extra', 
    'from', 'gd', 'glpd', 'het', 'im', 'in', 'jm', 'kb', 'kdk', 
    'krs', 'ktp', 'ld', 'min', 'mr', 'nc', 'nk', 'no', 'npc', 'nr', 'ns',
    'og', 'pc', 'se', 'sw', 'tc', 'te', 'teh', 'th', 'the', 'tn',
    'trn', 'ts', 'tv', 'und', 'vsa', 'vsb', 'vw','xy', 'yz', 'zw'],
  Uninformative => ['anniversary', 'annual', 'any', 'away',
    'best', 'bridge', 'bric', 'bdg',
    'centenary', 'cetenary', 'center', 'merkezi',
    'challenger', 'challengers', 'chalengers', 'champion', 'champions',
    'city', 'commercial', 'commune']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
