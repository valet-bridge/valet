#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::Carding;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Lavinthal Against NT',
  'Reverse Smith',
  'Standard Carding',
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  UDCA
  Lavinthal
);

my %SINGLE_TYPOS =
(
  Lavinthal => [
    'lav',
    'lavantal',
    'lavanthal',
    'lavantl',
    'lavenhal',
    'lavent',
    'laventahl',
    'lavental',
    'laventall',
    'laventatal',
    'laventh',
    'laventha',
    'laventhal',
    'laventhall',
    'laventhial',
    'laventhol',
    'laventol',
    'laveth',
    'lavethal',
    'lavh',
    'lavhintal',
    'lavhinthal',
    'lavhithall',
    'lavi',
    'laviental',
    'lavienthal',
    'lavin',
    'lavinethal',
    'laving',
    'lavingt',
    'lavingtahl',
    'lavingtal',
    'lavingthal',
    'lavingtl',
    'lavingual',
    'lavinhal',
    'lavinhtal',
    'lavinsal',
    'lavint',
    'lavinta',
    'lavintah',
    'lavintahl',
    'lavintak',
    'lavintal',
    'lavintall',
    'lavintals',
    'lavinth',
    'lavintha',
    'lavinthael',
    'lavinthah',
    'lavinthale',
    'lavinthalk',
    'lavinthall',
    'lavinthalm',
    'lavinthals',
    'lavinthel',
    'lavinthial',
    'lavinthl',
    'lavinthol',
    'lavintl',
    'lavintlhal',
    'lavintlhl',
    'lavinttal',
    'lavintth',
    'lavital',
    'lavitanl',
    'lavith',
    'lavitha',
    'lavithal',
    'lavithall',
    'lavitnhal',
    'lavitnthal',
    'lavjnthal',
    'lavl',
    'lavlenthal',
    'lavn',
    'lavnthal',
    'lavnthl',
    'lavntl',
    'lavt',
    'lavth',
    'lavthl',
    'lavtl',
    'lawent',
    'lawenthal',
    'lawentlal',
    'laweth',
    'lawint',
    'lawinta',
    'lawintal',
    'lawinthal',
    'lawinthall',
    'lawt',
    'leventhal',
    'levent',
    'levinthal'],
  'Lavinthal Against NT' => [
    'laventhalsa',
    'lavesa',
    'lavinsa',
    'lavintalsa',
    'lavintfornt',
    'lavinthalnt',
    'lavinthalonn',
    'lavinthalonnt',
    'lavinthalsa',
    'lavintsa',
    'lavnt',
    'lavsa',
    'levanthalsa',
    'leventhsa',
    'leventhalsa',
    'leventsa',
    'levinsa',
    'levintalsa',
    'levinthalsa',
    'levsa'],
  'Reverse Smith' => [
    'revsmith',
    'revsmithecho'],
  'Standard Carding' => [
    'stancarding',
    'standardsigs',
    'standcard',
    'standcarding',
    'stdc',
    'stdca',
    'stdcard',
    'stdcard\'s',
    'stdcardg',
    'stdcarding',
    'stdcd',
    'stdcding',
    'stdcg',
    'stdcrd',
    'stdcrdg',
    'stncard',
    'stncrd',
    'stndc',
    'stndrdc'],
  UDCA => [
    'uda',
    'udac',
    'udc',
    'udcad',
    'udcal',
    'udcard',
    'udcarding',
    'udcas',
    'udce',
    'uddc',
    'udeca',
    'udga',
    'udica',
    'udka',
    'udlca',
    'udsa',
    'udsca'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;




