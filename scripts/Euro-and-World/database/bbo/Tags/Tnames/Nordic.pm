#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Nordic;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Nordic Cup',
  'Nordic Junior Pairs',
  'Nordic Junior Teams',
  'Nordic Open Pairs',
  'Nordic Open Teams',
  'Nordic Security Pro-Am Pairs',
  'Nordic Women Teams',
);

my %MULTI_TYPOS =
(
  'Nordic Cup' => [
    'rottneros cup',
    'rottneros nordic cup'],
  'Nordic Junior Pairs' => [
    'nordic junior pair championship',
    'open nordic junior pair',
    'open nordic junior pairs'],
  'Nordic Junior Teams' => [
    'nordic junior team championship',
    'nordic junior team championships',
    'nordic junior teams championship',
    'nordic junior teams championships',
    'nordic youth team championship',
    'nordic youth teams championship'],
  'Nordic Open Pairs' => [
    'nordic pair championships'],
  'Nordic Open Teams' => [
    'nordic championship open class',
    'nordic open championship'],
  'Nordic Security Pro-Am Pairs' => [
    'Nordic Security Play against the stars'],
  'Nordic Women Teams' => [
    'nordic women championship',
    'nordics (women)'],
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
