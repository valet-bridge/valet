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
  'Saudi Arabia',
  'Serbia and Montenegro',
  'South Africa',
  'South Korea',
  'Sri Lanka',
  'Trinidad and Tobago',
  'United Kingdom'
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
  'French Guyana' => ['french guayana', 'french guiana'],
  'Great Britain' => ['g.britain'],
  'Hong Kong' => ['china hong kong', 'china hongkong', 'china honk kong'],
  'Isle of Man' => ['isle of man'],
  'Netherlands' => ['team orange', 'the netherlands', 'pays-bas'],
  'New Zealand' => ['new zeland', 'new zealans', 'new zeland',
    'aotearoa', 'aotearoq'],
  'North Macedonia' => ['macedonia'],
  'Northern Ireland' => ['northertn irelsnd', 'n irelena', 'n. ireland',
    'n.ireland', 'n ire', 'north ire', 'northern irelnd'],
  'Republic of Ireland' => ['rep. of ireland', 'rep of ireland', 'roi',
    'rep ire', 'rep ireland', 'republic of irelend', 'reublic of ireland',
    'r of ireland'],
  'San Marino' => ['san_marino', 'san  marino'],
  'Serbia and Montenegro' => ['serbia/mont', 'serbia&mon.'],
  'Trinidad and Tobago' => ['trinidad & tobago', 'trinidad&tobago'],
  USA => ['u.s.a.']
);

my @SINGLE_WORDS = qw(
  Andorra Angora Argentina Australia Austria 
  Belarus Brazil Bulgaria
  Canada Colombia Croatia 
  Denmark 
  Egypt England Estonia 
  Finland 
  Germany Guadeloupe Guernsey
  Hungary 
  Ireland Israel Italy
  Jersey Jordan
  Latvia 
  Lichtenstein Luxembourg 
  Madagascar Malta Malaysia Monaco 
  Netherlands Norway 
  Pakistan Palestine Philippines Poland 
  Reunion Romania
  Scotland Slovakia Switzerland 
  Tunisia Turkey
  Uganda USA
  Wales
);

my %SINGLE_TYPOS =
(
  Argentina => ['argenting', 'argentýna'],
  Australia => ['austrlia', 'oz'],
  Austria => ['austra'],
  Belarus => ['bielarus'],
  Brazil => ['brasil'],
  Bulgaria => ['bg', 'bulgarya'],
  Canada => ['kanada'],
  'Czech Republic' => ['czr', 'czech republic.'],
  'Chinese Taipei' => ['taipei'],
  Colombia => ['columbia'],
  Croatia => ['croatie'],
  Denmark => ['danmark', 'danemark', 'denmarrk', 'den', 'dk',
    'denmark*'],
  Egypt => ['egy', 'egytp'],
  England => ['eng'],
  Estonia => ['estonie', 'est'],
  Finland => ['finnland'],
  France => ['fra', 'fnc', 'frandce'],
  'French Guyana' => ['guyana', 'guayana', 'guayana'],
  Germany => ['deutschland'],
  Guadeloupe => ['guadelupe'],
  'Hong Kong' => ['hk', 'hongkong'],
  Hungary => ['hungar'],
  Iceland => ['ice'],
  Indonesia => ['timnas', 'ind'],
  Ireland => ['roireland', 'irelnd', 'irelsnd', 'irlande',
    'irelend', 'irelena', 'ire', 'eire'],
  Italy => ['italia'],
  Israel => ['isreal', 'israil', 'isarel', 'israël'],
  Jordan => ['jor'],
  Latvia => ['lavtia', 'latvija'],
  Luxembourg => ['luxemburg', 'luxembourgh'],
  Macau => ['china macau'],
  Madagascar => ['madagaskar'],
  Netherlands => ['nederlands', 'netherland', 'nrtherlands', 
    'netherlans', 'netherlnd', 'neth', 'nl', 'net', 'holland'],
  Monaco => ['nonaco'],
  'New Zealand' => ['nwzealand', 'nz'],
  'North Macedonia' => ['macedonia'],
  'Northern Ireland' => ['nireland'],
  Norway => ['norge', 'norges', 'norwegen', 'nor'],
  Palestine => ['palastine'],
  Philippines => ['philipppines'],
  Poland => ['polen', 'pologne', 'polska'],
  Reunion => ['réunion'],
  Romania => ['rumania'],
  'Serbia and Montenegro' => ['serbia&mon'],
  Scotland => ['scotlsnd'],
  'South Korea' => ['korea'],
  'Sri Lanka' => ['srilanka'],
  Sweden => ['swe'],
  Switzerland => ['suitzerland', 'switserland'],
  Tunisia => ['tunisie'],
  Turkey => ['tur'],
  'United Kingdom' => ['uk']
);


sub set_hashes_team_country
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
