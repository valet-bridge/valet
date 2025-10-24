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
  'Ko Shing',
  'Isen Mulang',
  'Lawang Salapan',
  'Mescid-i Aksa',
  'Poiana Brasov',
  'Raewaya Hills',
  'Saint Honoré',
  'Siger Lampung'
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
  Akcay Akçeşme Albena Amanora Arjasa Atakoy Avren
  Bahce Bahcesehir Balcova Balgat Baragnon Barrière Bayrampaþa 
  Bellagatta Beroe Bieniewo Bogazici Borivli Bormali Bornova 
  Bosphorus Bozdogan Brotteaux Buca Buitenhof
  Çayyolu Cemara Cesmealti Changning Chelsea Chislehurst Civyork
  Cossipore Courseulles
  Ege Esenkent Estrela
  Fatih Fijanova Freidorf Fukien
  Gaogang Gardermoen Göktürk Gucheng Gundogan Gunebakan
  Heimdal Hirabaug Huochetou
  Incirli
  Jarville Jomtien
  Kadikoy Karaçay Kardelen Kartal Katok Kaylaka Khalkedon 
  Kirim Kocamustafapasa Konak Korwin Kucukcekmece Kurtulus Küp
  Lappee Leilem Lemvourgeio Losari Lozenets
  Maadi Makaliwe Manahasa Marmaris Männiku Meski Monceau Mrzenci 
  Muratpasa
  Nagbagan Nanshan Narbel Narita Narlidere Niski
  Olgiata
  Parioli Piloni Pinarbasi Polonezkoy Poncol Pudong Puzhong
  Qiaoxie
  Palaiseau Pasham Pato
  Radkov Recoleta Ridabu
  Sabadel Sancaktar Sansar Sarniak Senayan Serdika Setagaya
  Seved Shihua Simal Sirinyer Slaska Sredec Sukomoro Suleymanpasa 
  Suralaya
  Taihu Tama Tengah Tianya
  Uccle Ulus Unaós
  Varbergshus Vefa Viþnelik Vitacura
  Wadas Waikiki Wenang Wightwick Wratislavia Wroble Wujiang Wuyuanhe
  Yalikavak Yangpu Yarimca Yenisehir Yizhuang Yildirim Yuquan
  Yvelines
  Zaohe Zhujiang
);

my %SINGLE_TYPOS =
(
  Akçeşme => ['akcesme', 'akçeþme'],
  Amanora => ['amonara'],
  Atakoy => ['ataköy'],
  Bahcesehir => ['bahçeþehýr', 'bahcesehýr', 'bahçesehir'],
  Barrière => ['barriere'],
  Bogazici => ['boðaziçi', 'boðazýçý', 'bogazýcý'],
  Borivli => ['borivali'],
  Çayyolu => ['cayyolu'],
  Fatih => ['fatýh'],
  'Fatih Karagümrük' => ['karagümrük', 'karagumruk'],
  Göktürk => ['gokturk'],
  Hirabaug => ['hirabag'],
  Heimdal => ['heimdalbc'],
  Kadikoy => ['kadiköy'],
  'Ko Shing' => ['koshing'],
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
