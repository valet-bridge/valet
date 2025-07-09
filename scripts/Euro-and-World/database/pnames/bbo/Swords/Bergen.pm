#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::Bergen;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Bergen Raise',
  'Reverse Bergen',
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Bergen
);

my %SINGLE_TYPOS =
(
  Bergen => [
    'berg',
    'berga',
    'bergam',
    'bergama',
    'bergan',
    'berge',
    'bergeb',
    'bergeen',
    'bergegn',
    'bergein',
    'bergek',
    'bergem',
    'bergen',
    'bergenf',
    'bergeni',
    'bergenl',
    'bergens',
    'berger',
    'bergern',
    'berges',
    'berghen',
    'bergin',
    'bergn',
    'bergns',
    'bergon',
    'bergr',
    'bergrn',
    'bergue',
    'berguen',
    'bergun',
    'berjen',
    'bgn',
    'brg',
    'brgan',
    'brge',
    'brgen',
    'brgn',
    'brgr',
    'regber',
    'regberg'],
  'Bergen Raise' => [
    'bergenr',
    'bergenraise',
    'bergenraises',
    'bergenriases',
    'bergnrzs',
    'bergr',
    'bergrais',
    'bergraise',
    'bergraises',
    'bergrise',
    'berrai',
    'rialzibergen'],
  'Reverse Bergen' => [
    'bergenrev',
    'bergrev',
    'invertbergen',
    'rberg',
    'revber',
    'revberg',
    'revbergen',
    'revbergn',
    'revbgraise',
    'revbrg',
    'revbrgn',
    'revebergen',
    'reverseberg',
    'reversebergen',
    'rvberg',
    'rvrsbergen'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
