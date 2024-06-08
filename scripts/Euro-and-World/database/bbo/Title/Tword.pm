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
  'Premier League' => ['premiere league', 'premier leaugue',
    'premier leauge', 'premier lge', '1st league', 'premie league',
    'prremier league', 'premieer league'],
  'Second League' => ['2 league'],
  'Super League' => ['sup league']
);

my @SINGLE_WORDS = qw(
  Championship Congress Cup
  Festival
  Invitational
  Tournament Training Trial Trophy
  University
);

my %SINGLE_TYPOS =
(
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
  Congress => ['kongres', 'kongresowy'],
  Cup => ['cuo', 'cupn', 'cups', 'copa', 'coppa', 'coppie', 'coupe'],
  Festival => ['fest', 'festiva', 'festivan', 'festval', 'festývalý',
    'festivali', 'festivals', 'festivalul', 'bridgefestival'],
  Invitational => ['invitacion', 'invitacional', 'invitación',
    'invitasi', 'invitatatinal', 'invitatioanal', 'invitation',
    'invites', 'invitional'],
  'Premier League' => ['premieleague'],
  'Super League' => ['superleague'],
  Tournament => ['torunament', 'toruney', 'torurnament', 'torurney',
    'tourament', 'tourn', 'tourname', 'tournamnet', 'tournement',
    'tournet', 'tourney', 'turnament', 'tourmanent', 'tourna',
    'tournamnt',
    'torneo', 'tournoi', 'turniej', 'trniej', 'turno', 'trng'],
  Training => ['træning', 'practice'],
  Trial => ['trials', 'trail', 'trails', 'triaals',
    'selection', 'seleccion', 'selección', 'select', 'selectiontrials',
    'selections', 'selekction', 'selelection', 'sélection',
    'séléction'],
  Trophy => ['trofeo', 'trohy', 'trpohy', 'troph'],
  University => ['unibridge', 'uni', 'universities']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
