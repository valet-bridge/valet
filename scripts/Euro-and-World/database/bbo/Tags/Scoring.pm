#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Scoring;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'IMPs Across the Field'
);

my %MULTI_TYPOS =
(
  BAM => ['board-a-match', 'b-a-m'],
  IMP => ['butler scoring', "IMP's"],
  'IMPs Across the Field' => ["imp's across the field"],
  MP => ['match point'],
);

my @SINGLE_WORDS = qw(
  MP IMP BAM Patton
);

my %SINGLE_TYPOS =
(
  MP => [qw(matchpoints machpoints macthpoints mpoints 
    matchpoint maxy mpp)],
  IMP => [qw(ýmp imps impy)],
  'IMPs Across the Field' => ['iaf']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
