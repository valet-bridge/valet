#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Baltic;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Baltic Open Teams',
  'Estonian Junior Pair Trials',
  'Estonian Open Pair Trials',
  'Estonian Open Teams',
  'Estonian-Latvian Open Team Trials',
  'Fortuna Cup',
  'Latvia Invites',
  'Lithuanian Open Teams',
  'Riga Invitational Pairs',
  'Riga Open Teams',
  'Tallinn Invitational Pairs',
  'Towns Cup',
  'Vilnius BAM Pairs',
  'Vilnius Club Pairs',
  'Vilnius IMP Pairs',
  'Vilnius Open Pairs',
  'Vilnius Open Teams',
);

my %MULTI_TYPOS =
(
  'Baltic Open Teams' => [
    'baltic open teams cup',
    'baltic teams cup'],
  'Estonian Junior Pair Trials' => [
    'est u21 u26 trial',
    'est u26 u21 trial'],
  'Estonian Open Teams' => [
    'est teams champs',
    'estonia a- league',
    'estonia teams championships', 
    'estonian a- league',
    'estonian bridge championship',
    'estonian first league',
    'estonian open teams',
    'estonian team championship',
    'estonian team championships', 
    'estonian teams championships'],
  'Estonian Open Pair Trials' => [
    'estonian open trials',
    'estonian team trials'],
  'Estonian-Latvian Open Team Trials' => [
    'estonian-latvian national team trials',
    'estonian-latvian open trials',
    'estonian-latvian team trials',
    'estonian_latvian team trials',
    'estonian latvian team trial',
    'estonian latvian team trials',
    'estonian and latvian team trial',
    'estonian and latvian team Trials'],
  'Lithuanian Open Teams' => [
    'lithuania open teams',
    'lithuanian teams championship'],

);

my %SINGLE_TYPOS =
(
  'Vilnius Club Pairs' => ['vbk'],
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
