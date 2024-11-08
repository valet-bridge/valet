#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Romania;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Romanian League',
  'Romanian Second League',
  'Romanian Open Teams',
  'Romanian Open Trials',
);

my %MULTI_TYPOS =
(
  'Romanian League' => [
    'cn ecgipe',
    'cn echipe',
    'c_n_ echipe',
    'divizia a',
    'national romanian teams',
    'romanian national teams div a',
    'romanian national division',
    'romanian national teams- div a',
    'romanian team championship',
    'romanian teams-a division',
    'romanian teams- a division'],
  'Romanian Open Teams' => [
    'romanian national champ_',
    'romanian national champs',
    'romanian national championship',
    'romanian national championships teams',
    'romanian national team championship',
    'romanian national team championships',
    'romanian national team champs',
    'romanian national teams',
    'romanian national teams championships',
    'romanian teams'],
  'Romanian Open Trials' => [
    'romanian national team selection',
    'romanian national trials',
    'romanian open teams trial',
    'romanian open teams trials',
    'romanian open trials',
    'romanian selection'],
  'Romanian Second League' => [
    'cn echipe div b',
    'cn echipe div b seria a',
    'cn ecgipe div b seria a'],
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
