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
    'quater final', 'quater finals'],
  'Round-robin' => ['round robin', 'raound robin'],
  Semifinal => ['semi final', 'semi finals',
    'semi-final', 'semi-finals'],
);

my @SINGLE_WORDS = qw(
  Qualifying
  Quarterfinal
  Semifinal
);

my %SINGLE_TYPOS =
(
  Final => ['finala', 'finalds', 'finale', 'finali', 'finals',
    'finales', 'finall', 'finar', 'finas', 'finat', 'finsl', 
    'fina', 'fýnal'],
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
