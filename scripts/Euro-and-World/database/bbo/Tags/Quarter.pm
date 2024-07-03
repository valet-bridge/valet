#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Quarter;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Poiana Brasov',
  'Saint Honoré',
  'Shanghai Yangpu',
  'Villa Fabbriche'
);

my %MULTI_TYPOS =
(
  Lozenets => ['vs lozenec', 'vv lozenets'],
  Pudong => ['pu dong'],
  Taihu => ['tai hu']
);

my @SINGLE_WORDS = qw(
  Adalar Agresar Akçeşme Albena Amanora Arjasa Atakoy Atakum Avren
  Bahce Bahcesehir Balcova Baragnon Barrière Bayrampaþa Beroe Bieniewo 
  Bogazici Borivli Bormali Bornova Bozdogan Brotteaux Buca Buitenhof
  Çayyolu Cemara Chelsea Chislehurst Courseulles
  Ege Esenkent
  Fatih
  Gardermoen Gundogan
  Heimdal Huochetou
  Jarville Jomtien
  Kadikoy Karaçay Kardelen Kartal Karsiyaka Katok Kaylaka
  Kocamustafapasa Konak Korwin Kucukcekmece Küp
  Lappee Leilem Lemvourgeio Losari Lozenets
  Maadi Makaliwe Manahasa Männiku Meski Moudania Mrzenci Muratpasa
  Nagbagan Narita Narlidere Norrorts
  Olgiata
  Pamukkale Parioli Piloni Pinarbasi Polonezkoy Poncol Pudong
  Qiaoxie
  Palaiseau Pasham
  Radkov Recoleta Ridabu
  Sabadel Sansar Sarniak Senayan Serdika Shihua Simal Sirinyer
  Slaska Sredec Sukomoro Suleymanpasa Suralaya
  Taihu
  Unaós
  Varbergshus Viþnelik
  Wadas Wratislavia Wroble
  Yalikavak Yarimada Yarýmca Yenisehir Yizhuang Yildirim Yuquan
  Zhujiang
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
  Heimdal => ['heimdalbc'],
  Kadikoy => ['kadiköy'],
  Karsiyaka => ['Karþiyaka'],
  Küp => ['kup'],
  Manahasa => ['mnhasa'],
  Moudania => ['moydania'],
  Narlidere => ['narlýdere'],
  Olgiata => ['ola'],
  Pamukkale => ['pamuk'],
  Parioli => ['paroli'],
  Serdika => ['serdica'],
  Wroble => ['wróble'],
  Yarýmca => ['yarimca'],
  Yildirim => ['yýldýrým']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
