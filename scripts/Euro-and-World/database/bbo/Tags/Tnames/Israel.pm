#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Israel;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Four Nations Cup',
  'Israel Cup',
  'Israel Juniors Pairs',
  'Israel Juniors Trials',
  'Israel IMP Pairs',
  'Israel Open Pairs',
  'Israel Open Teams',
  'Israel Open Trials',
  'Israel School Trials',
  'Israel Women Pairs',
  'Maccabi Games',
  'Rand Pairs Cup',
  'Rand Teams Cup',
);

my %MULTI_TYPOS =
(
  'Four Nations Cup' => [
    '4 nations cupn', 
    '4 nations cup'],
  'Israel Cup' => [
    'israel team cup',
    'israel team of four cup',
    'israeli teams cup'],
  'Israel Juniors Pairs' => [
    'israel juniours pairs'],
  'Israel Juniors Trials' => [
    'israel juniors team trials',
    'israeli juniors trials',
    'israeli juniors team trials'],
  'Israel Open Pairs' => [
    'israel pairs',
    'israel pairs champ',
    'israeli pairs championship'],
  'Israel Open Teams' => [
    'israeli open team',
    'israel teams',
    'israel team champ_',
    'israel team championship',
    'israelairs champ_',
    'israeli team champ_'],
  'Israel Open Trials' => [
    'israel open team trials',
    'israel open trials',
    'israel team trials',
    'israeli open team trials'],
  'Israel School Trials' => [
    'israel schools trials',
    'israel schools teams trials'],
  'Maccabi Games' => ['maccabi-games', 'europ_ maccabi games'],
);

my %SINGLE_TYPOS =
(
  'Maccabi Games' => ['maccabiah'],
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
