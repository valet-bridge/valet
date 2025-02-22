#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::France;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Biarritz Hiver',
  'Deauville Open Pairs',
  'Deauville Open Teams',
  'Deauville Patton Teams',
  'French Cup',
  'French First Division',
  'French Intercircle',
  'French Junior Trials',
  'French Mixed Teams',
  'French Mixed Trials',
  'French Open Teams',
  'French Open Trials',
  'French Senior Trials',
  'French U26 Trials',
  'French U28 Trials',
  'French U31 Trials',
  'French Women Trials',
  'Shield of Thoisy',
);

my %MULTI_TYPOS =
(
  'French Cup' => [
    'coupe de france', 
    'la coupe de france'],
  'French First Division' => [
    'div_nat',
    'div_ nat_',
    'division natinale',
    'division natonale',
    'division ntionale',
    'divison nationale',
    'dno_4 d1',
    'dn0_4 division 1',
    'dn0_4 d1',
    'dno0_4 d1',
    'dn1',
    'dn1 french',
    'divisionnationale 1',
    'division natinale open _ 4 d1',
    'division nationale',
    'division nationale 1',
    'division nationale1_4',
    'division nationale1 _4',
    'division nationale open 1_ 4',
    'division nationale open 1 _4',
    'division nationale open 1 _ 4',
    'division nationale open_4 d1',
    'division nationale open_ 4 d1',
    'division nationale open _4 d1',
    'division nationale open _ 4 d1',
    'division nationale 1 open_4 d1',
    'finale nationale interclubs division1',
    'france div_ nat_ 1',
    'french dn1',
    'interclub d1',
    'interclub finale d1',
    'interclubs d1',
    'interclubs division1',
    'interclubs finale nationale division1',
    'nationale interclubs division 1',
    'nationale division 1',
    'nationale interclub d1'],
  'French Intercircle' => ['finale intercercle'],
  'French Junior Trials' => [
    'french junior trial',
    'french juniors trial',
    'french juniors trials', 
    'sélection junior france',
    'selection junior france'],
  'French Mixed Trials' => [
    'selection mixte',
    'sélection mixte'],
  'French Open Teams' => ['french teams championship'],
  'French Open Trials' => [
    'french opentrial',
    'french open team trial',
    'french open trial',
    'french teams trial',
    'french teams trials',
    'french opentrial',
    'selection francaise pau',
    'selection francaise - pau',
    'selection francaise pour pau',
    'selection pekin',
    'séléction pékin',
    'selection pau',
    'sélection pau'],
  'French Senior Trials' => [
    'french senior trial', 
    'french senior trials', 
    'french seniors selection',
    'french seniors trial',
    'french seniors trials',
    'selection senior france',
    'selection senior pau', 
    'sélection senior',
    'sélection senior pau',
    'selection senior pekin',
    'sélection sénior',
    'sélection séniors'],
  'French U26 Trials' => [
    'sélection U26'],
  'French U28 Trials' => [
    'selection junior pekin', 
    'selection u28 pekin'],
  'French U31 Trials' => [
    'sélection u31'],
  'French Women Trials' => [
    'entrainement venice cup',
    'selection dames',
    'sélection dames',
    'sélection dames france'],
);


my %SINGLE_TYPOS =
(
  'French First Division' => ['dn'],
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
