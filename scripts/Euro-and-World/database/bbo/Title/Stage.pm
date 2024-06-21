#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Stage;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Closed Room',
  'Knock-out',
  'Open Room',
  'Round-robin'
);

my %MULTI_TYPOS =
(
  'Closed Room' => ['closed rm'],
  'Elimination' => ['head to head'],
  'Final' => ['gran final', 'super final', 'final phase'],
  'Knock-out' => ['knock-outs', 'knock - out'],
  Match => ['mecz o'],
  'Open Room' => ['open rm', 'room 1'],
  Playoff => ['play offs', 'play-off', 'play off'],
  Qualifying => ['qualification for', 'qualification to',
    'wbg qualification', 'qualification to', 'qualifying swiss'],
  Quarterfinal => ['quarter final', 'quarter finals', 
    'quarter-final', 'quarter-finals', 
    'quater final', 'quater finals', 'round of 8', 'rd of 8', 'r of 8',
    'æwieræfina³y', 'qtr finals', 'phase à 8', 'quoter-finals'],
  Rof6 => ['round of 6'],
  Rof12 => ['round of 12'],
  Rof14 => ['phase à 14'],
  Rof16 => ['round of 16', 'rd of 16', 'phase à 16', 'phase à16',
    'rd 0f 16', 'phase 16', 'rnd of 16'],
  Rof28 => ['phase à 28', 'phase 28'],
  Rof32 => ['round of 32', 'rd of 32', 'rnd of 32'],
  Rof64 => ['round of 64', 'rd of 64'],
  'Round-robin' => ['round robin', 'raound robin'],
  Semifinal => ['semi final', 'semi finals', 'semi-fiinal', 's_f',
    'semi-final', 'semi-finals', 'round of 4', 'round-of-four',
    'demi-final', 'demi-finale', 'demi-finales', 'half final', 's-final',
    'meia final', 'meias finais', 'yf', 'demi-nale', 'dsemi final',
    'pó³fina³y', 'semi and final', 'semis and finals'],
);

my @SINGLE_WORDS = qw(
  Elimination
  Final
  Playoff Pool
  Rof6 Rof12 Rof16 Rof32 Rof64
  Qualifying Quarterfinal
  Repechage
  Semifinal 
);

my %SINGLE_TYPOS =
(
  Elimination => ['eliminations'],
  Final => ['finala', 'finalds', 'finale', 'finali', 'finals',
    'finales', 'finall', 'finar', 'finas', 'finat', 'finsl', 
    'finais', 'finalns', 'fina³', 'fianal', 'fianl', 'fianls',
    'fiinal', 'fina', 'fýnal', 'finalleri', 'fina³y', 'fn',
    'slutspil', 'slutspillet', 'superfinal', 'finalen'],
  'Knock-out' => ['knockour', 'knockout', 'ko'],
  Phase => ['etap', 'fase'],
  Playoff => ['playoffs', 'po'],
  Pool => ['poule'],
  Qualifying => ['qualification', 'qualifications', 'qualif',
    'qualifier', 'qalifyng', 'qualy', 'qualifikation', 'qual',
    'qualifyng', 'qualýfýcatýon'],
  Quarterfinal => ['quarterfinals', 'quarterf', 'qualterfinal',
    'quarterfinala', 'quarterfinalb', 'quarterfinalc', 'quarterfinald',
    'quaterfinal', 'quaterfinals',
    'quartetfinal', 'qurterfinal', 'qfinal', 
    'qf', 'qfa', 'qfb', 'qfc', 'qfd', 'qr'],
  Repechage => ['repcharge', 'repercharge'],
  Rof12 => ['r12a', 'r12b'],
  Rof16 => ['r16a', 'r16b', 'r16c', 'r16d'],
  'Round-robin' => ['rr'],
  Semifinal => ['semifinals', 'semifinale', 'semifimals', 'semifi',
    'semif', 'semis', 'sf', 'sfa', 'sfb', 'semi'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
