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
  'Autumn National Open Teams',
  'Bridge League',
  'Bridge Meeting',
  'Business League',
  'Butler Pairs',
  'Challenge Match',
  'Closed Room',
  'Commercial Pairs',
  'Easter Bridge Trophy',
  'Elite Tournament',
  'Euro-Region Cup',
  'Exhibition Match',
  'Friendly match',
  'Club Teams Championship',
  'First Division',
  'Grand National Teams',
  'Grand Prix',
  'Interbridge Tournament',
  'International Grand Tournament',
  'International Team Trials',
  'International Seniors',
  'Invitational Bridge Meeting',
  'Junior League',
  'Junior/Pro',
  'Junior High School',
  'Midsummer Juniors',
  'Mike Lawrence Exhibition',
  'Mini Swiss',
  'Mixed Teams',
  'Mixed Swiss Teams',
  'Mixed Tournament',
  'National Club League',
  'National League',
  'National Masters',
  'National Senior Teams',
  'National Student Championship',
  'National Open Teams',
  'National Pairs Championship',
  'National Team Championship',
  'National Women Teams',
  'Nations Cup',
  'NEC Cup',
  'Neighbor Challenge',
  "New Year's Teams",
  'New Zealand Trials',
  'North Open',
  'North Open Teams',
  'Northern Regional',
  'Open Room',
  'Open Swiss Teams',
  'Opening Tournament',
  'Premier Pairs',
  'Premier League',
  'Regional Championship',
  'Second Half',
  'Second League',
  'Second Place',
  'Senior High School',
  'Senior Knock-out',
  'Spring National Open Teams',
  'Spring National Senior Teams',
  'Spring National Women Teams',
  'Spring Teams',
  'Summer Bridge Festival',
  'Summer Team Championship',
  'Super League',
  'State Teams',
  'Student Championship',
  'Swiss IMP Pairs',
  'Swiss Pairs',
  'Swiss Teams',
  'Third Division',
  'Top Individual',
  'Top Pairs',
  'Winter Open Teams',
  'Youth Game',
  'Youth Triathlon',
  'Youth Triathlon Individual',
  'Youth Triathlon Pairs'
);

my %MULTI_TYPOS =
(
  Championship => ["ch'ship", 'ch.ship', "champion's",
    "championship's", "chmpionship's", 'champion ship',
    'championship flight', 'championship flt'],
  Charity => ['the longest day charity match on the shortest day',
    'the longest day charity on the shortest day'],
  'Closed Room' => ['closed rm'],
  'Commercial Pairs' => ['comeriacial pairs'],,
  'Elite Tournament' => ['elites tournament'],
  'Euro-Region Cup' => ['cup of euroregion'],
  'First Division' => ['1_ division', '1st division', 'd1', 
    'division1', 'division 1', 'i liga', '1_division', 'a division'],
  'First Half' => ['1st half', '1_halvleg', '1_ halvleg'],
  'Friendly match' => ['match amical', 'friendly tm'],
  'Grand Prix' => ['grand pix', 'grand peix', 'grad prix',
    'gran prix'],
  'International Grand Tournament' => ['intl_ grand tournament', 
    'intl grand tournament'],
  'International Seniors' => ['int_ seniors'],
  'Junior/Pro' => ['jr/pro'],
  Memorial => ['pro memoriam', 'memorial of'],
  'Mike Lawrence Exhibition' => ['m lawrence exhibiton'],
  'Mixed Swiss Teams' => ['mixed teams swiss'],
  'Mixed Teams' => ['du 4 mixte', '4 mixte', 'mixte/4'],
  'Mixed Tournament' => ['turniej kongresowy mixty'],
  'National Pairs Championship' => ["nacional pares por imp's",
    'nacional pares imps', 'nacional pares por imps'],
  'National Team Championship' => ['campeonato nacional de equipas'],
  'Neighbor Challenge' => ['neighbour challenge',
    'neighbourhood challange', 'neighbour challange'],
  "New Year's Teams" => ['new year greet tm'],
  'New Zealand Trials' => ['nz trials'],
  'North Open' => ['north championship', 'north bridge championship'],
  'Open Room' => ['open rm', 'or'],
  'Open Swiss Teams' => ['open teams swiss'],
  'Opening Tournament' => ['opening tournement', 'pre nm'],
  'Premier League' => ['premiere league', 'premier leaugue',
    'premier leauge', 'premier lge', 'premie league',
    'prremier league', 'premieer league', 'premier legaue',
    'premier legue'],
  'Regional Championship' => ['regional chship', 'regional champship'],
  'Second Half' => ['2nd half', '2_halvleg', '2_ halvleg'],
  'Second League' => ['2 league', 'div b'],
  'Second Phase' => ['ii etap'],
  'Second Place' => ['segundo lugar'],
  'Senior Knock-out' => ['senior ko'],
  'Spring National Open Teams' => ['spring open teams'],
  'Spring National Senior Teams' => ['spring senior', 'spring seniors'],
  'Spring National Women Teams' => ['spring womens teams'],
  'State Teams' => ['state level bridgee championship',
    'state level bridge championship',
    'state level bridge tournament'],
  'Student Championship' => ['students championships'],
  'Summer Team Championship' => ['summer teams championship'],
  'Super League' => ['sup league', 'sup leg', 'sup l',
    'super leahue', 's l', 'sup-l'],
  'Swiss Pairs' => ['parejas suizas', 'sw2iss pairs', 'swiis pairs',
    'swiss pair'],
  'Swiss Teams' => ['teams swiss', 'swiss team'],
  'Third Division' => ['division 3'],
  'Top Individual' => ['top indyvidual'],
  Training => ['practice session', 'training match', 'practice match',
    'test match', 'tes match', 'practise match', 'practice matche',
    'practice matches'],
  Trial => ['prueba de seleccion', 'test event'],
  'Winter Open Teams' => ['wýnter team cs'],
  'Youth Game' => ['youth games'],
  'Youth Triathlon' => ['youth triathalon'],
  'Youth Triathlon Individual' => ['youth tri individual']
);

my @SINGLE_WORDS = qw(
  Bridge
  Challenge Championship Charity Club Commercial Cup
  Friendship
  Memorial
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
  'Junior High School' => ['jhs'],
  Memorial => ['memorials', 'menorial', 'memoral', 'memrial'],
  'National Masters' => ['nationalmasters'],
  'National Open Teams' => ['not'],
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
  'Youth Triathlon Pairs' => ['youth triathalon']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
