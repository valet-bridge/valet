#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamSponsor;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_sponsor);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Beijing Hull Technology',
  'Beijing Liuhe',
  'Beijing Dazhong',
  'Darles Santerm',
  'Grant Thornton',
  'J. Pereira de Sousa',
  'Novi Kod',
  'Palma Karya Mandiri',
  'Paulo G. Pereira',
  'Phoenix TV',
  'Unia Leszno',
  'Unia Winkhaus',
  'Zhongshan Jiegao'
);

my %MULTI_TYPOS =
(
  'Beijing Hull Technology' => ['beijing hull tech'],
  'Dongfeng' => ['dongfeng automobile'],
  'Grant Thornton' => ['grant thonrton', 'grantt thornton', 'bg thornton'],
  'Paulo G. Pereira' => ['p g pereira', 'p. g. pereira', 
    'pg pereira', 'p.g.pereira'],
  'Unia Winkhaus' => ['winkhaus unia', 'winkhaus-unia'],
  'Zhongshan Jiegao' => ['zhong shan jie gao']
);

my @SINGLE_WORDS = qw(
  COMAL CONSUS
  Dongfeng
  Enterprise
  Lavazza
  Sagaplast Solakoglu
  Vito
);

my %SINGLE_TYPOS =
(
);


sub set_hashes_team_sponsor
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
