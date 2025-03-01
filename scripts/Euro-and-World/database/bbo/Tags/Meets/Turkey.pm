#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Turkey;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Assael Festival',
  'Bodrum Peninsula Festival',
  'Cappadocia Fairy Chimneys Festival',
  'Merit Bridge Festival',
  'Mersin Bridge Festival',
  'Sivrioglu Festival',
  'Turkish-Greek Friendship Festival',
  'Turkish Open Trials', # TODO Is this a Meet?
  'Turkish Summer Championships',
  'Turkish Winter Championships',
  'Turkish Women Trials' # TODO Is this a Meet?
);

my %MULTI_TYPOS =
(
  'Bodrum Peninsula Festival' => ['bodrum yarýmada bric festivali'],
  'Cappadocia Fairy Chimneys Festival' => [
    'cappadocia bridge fest',
    'kapadokya brýç festývalý',
    'sonbahar bridge festival'],
  'Merit Bridge Festival' => [
    'merit festival',
    "merit int_ bridge festival",
    "merit int'l bridge festival"],
  'Mersin Bridge Festival' => [
    'international bridge festival mersin_turkey',
    'mersin bridge fest',
    'mersin brdige festival'],
  'Turkish-Greek Friendship Festival' => [
    'greek-turkish festival',
    'greek-turkish friendship festival'],
  'Turkish Open Trials' => [
    'turkey open national team selection',
    'turkey open team trials',
    'turkish national team selection',
    'turkish national open team selection',
    'turkish open national selection',
    'turkish open national team selection',
    'turkish open team selection',
    'turkish open team trials'],
  'Turkish Summer Championships' => [
    'turkish summer championship'],
  'Turkish Winter Championships' => [
    'turkish winter championship',
    'turkish winter championsship'],
  'Turkish Women Trials' => [
    'turkish woman national selection',
    'turkish woman team trials',
    'turkish women national selection',
    'turkish women team selection'],
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
