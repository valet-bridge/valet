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
  'Bilkent University',
  'Brawijaya University',
  'Budapest University',
  'Chang Gung University',
  'Chung Hua University',
  'Columbia University',
  'Cornell University',
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
  'Selçuk University',
  'Shenyang Ligong',
  'Soochow University',
  'Tarsus American College',
  'Trakya University',
  'Umeå University',
  'UBC Hamburg',
  'University of Airlangga',
  'University of Bung Hatta',
  'University of California at Berkeley',
  'University of Chicago',
  'University of Gdansk',
  'University of Illinois',
  'University of Jember',
  'University of North Carolina',
  'University of Rijeka',
  'University of Tanjungpura',
  'University of Warsaw',
  'University of Wroclaw',
  'Universität Potsdam',
  'Valahia University',
  'Warsaw University of Technology',
  'Yildiz Technical University',
  'Zagreb University'
);

my %MULTI_TYPOS =
(
  'Akdeniz University' => ['akdenýz üný', 'akdeniz uni.'],
  'Anadolu University' => ['uni. anadolu', 'anadolu uni'],
  'Ankara University' => ['ankara uni'],
  'Bilkent University' => ['bilkent uni'],
  'Budapest University' => ['budapest uni'],
  'Cornell University' => ['cornell'],
  'École Polytechnique' => ['paris polytechnix', 'ecole polytech'],
  'Ege University' => ['ege uni'],
  'Gunadurma' => ['guna darma'],
  'ITÜ Vakfi' => ['itu vakfi'],
  'Kirsehir Republic Primary School' => ['kýrþehir cumh. ýöo'],
  'Koc University' => ['koc university bk', 'koç üniversitesi',
    'koç ünýversýtesý'],
  'Kocaeli University' => ['kocaeli üni'],
  'National Chengchi University' => ['nccu'],
  'National Chiao Tung University' => ['nctu'],
  'National Chung Hsing University' => ['nchu'],
  'Osmangazi University' => ['osmangazi uni'],
  'Selçuk University' =>['selçuk uni'],
  'Tarsus American College' => ['tarsus amer koleji', 
    'tarsus amerikan klj', 'tarsus amerikan k'],
  'Trakya University' => ['trakya uni', 'trakya tip'],
  'Umeå University' => ['umea uni'],
  'University of Airlangga' => ['univ airlangga'],
  'University of Brawijaya' => ['univ brawijaya'],
  'University of Bung Hatta' => ['univ bung hatta', 'univ. bung hatta'],
  'University of California at Berkeley' => ['cal berkeley',
    'u calif berkeley', 'cal-berkeley', 'uc berkeley', 'u berkeley'],
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
  'Yildiz Technical University' => ['ýtü']
);

my @SINGLE_WORDS = qw(
  Brandeis
  Gunadarma
);

my %SINGLE_TYPOS =
(
  'Andalas University' => ['unand'],
  'Brawijaya University' => ['brawijaya'],
  'Chang Gung University' => ['cgu'],
  'Chung Hua University' => ['chu'],
  'École Polytechnique' => ['polytech'],
  'Fu Jen Catholic University' => ['fju'],
  'National Chung Cheng University' => ['ccu'],
  'National Taiwan Normal University' => ['ntnu'],
  'National Taiwan Ocean University' => ['ntou'],
  'National Taiwan University' => ['ntu'], # Also Nanyang Tech. Uni...
  'National Tsing Hua University' => ['nthu'],
  'Northwestern University' => ['northwestern'],
  'Osmangazi University' => ['osmangazi'],
  'Soochow University' => ['scu'],
  'University of California at Berkeley' => ['berkeley'],
  'University of Wroclaw' => ['pwr'],
  'Valahia University' => ['valahia']
);


sub set_hashes_team_university
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
