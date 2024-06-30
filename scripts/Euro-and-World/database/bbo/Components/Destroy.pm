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
  'Around 52 cards in 80 years',
  'before bermuda bowl', 'bridge master champion', 'by joe pochron',
  'BBO1', 'BBO2', 'BB02', 'BBO3', 'BBO4', 'BBO5', 'BB05',
  'BBO6', 'BBO7', 'BBO8', 'BBO9',
  '*BBO1', '*BBO2', '*BBO3', '*BBO4',
  'BBO 1', 'BBO 2', 'BBO 3', 'BBO 4', 'BBO 5', 'BBO - 2',
  'champion of champions',
  'de bridge', 'de vigraph', 'div a retour', 'dno_4',
  'eng comment', 'eng comments', 'eng comment in',
  'for 3rd pair', 'for pau', 'for the',
  'g_m_',
  'in the',
  'main event',
  'sede', 'special tournament', 'sports event', 'swe comment', 
  'swe comments', 'sw comment', 'sw comments',
  'the 80 grand challenge', 'the combat of system',
  'untitled match',
  'warm up', 'Welcome to'
);

my %MULTI_TYPOS =
(
  'Generic Team Team' => ['bridge tem', 'bridge tea'],
  'Undecipherable Team' => ['a-hvv', 'a-srr', 'b-srk', 'g-dkr',
    'i-aaa', 'i-vvu', 't-dbi', 't-rsb', 'v-dkm', 'v-ivi', 'v-jgd', 'y-ivz',
    'dhzhy', 'dhzy', 'gdcd', 'gzzj', 'hssqx', 'jy',
    'kj', 'kjy', 'lqsw', 'ly', 'lylw', 'mktx', 'qc', 'qy', 'pn',
    'scdhzy', 'scmy', 'sdlsjy', 'sey', 'sft', 'sjcd', 'sjsd',
    'sxsdlsjy', 'szqy',
    'xdsjjt', 'xhld', 'xmxv', 'xnmf', 'xnwy', 'ycd', 'yy', 'zkwx', 'zqjk',
    'abc_n', 'cd', 'jj', 'jk', 'pk', 'sv',
    'ÄÏÄþÑÅÂ×', 'ÉîÛÚÁª²©', 'ÊÀ¼Í³©´ï', 'º£ÄÏÊÓ´°', 'ÖÐ¹úÆ½°²',
    '¥æ¤j', 'ªþ¾ô±¡¸', 'µæ', '§N¥ú', '°¨¥d³q', '¥©§J¤O', '¶Rµæ'],

  'bridge master champion' => ['bridge master champions'],
  'extra' => ['extra match'],
  'for Pau' => ['pour pau'],
  retour => ['match retour']
);

my @SINGLE_WORDS = qw(
  aa abd aft afternoon anniversary annual as at av
  b! BBO bboz bt bv by
  centenary celebrations closed combat compared
  de des du duplicate duplicato
  eagles elite étoile eve evening ew extra
  from
  hawks het
  im in interland
  jm
  ktp
  multievent
  naturalists nature
  popular
  retour retur
  science scientists show
  tc te teh the tn transfer trn ts tv
  und
  vsa vsb
  vw
);

my %SINGLE_TYPOS =
(
  centenary => ['cetenary'],
  multievent => ['multieventof'],
  naturalists => ['nauralists'],
  scientists => ['scientist']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
