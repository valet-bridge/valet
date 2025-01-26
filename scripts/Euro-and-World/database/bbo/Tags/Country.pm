#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Country;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

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
  'North America',
  'North Macedonia',
  'Northern Ireland',
  'San Marino',
  'Saudi Arabia',
  'Serbia and Montenegro',
  'South Africa',
  'South Korea',
  'Sri Lanka',
  'Trinidad and Tobago',
  'United Arab Emirates',
  'United Kingdom'
);

my %MULTI_TYPOS =
(
  Argentina => ['argentine republic'],
  'Bosnia & Herzegovina' => [
    'bosnia-herzegovina', 
    'bosnia herzegovina', 
    'bosnia&herzegovina', 
    'bosnia and herz',
    'bosnia and herzegov'],
  China => ['pan china', 'pan-china'],
  'Chinese Taipei' => [
    'ch.taipei', 
    'ch. taipei',
    'chainese taipei', 
    'chi taipei', 
    'china taipei', 
    'chinese tai', 
    'chinese taipai',
    'chinese taipe', 
    'chinese tapei',
    'chinese taipae',
    'chinesetaipei',
    'chinesse taipei'], 
  'Czech Republic' => [
    'czec republic', 
    'czech rep', 
    'czech_rep',
    'czech republik', 
    'czech_republic'],
  'Faroe Islands' => ['faroe_islands', 'faroe island', 'faroe_isl'],
  'French Guyana' => ['french guayana', 'french guiana'],
  'Great Britain' => ['g.britain'],
  'Hong Kong' => [
    'china hong kong', 
    'china hongkong', 
    'china honk kong',
    'china hk', 
    'hkj', 
    'hon kong',
    'hong kong chn', 
    'honk kong',
    'chn hong kong'],
  India => ['all india'],
  'Isle of Man' => ['isle of man'],
  Macau => ['china macau'],
  'Netherlands' => ['team orange', 'the netherlands', 'pays-bas',
    'teamnl'],
  'Netherlands Antilles' => ['neth.antilles'],
  'New Zealand' => ['new zeland', 'new zealans', 'new zeland',
    'aotearoa', 'aotearoq'],
  'North Macedonia' => [
    'n. macedonia',
    'macedonia'],
  'Northern Ireland' => [
    'n ire', 
    'n irelena', 
    'n ireland',
    'n. ireland',
    'n.ireland', 
    'nor ire', 
    'norhern ireland',
    'north ire', 
    'northern irelnd',
    'northertn irelsnd'], 
  Ireland => ['republic of ireland', 'rep. of ireland', 
    'rep of ireland', 'roi', 'rep ire', 'rep ireland', 
    'republic of irelend', 'reublic of ireland', 'r of ireland'],
  'San Marino' => ['san_marino', 'san  marino'],
  'Serbia and Montenegro' => ['serbia/mont', 'serbia&mon.', 's&mn'],
  'South Africa' => ['south frica'],
  'Trinidad and Tobago' => [
    'trinidad tobago',
    'trinidad & tobago', 
    'trinidad&tobago'],
  'United Arab Emirates' => ['u.a.e.'],
  USA => ['u.s.a.']
);

my @SINGLE_WORDS = qw(
  Albania Andorra Angora Argentina Australia Austria 
  Bahrain Bangladesh Barbados Belarus Belgium Bermuda 
  Bolivia Bosnia Botswana Brazil Bulgaria
  Canada Chile Colombia Croatia Cuba Cyprus
  Denmark 
  Ecuador Egypt England Estonia 
  Finland France
  Germany Georgia Greece Guadeloupe Guernsey
  Hungary 
  Iceland Indonesia Iraq Ireland Israel Italy
  Japan Jersey Jordan
  Kazakhstan Kenya Kuwait
  Latvia Lebanon Lichtenstein Lithuania Luxembourg 
  Macau Madagascar Malta Malaysia Mauritius Mexico 
  Monaco Mongolia Montenegro Morocco
  Netherlands Norden Norway 
  Pakistan Palestine Peru Philippines Poland Portugal
  Qatar
  Reunion Romania Russia
  Scotland Serbia Singapore Slovenia Slovakia Spain Sweden Switzerland Syria
  Taiwan Tanzania Thailand Tunisia Turkey Turkmenistan
  Uganda Ukraine Uruguay USA
  Venezuela
  Wales
  Yugoslavia
  Zimbabwe
);

