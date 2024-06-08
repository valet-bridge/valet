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
);

my %MULTI_TYPOS =
(
  Championship => ["ch'ship", "ch'ships", 'ch.ship', "cha'ships",
    "c'ship", "c'ships", "champion's", "champions'",
    "championship's", "chmpionship's"],
);

my @SINGLE_WORDS = qw(
  Championship
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
    'chamapionship', 'champiosnhip',
    'championnat', 'þampýyonasi',
    'champinship', 'campeonato', 'campionati', 'campionato'],
  Tournament => ['torunament', 'toruney', 'torurnament', 'torurney',
    'tourament', 'tourn', 'tourname', 'tournamnet', 'tournement',
    'tournet', 'tourney', 'turnament',
    'torneo', 'tournoi', 'turniej']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
