#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamCountry;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_country);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Bosnia & Herzegovina',
  'Chinese Taipei',
  'Czech Republic',
  'Faroe Islands',
  'French Polynesia',
  'Great Britain',
  'Hong Kong',
  'Isle of Man',
  'Netherlands Antilles',
  'New Zealand',
  'North Macedonia',
  'Northern Ireland',
  'Republic of Ireland',
  'San Marino',
  'Serbia and Montenegro',
  'Trinidad and Tobago'
);

my %MULTI_TYPOS =
(
  'Bosnia & Herzegovina' => ['bosnia-herzegovina', 
    'bosnia&herzegovina', 'bosnia and herz.'],
  'Chinese Taipei' => ['chinese tai', 'chinese taipe', 'chinese tapei',
    'chinese taipae', 'chi taipei', 'chainese taipei', 'ch.taipei', 
    'china taipei'],
  'Czech Republic' => ['czec republic', 'czech rep'],
  'Faroe Islands' => ['faroe_islands', 'faroe island'],
  'Great Britain' => ['g.britain'],
  'Hong Kong' => ['china hong kong', 'china hongkong', 'china honk kong'],
  'Isle of Man' => ['isle of man'],
  'New Zealand' => ['new zeland', 'new zealans', 'new zeland'],
  'North Macedonia' => ['macedonia'],
  'Northern Ireland' => ['northertn irelsnd'],
  'Republic of Ireland' => ['rep. of ireland', 'rep of ireland', 'roi'],
  'Serbia and Montenegro' => ['serbia/mont', 'serbia&mon'],
  'Trinidad and Tobago' => ['trinidad & tobago', 'trinidad&tobago'],
);

my @SINGLE_WORDS = qw(
  Argentina 
  Australia 
  Austria 
  Brazil 
  Canada 
  Colombia 
  Croatia 
  Denmark 
  England
  Estonia 
  Finland 
  Germany 
  Hungary 
  Ireland 
  Italy 
  Israel 
  Latvia 
  Luxembourg 
  Madagascar 
  Malta
  Monaco 
  Netherlands 
  Norway 
  Pakistan
  Palestine 
  Philippines 
  Poland 
  Reunion 
  Scotland
  Switzerland 
  Tunisia
  Turkey
  USA
  Wales
);

my %SINGLE_TYPOS =
(
  Argentina => ['argenting', 'argentýna'],
  Australia => ['austrlia', 'oz'],
  Austria => ['austra'],
  Brazil => ['brasil'],
  Canada => ['kanada'],
  'Czech Republic' => ['czr'],
  'Chinese Taipei' => ['taipei'],
  Colombia => ['columbia'],
  Croatia => ['croatie'],
  Denmark => ['danmark', 'danemark', 'denmarrk'],
  England => ['eng'],
  Estonia => ['estonie'],
  Finland => ['finnland'],
  France => ['fra'],
  Germany => ['deutschland'],
  Guyana => ['french guiana', 'french guyana'],
  Hungary => ['hungar'],
  Ireland => ['roireland', 'irelnd', 'irelsnd', 'irlande',
    'irelend', 'irelena', 'ire'],
  Italy => ['italia'],
  Israel => ['isreal', 'israil', 'isarel', 'israël'],
  Latvia => ['lavtia', 'latvija'],
  Luxembourg => ['luxemburg'],
  Macau => ['china macau'],
  Madagascar => ['madagaskar'],
  Netherlands => ['the netherlands', 'nederlands', 'netherland', 
    'nrtherlands', 'netherlans', 'netherlnd', 'neth', 'nl', 'net'],
  Monaco => ['nonaco'],
  'New Zealand' => ['nwzealand'],
  'North Macedonia' => ['macedonia'],
  'Northern Ireland' => ['nireland'],
  Norway => ['norge', 'norges', 'norwegen', 'nor'],
  Palestine => ['palastine'],
  Philippines => ['philipppines'],
  Poland => ['polen'],
  Reunion => ['réunion'],
  'Sri Lanka' => ['srilanka'],
  Switzerland => ['suitzerland', 'switserland'],
  Tunisia => ['tunisie'],
  Turkey => ['tur']
);


sub set_hashes_team_country
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
