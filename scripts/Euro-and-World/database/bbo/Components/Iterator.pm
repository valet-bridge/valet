#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Components::Iterator;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Berth Boards
  Day
  Flight
  Half
  Group
  Match
  Part Phase Place
  Quarter 
  Rof Round
  Room Rof
  Section Segment Series Session Set Stage Stanza
  Table Tempo Top
  Week Weekend
);

my %SINGLE_TYPOS =
(
  Boards => ['board', 'bds', 'brds', 'donnes', 'spil'],
  Flight => ['flt'],
  Group => ['gruop', 'gr', 'grp', 'groups', 'pool', 'poule'],
  Half => ['hallf', 'halvleg', 'halv', 'lhf', 'mt', 'ha'],
  Match => ['m', 'mathc', 'kamp', 'incontro', 'matxh', 'macth',
    'meci', 'matches', 'mo', 'maych', 'mecz'],
  Part => ['parte'],
  Phase => ['etap', 'fase'],
  Place => ['puesto', 'lugar'],
  Quarter => ['qtr', 'quater', 'quaerter'],
  Round => ['ronda', 'runde', 'runda', 'rundy', 'rnd', 'r', 'ound',
    'dg', 'devre', 'tour', 'rd', 'rounds', 'rouns', 'rueda', 'ruond',
    'rd', 'riund', 'rds', 'ound', 'ro', 'tound', 'tour', 'runder',
    'rn',  'rond', 'ronud', 'roudn', 'turno', 'turul', 'sr', 'turno'],
  Section => ['seksjon', 'sektion'],
  Segment => ['seg', 'segm', 'segement', 'segemt', 'segmant',
    'segmen', 'segemnt', 'segmento', 'segments', 'segmetn', 'segmnet', 
    'segnment', 'sgment', 'segt', 'sengemt', 'se', 'eg', 'seg#'],
  Series => ['seria'],
  Session => ['seesion', 'part', 'sesja', 'sess', 'serssion', 'sesion',
    'sesión', 'sesj', 'sesjon', 'sessió', 'sessión', 'ses', 'sesje',
    'sessie', 'sesson', 'sesssion', 'sessions', 'sessão',
    'segssion', 'séance', 'séan', 'seans', 'seansi'],
  Set => ['sets'],
  Stage => ['stg'],
  Stanza => ['stanzas', 'stranza', 'stsnza', 'stan', 'stanzaq'],
  Table => ['t', 'tisch']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
