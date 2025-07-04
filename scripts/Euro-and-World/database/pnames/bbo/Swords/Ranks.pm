#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::Ranks;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  major
  minor
);

# Not all U.S., but could be several things

my %SINGLE_TYPOS =
(
  major => [
    'maiger',
    'maigor',
    'maigors',
    'maigr',
    'maijur',
    'maijurs',
    'majer',
    'majorler',
    'majora',
    'majumdar',
    'majumder',
    'maiores',
    'maizor',
    'maizors',
    'maior',
    'maiors',
    'majior',
    'majiors',
    'majaor',
    'majar',
    'maj',
    'mj',
    'mjo',
    'mjor',
    'mjr',
    'mjrs',
    'mjs',
    'maggiore',
    'maggiori',
    'maiijor',
    'maij',
    'maija',
    'maijor',
    'maijors',
    'majaure',
    'majaz',
    'majeire',
    'majere',
    'majers',
    'majerz',
    'majeut',
    'majio',
    'majj',
    'majjor',
    'majjors',
    'majjr',
    'majki',
    'majkors',
    'majo',
    'majoe',
    'majoen',
    'majoir',
    'majoo',
    'majoor',
    'majoors',
    'majore',
    'majores',
    'majori',
    'majorr',
    'majors',
    'majory',
    'majos',
    'majot',
    'majots',
    'majour',
    'majours',
    'majoy',
    'majoys',
    'majqr',
    'majr',
    'majrs',
    'majs',
    'maju',
    'majueur',
    'majun',
    'majur',
    'majurs',
    'mayor',
    'mayore',
    'mayores',
    'mejor',
    'mjao',
    'mjaor',
    'mjaors',
    'mjar',
    'mjjr',
    'mjore',
    'mjores',
    'mjors',
    'mjrrs',
    'mjzor',
    'nob',
    'nobile',
    'nobili',
    'nobilie',
    'nobilui'],
  minor => [
    'mainoir',
    'mainor',
    'mainors',
    'mainory',
    'menor',
    'menores',
    'miner',
    'mineros',
    'miners',
    'minette',
    'minetti',
    'minieure',
    'minneur',
    'minnor',
    'minnors',
    'minnr',
    'mino',
    'minora',
    'minore',
    'minoree',
    'minores',
    'minori',
    'minors',
    'minotti',
    'minoui',
    'minours',
    'minr',
    'minrs',
    'mins',
    'minuer',
    'mionr',
    'mior',
    'miore',
    'mjnors',
    'mn',
    'mno',
    'mnor',
    'mnors',
    'mnr',
    'mnrs',
    'mns'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
