#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Brazil;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Brazilian Senior Trials',
  'Brazilian Open Teams',
  'Brazilian Open Trials',
  'Brazilian Women Trials',
  'Rio de Janeiro Open Teams',
  'Rio de Janeiro Christmas Individual',
  'Roberto Taunay Cup',
  'Sao Paulo Cup',
  'Sao Paulo State Championship',
);

my %MULTI_TYPOS =
(
  'Brazilian Open Teams' => [
    'brasil champ',
    'brasilian championship',
    'brazilian championship',
    'brazilian championships',
    'brazilian chapionship',
    'brazilian national championship',
    'brazilian open championship',
    'brazilian team',
    'brazilian teams',
    'open brazilian championship'],
  'Brazilian Senior Trials' => ['brazilian senior'],
  'Brazilian Women Trials' => ['brazilian ladies trials'],
  'Rio de Janeiro Open Teams' => [
    'rio de janeiro championship',
    'rio de janeiro state final'],
  'Rio de Janeiro Christmas Individual' => [
    'rio de janeiro xmas individual'],
  'Sao Paulo Cup' => [
    's o paulo cup',
    'sao paulo state cup',
    'são paulo cup'],
  'Sao Paulo State Championship' => [
    'sao paulo champ',
    'sao paulo championship',
    'sao paulo champ',
    'sap paulo state championship',
    'são paulo state championship',
    'sp champ',
    'sao paulo state'],
);

my %SINGLE_TYPOS =
(
  'Brazilian Open Teams' => ['brasilchamp'],
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
