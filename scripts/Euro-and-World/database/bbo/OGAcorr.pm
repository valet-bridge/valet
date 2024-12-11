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

my %ORIGIN_COMPATIBILITY = (
  Intercity => {
    CITY => 1, 
    CLUB => 1,
    REGION => 1},
  Interclub => {
    LOCALITY => 1,
    CLUB => 1, 
    UNIVERSITY => 1,
    CITY => 1, 
    REGION => 1, 
    COUNTRY => 1,
    ORGANIZATION => 1,
    SPONSOR => 1},
  International => {
    COUNTRY => 1},
  Interprovince => {
    CITY => 1, 
    REGION => 1},
  Interregional => {
    CITY => 1, 
    REGION => 1},
  Interstate => {
    CITY => 1, 
    REGION => 1},
  Supranational => {
    COUNTRY => 1},
  University => {
    LOCALITY => 1,
    CITY => 1, 
    CLUB => 1,
    COUNTRY => 1,
    REGION => 1,
    UNIVERSITY => 1},
);

# These are sometimes rather permissive, e.g. Israel in Balkan.

my %ZONE_COMPATIBILITY =
(
  'African Zone' =>
  {
    Botswana => 1,
    Egypt => 1,
    Kenya => 1,
    Madagascar => 1,
    Mauritius => 1,
    Morocco => 1,
    Reunion => 1,
    'South Africa' => 1,
    Tunisia => 1,
    Zimbabwe => 1,
  },
  'Asia Pacific' =>
  {
    Australia => 1,
    China => 1,
    'Chinese Taipei' => 1,
    'French Polynesia' => 1,
    'Hong Kong' => 1,
    India => 1,
    Indonesia => 1,
    Japan => 1,
    Macau => 1,
    Malaysia => 1,
    Mongolia => 1,
    'New Zealand' => 1,
    Philippines => 1,
    Singapore => 1,
    'South Korea' => 1,
    Taiwan => 1,
    Thailand => 1,
  },
  Balkan =>
  {
    Albania => 1,
    'Bosnia & Herzegovina'=> 1,
    Bulgaria => 1,
    Croatia => 1,
    Greece => 1,
    Israel => 1,
    'North Macedonia' => 1,
    Romania => 1,
    Serbia => 1,
    Slovenia => 1,
    Turkey => 1,
  },
  'Central America and Caribbean' =>
  {
    Barbados => 1,
    Bermuda => 1,
    'French Guyana' => 1,
    Guadeloupe => 1,
    'Netherlands Antilles' => 1,
    'Trinidad and Tobago' => 1,
  },
  Commonwealth =>
  {
    Australia => 1,
    Bangladesh => 1,
    Barbados => 1,
    Canada => 1,
    England => 1,
    Guernsey => 1,
    India => 1,
    'Isle of Man' => 1,
    Jersey => 1,
    Kenya => 1,
    Malaysia => 1,
    Malta => 1,
    'Northern Ireland' => 1,
    Pakistan => 1,
    'New Zealand' => 1,
    Scotland => 1,
    Singapore => 1,
    'South Africa' => 1,
    'Sri Lanka' => 1,
    Tanzania => 1,
    Uganda => 1,
    Wales => 1,
  },
  'Europe' =>
  {
    Andorra => 1,
    Austria => 1,
    Belarus => 1,
    Belgium => 1,
    Bosnia => 1,
    'Bosnia & Herzegovina'=> 1,
    Bulgaria => 1,
    Croatia => 1,
    Cyprus => 1,
    'Czech Republic' => 1,
    Denmark => 1,
    England => 1,
    Estonia => 1,
    'Faroe Islands' => 1,
    Finland => 1,
    France => 1,
    Georgia => 1,
    Germany => 1,
    'Great Britain' => 1,
    Greece => 1,
    Hungary => 1,
    Iceland => 1,
    Ireland => 1,
    Israel => 1,
    Italy => 1,
    Latvia => 1,
    Lebanon => 1,
    Lichtenstein => 1,
    Lithuania => 1,
    Luxembourg => 1,
    Malta => 1,
    Monaco => 1,
    Netherlands => 1,
    'Northern Ireland' => 1,
    Norway => 1,
    Poland => 1,
    Portugal => 1,
    Romania => 1,
    Russia => 1,
    'San Marino' => 1,
    Scotland => 1,
    Serbia => 1,
    'Serbia and Montenegro' => 1,
    Slovakia => 1,
    Slovenia => 1,
    Spain => 1,
    Sweden => 1,
    Switzerland => 1,
    Turkey => 1,
    'United Kingdom' => 1,
    Ukraine => 1,
    Wales => 1,
    Yugoslavia => 1,
  },
  'Middle East' => 
  {
    Bahrain => 1,
    Bangladesh => 1,
    Egypt => 1,
    India => 1,
    Jordan => 1,
    Kuwait => 1,
    Lebanon => 1,
    Pakistan => 1,
    Palestine => 1,
    Qatar => 1,
    'Saudi Arabia' => 1,
    'Sri Lanka' => 1,
    Syria => 1,
    Tunisia => 1,
    Turkey => 1,
    'United Arab Emirates' => 1,
  },
  'North America' =>
  {
    Canada => 1,
    Mexico => 1,
    USA => 1,
  },
  'South America' => 
  {
    Argentina => 1,
    Brazil => 1,
    Chile => 1,
    Colombia => 1,
    Ecuador => 1,
    Peru => 1,
    Singapore => 1,
    Uruguay => 1,
    Venezuela => 1,
  },
  'South East Asia' =>
  {
    China => 1,
    'Chinese Taipei' => 1,
    'Hong Kong' => 1,
    Indonesia => 1,
    Japan => 1,
    'Macau' => 1,
    Taiwan => 1,
  },
  'South Pacific' =>
  {
    Australia => 1,
    'New Zealand' => 1
  },
);

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


sub origin_checkable
{
  my ($origin) = @_;

  return exists $ORIGIN_COMPATIBILITY{$origin};
}


sub origin_team_field_ok
{
  my ($origin, $team_field) = @_;

  return 0 unless exists $ORIGIN_COMPATIBILITY{$origin};
  return exists $ORIGIN_COMPATIBILITY{$origin}{$team_field};
}


sub zone_country_ok
{
  my ($zone, $country) = @_;

  return 0 unless exists $ZONE_COMPATIBILITY{$zone};
  return (exists $ZONE_COMPATIBILITY{$zone}{$country});
}


1;
