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
  'Ashok Kapur',
  'Boris Schapiro',
  'Brahmin Sabha',
  'Dr. Tolani',
  'Jaap Kokkes',
  'Janiny Wielkoszewskiej',
  'Janos Levai',
  'John Arkinstall',
  'Justice JM Lal',
  'Lalit Mohanka',
  'LC Sunil Rajendra',
  'Maharaja Yeshwant Rao Holkar',
  'Mohanlal Bhartia',
  'Mrs Jaya Jain',
  'Nandu Oke',
  'Narayan Bhojwani',
  'Özgecan Aslan',
  'Prashant Desai',
  'Prince Albert II',
  'Prince Takamatsu',
  'PSN Sarma',
  'R R Gupta',
  'Salvador Assael'
);

my %MULTI_TYPOS =
(
  'Brahmin Sabha' => ['brhman sabha'],
  'Dr. Tolani' => ['dr_ tolani', 'dr_tolani', 'dr tolani'],
  'Jaap Kokkes' => ['jaap kookes'],
  'Justice JM Lal' => ['justice j m lal', 'j m lal', 'justice lal',
    'justice j_m_lal'],
  'LC Sunil Rajendra' => ['l_c_sunil rajendra'],
  'Maharaja Yeshwantrao Holkar' => ['m yeshwantrao holkar',
    'maharaja yeshwantrao holkar', 'maharaja holkar',
    'yashawantrao holkar', 'yashwant rao holkar'],
  'Mohanlal Bhartia' => ['mohanlal bharatia', 'mohanlal bharatiya', 
    'mohon lal bhararia', 'mohanlal bhartiya'],
  'Mrs Jaya Jain' => ['mrs_ jaya jain'],
  'Narayan Bhojwani' => ['narain bhojwani'],
  'Özgecan Aslan' => ['ozgecan aslan']
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Boris Schapiro' => ['schapiro'],
  'Dr. Tolani' => ['tolani'],
  'Maharaja Yeshwantrao Holkar' => ['holkar'],
  'Mohanlal Bhartia' => ['bhartia', 'bhartiya'],
  'Salvador Assael' => ['assael']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
