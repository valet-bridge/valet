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
  'Electric Center',
  'Fisk Seafood',
  'Geely Automobile',
  'Grant Thornton',
  'India Glycols',
  'Indian Medical',
  'Indian Oil',
  'Indian Railways',
  'Indonesian Power',
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
  'Geely Automobile' => ['geely auto'],
  'Grant Thornton' => ['grant thonrton', 'grantt thornton', 'bg thornton'],
  'India Glycols' => ['india glycol', 'india glycols ltd.',
    'india glyclos', 'indian glycols'],
  'Indian Medical' => ['indian medical asso'],
  'Indian Railways' => ['indianrailways', 'indian railyaws',
    'indin railways', 'indian railway', 'indian rail'],
  'Indonesian Power' => ['indo power', 'indonesia power'],
  'Lögfræðiskrifstofa Islands' => ['lögfr.stofa íslands', 'lögfr.íslands', 
    'lögfrst. íslands', 'lögfrst.íslands', 'lögfræðisk. ísl.',
    'lögfræðiskrifst. ís', 'lögfræðist. ísl.', 'lögfræðisk. ísl.',
    'lögfræðist. ísl.', 'lögfræðist. íslands', 'lögfræðist.íslands',
    'lögfræðistofa ísl', 'lögfræðistofa ísl.'],
  'Lögfræðistofa Bjarna' => ['lögfr.st bjarna', 'lögfr.stofa bjarna',
    'lögfr.stofa ´bjarna'],
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
