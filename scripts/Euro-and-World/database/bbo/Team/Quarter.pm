#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Quarter;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_quarter);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Shanghai Yangpu',
  'Villa Fabbriche'
);

my %MULTI_TYPOS =
(
  Lozenets => ['vs lozenec', 'vv lozenets'],
);

my @SINGLE_WORDS = qw(
  Adalar Agresar Akçeşme Albena Amanora Arjasa Atakoy Atakum Avren
  Bahce Bahcesehir Balcova Baragnon Bayrampaþa Beroe Bieniewo Bogazici
  Borivli Bormali Bornova Bozdogan Brotteaux Buca Buitenhof
  Çayyolu Cemara Chelsea Chislehurst Courseulles
  Ege Esenkent
  Fatih
  Gundogan
  Jomtien
  Kadikoy Karaçay Kardelen Kartal Karsiyaka Katok Kaylaka
  Kocamustafapasa Konak Korwin Kucukcekmece Küp
  Lappee Leilem Lemvourgeio Losari Lozenets
  Maadi Makaliwe Manahasa Männiku Meski Moudania Mrzenci
  Nagbagan
  Parioli
  Pinarbasi
  Polonezkoy
  Muratpasa
  Pasham
  Sansar
);

my %SINGLE_TYPOS =
(
  Akçeşme => ['akcesme', 'akçeþme'],
  Atakoy => ['ataköy'],
  Bahcesehir => ['bahçeþehýr', 'bahcesehýr', 'bahçesehir'],
  Borivli => ['borivali'],
  Çayyolu => ['cayyolu'],
  Fatih => ['fatýh'],
  Kadikoy => ['kadiköy'],
  Karsiyaka => ['Karþiyaka'],
  Küp => ['kup'],
  Manahasa => ['mnhasa'],
  Moudania => ['moydania'],
  Parioli => ['paroli']
);


sub set_hashes_team_quarter
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
