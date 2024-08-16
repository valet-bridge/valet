#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Gender;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Men => ["men's", "men`s"],
  Mixed => ['cat mixtas', 'categorías mixtas'],
  Open => ['open´s', 'open series'],
  Women => ["ladies's", "ladies'", "woman's", "women's", 'for ladies',
    'womwn'],
);

my @SINGLE_WORDS = qw(
  Open Men Women Mixed
);

my %SINGLE_TYPOS =
(
  Open => [qw(libre libres terbuka opain oper opn oprn op åben acik 
    offene opena)],
  Men => [qw(mens putra pa homme hommes varones)],
  Women => [qw(woman wemen womans womens womvn
    lady ladies ladie femme femmes damas dames damer dame damen 
    putri pi wo womvn)],
  Mixed => [qw(mix mixte mýx mixen mixt mixty)]
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
