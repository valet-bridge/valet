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
  'Business League',
  'Division Nationale',
  'First Division',
  'Grand Prix',
  'Junior League',
  'National Club League',
  'National League',
  'Premier Pairs',
  'Premier League',
  'Second League',
  'Super League'
);

my %MULTI_TYPOS =
(
  Championship => ["ch'ship", "ch'ships", 'ch.ship', "cha'ships",
    "c'ship", "c'ships", "champion's", "champions'",
    "championship's", "chmpionship's"],
  'Division Nationale' => ['division natonale', 'division ntionale'],
  'First Division' => ['1_ division', '1st division'],
  'Intercity' => ['inter-city', 'inter city'],
  'Interclub' => ['inter-club', 'inter-clubs', 'inter club'],
  'Interprovincial' => ['inter provincials', 'inter province',
    'inter=provincial', 'inter-provincial'],
  'Interstate' => ['inter-state', 'inter state'],
  'Interuniversity' => ['inter-university', 'inter-universities'],
  'Premier League' => ['premiere league', 'premier leaugue',
    'premier leauge', 'premier lge', '1st league', 'premie league',
    'prremier league', 'premieer league', 'premier legaue',
    'premier legue'],
  'Second League' => ['2 league'],
  'Super League' => ['sup league', 'super legue']
);

my @SINGLE_WORDS = qw(
  Bridge
  Championship Club Congress Cup
  Festival
  Interclub Intercity International Interprovince Interstate 
  Interuniversity Invitational
  Memorial
  National
  Tournament Training Trial Trophy
  University
);

my %SINGLE_TYPOS =
(
  Bridge => ['brdige', 'briag', 'bric', 'bridg', 'bride', 'bridgee',
    'brýç'],
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
  Congress => ['kongres', 'kongresowy'],
  Cup => ['cuo', 'cupn', 'cups', 'copa', 'coppa', 'coppie', 'coupe'],
  'Division Nationale' => ['divisionnationale'],
  Festival => ['fest', 'festiva', 'festivan', 'festval', 'festývalý',
    'festivali', 'festivals', 'festivalul', 'bridgefestival',
    'festiwal'],
  Intercity => ['intecity'],
  Interclub => ['interclubs'],
  International => ['internacional', 'internationals',
    'internazionale'],
  Interprovince => ['interprovincal', 'interprovincials'],
  Invitational => ['invitacion', 'invitacional', 'invitación',
    'invitasi', 'invitatatinal', 'invitatioanal', 'invitation',
    'invites', 'invitional'],
  Memorial => ['memorials', 'menorial', 'memoral', 'memrial'],
  National => ['natioanl', 'nationale', 'nationals', 'natonale',
    'ntionale', 'natinal', 'natinale', 'natioanal', 'nationaals',
    'nationald', "national's", 'naational', 'nacional', 'nasional', 'nat'],
  'Premier League' => ['premieleague'],
  'Super League' => ['superleague'],
  Tournament => ['torunament', 'toruney', 'torurnament', 'torurney',
    'tourament', 'tourn', 'tourname', 'tournamnet', 'tournement',
    'tournet', 'tourney', 'turnament', 'tourmanent', 'tourna',
    'tournamnt', 'toernooi',
    'torneo', 'tournoi', 'turniej', 'trniej', 'turno', 'trng'],
  Training => ['træning', 'practice'],
  Trial => ['trials', 'trail', 'trails', 'triaals',
    'selection', 'seleccion', 'selección', 'select', 'selectiontrials',
    'selections', 'selekction', 'selelection', 'sélection',
    'séléction'],
  Trophy => ['trofeo', 'trohy', 'trpohy', 'troph'],
  University => ['unibridge', 'uni', 'universities', 'univeristies']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
