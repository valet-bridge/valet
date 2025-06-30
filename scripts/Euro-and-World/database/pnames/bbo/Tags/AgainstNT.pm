#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::AgainstNT;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Cappelletti Against 1NT',
);

my %MULTI_TYPOS =
(
  'Cappelletti Against 1NT' => [
    'cap./mod',
    'capell etti',
    'capelleti mod',
    'capelletti on nt',
    'cappeletti ove',
    're capp',],
  DONT => [
    'dont over nt',
    'mod dont'],
);

my @SINGLE_WORDS = qw(
  DONT
);

my %SINGLE_TYPOS =
(
  'Cappelletti Against 1NT' => [
    'cap',
    'capaletti',
    'capality',
    'capalleti',
    'capaltti',
    'caparetti',
    'capel',
    'capeleti',
    'capeletti',
    'capelleti',
    'capil',
    'capiletti',
    'capilleti',
    'capiltetti',
    'capleti',
    'capolet',
    'capoletti',
    'capollrtti',
    'capp',
    'cappaletti',
    'cappeiieti',
    'cappel',
    'cappeleti',
    'cappeletti',
    'cappelitti',
    'cappelleti',
    'cappelletti',
    'cappellitti',
    'cappilatti',
    'cappl',
    'capplety',
    'cappll',
    'cappoletti',
    'capps',
    'cappti'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
