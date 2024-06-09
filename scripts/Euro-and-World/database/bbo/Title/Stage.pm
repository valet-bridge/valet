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
  'Knock-out',
  'Round-robin'
);

my %MULTI_TYPOS =
(
  'Knock-out' => ['knock-outs', 'knock - out'],
  Qualifying => ['qualification for', 'qualification to'],
  Quarterfinal => ['quarter final', 'quarter finals', 
    'quarter-final', 'quarter-finals', 
    'quater final', 'quater finals', 'round of 8', 'rd of 8', 'r of 8',
    'æwieræfina³y'],
  Playoff => ['play offs', 'play-off', 'play off'],
  Rof6 => ['round of 6'],
  Rof12 => ['round of 12'],
  Rof16 => ['round of 16', 'rd of 16', 'phase à 16', 'phase à16'],
  Rof32 => ['round of 32', 'rd of 32'],
  Rof64 => ['round of 64', 'rd of 64'],
  'Round-robin' => ['round robin', 'raound robin'],
  Semifinal => ['semi final', 'semi finals',
    'semi-final', 'semi-finals', 'round of 4', 'round-of-four'],
);

my @SINGLE_WORDS = qw(
  Elimination
  Final
  Playoff
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
    'fiinal', 'fina', 'fýnal'],
  'Knock-out' => ['knockour', 'knockout'],
  Playoff => ['playoffs'],
  Rof12 => ['r12a', 'r12b'],
  Rof16 => ['r16a', 'r16b', 'r16c', 'r16d'],
  Qualifying => ['qualification', 'qualifications', 'qualif',
    'qualifier', 'qalifyng', 'qualy', 'qualifikation', 'qual'],
  Quarterfinal => ['quarterfinals', 'quarterf', 'qualterfinal',
    'quarterfinala', 'quarterfinalb', 'quarterfinalc', 'quarterfinald',
    'quaterfinal', 'quaterfinals',
    'quartetfinal', 'qurterfinal', 'qfinal', 
    'qf', 'qfa', 'qfb', 'qfc', 'qfd'],
  Repechage => ['repcharge', 'repercharge'],
  'Round-robin' => ['rr'],
  Semifinal => ['semifinals', 'semifinale', 'semifimals', 'semifi',
    'semif', 'semis', 'sf', 'sfa', 'sfb']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
