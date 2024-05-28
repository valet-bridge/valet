#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamDestroy;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_destroy);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  '>',
  'ÀA¬ü',
  'Bridge Team',
  'City of',
  'nat. champio',
  'No Name',
  'Premier League',
  'Pra PON',
  'Undecipherable Team',
);

my %MULTI_TYPOS =
(
  'Bridge Team' => ['bridge tem', 'bridge tea'],
  'Undecipherable Team' => ['a-hvv', 'a-srr', 'b-srk', 'g-dkr', 
    'i-aaa', 'i-vvu', 't-dbi', 't-rsb', 'v-dkm', 'v-ivi', 'v-jgd', 'y-ivz',
    'dhzhy', 'dhzy', 'fx', 'gdcd', 'gzzj', 'hssqx', 'jy', 
    'kj', 'kjy', 'lqsw', 'ly', 'lylw', 'mktx', 'qc', 'qy', 'pn',
    'scdhzy', 'scmy', 'sdlsjy', 'sey', 'sft', 'sjcd', 'sjsd', 
    'sxsdlsjy', 'szqy',
    'xdsjjt', 'xhld', 'xmxv', 'xnmf', 'xnwy', 'ycd', 'yy', 'zkwx', 'zqjk',
    'abc_n', 'cd', 'jj', 'jk', 'm', 'pk', 'sv', 't',
    'ÄÏÄþÑÅÂ×', 'ÉîÛÚÁª²©', 'ÊÀ¼Í³©´ï', 'º£ÄÏÊÓ´°', 'ÖÐ¹úÆ½°²',
    '¥æ¤j', 'ªþ¾ô±¡¸', 'µæ', '§N¥ú', '°¨¥d³q', '¥©§J¤O', '¶Rµæ'
    ]
);

my @SINGLE_WORDS = qw(
  1st 2nd 3rd 4th 5th 6th 7th 24th
  1z 2a 5a 6a 7a 8a 9a u2 
  a and as Alumni Any April Away
  Best Bridge
  Center Challenger Champion Champions City Commercial Commune
  Dist Ds Dw dwii
  Earth East ENC European Event
  Fans Festival Field
  GD GLPD Group Groupe
  Home Host
  Indi Inter International Invit Invitational
  June
  KB KDK KRS
  LD Leaders
  Match Mates Milli min Mr
  National NC NK No NONAME North npc nr NS
  og Olympiad Opponent Opponents Other Others
  Pacific pc PairNo Platinum Players Plus Point PON Prima Pusat
  Rank 
  SE Section Selected Selection South Sponsor Squad Standard Stars 
  Sunday Super SW Swiss
  Table Tennis Test TH Times Top Tournament Trials Tricks
  United
  West World
  XY
  YZ
  ZW
  Various
);

my %SINGLE_TYPOS =
(
  Bridge => ['bric', 'bdg'],
  Center => ['merkezi'],
  Challengers => ['chalengers'],
  Group => ['istis'],
  International => ['internat', 'internationa'],
  Leaders => ['leders', 'winners'],
  National => ['nasional'],
  'No Name' => ['noname'],
  North => ['nord'],
  Pacific => ['pacyfic'],
  'Pra PON' => ['prapon', 'pon'],
  South => ['syd'],
  Squad => ['squadra', 'takim', 'tim'],
  Tournament => ['tounament', 'tourney', 'trn', 'trnaway', 'trnhome'],
  World => ['worldteam']
);


sub set_hashes_team_destroy
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
