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
  'First Division',
);

my %MULTI_TYPOS =
(
  'First Division' => ['1_ division', '1st division', 'd1', 
    'division1', 'division 1', 'i liga', '1_division', 'a division'],
  Trial => [
    'prueba de seleccion', 
    'test event'],
);

  # Challenge 
my @SINGLE_WORDS = qw(
  Club 
  Cup
  Training 
  Trial 
);

my %SINGLE_TYPOS =
(
  Club => ['clubs', 'clut', 'clybs'],
  Cup => ['cups', 'coppa'],
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
