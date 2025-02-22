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
  'Israel Festival Open Pairs',
  'Israel Festival Open Teams',
  'Israel Individual',
  'Israel Juniors Pairs',
  'Israel Juniors Trials',
  'Israel IMP Pairs',
  'Israel Open Pairs',
  'Israel League',
  'Israel Open Teams',
  'Israel Open Teams Cup',
  'Israel Open Trials',
  'Israel School Trials',
  'Israel U21 Trials',
  'Israel Women Pairs',
  'Maccabi Games',
  'Rand Pairs Cup',
  'Rand Teams Cup',
  'Red Sea Invitational Pairs',
  'Red Sea Open Swiss Teams',
);

my %MULTI_TYPOS =
(
  'Four Nations Cup' => [
    '4 nations cupn', 
    '4 nations cup'],
  'Israel Juniors Pairs' => [
    'israel juniours pairs',
    'israeli juniors pairs'],
  'Israel Juniors Trials' => [
    'israel juniors team trials',
    'israeli juniors trials',
    'israeli juniors team trials'],
  'Israel League' => [
    'israeli league'],
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
  'Israel Open Teams Cup' => [
    'israel cup',
    'israel national team cup',
    'israel team cup',
    'israel team of four cup',
    'israel teams cup',
    'israeli team cup',
    'israeli teams cup'],
  'Israel Open Trials' => [
    'israel open team trials',
    'israel open trials',
    'israel team trials',
    'israeli open team trials',
    'israeli open trials'],
  'Israel School Trials' => [
    'israel schools trials',
    'israel schools team trials',
    'israel schools teams trials'],
  'Israel U21 Trials' => [
    'israeli u21 trials',
    'israeli trials u21'],
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
