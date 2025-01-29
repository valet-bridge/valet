#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Locality;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Fatih Karagümrük',
  'Isen Mulang',
  'Lawang Salapan',
  'Poiana Brasov',
  'Raewaya Hills',
  'Saint Honoré'
);

my %MULTI_TYPOS =
(
  'Brotteaux' => ['les brotteaux', 'les brotteax'],
  'Fatih Karagümrük' => ['fatih karagumruk', 'f karagumruk', 'fatih ksk',
    'Fatýh KSK'],
  'Lawang Salapan' => ['lawang salapan kota'],
  Lozenets => ['vs lozenec', 'vv lozenets', 'v v lozenets'],
  Nanshan => ['nan shan'],
  Pudong => ['pu dong'],
  Taihu => ['tai hu'],
  Ulus => ['ulus-der'],
  Wenang => ['wenang sp'],
);

my @SINGLE_WORDS = qw(
  Akçeşme Albena Amanora Arjasa Atakoy Avren
  Bahce Bahcesehir Balcova Balgat Baragnon Barrière Bayrampaþa Beroe 
  Bieniewo Bogazici Borivli Bormali Bornova Bozdogan Brotteaux Buca 
  Buitenhof
  Çayyolu Cemara Changning Chelsea Chislehurst Courseulles
  Ege Esenkent
  Fatih Freidorf Fukien
  Gardermoen Göktürk Gucheng Gundogan
  Heimdal Hirabaug Huochetou
  Incirli
  Jarville Jomtien
  Kadikoy Karaçay Kardelen Kartal Katok Kaylaka
  Kocamustafapasa Konak Korwin Kucukcekmece Kurtulus Küp
  Lappee Leilem Lemvourgeio Losari Lozenets
  Maadi Makaliwe Manahasa Männiku Meski Mrzenci Muratpasa
  Nagbagan Nanshan Narita Narlidere Niski
  Olgiata
  Parioli Piloni Pinarbasi Polonezkoy Poncol Pudong Puzhong
  Qiaoxie
  Palaiseau Pasham
  Radkov Recoleta Ridabu
  Sabadel Sancaktar Sansar Sarniak Senayan Serdika Shihua Simal 
  Sirinyer Slaska Sredec Sukomoro Suleymanpasa Suralaya
  Taihu Tengah Tianya
  Uccle Ulus Unaós
  Varbergshus Viþnelik
  Wadas Wenang Wratislavia Wroble Wujiang Wuyuanhe
  Yalikavak Yangpu Yarimca Yenisehir Yizhuang Yildirim Yuquan
  Yvelines
  Zaohe Zhujiang
);

my %SINGLE_TYPOS =
(
  Akçeşme => ['akcesme', 'akçeþme'],
  Atakoy => ['ataköy'],
  Bahcesehir => ['bahçeþehýr', 'bahcesehýr', 'bahçesehir'],
  Barrière => ['barriere'],
  Borivli => ['borivali'],
  Çayyolu => ['cayyolu'],
  Fatih => ['fatýh'],
  'Fatih Karagümrük' => ['karagümrük', 'karagumruk'],
  Göktürk => ['gokturk'],
  Hirabaug => ['hirabag'],
  Heimdal => ['heimdalbc'],
  Kadikoy => ['kadiköy'],
  Küp => ['kup'],
  Manahasa => ['mnhasa'],
  Narlidere => ['narlýdere'],
  Olgiata => ['ola'],
  Parioli => ['paroli'],
  'Raewaya Hills' => ['raewaya'],
  Serdika => ['serdica'],
  Wroble => ['wróble'],
  Yarimca => ['Yarýmca'],
  Yildirim => ['yýldýrým']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
