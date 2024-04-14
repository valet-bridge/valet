#!perl

package Month;

use strict;
use warnings;
use Exporter;
use v5.10;

my %FULL_TO_NUMBER =
(
  'January' => '01',
  'Jan' => '01',
  'February' => '02',
  'March' => '03',
  'April' => '04',
  'May' => '05',
  'June' => '06',
  'July' => '07',
  'August' => '08',
  'September' => '09',
  'October' => '10',
  'November' => '11',
  'December' => '12'
);

my %MONTH_ALIASES =
(
  January => [qw(jan)],
  February => [qw(feb)],
  March => [qw(mar)],
  April => [qw(apr)],
  May => [],
  June => [qw(jun juin)],
  July => [qw(jul)],
  August => [qw(aug)],
  September => [qw(sept sep)],
  October => [qw(oct)],
  November => [qw(nov)],
  December => [qw(dec)]
);

my %ALIAS_TO_FULL;
for my $m (keys %MONTH_ALIASES)
{
  $ALIAS_TO_FULL{lc($m)} = $m;
  for my $v (@{$MONTH_ALIASES{$m}})
  {
    $ALIAS_TO_FULL{lc($v)} = $m;
  }
}

my %ALIAS_TO_NUMBER;
for my $m (keys %MONTH_ALIASES)
{
  my $f = $FULL_TO_NUMBER{$m};
  $ALIAS_TO_NUMBER{lc($m)} = $f;
  for my $v (@{$MONTH_ALIASES{$m}})
  {
    $ALIAS_TO_NUMBER{lc($v)} = $f;
  }
}


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $ALIAS_TO_NUMBER{lc($text)} ? 1 : 0;
}


sub number
{
  my ($self, $text) = @_;
  die "No month alias: $text" unless exists $ALIAS_TO_NUMBER{lc($text)};
  return $ALIAS_TO_NUMBER{lc($text)};
}


sub full
{
  my ($self, $text) = @_;
  die "No month alias: $text" unless exists $ALIAS_TO_FULL{lc($text)};
  return $ALIAS_TO_FULL{lc($text)};
}


1;
