#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Person;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Andrzej Wilkosz',
  'Ashok Kapur',
  'B L Rao',
  'Boris Schapiro',
  'Brahmin Sabha',
  'Dainik Navjyoti',
  'Dr. Tolani',
  'Jaap Kokkes',
  'Janiny Wielkoszewskiej',
  'Janos Levai',
  'Jean Besse',
  'John Arkinstall',
  'Justice JM Lal',
  'Lalit Mohanka',
  'LC Sunil Rajendra',
  'Leszek Kwiatkowski',
  'Maharaja Yeshwant Rao Holkar',
  'Marit Sveaas',
  'Marsha May Sternberg',
  'Mohanlal Bhartia',
  'Mrs Jaya Jain',
  'Nandu Oke',
  'Narayan Bhojwani',
  'Necmettin Sunget',
  'Özgecan Aslan',
  'Prashant Desai',
  'Prince Albert II',
  'Prince Takamatsu',
  'PSN Sarma',
  'R N Bagla',
  'R R Gupta',
  'R Ratnam',
  'Rade Antic',
  'Rai Bahadur Modi',
  'Salvador Assael',
  'Willy Brown'
);

my %MULTI_TYPOS =
(
  'Andrzej Wilkosz' => ['a_ wilkosz'],
  'Ashok Kapur' => ['ashok kapoor'],
  'B L Rao' => ['b_l_rao'],
  'Brahmin Sabha' => ['brhman sabha'],
  'Dr. Tolani' => ['dr_ tolani', 'dr_tolani', 'dr tolani'],
  'Jaap Kokkes' => ['jaap kookes'],
  'Jean Besse' => ['jean besser'],
  'Justice JM Lal' => ['justice j m lal', 'j m lal', 'justice lal',
    'justice j_m_lal'],
  'LC Sunil Rajendra' => ['l_c_sunil rajendra'],
  'Maharaja Yeshwantrao Holkar' => ['m yeshwantrao holkar',
    'maharaja yeshwantrao holkar', 'maharaja holkar',
    'yashawantrao holkar', 'yashwant rao holkar',
    'maharaja yashwantrao holkar', 'maharaja holakar',
    'maharaja holar'],
  'Mohanlal Bhartia' => ['mohanlal bharatia', 'mohanlal bharatiya', 
    'mohon lal bharatia', 'mohanlal bhartiya', 'mohanlal bharia'],
  'Mrs Jaya Jain' => ['mrs_ jaya jain'],
  'Narayan Bhojwani' => ['narain bhojwani'],
  'Necmettin Sunget' => ['necmettin sünget'],
  'Özgecan Aslan' => ['ozgecan aslan'],
  'R N Bagla' => ['rn bagla', 'r_nbagla', 'r_n_bagla'],
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Boris Schapiro' => ['schapiro'],
  'Dr. Tolani' => ['tolani'],
  'Maharaja Yeshwantrao Holkar' => ['holkar', 'holkars'],
  'Mohanlal Bhartia' => ['bhartia', 'bhartiya'],
  'R N Bagla' => ['bagla'],
  'Rai Bahadur Modi' => ['rai bahadur'],
  'Salvador Assael' => ['assael']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
