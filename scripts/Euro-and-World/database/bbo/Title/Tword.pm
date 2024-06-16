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
  'Autumn National Open Teams',
  'Bridge League',
  'Bridge Meeting',
  'Business League',
  'Butler Pairs',
  "Chairman's Cup",
  'Challenge Match',
  'Commercial Pairs',
  'Easter Bridge Trophy',
  'Elite Tournament',
  'Exhibition Match',
  'Fantasy Challenge Match',
  'Friendly match',
  'Club League',
  'Club Teams Championship',
  'Division Nationale',
  'First Division',
  'Four Nations Cup',
  'Gold Swiss Pairs',
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
  'Neighbor Challenge',
  "New Year's Teams",
  'North Open',
  'North Open Teams',
  'Northern Regional',
  'Open Swiss Teams',
  'Opening Tournament',
  'Premier Pairs',
  'Premier League',
  'Pro-Am',
  'Regional Championship',
  'Second Half',
  'Second League',
  'Second Place',
  'Senior High School',
  'Spring National Open Teams',
  'Spring Teams',
  'Summer Bridge Festival',
  'Super League',
  'State Teams',
  'Swiss Pairs',
  'Third Division',
  'Third Place',
  'Top Individual',
  'Top Pairs',
  'Women Elite Tournament',
  'Winter Nationals',
  'Winter Open Teams',
  'Youth Game',
  'Youth Triathlon',
  'Youth Triathlon Individual',
  'Youth Triathlon Pairs'
);

my %MULTI_TYPOS =
(
  "Chairman's Cup" => ['chairmans cup', "chariman's cup",
    "chairmans's cup"],
  Championship => ["ch'ship", "ch'ships", 'ch.ship', "cha'ships",
    "c'ship", "c'ships", "champion's", "champions'",
    "championship's", "chmpionship's", 'champion ship'],
  Charity => ['the longest day charity match on the shortest day',
    'the longest day charity on the shortest day'],
  'Commercial Pairs' => ['comeriacial pairs'],,
  'Division Nationale' => ['division natonale', 'division ntionale',
    'division natinale', 'divison nationale', 'french dn1', 'div_nat',
    'div_ nat_', 'nationale interclubs division 1', 
    'nationale division 1'],
  'Elite Tournament' => ['elites tournament'],
  'First Division' => ['1_ division', '1st division', 'd1', 'division1',
    'division 1', 'i liga'],
  'First Half' => ['1st half'],
  'Friendly match' => ['match amical', 'friendly tm'],
  'Four Nations Cup' => ['4 nations cupn'],
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
    'intl_ grand tournament', 'intl grand tournament'],
  'International Seniors' => ['int_ seniors'],
  Interport => ['inter-port'],
  Interprovince => ['inter provincials', 'inter province',
    'inter provinces', 'inter=provincial', 'inter-provincial', 
    'inter provice'],
  Interstate => ['inter-state', 'inter state', 'inter -state'],
  Interuniversity => ['inter-university', 'inter-universities'],
  Invitational => ['invitasi terbatas'],
  'Junior/Pro' => ['jr/pro'],
  Match => ['mecz o'],
  Memorial => ['pro memoriam'],
  'Mike Lawrence Exhibition' => ['m lawrence exhibiton'],
  'Mixed Swiss Teams' => ['mixed teams swiss'],
  'Mixed Teams' => ['du 4 mixte'],
  'Mixed Tournament' => ['turniej kongresowy mixty'],
  'National Pairs Championship' => ["nacional pares por imp's",
    'nacional pares imps', 'nacional pares por imps'],
  'National Team Championship' => ['campeonato nacional de equipas'],
  'Neighbor Challenge' => ['neighbour challenge',
    'neighbourhood challange', 'neighbour challange'],
  "New Year's Teams" => ['new year greet tm'],
  'North Open' => ['north championship', 'north bridge championship'],
  'Open Swiss Teams' => ['open teams - swiss', 'open teams swiss'],
  'Opening Tournament' => ['opening tournement', 'pre nm'],
  'Premier League' => ['premiere league', 'premier leaugue',
    'premier leauge', 'premier lge', '1st league', 'premie league',
    'prremier league', 'premieer league', 'premier legaue',
    'premier legue'],
  'Pro-Am' => ['play against the stars', 'play with the champs',
    'pro_am'],
  'Regional Championship' => ['regional chship', 'regional champship'],
  'Second Half' => ['2nd half'],
  'Second League' => ['2 league', 'div b'],
  'Second Place' => ['segundo lugar'],
  'State Teams' => ['state level bridgee championship',
    'state level bridge championship',
    'state level bridge tournament'],
  'Super League' => ['sup league', 'super legue'],
  'Swiss Pairs' => ['parejas suizas', 'sw2iss pairs', 'swiis pairs'],
  'Third Division' => ['division 3'],
  'Third Place' => ['3rd place', 'bronze-finals'],
  'Top Individual' => ['top indyvidual'],
  Training => ['practice session', 'training match', 'practice match',
    'test match', 'tes match', 'practise match', 'practice matche',
    'practice matches'],
  Trial => ['prueba de seleccion', 'test event'],
  'Winter Open Teams' => ['wýnter team cs', 'winter open teams cs'],
  'Women Elite Tournament' => ["women's elite tournament"],
  'Youth Game' => ['youth games'],
  'Youth Triathlon' => ['youth triathalon'],
  'Youth Triathlon Individual' => ['youth tri individual']
);

