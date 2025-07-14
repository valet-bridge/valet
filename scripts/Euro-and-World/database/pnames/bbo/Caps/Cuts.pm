#!perl

package Caps::Cuts;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(divide);

use lib '..';

use Butil;

my %FRONTS =
(
  all => [ CATEGORY => 'WORD', VALUE => 'all'],
  capp => [ CATEGORY => 'COMPETITIVE', VALUE => 'Cappelletti'],
  bergen => [ CATEGORY => 'BERGEN', VALUE => 'Bergen'],
  drury => [ CATEGORY => 'CONSTRUCTIVE', VALUE => 'Drury'],
  gerber => [ CATEGORY => 'CONSTRUCTIVE', VALUE => 'Gerber'],
  michaels => [ CATEGORY => 'COMPETITIVE', VALUE => 'Michaels'],
  nt => [ CATEGORY => 'DENOMINATIONS', VALUE => 'notrump'],
  private => [ CATEGORY => 'MISC', VALUE => 'private'],
  sa => [ CATEGORY => 'DENOMINATIONS', VALUE => 'notrump'],
  sayc => [ CATEGORY => 'BASES', VALUE => 'SAYC'],
  stayman => [ CATEGORY => 'STAYMAN', VALUE => 'Stayman'],
  staymn => [ CATEGORY => 'STAYMAN', VALUE => 'Stayman'],
  strong => [ CATEGORY => 'STRENGTHS', VALUE => 'strong'],
  suit => [ CATEGORY => 'MISC', VALUE => 'Suit'],
  th => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator'],
  transfer => [ CATEGORY => 'MISC', VALUE => 'Transfer'],
  vs => [ CATEGORY => 'WORD', VALUE => 'vs'],
  way => [ CATEGORY => 'WORD', VALUE => 'way'],
  weak => [ CATEGORY => 'STRENGTHS', VALUE => 'weak'],
  wy => [ CATEGORY => 'WORD', VALUE => 'way'],
);

my $FPATTERN = join('|', map { quotemeta }
  sort { length($b) <=> length($a) } keys %FRONTS);

my $FREGEX = qr/^((?i:$FPATTERN))([A-Z].*)/;

my %BACKS =
(
  bergen => [ CATEGORY => 'BERGEN', VALUE => 'Bergen'],
  private => [ CATEGORY => 'MISC', VALUE => 'private'],
  strong => [ CATEGORY => 'STRENGTHS', VALUE => 'strong'],
);

my $BPATTERN = join('|', map { quotemeta }
  sort { length($b) <=> length($a) } keys %BACKS);

my $BREGEX = qr/^(.*[a-z])((?i:$BPATTERN))\z/;


sub divide
{
  my ($whole, $tag_list, $text, $splits, $identifier) = @_;

my $orig = $text;

  my $front;
  my $match = 0;
  while (1)
  {
    last unless $text =~ /$FREGEX/;
    ($front, $text) = ($1, $2);
    push @$splits, @{$FRONTS{lc($front)}};
    $match = 1;
  }

  my $back;
  my @temp;
  while (1)
  {
    last unless $text =~ /$BREGEX/;
    ($text, $back) = ($1, $2);
    push @temp, @{$BACKS{lc($back)}};
    $match = 1;
  }

  return 0 unless $match;

  my ($category, $value);
  categorize($whole, $tag_list, $text, \$category, \$value);

  if ($category eq 'WORD' || $category eq 'HIGH_WORD')
  {
    # Doesn't happen.
    print $identifier;
    print "MIDDLEX $text ($orig) [$category]\n\n";
  }

  push @$splits, $category, $value;

  return 1 if $#temp == -1;
  push @$splits, @temp;
  return 1;
}

1;
