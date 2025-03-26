#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Finland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Finnish Cup',
  'Finnish Open IMP Pairs',
  'Finnish Open IMP Pairs',
  'Finnish Open Pairs',
  'Finnish Open Pair Trials',
  'Finnish Open Trials',
  'Finnish Open Teams',
  'Finnish Senior Trials',
  'Finnish Women Pairs',
  'Finnish Women Trials',
  'Hanko Open Teams',
  'Jyväskylä Open Pairs',
  'Jyväskylä Open Teams',
  'Pärnu Summer Invitational Pairs',
  'Pärnu Summer Open Teams',
  'Puutalo Open Teams',
  'Salo Midsummer Juniors Teams',
  'Vadsø Open Pairs',
);

my %MULTI_TYPOS =
(
  'Finnish Cup' => ['suomen cup'],
  'Finnish Open Pairs' => [
    'finnish open pairs championship',
    'finnish pair championship',
    'finnish pair championships',
    'finnish pairs',
    'finnish pairs championship',
    'finnish pairs champs'],
  'Finnish Open Teams' => [
    'finnish imp championship',
    'finnish team championship',
    'finnish team championships',
    'finnish teams championship',
    'finnish teams championships',
    'finnish teams',
    'joukkue-sm',
    'sm joukkue',
    'sm joukkis'],
  'Finnish Open Trials' => [
    'finnish national team qualifications',
    'finnish open team qualifications',
    'finnish team trials',
    'finnish teams trials'],
  'Finnish Senior Trials' => [
    'finnish senior qualifications',
    'finnish senior teams trial',
    'finnish senior teams trials',
    'finnish teams senior trials'],
  'Finnish Swiss Pairs' => [
    'finnish open imp championship',
    'finnish swiss imps championship',
    'finnish swiss imps championships',
    'finnish swiss-imps championships',
    'finnish swiss-ims championships'],
  'Finnish Women Trials' => [
    'finnish women teams trials'],
  'Hanko Open Teams' => ['hanko teams'],
  'Jyväskylä Open Teams' => [
    'finnish easter teams',
    'grand slam jyväskylä'],
  'Pärnu Summer Invitational Pairs' => [
    'pärnu summer_ invitational pairs_',
    'parnu summer tournament_ invitatoinal pairs',
    'pärnu summer tournament_ invitational pairs_'],
  'Puutalo Open Teams' => ['puutalo open'],
  'Salo Midsummer Juniors Teams' => [
    'midsummer juniors',
    'salo midsummer Juniors'],
  'Vadsø Open Pairs' => ['Vadsøturneringen'],
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
