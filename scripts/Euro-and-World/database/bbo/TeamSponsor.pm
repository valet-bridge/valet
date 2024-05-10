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
  '101 Fasteignasala',
  'Abadi Adimulia',
  'Adaro Energy',
  'Agsar Paints',
  'AJ Diament',
  'Alfa Romeo',
  'APRA Clothing',
  'Apreo Logistic Poland',
  'Asindo Prima',
  'Astro A/S',
  'Baltic Express',
  'Bangur Cement',
  'Bank Indonesia',
  'Bank Mandiri',
  'Beijing Capital',
  'Beijing Cartoon',
  'Beijing Evertrust',
  'Beijing Hull Technology',
  'Beijing Lawyers',
  'Beijing Liuhe',
  'Beijing Trinergy',
  'Beijing Dazhong',
  'Bokadirekt SE',
  'Breki Jarðverk',
  'bridge24.pl',
  'BridgeBertheau.com',
  'BridgeYes.com',
  'Bridge Winners',
  'Brink Plast',
  'Century Insurance',
  'Chateau Rossenovo',
  'China Evertrust',
  'China Finance',
  'China Global Times',
  'China Resources',
  'China Trinergy',
  'Consus Oil',
  'Darles Santerm',
  'Data Steel',
  'Dhampur Sugar',
  'Djarum Black',
  'e-bridge',
  'Eden Realty Kolkata',
  'Electric Center',
  'Fisk Seafood',
  'Garðar & Vélar',
  'Garðs Apotek',
  'Geely Automobile',
  'Geologi Timah',
  'Guangzhou Pearl River',
  'Hotel Senator',
  'Hotell Strand',
  'Hreint ehf',
  'Iceland Express',
  'Inci Ayakkabi',
  'India Glycols',
  'Indian Medical',
  'Indian Oil',
  'Indian Railways',
  'Indonesian Power',
  'J. Pereira de Sousa',
  'Jasa Marga Jakarta',
  'Jiang You',
  'Jin Rong',
  'Jin Jing',
  'Jing Tie',
  'Kuncheng Group',
  'Lögfræðiskrifstofa Islands',
  'Lögfræðistofa Bjarna',
  'Lupo Veloce',
  'Málning hf',
  'Mitra Buana',
  'Mutiara Energy',
  'Nordfyns Finans',
  'Nordic Security',
  'Novi Kod',
  'PD Real Estate',
  'PD Times',
  'PD Transnational',
  'Palma Karya Mandiri',
  'Pan China Construction',
  'Paulo G. Pereira',
  'Poddar Developers',
  'Poddar Housing',
  'PRI Investment',
  'Quik Tea',
  'Red Bull',
  'Red Cotton',
  'Phoenix TV',
  'Polarman Regnskap',
  'Ronke Camping',
  'Ryan Express',
  'Samtronic Constanta',
  'Semangat Baru Makassar',
  'Shanghai Automobile',
  'Shanghai Financial',
  'Shenzhen Electronic City',
  'Shree Cement',
  'Shree Radhey',
  'Siwik Holiday Mragowo',
  'Siwik Intertrade',
  'Société Générale',
  'Sölufélag Garðyrkjumanna',
  'Sparisjóður Keflavik',
  'Sparisjóður Norðurland',
  'Sparisjóður Norðfjörður',
  'Sparisjóður Siglufjarðar',
  'Spasso Food',
  'SPS Construction',
  'Sunchime Cartoon',
  'Sunchime Fund',
  'Syabas Energy',
  'Sygnity',
  'Synergia Lublin',
  'Taste of Goa',
  'Team Audita',
  'Team PharmaService',
  'Team Secure',
  'Telkom Indonesia',
  'Telkom Speedy',
  'Telkom UseeTV',
  'Telkom@wifi.id',
  'Thai Oil',
  'Tolani Shipping Ltd',
  'Trambak Rubber',
  'Tricon Infotech',
  'Unia Leszno',
  'Unia Winkhaus',
  'Vestel',
  'Vidbot ehf',
  'Viego Regnskap',
  'Viru Valge',
  'Wuhan Dongfang',
  'Xiamen Xiashun',
  'Xiao Ying',
  'Yalu Group',
  'Yibin China Resources',
  'Yeh Bros',
  'Yunnan Dikuang Resources',
  'Z-Tech',
  'Zhongshan Jiegao'
);

