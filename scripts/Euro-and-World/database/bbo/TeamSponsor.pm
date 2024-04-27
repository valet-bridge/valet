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
  'Baltic Express',
  'Bangur Cement',
  'Beijing Hull Technology',
  'Beijing Liuhe',
  'Beijing Dazhong',
  'Darles Santerm',
  'Djarum Black',
  'Grant Thornton',
  'Indian Railways',
  'J. Pereira de Sousa',
  'Lögfræðiskrifstofa Islands',
  'Lögfræðistofa Bjarna',
  'Novi Kod',
  'Palma Karya Mandiri',
  'Paulo G. Pereira',
  'Poddar Developers',
  'Poddar Housing',
  'Phoenix TV',
  'Shree Cement',
  'Trambak Rubber',
  'Unia Leszno',
  'Unia Winkhaus',
  'Zhongshan Jiegao'
);

my %MULTI_TYPOS =
(
  'Baltic Express' => ['baltic expres'],
  'Bangur Cement' => ['bangur cements', 'bangur cment'],
  'Beijing Hull Technology' => ['beijing hull tech'],
  'Dongfeng' => ['dongfeng automobile'],
  'Grant Thornton' => ['grant thonrton', 'grantt thornton', 'bg thornton'],
  'Indian Railways' => ['indianrailways'],
  'Lögfræðiskrifstofa Islands' => ['lögfr.stofa íslands', 'lögfr.íslands', 
    'lögfrst. íslands', 'lögfrst.íslands', 'lögfræðisk. ísl.',
    'lögfræðiskrifst. ís', 'lögfræðist. ísl.',
    'lögfræðist. íslands', 'lögfræðist.íslands',
    'lögfræðistofa ísl', 'lögfræðistofa ísl.'],
  'Paulo G. Pereira' => ['p g pereira', 'p. g. pereira', 
    'pg pereira', 'p.g.pereira'],
  'Poddar Developers' => ['poddar development'],
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
