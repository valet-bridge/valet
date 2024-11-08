#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::CentralAmerica;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Central American & Caribbean Open Teams',
  'Central American & Caribbean Transnational Teams',
);

my %MULTI_TYPOS =
(
  'Central American & Caribbean Open Teams' => [
    'cac final',
    "cacbf zonal c'ships",
    "cacbf zonal ch'ships",
    "cacbf zonal cha'ships",
    'cacbf zonal championship',
    'central america & caribean championship',
    'central american & caribbean championship',
    'central american zonal championships'],
);

my %SINGLE_TYPOS =
(
);

sub set_hash
{
  my ($gmulti_words, $gmulti_typos, $gsingle_typos) = @_;

  push @$gmulti_words, @MULTI_WORDS;

  while (my ($key, $value) = each %MULTI_TYPOS)
  {
    @{$gmulti_typos->{$key}} = @$value;
  }

  while (my ($key, $value) = each %SINGLE_TYPOS)
  {
    @{$gsingle_typos->{$key}} = @$value;
  }
}

1;
