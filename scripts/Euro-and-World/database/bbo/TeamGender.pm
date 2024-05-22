#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamGender;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_gender);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Open Men Women Mixed
);

my %SINGLE_TYPOS =
(
  Open => [qw(libre libres terbuka)],
  Men => [qw(mens men's men`s putra pa homme hommes)],
  Women => [qw(woman wemen womans women's womens 
    lady ladies ladie ladies's
    femme femmes damas dames damer putri pi wo)],
  Mixed => [qw(mix mixte mýx mixen)]
);


sub set_hashes_team_gender
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
