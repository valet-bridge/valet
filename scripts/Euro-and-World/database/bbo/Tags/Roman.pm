#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Roman;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  '1' => ['i'],
  '2' => ['ii'],
  '3' => ['iii'],
  '4' => ['iv'],
  '5' => ['v'],
  '6' => ['vi'],
  '7' => ['vii'],
  '8' => ['viii'],
  '9' => ['ix'],
  '10' => ['x'],
  '11' => ['xi', 'xith'],
  '12' => ['xii'],
  '13' => ['xiii'],
  '14' => ['xiv'],
  '15' => ['xv'],
  '16' => ['xvi'],
  '17' => ['xvii'],
  '18' => ['xviii'],
  '19' => ['xix', 'xixth'],
  '20' => ['xx'],
  '21' => ['xxi'],
  '22' => ['xxii'],
  '23' => ['xxiii'],
  '24' => ['xxiv', 'xxivth'],
  '25' => ['xxv', 'xxvth'],
  '26' => ['xxvi'],
  '27' => ['xxvii'],
  '28' => ['xxviii'],
  '29' => ['xxix', 'xxixth'],
  '30' => ['xxx'],
  '31' => ['xxxi'],
  '32' => ['xxxii'],
  '33' => ['xxxiii'],
  '34' => ['xxxiv', 'xxxivth'],
  '35' => ['xxxv', 'xxxvth'],
  '36' => ['xxxvi'],
  '37' => ['xxxvii'],
  '38' => ['xxxviii'],
  '39' => ['xxxix', 'xxxixth'],
  '40' => ['xl', 'xlth'],
  '53' => ['liii']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
