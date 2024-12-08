#!perl

package OGAcorr;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

my %ORIGIN_ACCEPTS = (
  # Says Youngsters in the team, but is Open tournament
  # (for example)
  'Bonn Nations Cup' => [
     2637,
     8891,
     9846],
  'German Open Teams' => [
    46399],
  'Hungary Exhibition' => [
      719,  720,  722,  723,  724],
  'IMSA Elite Women Teams' => [
    30778],
  'Italy Friendly' => [
    41430, 41433],
  'Pan Arab Inter-Club Championship' => [
    31174],
  'Teltscher Trophy' => [
     9946,  9964,  9988,  9995,
    39014,
    44818, 44830, 44843, 44849],
  'The Hague Bridge Experience' => [
    46355],
);

my %ORIGIN_FLAT_LIST;
for my $tname (keys %ORIGIN_ACCEPTS)
{
  for my $bbono (@{$ORIGIN_ACCEPTS{$tname}})
  {
    $ORIGIN_FLAT_LIST{$bbono} = $tname;
  }
}


sub origin_fixable
{
  my ($tname, $bbono) = @_;

  return 0 unless exists $ORIGIN_ACCEPTS{$tname};
  for my $ok (@{$ORIGIN_ACCEPTS{$tname}})
  {
    return 1 if $bbono eq $ok;
  }
  return 0;
}


sub origin_number_fixable
{
  my ($bbono) = @_;
  return (exists $ORIGIN_FLAT_LIST{$bbono} ? 1 : 0);
}


sub origin_org_ok
{
  my ($tname) = @_;

  if ($tname eq 'Camrose Trophy' ||
      $tname eq 'Lady Milne Trophy' ||
      $tname eq 'Junior Camrose' ||
      $tname eq 'Teltscher Trophy')
  {
    return 1;
  }
  else
  {
    return 0;
  }
}


1;
