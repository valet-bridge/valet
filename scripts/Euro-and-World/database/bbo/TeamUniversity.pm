#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamUniversity;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_university);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'AGH Krakow',
  'Akdeniz University',
  'Anadolu University',
  'Andalas University',
  'Ankara University',
  'Asko Tech University',
  'Bilkent University',
  'Brawijaya University',
  'Budapest University',
  'Chang Gung University',
  'Chung Hua University',
  'Chung Hwa Medical and Pharmaceutical University',
  'Columbia University',
  'Cornell University',
  'Diponegoro University',
  'École Polytechnique',
  'Ege University',
  'Fu Jen Catholic University',
  'Gunadurma',
  'ITS IKOMA',
  'ITÜ Vakfi',
  'Jiangsu Tianyi',
  'Karel de Grote',
  'Kirsehir Republic Primary School',
  'Kocaeli University',
  'Koc University',
  'KU Leuven',
  'Kusuma Bangsa',
  'KwaZulu Natal',
  'Manado State University',
  'National Chengchi University',
  'National Chiao Tung University',
  'National Chung Cheng University',
  'National Chung Hsing University',
  'National Taiwan Normal University',
  'National Taiwan Ocean University',
  'National Taiwan University',
  'National Tsing Hua University',
  'Northwestern University',
  'Osmangazi University',
  'Paris ECE',
  'Riau University',
  'Sam Ratulangi University',
  'Selçuk University',
  'Shenyang Ligong',
  'Sekolah Tinggi Teknologi',
  'Senior High School',
  'Stanford University',
  'Soochow University',
  'Tarsus American College',
  'Telkom University',
  'Trakya University',
  'Umeå University',
  'UBC Hamburg',
  'Universitas Muhammadiyah Gresik',
  'University of Airlangga',
  'University of Bung Hatta',
  'University of California at Berkeley',
  'University of Chicago',
  'University of Gdansk',
  'University of Illinois',
  'University of Indonesia',
  'University of Jember',
  'University of North Carolina',
  'University of Porto',
  'University of Rijeka',
  'University of Surabaya',
  'University of Tanjungpura',
  'University of Warsaw',
  'University of Wroclaw',
  'Universität Potsdam',
  'Valahia University',
  'Warsaw University of Technology',
  'Wroclaw University of Science and Technology',
  'Yildiz Technical University',
  'Zagreb University'
);

my %MULTI_TYPOS =
(
  'Akdeniz University' => ['akdenýz üný', 'akdeniz uni.'],
  'Anadolu University' => ['uni. anadolu', 'anadolu uni',
    'uni anadolu'],
  'Ankara University' => ['ankara uni'],
  'Asko Tech University' => ['asko-tech', 'asco tech', 'asko tech'],
  'Bilkent University' => ['bilkent uni'],
  'Budapest University' => ['budapest uni'],
  'Cornell University' => ['cornell'],
  'École Polytechnique' => ['paris polytechnix', 'ecole polytech'],
  'Ege University' => ['ege uni'],
  'Gunadurma' => ['guna darma'],
  'ITÜ Vakfi' => ['itu vakfi'],
  'Kirsehir Republic Primary School' => ['kýrþehir cumh. ýöo'],
  'Koc University' => ['koc university bk', 'koç üniversitesi',
    'koç ünýversýtesý', 'koc uni'],
  'Kocaeli University' => ['kocaeli üni'],
  'National Chengchi University' => ['nccu'],
  'National Chiao Tung University' => ['nctu'],
  'National Chung Hsing University' => ['nchu'],
  'Osmangazi University' => ['osmangazi uni'],
  'Selçuk University' =>['selçuk uni'],
  'Senior High School' => ['sekolah menengah atas', 'sma kimia'],
  'Tarsus American College' => ['tarsus amer koleji', 
    'tarsus amerikan klj', 'tarsus amerikan k'],
  'Trakya University' => ['trakya uni', 'trakya tip'],
  'Umeå University' => ['umea uni'],
  'University of Airlangga' => ['univ airlangga'],
  'University of Brawijaya' => ['univ brawijaya'],
  'University of Bung Hatta' => ['univ bung hatta', 'univ. bung hatta'],
  'University of California at Berkeley' => ['cal berkeley',
    'u calif berkeley', 'cal-berkeley', 'uc berkeley', 'u berkeley',
    'u cal berkeley'],
  'University of Chicago' => ['u chicago'],
  'University of Gdansk' => ['uni gdansk', 'gdank univ poland',
    'gdansk univ poland'],
  'University of Illinois' => ['u of illinois', 'u illinois uc'],
  'University of Jember' => ['univ jember'],
  'University of North Carolina' => ['u n. carolina'],
  'University of Rijeka' => ['uni of rijeka'],
  'University of Warsaw' => ['uni warsaw'],
  'University of Wroclaw' => ['uni wroclaw', 'Politechnika Wrocławska'],
  'University of Tanjungpura' => ['untan'],
  'Universität Potsdam' => ['uni potsdam'],
  'Warsaw University of Technology' => ['warsaw ut'],
  'Wroclaw University of Science and Technology' => 
    ['Politechnika Wroclawska', 'polit wroclaw', 'polite wroclaw',
    'polit wr', 'politechnika wr', 'azs pw'],
  'Yildiz Technical University' => ['ýtü']
);

my @SINGLE_WORDS = qw(
  Brandeis
  CCUB
  Gunadarma
  Radboud
);

my %SINGLE_TYPOS =
(
  'Andalas University' => ['unand'],
  'Asko Tech University' => ['atu'],
  'Bilkent University' => ['bilkent'],
  'Brawijaya University' => ['brawijaya'],
  'Chang Gung University' => ['cgu'],
  'Chung Hua University' => ['chu'],
  'Chung Hwa Medical and Pharmaceutical University' => ['cmu'],
  'Diponegoro University' => ['undip'],
  'École Polytechnique' => ['polytech'],
  'Fu Jen Catholic University' => ['fju'],
  'Koc University' => ['koc'],
  'Manado State University' => ['unima'],
  'National Chung Cheng University' => ['ccu'],
  'National Taiwan Normal University' => ['ntnu'],
  'National Taiwan Ocean University' => ['ntou'],
  'National Taiwan University' => ['ntu', 'btu'], 
  # Also Nanyang Tech. Uni...
  'National Tsing Hua University' => ['nthu'],
  'Northwestern University' => ['northwestern'],
  'Osmangazi University' => ['osmangazi'],
  'Riau University' => ['unri'],
  'Sam Ratulangi University' => ['unsrat'],
  'Sekolah Tinggi Teknologi' => ['stt'],
  'Senior High School' => ['shs', 'sma', 'sman'],
  'Soochow University' => ['scu'],
  'Stanford University' => ['stanford'],
  'Universitas Muhammadiyah Gresik' => ['unmuh'],
  'Universitas Tanjungpura' => ['untan'],
  'University of Airlangga' => ['unair'],
  'University of California at Berkeley' => ['berkeley'],
  'University of Indonesia' => ['ui'],
  'University of Porto' => ['cdup'],
  'University of Surabaya' => ['ubaya'],
  'University of Wroclaw' => ['pwr'],
  'Valahia University' => ['valahia'],
  'Wroclaw University of Science and Technology' => ['pwr']
);


sub set_hashes_team_university
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
