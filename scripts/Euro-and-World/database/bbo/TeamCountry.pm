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
  'Costa Rica',
  'Czech Republic',
  'Faroe Islands',
  'French Guyana',
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
  'Saudia Arabia',
  'Serbia and Montenegro',
  'South Africa',
  'South Korea',
  'Sri Lanka',
  'Trinidad and Tobago'
);

my %MULTI_TYPOS =
(
  'Bosnia & Herzegovina' => ['bosnia-herzegovina', 
    'bosnia&herzegovina', 'bosnia and herz'],
  'Chinese Taipei' => ['chinese tai', 'chinese taipe', 'chinese tapei',
    'chinese taipae', 'chi taipei', 'chainese taipei', 'ch.taipei', 
    'china taipei'],
  'Czech Republic' => ['czec republic', 'czech rep', 'czech_rep',
    'czech_republic'],
  'Faroe Islands' => ['faroe_islands', 'faroe island', 'faroe_isl'],
  'Great Britain' => ['g.britain'],
  'Hong Kong' => ['china hong kong', 'china hongkong', 'china honk kong'],
  'Isle of Man' => ['isle of man'],
  'Netherlands' => ['team orange', 'the netherlands', 'pays-bas'],
  'New Zealand' => ['new zeland', 'new zealans', 'new zeland'],
  'North Macedonia' => ['macedonia'],
  'Northern Ireland' => ['northertn irelsnd', 'n irelena', 'n. ireland',
    'n ire', 'north ire', 'northern irelnd'],
  'Republic of Ireland' => ['rep. of ireland', 'rep of ireland', 'roi',
    'rep ire', 'rep ireland', 'republic of irelend', 'reublic of ireland',
    'r of ireland'],
  'Serbia and Montenegro' => ['serbia/mont', 'serbia&mon.'],
  'Trinidad and Tobago' => ['trinidad & tobago', 'trinidad&tobago'],
);

my @SINGLE_WORDS = qw(
  Argentina 
  Australia 
  Austria 
  Brazil 
  Bulgaria
  Canada 
  Colombia 
  Croatia 
  Denmark 
  England
  Estonia 
  Finland 
  Germany 
  Guernsey
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
  Bulgaria => ['bg'],
  Canada => ['kanada'],
  'Czech Republic' => ['czr', 'czech republic.'],
  'Chinese Taipei' => ['taipei'],
  Colombia => ['columbia'],
  Croatia => ['croatie'],
  Denmark => ['danmark', 'danemark', 'denmarrk', 'den'],
  England => ['eng'],
  Estonia => ['estonie'],
  Finland => ['finnland'],
  France => ['fra'],
  Germany => ['deutschland'],
  'French Guyana' => ['guyana'],
  'Hong Kong' => ['hk', 'hongkong'],
  Hungary => ['hungar'],
  Indonesia => ['timnas'],
  Ireland => ['roireland', 'irelnd', 'irelsnd', 'irlande',
    'irelend', 'irelena', 'ire'],
  Italy => ['italia'],
  Israel => ['isreal', 'israil', 'isarel', 'israël'],
  Latvia => ['lavtia', 'latvija'],
  Luxembourg => ['luxemburg'],
  Macau => ['china macau'],
  Madagascar => ['madagaskar'],
  Netherlands => ['nederlands', 'netherland', 'nrtherlands', 
    'netherlans', 'netherlnd', 'neth', 'nl', 'net'],
  Monaco => ['nonaco'],
  'New Zealand' => ['nwzealand'],
  'North Macedonia' => ['macedonia'],
  'Northern Ireland' => ['nireland'],
  Norway => ['norge', 'norges', 'norwegen', 'nor'],
  Palestine => ['palastine'],
  Philippines => ['philipppines'],
  Poland => ['polen'],
  Reunion => ['réunion'],
  'Serbia and Montenegro' => ['serbia&mon'],
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