my %MULTI_TYPOS =
(
  'Abadi Adimulia' => ['abadi adi mulia', 'abadi adimulya'],
  'Agsar Paints' => ['agsar pints'],
  'AJ Diament' => ['aj diamonds'],
  'Apreo Logistic Poland' => ['apreo logistic pol', 'apreo logistic pola'],
  'Baltic Express' => ['baltic expres'],
  'Bangur Cement' => ['bangur cements', 'bangur cment'],
  'Beijing Hull Technology' => ['beijing hull tech'],
  'Beijing Trinergy' => ['beijing trinergyy'],
  'Breki Jarðverk' => ['breki jarðverk ehf'],
  'bridge24.pl' => ['bridge 24', 'bridge24'],
  'Bridge Winners' => ['bridge winner', 'bridgewinners.com'],
  'Chateau Rossenovo' => ['chatteau rossenovo', 'chatteu rossenovo',
    'chaetou rosenovo', 'shato rosenovo', 'shato rossenovo'],
  'China Global Times' => ['chinal global times'],
  'Data Steel' => ['datta steel'],
  'Dhampur Sugar' => ['dhampur sugar mills', 'dhampur sugars', 
    'dhampur suger mills', 'dhampor sugar mills', 'dhampu sugar hills'],
  'Dongfeng' => ['dongfeng automobile'],
  'Eden Realty Kolkata' => ['eden city', 'eden city kolkata',
    'eden reality kolkat'],
  'Garðar & Vélar' => ['garðar & vélar ehf.', 'garðar og vélar',
    'gardar og velar'],
  'Garðs Apotek' => ['garðs apótek', 'garðs apoótek', 'gards apótek'],
  'Geely Automobile' => ['geely auto', 'gely auto', 'chaina geely'],
  'Geologi Timah' => ['geo timah', 'geo tima'],
  'Guangzhou Pearl River' => ['gz pearl river', 
    'guangzhou pearl river development'],
  'India Glycols' => ['india glycol', 'india glycols ltd.',
    'india glyclos', 'indian glycols'],
  'Indian Medical' => ['indian medical asso'],
  'Indian Railways' => ['indianrailways', 'indian railyaws',
    'indin railways', 'indian railway', 'indian rail', 'indians railways'],
  'Indonesian Power' => ['indo power', 'indonesia power'],
  'Jasa Marga Jakarta' => ['jasa marga'],
  'Kuncheng Group' => ['kucheng group'],
  'Lögfræðiskrifstofa Islands' => ['lögfr.stofa íslands', 'lögfr.íslands', 
    'lögfrst. íslands', 'lögfrst.íslands', 'lögfræðisk. ísl.',
    'lögfræðiskrifst. ís', 'lögfræðist. ísl.', 'lögfræðisk. ísl.',
    'lögfræðist. ísl.', 'lögfræðist. íslands', 'lögfræðist.íslands',
    'lögfræðistofa ísl', 'lögfræðistofa ísl.'],
  'Lögfræðistofa Bjarna' => ['lögfr.st bjarna', 'lögfr.stofa bjarna',
    'lögfr.stofa ´bjarna'],
  'Málning hf' => ['målning hf'],
  'PD Times' => ['p d times'],
  'Pan China Construction' => ['pan-china const', 'pan china construct'],
  'Pan China Group' => ['pan-china group'],
  'Paulo G. Pereira' => ['p g pereira', 'p. g. pereira', 
    'pg pereira', 'p.g.pereira'],
  'Pertamina' => ['pertamina ep', 'pertamina ft', 'pertamina field', 
    'pertamina ge', 'pertamina indonesia'],
  'Poddar Developers' => ['poddar development', 'poddar dev',
    'podder dev', 'podder developers', 'poddar devekopers',
    'poddar dovelopers'],
  Pufa => ['pu fa'],
  'Ryan Express' => ['ryan_express'],
  'Samtronic Constanta' => ['samtronic ct'],
  'Semangat Baru Makassar' => ['semangat baru mks', 'semangat baru mks.'],
  'Shanghai Automobile' => ['shanghai automoblie'],
  'Shree Cement' => ['shre cement', 'shree cements', 'sree cement',
    'sri cements'],
  'Shree Radhey' => ['shree radhye', 'shri radhey', 'shri radheya',
    'sree radhye'],
  'Siwik Holiday Mragowo' => ['siwik holiday bt', 'siwik holiday mrag',
    'siwik mragowo'],
  'Société Générale' => ['societe generale', 'societè general'],
  'Sölufélag Garðyrkjumanna' => ['sölufélag garð'],
  'Sparisjóður Keflavik' => ['sparisjóður kef'],
  'Sparisjóður Norðurland' => ['sparisjóður nord'],
  'Sparisjóður Norðfjörður' => ['sparisjóður norðfj'],
  'Sparisjóður Siglufjarðar' => ['sparisjóður sigl',
    'sparisjóður sigluf', 'sparisjóður siglufj', 'sparisj. siglufjarð'],
  'Spasso Food' => ['spassofood'],
  'Syabas Energy' => ['syabas energi', 'syabas e'],
  'Synergia Lublin' => ['synergia lubin'],
  'Team PharmaService' => ['pharma service', 'pharmaservice'],
  'Telkom Indonesia' => ['telkom ind indihome', 'telkom indonesia'],
  'Telkom Speedy' => ['telkom speedy bpn'],
  'Tolani Shipping Ltd' => ['tolani shipping'],
  'Trambak Rubber' => ['trumpak rubber'],
  'Unia Winkhaus' => ['winkhaus unia', 'winkhaus-unia'],
  'Viego Regnskap' => ['viego regnskap as'],
  'Xiao Ying' => ['xiao ying inn'],
  'Yalu Group' => ['js yalu'],
  'Yeh Bros' => ['yeh brothers', 'yer bros', "yeh's bros", 'yehs bros',
    'yer bros', 'yeoh bros'],
  'Yibin China Resources' => ['yibin cr gas', 'yibin china resourc'],
  'Yunnan Dikuang Resources' => ['yunnan dikuang', 'yun nan'],
  'Zhejiang Huamen' => ['zhe jiang hua men'],
  'Zhongshan Jiegao' => ['zhong shan jie gao']
);

my @SINGLE_WORDS = qw(
  ABAX Abnegat Actavis Akaylar Aklindo Arboned Argento Arkas Arma 
  Asindo Ayýntab

  Bajaj Banpu
  COMAL Cimentas Computerland CONSUS
  Dongfeng
  Enterprise
  GAMAX
  Hana
  IMAX
  JHS
  Lavazza Longjiangfu
  Pertamina Pufa
  Qiaoyou
  Sagaplast Solakoglu
  Vito
  Wellwise
);

my %SINGLE_TYPOS =
(
  'Adaro Energy' => ['adaro'],
  'Agsar Paints' => ['agsar'],
  Computerland => ['computerlan'],
  'Dhampur Sugar' => ['dhampur'],
  'Indian Railways' => ['railways'],
  'Málning hf' => ['málning'],
  'SPS Construction' => ['sps'],
  Wellwise => ['wellwiss']
);


sub set_hashes_team_sponsor
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
