#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Supra;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Buffett Cup Individual',
  'Buffett Cup Pairs',
  'Buffett Cup Teams',
  'Cavendish Open Pairs',
  'Cavendish Women Pairs',
  'Cavendish Teams',
  'Channel Girls Trophy',
  'Channel Juniors Trophy',
  'Channel Schools Trophy',
  'Computer World Championship',
  'Neighbor Challenge IMP Pairs',
  'Neighbor Challenge Open Teams',
  'Neighbor Challenge Women Teams',
  'NYSA Euroregion Nations Cup',
  'Stern-Cornell Trophy',
  'Paris Youth Open Teams',
);

my %MULTI_TYPOS =
(
  'Cavendish Open Pairs' => [
    'cavemdish pairs',
    'cavendish monaco pairs',
    'cavendish pair',
    'cavendish pairs',
    'cavendiish pairs',
    'cavendiosh pairs',
    'cavendsh pairs'],
  'Cavendish Women Pairs' => [
    'cavendish monaco pairs women'],
  'Cavendish Teams' => [
    'avendish teams',
    'cavendish tms',
    'cavendish team'],
  'Channel Girls Trophy' => ['channel trophy girls'],
  'Channel Schools Trophy' => ['channel trophy schools'],
  'Computer World Championship' => [
    'computer bridge', 
    'computer bridge championship',
    'computer world bridge championships'],
  'NYSA Euroregion Nations Cup' => ['cup of euroregion nysa'],
  'Paris Youth Open Teams' => [
    'youth open bridge paris',
    'youth paris open bridge'],
);

my %SINGLE_TYPOS =
(
  'Paris Youth Open Teams' => ['ypob'],
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
