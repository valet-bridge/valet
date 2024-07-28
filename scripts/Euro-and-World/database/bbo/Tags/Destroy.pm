#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Destroy;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);


my @MULTI_WORDS =
(
  'BBO Operator',
  'Empty Words',
  'Fluff Words',
  'Generic Team',
  'Undecipherable Team',

  'bds 1 to 18', 'bds 19-46', 'bds 31-60', 'eve 17-32', 'rundy 14-16',
  's5r38t2', 's5r40t2', 's5r4t2', 's5r43_t2', 's5r42t2', 's5r45t2',
  's1r7', 's2r1'
);

my %MULTI_TYPOS =
(
  'BBO Operator' => ['BBO1', 'BBO2', 'BB02', 'BBO3', 'BBO4', 
    'BBO5', 'BB05', 'BBO6', 'BBO7', 'BBO8', 'BBO9',
    '*BBO1', '*BBO2', '*BBO3', '*BBO4',
    'BBO 1', 'BBO 2', 'BBO 3', 'BBO 4', 'BBO 5', 'BBO 6', 
    'BBO 7', 'BBO 8', 'BBO 9', 'BBO - 2',
    'bbvg', 'bbovg', 'vg1', 'vg2', 'vg3', 'vg 1', 'vg 2', 'vg 3',
    'vmg 1'],
  'Empty Words' => ['Around 52 cards in 80 years',
    'before bermuda bowl', 'best play', 'bridge master champion', 
    'bridge master champions', 'by joe pochron',
    'champion of champions', 'de bridge', 'de vigraph', 'div a retour', 
    'eng comment', 'eng comments', 'eng comment in',
    'for 3rd pair', 'for pau', 'for the', 'in the', 
    'last game', 'last one!', 'last train', 'main event', 'match retour', 
    'no name', 'pour pau', 'special tournament', 'sports event', 
    'swe comment', 'swe comments', 'sw comment', 'sw comments',
    'the 80 grand challenge', 'the combat of system',
    'única sesión', 'untitled match', 'untitled segment', 
    'untitled segment1', 'warm up', 'Welcome to'],
  'Fluff Words' => ['1v4', '2v3', '3x12', '4x12', '4v5', 
    '#7836 teams', '#8405 teams', '4 bd', '40 boards', 'k-8',
    '3way match 3 to 1 a', '3way match 3 to 1 b', 
    'a&b', 'istis', 'IIa', 'dno_4', 'g_m_', 'sede'], 
  'Generic Team' => ['bridge tem', 'bridge tea'],
  'Undecipherable Team' => ['ÀA¬ü', 'a-hvv', 'a-srr', 'b-srk', 'g-dkr',
    'i-aaa', 'i-vvu', 't-dbi', 't-rsb', 'v-dkm', 'v-ivi', 'v-jgd', 'y-ivz',
    'dhzhy', 'dhzy', 'gdcd', 'gzzj', 'hssqx', 'jy',
    'kj', 'kjy', 'lqsw', 'ly', 'lylw', 'mktx', 'ns-1z', 'ns 1z',
    'qc', 'qy', 'pn',
    'scdhzy', 'scmy', 'sdlsjy', 'sey', 'sft', 'sjcd', 'sjsd',
    'sxsdlsjy', 'szqy',
    'xdsjjt', 'xhld', 'xmxv', 'xnmf', 'xnwy', 'ycd', 'yy', 'zkwx', 'zqjk',
    'abc_n', 'cd', 'jj', 'jk', 'pk', 'sv',
    'ÄÏÄþÑÅÂ×', 'ÉîÛÚÁª²©', 'ÊÀ¼Í³©´ï', 'º£ÄÏÊÓ´°', 'ÖÐ¹úÆ½°²',
    '¥æ¤j', 'ªþ¾ô±¡¸', 'ªþ¾ô±¡¸t', 'µæ', '§N¥ú', '°¨¥d³q', '¥©§J¤O', '¶Rµæ']
);

my @SINGLE_WORDS = qw(
  Fluff
  Uninformative
);

my %SINGLE_TYPOS =
(
  Fluff => ['>', 'aa', 'abd', 'aft', 'and', 'as', 'at', 'av',
    'b!', 'bbo', 'bboz', 'bt', 'bv', 'by',
    'de', 'des', 'ds', 'du', 'dw', 'dwii', 'enc', 'eve', 'ew',
    'from', 'gd', 'glpd', 'het', 'im', 'in', 'jm', 'kb', 'kdk', 
    'krs', 'ktp', 'ld', 'min', 'mr', 'nc', 'nk', 'no', 'npc', 'nr', 'ns',
    'og', 'pc', 'se', 'sw', 'tc', 'te', 'teh', 'th', 'the', 'tn',
    'ts', 'tv', 'und', 'vsa', 'vsb', 'vw','xy', 'yz', 'zw'],
  Uninformative => ['?', '*',
    'ab', 'am', 'alumni', 'anniversary', 'annual', 'any', 'away',
    'alle', 'best', 'bridge', 'bric', 'bdg',
    'celebrations', 'centenary', 'cetenary', 'center', 'challenger', 
    'challengers', 'chalengers', 'champion', 'champions', 'city', 
    'closed', 'combat', 'combined', 'commercial', 'commune', 'compared',
    'delayed', 'dist', 'duplicate', 'duplicato', 'dup',
    'è', 'earth', 'eagles', 'east', 'elite', 'étoile', 
    'fans', 'for', 'hawks', 'home', 'host',
    'inter', 'interland', 'kws',
    'last one!', 'leaders', 'leders', 
    'man', 'mandarin', 'merkezi', 'mates', 'milli', 'missed', 
    'multievent', 'multieventof',
    'naturalists', 'nature', 'nauralists', 'noname', 'nord', 'north',
    'only', 'opponent', 'opponents', 'other', 'others',
    'pairno', 'patkawan', 'platinum', 'players', 'plus', 'point', 
    'popular', 'prima',
    'rank', 'reloaded', 'retour', 'retur',
    'science', 'scientist', 'scientists', 'selected', 'show', 'south', 
    'sponsor', 'standard', 'stars', 'super', 'syd',
    'tennis', 'test', 'times', 'top', 'tournament', 'tounament',
    'tourney', 'trn', 'trnaway', 'trnhome', 'transfer', 'tricks',
    'united', 'untitled', 'us', 'various', 'vg', 'vmg', 'vp',
    'welcome', 'west', 'winners', 'world', 'worldteam']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
