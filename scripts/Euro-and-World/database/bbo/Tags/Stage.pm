#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Stage;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Closed Room',
  'Knock-out',
  'Open Room',
  'Pre-Quarterfinal',
  'Round-robin'
);

my %MULTI_TYPOS =
(
  Bronze => ['third place', '3rd place', 'bronze-finals', 
    'bronze playoff', 'bronze match', 'small final'],
  'Closed Room' => ['closed rm'],
  'Elimination' => ['head to head'],
  'Final' => ['gran final', 'super final', 'final phase', 'fase final',
    'playoff final', 'playoffs final', 'final poule', 'phase finale',
    'f i n a l', 'fin als'],
  'Knock-out' => ['knock-outs', 'knock out', 'k _ o'],
  Match => ['mecz o'],
  'Open Room' => ['open rm', 'room 1', 'or'],
  Playoff => ['play offs', 'play-off', 'play off', 'play_off'],
  'Pre-Quarterfinal' => ['pre qf', 'pr qf'],
  Qualifying => ['qualification for', 'qualification to',
    'wbg qualification', 'qualification to', 'qualifying swiss',
    'playoff qual'],
  Quarterfinal => ['quarter final', 'quarter finals', 
    'quarter-final', 'quarter-finals', 'qua fin', 'q-final', 'q_f',
    'quater final', 'quater finals', 'round of 8', 'rd of 8', 'r of 8',
    'æwieræfina³y', 'qtr finals', 'phase à 8', 'quoter-finals',
    'quet final', 'quarti finale', '1_4 finale', 'quartal final'],
  Rof6 => ['round of 6'],
  Rof12 => ['round of 12', 'rnd of12', 'phase a 12'],
  Rof14 => ['phase à 14'],
  Rof16 => ['round of 16', 'rd of 16', 'phase à 16', 'phase à16',
    'phase a 16', 'rd 0f 16', 'phase 16', 'rnd of 16', 'rof 16', 
    '1_8e finale', 'r.of 16', 'rn of 16', 'r of 16', '1_8e de finale'],
  Rof18 => ['phase a 18'],
  Rof28 => ['phase à 28', 'phase 28'],
  Rof32 => ['round of 32', 'rd of 32', 'rnd of 32', 'rof 32', 'r of 32'],
  Rof64 => ['round of 64', 'rd of 64'],
  Rof128 => ['round of 128', 'rof 128'],
  'Round-robin' => ['round robin', 'raound robin', 'r robin', 'r_robin',
    'roun robin', 'round roubin', 'round ronin', 'round bobin',
    'r_r', 'grup maçlari'],
  Semifinal => ['semi final', 'semi finals', 'semi-fiinal', 's_f',
    'semi-final', 'semi-finals', 'round of 4', 'round-of-four',
    'demi-final', 'demi-finale', 'demi-finales', 'half final', 's-final',
    'meia final', 'meias finais', 'yf', 'demi-nale', 'dsemi final',
    'yarý final', 'sem fin', 'semi <final', 'simi final',
    'pó³fina³y', 'semi and final', 'semis and finals', 'semi f',
    'playoff semi-final', 'playoffs semi final', 'semi finale',
    'play-off semi-final', 'semi- final', 'semi finall'],
  Tiebreak => ['tie break', 'tie reak', 'extra boards', 'extra stanza',
    'extra match', 'o_t', 'extra time']
);

my @SINGLE_WORDS = qw(
  Bronze
  Consolation
  Elimination
  Final
  Playoff Pool
  Rof6 Rof12 Rof16 Rof32 Rof64
  Qualifying Quarterfinal
  Repechage
  Semifinal 
  Tiebreak
);

my %SINGLE_TYPOS =
(
  Consolation => ['conso'],
  Elimination => ['eliminations'],
  Final => ['finala', 'finalds', 'finale', 'finali', 'finals',
    'finales', 'finall', 'finar', 'finas', 'finat', 'finsl', 
    'finais', 'finalns', 'fina³', 'fianal', 'fianl', 'fianls',
    'fiinal', 'fina', 'fýnal', 'finalleri', 'fina³y', 'fn',
    'filnal', 'fnal', 'fnals', 'ff',
    'slutspil', 'slutspillet', 'superfinal', 'finalen'],
  'Knock-out' => ['knockour', 'knockout', 'ko', 'kostage', 'knockouts',
    'knock'],
  Match => ['mac'],
  Phase => ['etap', 'fase'],
  Playoff => ['playoffs', 'po'],
  Pool => ['poule'],
  Qualifying => ['qualification', 'qualifications', 'qualif',
    'qualifier', 'qalifyng', 'qualy', 'qualifikation', 'qual',
    'qualifyng', 'qualýfýcatýon', 'qualification', 'qualifications', 
    'quailfy', 'qualf', 'qualfication', 'quali', 'qualify',
    'quallification', 'qulification', 'quarti',
    'qualif', 'qualifier', 'q',
    'prelim', 'preliminary', 'pre', 'pelim',
    'clasificacion', 'clasificatoria'],
  Quarterfinal => ['quarterfinals', 'quarterf', 'qualterfinal',
    'quarterfinala', 'quarterfinalb', 'quarterfinalc', 'quarterfinald',
    'quaterfinal', 'quaterfinals',
    'quartetfinal', 'qurterfinal', 'qfinal', 'qfinals', 'ottavi',
    'qf', 'qfa', 'qfb', 'qfc', 'qfd', 'qr'],
  'Pre-Quarterfinal' => ['pqf', 'preqf'],
  Repechage => ['repcharge', 'repercharge'],
  Rof12 => ['r12a', 'r12b'],
  Rof16 => ['r16a', 'r16b', 'r16c', 'r16d'],
  'Round-robin' => ['rr', 'roundrobin', 'rrr', 'rrobin'],
  Semifinal => ['semifinals', 'semifinale', 'semifimals', 'semifi',
    'semif', 'semis', 'sf', 'sfa', 'sfb', 'semi', 'semifianls',
    'semýfýnal', 'sfinals', 'sefi', 'semifinales', 'semifinali', 
    'seminfinal', 'sfinal', 'sinal'],
  Tiebreak => ['ot', 'tie', 'extra']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