my %SINGLE_TYPOS =
(
  Argentina => ['argenting', 'argentýna', 'arg', 'argetina'],
  Australia => ['austrlia', 'oz', 'australla', 'aus'],
  Austria => ['austra', 'aut'],
  Belarus => ['bielarus', 'blr'],
  Belgium => ['belgique'],
  Bermuda => ['bemruda'],
  'Bosnia & Herzegovina' => ['bih'],
  Brazil => ['brasil'],
  Bulgaria => ['bg', 'bulgarya', 'bul', 'bulgar', 'bulgari'],
  Canada => ['kanada'],
  'Czech Republic' => ['czr'],
  'Chinese Taipei' => ['taipei'],
  Colombia => ['columbia'],
  Croatia => ['croatie', 'cro'],
  Denmark => ['danmark', 'danemark', 'denmarrk', 'den', 'dk',
    'denmark*'],
  Egypt => ['egy', 'egytp', 'egypte'],
  England => ['eng', 'angleterre', 'englnd'],
  Estonia => ['estonie', 'est'],
  Finland => ['finnland', 'fi', 'fin'],
  France => ['fra', 'fnc', 'frandce'],
  'French Guyana' => ['guyana', 'guayana', 'guayana'],
  Germany => ['deutschland', 'ger'],
  'Great Britain' => ['gb'],
  Greece => ['gre', 'hellas'],
  Guadeloupe => ['guadelupe'],
  'Hong Kong' => ['hk', 'hongkong'],
  Hungary => ['hungar', 'hun'],
  Iceland => ['ice', 'islande'],
  India => ['indýa', 'hindusthan', 'hidusthan', 'indiaa'],
  Indonesia => ['timnas', 'ina'],
  Italy => ['italia', 'it', 'ita'],
  Israel => ['isreal', 'israil', 'isarel', 'israël', 'isr'],
  Jordan => ['jor'],
  Latvia => ['lavtia', 'latvija', 'lat'],
  Lebanon => ['leb'],
  Lithuania => ['lithuana', 'lit'],
  Luxembourg => ['luxemburg', 'luxembourgh'],
  Madagascar => ['madagaskar'],
  Morocco => ['maroc'],
  Netherlands => ['nederlands', 'netherland', 'nrtherlands', 'hol',
    'netherlans', 'netherlnd', 'neth', 'nl', 'net', 'holland', 'ned'],
  Monaco => ['nonaco', "monaco's"],
  'New Zealand' => ['nwzealand', 'nz'],
  'North Macedonia' => ['macedonia'],
  'Northern Ireland' => ['nireland', 'ni'],
  Norway => ['norge', 'norges', 'norwegen', 'nor', 'norja'],
  Palestine => ['palastine'],
  Philippines => ['philipppines', 'phillipina'],
  Poland => ['polen', 'pologne', 'polska', 'pol', 'polland',
    'porland'],
  Portugal => ['por', 'pl', 'portogallo'],
  Ireland => ['roireland', 'irelnd', 'irelsnd', 'irlande',
    'irelend', 'irelena', 'ire', 'eire'],
  Reunion => ['réunion'],
  Romania => ['rumania', 'rum', 'rom'],
  Russia => ['russian', 'rus', 'rusia'],
  'Saudi Arabia' => ['ksa'],
  'Serbia and Montenegro' => ['serbia&mon', 'srbija'],
  Scotland => ['scotlsnd', 'scotlands', 'scotlans', 'sco'],
  Slovenia => ['sovenia'],
  'South Korea' => ['korea'],
  Spain => ['esp', 'españa'],
  'Sri Lanka' => ['srilanka'],
  Sweden => ['swe', 'swedem', 'schweden', 'sweeden'],
  Switzerland => ['suitzerland', 'switserland', 'swiitzerland'],
  Taiwan => ['tw'],
  Thailand => ['thai'],
  Tunisia => ['tunisie', 'tunisian'],
  Turkey => ['tur', 'turkish', 'turkiye', 'türkýye'],
  'United Arab Emirates' => ['uae'],
  'United Kingdom' => ['uk'],
  Wales => ['wal'],
  Uruguay => ['uru'],
  USA => ['america']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
