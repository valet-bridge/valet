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
  'Invitational Bridge Meeting',
  "New Year's Teams",
  'Opening Tournament'
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
  "New Year's Teams" => ['new year greet tm'],
  'Opening Tournament' => ['opening tournement', 'pre nm'],
  Training => ['practice session', 'training match', 'practice match',
    'test match', 'tes match', 'practise match', 'practice matche',
    'practice matches'],
  Trial => ['prueba de seleccion', 'test event']
);

my @SINGLE_WORDS = qw(
  Bridge
  Challenge 
  Championship 
  Charity 
  Club 
  Cup
  Tournament 
  Training 
  Trial 
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
  Tournament => ['tourn', 'tourname', 'tourney', 'turnament', 
    'tourmanent', 'tourna', 'tournamnt', 'toernooi', 'turneringen', 
    'tounoi', 'torneo', 'tournoi', 'turniej', 'trniej'],
  Training => ['træning', 'practice', 'allenamento',
    'entrenamiento'],
  Trial => ['trials', 'trail', 'trails', 'triaals',
    'selection', 'seleccion', 'selección', 'select',
    'selections', 'selekction', 'selelection', 'sélection', 'selectio',
    'séléction', 'entrainement', 'slection', 'prueba']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
