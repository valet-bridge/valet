#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::Competitive;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Ghestem
  Michaels
);

my %SINGLE_TYPOS =
(
  Ghestem => [
    'geshtem',
    'gest',
    'gestam',
    'gestehm',
    'gestem',
    'gesten',
    'gestend',
    'gesth',
    'gestham',
    'gestheim',
    'gesthem',
    'gheestem',
    'gheistem',
    'ghenstem',
    'ghes',
    'ghesdem',
    'ghesht',
    'gheshtum',
    'ghest',
    'ghestam',
    'ghestan',
    'gheste',
    'ghesteem',
    'ghesteim',
    'ghestem',
    'ghestemm',
    'ghesten',
    'ghesth',
    'ghesthem',
    'ghestim',
    'ghestm',
    'ghestom',
    'gheston',
    'ghestum',
    'ghstem',
    'ghsthem',
    'ghstm',
    'ghtem',
    'gshm',
    'gsthm',
    'gstm'],
  Michaels => [
    'mchls',
    'mechels',
    'mhcels',
    'mhcls',
    'miachels',
    'mic',
    'micaels',
    'micahels',
    'micals',
    'micchaels',
    'mich',
    'michacls',
    'michaeals',
    'michaeels',
    'michaeis',
    'michaeks',
    'michael',
    'michaeles',
    'michaells',
    'michaels',
    'michal',
    'michales',
    'michals',
    'miche',
    'michea',
    'micheaels',
    'micheal',
    'micheales',
    'michealis',
    'micheals',
    'michedals',
    'micheles',
    'michellls',
    'michells',
    'michels',
    'michles',
    'michls',
    'michs',
    'mick',
    'mickael',
    'mickaels',
    'mickeals',
    'mickels',
    'mickls',
    'micks',
    'micls',
    'mics',
    'miichaels',
    'mikels',
    'mikles',
    'mikls',
    'mkls'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