my @SINGLE_WORDS = qw(
  Barometer Bridge
  Challenge Championship Charity Club Commercial Cup
  Friendship
  Goulash
  Interclub Intercity International Interport Interprovince Interstate 
  Interuniversity Invitational
  Match Memorial
  National
  Online
  Pool
  Segment Session Simultaneous
  Tournament Training Trial Trophy
  University
);

my %SINGLE_TYPOS =
(
  'Autumn National Open Teams' => ['anot'],
  Barometer => ['barometr'],
  Bridge => ['brdige', 'briag', 'bric', 'bridg', 'bride', 'bridgee',
    'brýç'],
  'Business League' => ['blb'],
  Challenge => ['desafio', 'challengue', 'challenger'],
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
    'meisterschaft', 'meistershaft', 'cs',
    'champinship', 'campeonato', 'campionati', 'campionato'],
  Club => ['clubs', 'clut', 'clybs'],
  Cup => ['cuo', 'cupn', 'cups', 'copa', 'coppa', 'coppie', 'coupe'],
  'Division Nationale' => ['divisionnationale', 'dn', 'pokal'],
  'Exhibition Match' => ['exhibition', 'exhibiton'],
  'Friendly match' => ['friendly'],
  Goulash => ['goullash', 'goulyash'],
  'Grand Prix' => ['gp'],
  Intercity => ['intecity'],
  Interclub => ['interclubs'],
  International => ['internacional', 'internationals',
    'internazionale'],
  'International Team Trials' => ['itt'],
  Interprovince => ['interprovincal', 'interprovincials',
    'interprovincial', 'ip'],
  Invitational => ['invitacion', 'invitacional', 'invitación',
    'invitasi', 'invitatatinal', 'invitatioanal', 'invitation',
    'invites', 'invitional', 'inivitational', 'invitatational',
    'invis', 'ivitational'],
  'Junior High School' => ['jhs'],
  Memorial => ['memorials', 'menorial', 'memoral', 'memrial'],
  National => ['natioanl', 'nationale', 'nationals', 'natonale',
    'ntionale', 'natinal', 'natinale', 'natioanal', 'nationaals',
    'nationald', "national's", 'naational', 'nacional', 'nasional', 'nat'],
  'National Masters' => ['nationalmasters'],
  'National Open Teams' => ['not'],
  'National Senior Teams' => ['nst'],
  'National Women Teams' => ['nwt'],
  'Premier League' => ['premieleague'],
  Segment => ['seg'],
  'Senior High School' => ['shs'],
  Session => ['sesje'],
  Simultaneous => ['simultaneo'],
  'Spring National Open Teams' => ['snot'],
  'Super League' => ['superleague', 'superlige', 'superlig©',
    'superligê'],
  Tournament => ['torunament', 'toruney', 'torurnament', 'torurney',
    'tourament', 'tourn', 'tourname', 'tournamnet', 'tournement',
    'tournet', 'tourney', 'turnament', 'tourmanent', 'tourna',
    'tournamnt', 'toernooi', 'turneringen',
    'torneo', 'tournoi', 'turniej', 'trniej', 'turno', 'trng'],
  Training => ['træning', 'practice', 'allenamento',
    'entrenamiento'],
  Trial => ['trials', 'trail', 'trails', 'triaals',
    'selection', 'seleccion', 'selección', 'select', 'selectiontrials',
    'selections', 'selekction', 'selelection', 'sélection',
    'séléction', 'entrainement', 'slection', 'prueba'],
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
