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
  'Antalya Halk Egitim',
  'Asko Tech University',
  'Bandung Institute of Technology',
  'Bilkent University',
  'Brawijaya University',
  'Budapest University',
  'Chang Gung University',
  'Chien Kuo Senior High School',
  'Chung Hua University',
  'Chung Hwa Medical and Pharmaceutical University',
  'Columbia University',
  'Cornell University',
  'Croatia University',
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
  'Makassar University',
  'Manado State University',
  'Miaoli Senior High School',
  'Middle East Technical University',
  'Nahdlatul Ulama Alumni',
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
  'Ren Da Fu Zhong',
  'Riau University',
  'Sam Ratulangi University',
  'Selçuk University',
  'Shenyang Ligong',
  'Sekolah Tinggi Teknologi',
  'Senior High School',
  'Soochow University',
  'Stanford University',
  'Sekolah Tinggi Ilmu Statistik',
  'Tarsus American College',
  'Telkom University',
  'Trakya University',
  'Umeå University',
  'UBC Hamburg',
  'Universitas Gadjah Mada',
  'Universitas Muhammadiyah Gresik',
  'Universitas Riau Bridge Club',
  'Universitas Sriwijaya',
  'Universitas Sumatera Utara',
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
  'Akdeniz University' => ['akdenýz üný', 'akdeniz uni.', 'd.akdený'],
  'Anadolu University' => ['uni. anadolu', 'anadolu uni',
    'uni anadolu'],
  'Ankara University' => ['ankara uni'],
  'Asko Tech University' => ['asko-tech', 'asco tech', 'asko tech'],
  'Bilkent University' => ['bilkent uni'],
  'Budapest University' => ['budapest uni'],
  'Croatia University' => ['cro uni'],
  'École Polytechnique' => ['paris polytechnix', 'ecole polytech'],
  'Ege University' => ['ege uni'],
  'Gunadurma' => ['guna darma'],
  'ITÜ Vakfi' => ['itu vakfi'],
  'Kirsehir Republic Primary School' => ['kýrþehir cumh. ýöo'],
  'Koc University' => ['koc university bk', 'koç üniversitesi',
    'koç ünýversýtesý', 'koc uni'],
  'Kocaeli University' => ['kocaeli üni'],
  'Nahdlatul Ulama Alumni' => ['nu alumni'],
  'National Chengchi University' => ['nccu'],
  'National Chiao Tung University' => ['nctu'],
  'National Chung Hsing University' => ['nchu'],
  'National Taiwan University' => ['abc_e', 'btu-p', 'btu-u', 
    'btu-y', 'ntu-pac'],
  'Osmangazi University' => ['osmangazi uni'],
  'Selçuk University' =>['selçuk uni'],
  'Senior High School' => ['sekolah menengah atas', 'sma kimia'],
  'Tarsus American College' => ['tarsus amer koleji',
    'tarsus american col', 'tarsus amerikan klj', 'tarsus amerikan k', 
    'tarsus a koleji', 'tarsus amerikan', 'tarsus amerikan col',
    't.a.c'],
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
    'polit wr', 'politechnika wr', 'azs pw', 'politehnica cluj',
    'poli cluj', 'poli'],
  'Yildiz Technical University' => ['yildiz sp.']
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
  'Bandung Institute of Technology' => ['ibt'],
  'Bilkent University' => ['bilkent'],
  'Brawijaya University' => ['brawijaya'],
  'Chang Gung University' => ['cgu'],
  'Chien Kuo Senior High School' => ['ckbc'],
  'Chung Hua University' => ['chu'],
  'Cornell University' => ['cornell'],
  'Chung Hwa Medical and Pharmaceutical University' => ['cmu'],
  'Diponegoro University' => ['undip'],
  'École Polytechnique' => ['polytech'],
  'Fu Jen Catholic University' => ['fju'],
  'Koc University' => ['koc'],
  'Makassar University' => ['mu'],
  'Manado State University' => ['unima'],
  'Miaoli Senior High School' => ['cbb'],
  'Middle East Technical University' => ['odtu'],
  'National Chung Cheng University' => ['ccu'],
  'National Taiwan Normal University' => ['ntnu'],
  'National Taiwan Ocean University' => ['ntou'],
  'National Taiwan University' => ['ntu', 'btu'], 
  # Also Nanyang Tech. Uni...
  'National Tsing Hua University' => ['nthu'],
  'Northwestern University' => ['northwestern'],
  'Osmangazi University' => ['osmangazi'],
  'Ren Da Fu Zhong' => ['rdfz'],
  'Riau University' => ['unri'],
  'Sam Ratulangi University' => ['unsrat'],
  'Sekolah Tinggi Teknologi' => ['stt'],
  'Senior High School' => ['shs', 'sma', 'sman'],
  'Soochow University' => ['scu'],
  'Stanford University' => ['stanford'],
  'Sekolah Tinggi Ilmu Statistik' => ['stis'],
  'Tarsus American College' => ['tarsus'],
  'University of Brawijaya' => ['ub'],
  'Universitas Gadjah Mada' => ['ugm'],
  'Universitas Muhammadiyah Gresik' => ['unmuh'],
  'Universitas Riau Bridge Club' => ['urbc'],
  'Universitas Sriwijaya' => ['unsri'],
  'Universitas Tanjungpura' => ['untan'],
  'Universitas Sumatera Utara' => ['usu'],
  'University of Airlangga' => ['unair'],
  'University of California at Berkeley' => ['berkeley'],
  'University of Indonesia' => ['ui'],
  'University of Jember' => ['unej'],
  'University of Porto' => ['cdup'],
  'University of Surabaya' => ['ubaya'],
  'University of Warsaw' => ['uw'],
  'University of Wroclaw' => ['pwr'],
  'Valahia University' => ['valahia'],
  'Wroclaw University of Science and Technology' => ['pwr'],
  'Yildiz Technical University' => ['ýtü']
);


sub set_hashes_team_university
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
