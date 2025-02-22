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
  'Brasov Open Pairs',
  'Brasov Open Teams',
  'Contra Open Cup',
  'Romanian League',
  'Romanian Second League',
  'Romanian Open Teams',
  'Romanian Open Trials',
  'Romanian Senior Team Trials',
  'Romanian Women Team Trials',
);

my %MULTI_TYPOS =
(
  'Contra Open Cup' => [
    'contra cup'],
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
    'romania open team trial',
    'romania open team trials',
    'romania selection open',
    'romanian national team selection',
    'romanian national trials',
    'romanian national team trials',
    'romanian national teams trial euro',
    'romanian open team trial',
    'romanian open team trials',
    'romanian open teams trial',
    'romanian open teams trials',
    'romanian open trials',
    'romanian team trial',
    'romanian team trials',
    'romanian teams selection',
    'romanian teams trial',
    'romanian teams trials',
    'romanian selection'],
  'Romanian Second League' => [
    'cn echipe div b',
    'cn echipe div b seria a',
    'cn ecgipe div b seria a'],
  'Romanian Senior Team Trials' => [
    'romanian seniors trials'],
  'Romanian Women Team Trials' => [
    'romanian women trials'],
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
