#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Tword;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Bridge League',
  'Bridge Meeting',
  'Business League',
  "Chairman's Cup",
  'Challenge Match',
  'Commercial Pairs',
  'Exhibition Match',
  'Fantasy Challenge Match',
  'Club League',
  'Club Teams Championship',
  'Division Nationale',
  'First Division',
  'Gold Swiss Pairs',
  'Grand National Teams',
  'Grand Prix',
  'International Grand Tournament',
  'International Team Trials',
  'Invitational Bridge Meeting',
  'Junior League',
  'Midsummer Juniors',
  'National Club League',
  'National League',
  'National Student Championship',
  'National Pairs Championship',
  'National Team Championship',
  'Neighbor Challenge',
  "New Year's Teams",
  'Premier Pairs',
  'Premier League',
  'Pro-Am',
  'Second Half',
  'Second League',
  'Second Place',
  'Summer Bridge Festival',
  'Super League',
  'Third Place',
  'Women Elite Tournament',
  'Winter Nationals',
  'Winter Open Teams',
  'Youth Triathlon Pairs'
);

my %MULTI_TYPOS =
(
  "Chairman's Cup" => ['chairmans cup'],
  Championship => ["ch'ship", "ch'ships", 'ch.ship', "cha'ships",
    "c'ship", "c'ships", "champion's", "champions'",
    "championship's", "chmpionship's", 'champion ship'],
  Charity => ['the longest day charity match on the shortest day',
    'the longest day charity on the shortest day'],
  'Commercial Pairs' => ['comeriacial pairs'],,
  'Division Nationale' => ['division natonale', 'division ntionale',
    'division natinale', 'divison nationale', 'french dn1'],
  'First Division' => ['1_ division', '1st division'],
  'Grand National Teams' => ['gnt'],
  'Grand Prix' => ['grand pix', 'grand peix', 'grad prix',
    'gran prix'],
  'Grand Tournament' => ['grand torurnament', 'grand torunament',
    'grand tourney', 'grant toruney', 'grand torurney',
    'grand tournet'],
  Intercity => ['inter-city', 'inter city', 'land inter-city'],
  Interclub => ['inter-club', 'inter-clubs', 'inter club',
    "de l'interclub"],
  'International Grand Tournament' => ['intl_ gran tournament',
    'intl_ grand tournament'],
  Interprovincial => ['inter provincials', 'inter province',
    'inter=provincial', 'inter-provincial'],
  Interstate => ['inter-state', 'inter state'],
  Interuniversity => ['inter-university', 'inter-universities'],
  Invitational => ['invitase terbatas'],
  Memorial => ['pro memoriam'],
  'National Pairs Championship' => ["nacional pares por imp's",
    'nacional pares imps', 'nacional pares por imps'],
  'National Team Championship' => ['campeonato nacional de equipas'],
  'Neighbor Challenge' => ['neighbour challenge',
    'neighbourhood challange', 'neighbour challange'],
  "New Year's Teams" => ['new year greet tm'],
  'Premier League' => ['premiere league', 'premier leaugue',
    'premier leauge', 'premier lge', '1st league', 'premie league',
    'prremier league', 'premieer league', 'premier legaue',
    'premier legue'],
  'Pro-Am' => ['play against the stars', 'play with the champs',
    'pro_am'],
  'Second Half' => ['2nd half'],
  'Second League' => ['2 league', 'div b'],
  'Second Place' => ['segundo lugar'],
  'Super League' => ['sup league', 'super legue'],
  'Third Place' => ['3rd place'],
  Training => ['practice session', 'training match', 'practice match',
    'test match', 'tes match', 'practise match'],
  Trial => ['prueba de seleccion'],
  'Winter Open Teams' => ['wýnter team cs', 'winter open teams cs'],
  'Women Elite Tournament' => ["women's elite tournament"]
);

