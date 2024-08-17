#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tword;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Exhibition Match',
  'Friendly Match',
  'Friendly Pairs',
  'First Division',
  'Grand National Teams',
  'International Grand Tournament',
  'National Club League',
  'National Senior Teams',
  'National Student Championship',
  'National Women Teams',
  'Neighbor Challenge',
  "New Year's Teams",
  'Opening Tournament',
  'Premier Pairs',
  'Premier League',
  'Spring National Open Teams',
  'Spring National Senior Teams',
  'Spring National Women Teams',
  'Spring Teams',
  'Summer Team Championship',
  'Super League',
  'Student Championship',
  'Swiss Teams'
);

my %MULTI_TYPOS =
(
  Championship => ["ch'ship", 'ch.ship', "champion's",
    "championship's", "chmpionship's", 'champion ship',
    'championship flight', 'championship flt'],
  Charity => ['the longest day charity match on the shortest day',
    'the longest day charity on the shortest day'],
  'First Division' => ['1_ division', '1st division', 'd1', 
    'division1', 'division 1', 'i liga', '1_division', 'a division'],
  'Friendly Match' => ['match amical', 'friendly tm'],
  'International Grand Tournament' => ['intl_ grand tournament', 
    'intl grand tournament'],
  'Neighbor Challenge' => ['neighbour challenge',
    'neighbourhood challange', 'neighbour challange'],
  "New Year's Teams" => ['new year greet tm'],
  'Opening Tournament' => ['opening tournement', 'pre nm'],
  'Premier League' => ['premiere league', 'premier leaugue',
    'premier leauge', 'premier lge', 'premie league',
    'prremier league', 'premieer league', 'premier legaue',
    'premier legue'],
  'Spring National Open Teams' => ['spring open teams'],
  'Spring National Senior Teams' => ['spring senior', 'spring seniors'],
  'Spring National Women Teams' => ['spring womens teams'],
  'Student Championship' => ['students championships'],
  'Summer Team Championship' => ['summer teams championship'],
  'Super League' => ['sup league', 'sup leg', 'sup l',
    'super leahue', 's l', 'sup-l'],
  'Swiss Teams' => ['teams swiss', 'swiss team'],
  Training => ['practice session', 'training match', 'practice match',
    'test match', 'tes match', 'practise match', 'practice matche',
    'practice matches'],
  Trial => ['prueba de seleccion', 'test event']
);

my @SINGLE_WORDS = qw(
  Bridge
  Challenge Championship Charity Club Commercial Cup
  Friendship
  Meeting Memorial
  Online
  Simultaneous
  Tournament Training Trial Trophy
);

my %SINGLE_TYPOS =
(
  Bridge => ['brdige', 'briag', 'bric', 'bridg', 'brýç'],
  'Business League' => ['blb'],
  Challenge => ['desafio', 'challengue', 'challenger'],
  Championship => ['champ', 'champion', 'champions', 
    'championshi', 'championships', 'championsihp', 'champioship', 
    'champs', 'chams', 'chmp', 'chmapionship', 'chship', 'chships', 
    'chamionship', 'chammp', 'cham', 'champhionship', 'champhionships', 
    'champi', 'champinonship', 'chamiponship', 'champinships',
    'champiomship', 'championchips', 'championhip', 'championsship',
    'champonship', 'chamrionship', 'chapionship', 'chapmionship', 
    'chmpionship', 'championhips', 'champions', 'chaionships',
    'chamapionship', 'champiosnhip', 'meistershaft', 'cs',
    'champinship', 'campeonato'],
  Club => ['clubs', 'clut', 'clybs'],
  Cup => ['cups', 'coppa'],
  'Exhibition Match' => ['exhibition'],
  'Friendly match' => ['friendly'],
  'Grand Prix' => ['gp'],
  'International Team Trials' => ['itt'],
  # 'Junior High School' => ['jhs'],
  # Memorial => ['memorials', 'menorial', 'memoral', 'memrial'],
  'National Masters' => ['nationalmasters'],
  'National Senior Teams' => ['nst'],
  'National Women Teams' => ['nwt'],
  'Senior High School' => ['shs'],
  Simultaneous => ['simultaneo'],
  'Spring National Open Teams' => ['snot'],
  'Super League' => ['superleague', 'superlige', 'superlig©',
    'superligê', 'sl'],
  Tournament => ['tourn', 'tourname', 'tourney', 'turnament', 
    'tourmanent', 'tourna', 'tournamnt', 'toernooi', 'turneringen', 
    'tounoi', 'torneo', 'tournoi', 'turniej', 'trniej'],
  Training => ['træning', 'practice', 'allenamento',
    'entrenamiento'],
  Trial => ['trials', 'trail', 'trails', 'triaals',
    'selection', 'seleccion', 'selección', 'select',
    'selections', 'selekction', 'selelection', 'sélection', 'selectio',
    'séléction', 'entrainement', 'slection', 'prueba'],
  Trophy => ['trofeo'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
