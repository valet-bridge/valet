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
  'Agsar Paints',
  'Baltic Express',
  'Bangur Cement',
  'Beijing Capital',
  'Beijing Cartoon',
  'Beijing Evertrust',
  'Beijing Hull Technology',
  'Beijing Lawyers',
  'Beijing Liuhe',
  'Beijing Trinergy',
  'Beijing Dazhong',
  'Darles Santerm',
  'Dhampur Sugar Mills',
  'Djarum Black',
  'Electric Center',
  'Fisk Seafood',
  'Garðar & Vélar',
  'Garðs Apotek',
  'Geely Automobile',
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
  'Red Bull',
  'Red Cotton',
  'Phoenix TV',
  'Shanghai Automobile',
  'Shanghai Financial',
  'Shree Cement',
  'Société Générale',
  'Team PharmaService',
  'Thai Oil',
  'Tolani Shipping',
  'Trambak Rubber',
  'Unia Leszno',
  'Unia Winkhaus',
  'Viego Regnskap',
  'Zhongshan Jiegao'
);

my %MULTI_TYPOS =
(
  'Agsar Paints' => ['agsar pints'],
  'Baltic Express' => ['baltic expres'],
  'Bangur Cement' => ['bangur cements', 'bangur cment'],
  'Beijing Hull Technology' => ['beijing hull tech'],
  'Dhampur Sugar Mills' => ['dhampur sugar', 'dhampur sugars'],
  'Dongfeng' => ['dongfeng automobile'],
  'Garðar & Vélar' => ['garðar & vélar ehf.', 'garðar og vélar'],
  'Garðs Apotek' => ['garðs apótek', 'garðs apoótek'],
  'Geely Automobile' => ['geely auto'],
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
  'Shree Cement' => ['shre cement', 'shree cements'],
  'Société Générale' => ['societe generale', 'societè general'],
  'Tolani Shipping' => ['tolani shipping ltd'],
  'Unia Winkhaus' => ['winkhaus unia', 'winkhaus-unia'],
  'Viego Regnskap' => ['viego regnskap as'],
  'Zhongshan Jiegao' => ['zhong shan jie gao']
);

my @SINGLE_WORDS = qw(
  COMAL Computerland CONSUS
  Dongfeng
  Enterprise
  Lavazza
  Sagaplast Solakoglu
  Vito
);

my %SINGLE_TYPOS =
(
  Computerland => ['computerlan']
);


sub set_hashes_team_sponsor
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
