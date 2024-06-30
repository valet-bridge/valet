#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Components::Gender;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Men => ["men's", "men`s"],
  Mixed => ['cat mixtas', 'categorías mixtas'],
  Open => ['open´s'],
  Seniors => ["seniors'"],
  Women => ["ladies's", "ladies'", "woman's", "women's", 'for ladies',
    'womwn'],
);

my @SINGLE_WORDS = qw(
  Open Men Women Mixed
);

my %SINGLE_TYPOS =
(
  Open => [qw(libre libres terbuka opn oprn åben acik offene opena)],
  Men => [qw(mens putra pa homme hommes varones)],
  Women => [qw(woman wemen womans womens womvn
    lady ladies ladie femme femmes damas dames damer dame damen 
    putri pi wo womvn)],
  Mixed => [qw(mix mixte mýx mixen mixt)]
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
