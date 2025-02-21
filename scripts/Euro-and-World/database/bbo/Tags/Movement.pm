#!perl

package Tags::Movement;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Round-robin'
);

my %MULTI_TYPOS =
(
  # In India, Super League seems to be not a tournament per se,
  # but more of a round-robin stage(?).
 'Round-robin' => ['round robin', 'raound robin', 'r robin', 'r_robin',
   'roun robin', 'round roubin', 'round ronin', 'round bobin',
   'r_r', 'grup maçlari', 'group stage',
   'super league rr', 'super league', 'superleague', 'super leahue',
   'sup league', 'sup leg', 'sup l', 'sup-l', 'sl', 's l'],
);

my @SINGLE_WORDS = qw(
  Barometer
  Danish
  Goulash
  Swiss
  Triangle
);

my %SINGLE_TYPOS =
(
  Barometer => [
    'barometr',
    'barometre',
    'baromètre',
    'baromtre'],
  Goulash => ['goullash', 'goulyash'],
  'Round-robin' => ['rr', 'roundrobin', 'rrr', 'rrobin'],
  Swiss => ['suisse', 'swis', 'sw', 'monrad']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