my @SINGLE_WORDS = qw(
  Barometer Bridge
  Championship Charity Club Cup
  Goulash Group
  Interclub Intercity International Interport Interprovince Interstate 
  Interuniversity Invitational
  Match Memorial
  National
  Pool
  Segment Session Simultaneous
  Tournament Training Trial Trophy
  University
);

my %SINGLE_TYPOS =
(
  Barometer => ['barometr'],
  Bridge => ['brdige', 'briag', 'bric', 'bridg', 'bride', 'bridgee',
    'brýç'],
  'Business League' => ['blb'],
  Championship => ['campionship', 'champ', 'champion', 'champions', 
    'championshi', 'championshio', 'championships', 'championsihp', 
    'champioship', 'champioships', 'champoinsihp', 'champs', 'chams', 
    'champoinship', 'chmp', 'chmapionship', 'chship', 'chships', 
    'chamions', 'chamionship', 'chamiponsihp', 'chammp', 'cham',
    'champhionship', 'champhionships', 'champi', 'champinonship', 
    'chamiponship', 'champinships', 'champiomshio',
    'champiomship', 'championchips', 'championhip', 'championsship',
    'champonship', 'champship', 'champsionship', 'chamrionship',
    'chanpionship', 'chapionship', 'chapmionship', 'chmpionship',
    'championhips', 'champions', 'chaionships',
    'chamapionship', 'champiosnhip', 'cship',
    'championnat', 'þampýyonasi',
    'meisterschaft', 'meistershaft',
    'champinship', 'campeonato', 'campionati', 'campionato'],
  Club => ['clubs', 'clut', 'clybs'],
  Cup => ['cuo', 'cupn', 'cups', 'copa', 'coppa', 'coppie', 'coupe'],
  'Division Nationale' => ['divisionnationale', 'dn'],
  'Exhibition Match' => ['exhibition', 'exhibiton'],
  Goulash => ['goullash', 'goulyash'],
  Intercity => ['intecity'],
  Interclub => ['interclubs'],
  International => ['internacional', 'internationals',
    'internazionale'],
  'International Team Trials' => ['itt'],
  Interport => ['inter-port'],
  Interprovince => ['interprovincal', 'interprovincials'],
  Invitational => ['invitacion', 'invitacional', 'invitación',
    'invitasi', 'invitatatinal', 'invitatioanal', 'invitation',
    'invites', 'invitional', 'inivitational', 'invitatational',
    'invis'],
  Match => ['mecz'],
  Memorial => ['memorials', 'menorial', 'memoral', 'memrial'],
  National => ['natioanl', 'nationale', 'nationals', 'natonale',
    'ntionale', 'natinal', 'natinale', 'natioanal', 'nationaals',
    'nationald', "national's", 'naational', 'nacional', 'nasional', 'nat'],
  'Premier League' => ['premieleague'],
  Segment => ['seg'],
  Session => ['sesje'],
  Simultaneous => ['simultaneo'],
  'Super League' => ['superleague', 'superlige', 'superlig©',
    'superligê'],
  Tournament => ['torunament', 'toruney', 'torurnament', 'torurney',
    'tourament', 'tourn', 'tourname', 'tournamnet', 'tournement',
    'tournet', 'tourney', 'turnament', 'tourmanent', 'tourna',
    'tournamnt', 'toernooi',
    'torneo', 'tournoi', 'turniej', 'trniej', 'turno', 'trng'],
  Training => ['træning', 'practice'],
  Trial => ['trials', 'trail', 'trails', 'triaals',
    'selection', 'seleccion', 'selección', 'select', 'selectiontrials',
    'selections', 'selekction', 'selelection', 'sélection',
    'séléction', 'entrainement', 'slection'],
  Trophy => ['trofeo', 'trohy', 'trpohy', 'troph'],
  University => ['unibridge', 'uni', 'universities', 'univeristies'],
  'Youth Triathlon Pairs' => ['youth triathalon']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
