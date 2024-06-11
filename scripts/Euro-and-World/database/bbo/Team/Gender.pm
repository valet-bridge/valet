#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Gender;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_gender set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Men => ["men's", "men`s"],
  Mixed => ['cat mixtas'],
  Seniors => ["seniors'"],
  Women => ["ladies's", "ladies'", "woman's", "women's", 'for ladies'],
);

my @SINGLE_WORDS = qw(
  Open Men Women Mixed
);

my %SINGLE_TYPOS =
(
  Open => [qw(libre libres terbuka opn åben acik offene)],
  Men => [qw(mens putra pa homme hommes)],
  Women => [qw(woman wemen womans womens womvn
    lady ladies ladie femme femmes damas dames damer dame damen 
    putri pi wo)],
  Mixed => [qw(mix mixte mýx mixen mixt)]
);


sub set_hashes_team_gender
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
