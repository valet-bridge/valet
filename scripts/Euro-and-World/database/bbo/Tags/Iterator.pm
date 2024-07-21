#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Iterator;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Match => ['mecz o']
);

my @SINGLE_WORDS = qw(
  Berth Boards
  Day
  Flight
  Group
  Half
  Match
  Phase Place
  Quarter 
  Rof Round
  Room Rof
  Section Segment Series Session Set Stage Stanza
  Table
  Week Weekend
);

my %SINGLE_TYPOS =
(
  Boards => ['board', 'brds', 'donnes', 'spil'],
  Flight => ['flt'],
  Group => ['gruop', 'gr', 'grp', 'groups', 'groupe',
    'istis', 'pool', 'poule'],
  Half => ['hallf', 'hlf', 'halvleg', 'halv', 'lhf', 'mt', 'ha'],
  Match => ['m', 'mathc', 'kamp', 'incontro', 'matxh', 'macth',
    'meci', 'matches', 'mo', 'maych', 'mecz', 'mac'],
  Phase => ['etap', 'fase'],
  Place => ['puesto', 'lugar'],
  Quarter => ['qtr', 'quaerter'],
  Room => ['rm'],
  Round => ['ronda', 'runde', 'runda', 'rundy', 'rnd', 'r', 'ound',
    'dg', 'devre', 'tour', 'rd', 'rounds', 'rouns', 'rueda', 'ruond',
    'rd', 'riund', 'rds', 'ound', 'ro', 'tound', 'tour', 'runder',
    'rn',  'rond', 'ronud', 'roudn', 'turno', 'turul', 'turno',
    'parte'],
  Section => ['seksjon', 'sektion'],
  Segment => ['seg', 'segm', 'segement', 'segemt', 'segmant',
    'segmen', 'segemnt', 'segmento', 'segments', 'segmetn', 'segmnet', 
    'segnment', 'sgment', 'segt', 'sengemt', 'se', 'eg', 'tempo'],
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
