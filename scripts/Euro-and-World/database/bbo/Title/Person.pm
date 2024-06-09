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
  'Justice JM Lal',
  'Maharaja Yeshwant Rao Holkar',
  'Mohanlal Bhartia',
  'Nandu Oke',
  'Narayan Bhojwani',
  'Özgecan Aslan',
  'Prince Albert II',
  'Prince Takamatsu',
  'Salvador Assael'
);

my %MULTI_TYPOS =
(
  'Brahmin Sabha' => ['brhman sabha'],
  'Dr. Tolani' => ['dr_ tolani', 'dr_tolani', 'dr tolani'],
  'Jaap Kokkes' => ['jaap kookes'],
  'Justice JM Lal' => ['justice j m lal', 'j m lal', 'justice lal',
    'justice j_m_lal'],
  'Maharaja Yeshwantrao Holkar' => ['m yeshwantrao holkar',
    'maharaja yeshwantrao holkar', 'maharaja holkar',
    'yashawantrao holkar', 'yashwant rao holkar'],
  'Mohanlal Bhartia' => ['mohanlal bharatia', 'mohanlal bharatiya', 
    'mohon lal bhararia', 'mohanlal bhartiya'],
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
