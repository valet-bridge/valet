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
  'Round-robin',
);

my %MULTI_TYPOS =
(
  Qualifying => ['qualification for', 'qualification to'],
  Quarterfinal => ['quarter final', 'quarter finals', 
    'quarter-final', 'quarter-finals', 
    'quater final', 'quater finals', 'round of 8'],
  Playoff => ['play offs', 'play-off', 'play off'],
  Rof6 => ['round of 6'],
  Rof12 => ['round of 12'],
  Rof16 => ['round of 16'],
  Rof32 => ['round of 32'],
  Rof64 => ['round of 64'],
  'Round-robin' => ['round robin', 'raound robin'],
  Semifinal => ['semi final', 'semi finals',
    'semi-final', 'semi-finals', 'round of 4', 'round-of-four'],
);

my @SINGLE_WORDS = qw(
  Final
  Playoff
  Rof6 Rof12 Rof16 Rof32 Rof64
  Qualifying Quarterfinal
  Semifinal
);

my %SINGLE_TYPOS =
(
  Final => ['finala', 'finalds', 'finale', 'finali', 'finals',
    'finales', 'finall', 'finar', 'finas', 'finat', 'finsl', 
    'finais', 'finalns', 'fina³', 'fianal', 'fianl', 'fianls', 
    'fiinal', 'fina', 'fýnal'],
  Playoff => ['playoffs'],
  Qualifying => ['qualification', 'qualifications', 'qualif',
    'qualifier'],
  Quarterfinal => ['quarterfinals', 'quarterf', 'qualterfinal',
    'quaterfinal', 'quaterfinals',
    'quartetfinal', 'qurterfinal', 'qfinal', 'qf'],
  Semifinal => ['semifinals', 'semifinale', 'semifimals', 'semifi',
    'semif', 'semis', 'sf']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
