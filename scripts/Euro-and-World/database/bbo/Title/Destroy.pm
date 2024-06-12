#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Destroy;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Around 52 cards in 80 years by',
  'before bermuda bowl', 'by joe pochron',
  'BBO1', 'BBO2', 'BBO3', 'BBO4', 'BBO5', 'BBO6', 'BBO7', 'BBO8', 'BBO9',
  'de vigraph',
  'eng comment', 'eng comments', 'eng comment in',
  'for Pau',
  'in the',
  'swe comment', 'swe comments', 'sw comment', 'sw comments',
  'the 80 grand challenge',
  'Welcome to'
);

my %MULTI_TYPOS =
(
  'for Pau' => ['pour pau'],
);

my @SINGLE_WORDS = qw(
  BBO *BBO
  compared
  étoile
  popular
  retour
);

my %SINGLE_TYPOS =
(
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
