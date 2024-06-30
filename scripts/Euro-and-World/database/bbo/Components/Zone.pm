#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Components::Zone;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'African Zone',
  'Central America and Caribbean',
  'North America',
  'South America'
);

my %MULTI_TYPOS =
(
  'African Zone' => ['african zone', 'african zonal', 'zonal africa',
    'zonal african'],
  'Central America and Caribbean' => ['central america & caribean'],
  'South America' => ['south american', 'south amerian',
    'south amercian']
);

my @SINGLE_WORDS = qw(
  ASEAN
  Balkan
  Commonwealth
  Eurasia
  Europe
  Global
  Mercosur
  Norden
);

my %SINGLE_TYPOS =
(
  Commonwealth => ['commomwealth'],
  'South America' => ['southamerica', 'sudamericano',
    'southamerican', 'sudamerican']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
