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
  'Antigua and Barbuda',
  'Abu Dhabi',
  'American Samoa',
  'Bosnia & Herzegovina',
  'Cape Verde',
  'Burkina Faso',
  'Cayman Islands',
  'Central African Republic',
  'Chinese Taipei',
  'Costa Rica',
  'Czech Republic',
  'Democratic Republic of the Congo',
  'Dominican Republic',
  'Equatorial Guinea',
  'Faroe Islands',
  'French Guyana',
  'French Polynesia',
  'Great Britain',
  'Guinea-Bissau',
  'Hong Kong',
  'Isle of Man',
  'Ivory Coast',
  'Marshall Islands',
  'Netherlands Antilles',
  'New Caledonia',
  'New Guinea',
  'New Zealand',
  'North America',
  'North Macedonia',
  'Northern Ireland',
  'Palau Republic',
  'Republic of the Congo',
  'Saint Barthélemy',
  'Saint Kitts and Nevins',
  'Saint Lucia',
  'Saint Vincent and the Grenadines',
  'San Marino',
  'São Tomé and Príncipe',
  'Saudi Arabia',
  'Serbia and Montenegro',
  'Sierra Leone',
  'Sint Maarten',
  'South Africa',
  'South Korea',
  'Sri Lanka',
  'Trinidad and Tobago',
  'United Arab Emirates',
  'United Kingdom',
  'US Virgin Islands'
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
    'china hong hong', 
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
  Afghanistan Albania Algeria Andorra Angola Angora Argentina Armenia 
  Aruba Australia Austria Azerbaijan
  Bahamas Bahrain Bangladesh Barbados Belarus Belgium Benin Bermuda 
  Bhutan Bolivia Bosnia Botswana Brazil Bulgaria
  Cambodia Cameroon Canada Chile China Colombia Comoros Congo Croatia 
  Cuba Curacao Cyprus
  Denmark 
  Ecuador Egypt England Estonia Eswatini Ethiopia
  Fiji Finland France
  Gabon Georgia Germany Georgia Greece Grenada Guadeloupe Guatemala 
  Guernsey Guyana
  Haiti Honduras Hungary 
  Iceland India Indonesia Iran Iraq Ireland Israel Italy
  Jamaica Japan Jersey Jordan
  Kazakhstan Kenya Kuwait Kyrgyzstan
  Laos Latvia Lebanon Lesotho Libya Liechtenstein Lithuania Luxembourg 
  Macau Madagascar Malawi Malaysia Mali Malta Martinique Mauritius 
  Mexico Moldova Monaco Mongolia Montenegro Morocco Mozambique
  Myanmar
  Namibia Nepal Netherlands Nicaragua Nigeria Norden Norway 
  Oman
  Pakistan Palestine Panama Paraguay Peru Philippines Poland Portugal
  Qatar
  Reunion Romania Russia Rwanda
  Scotland Senegal Serbia Seychelles Singapore Slovakia Slovenia 
  Spain Sudan Suriname Sweden Switzerland Syria
  Taiwan Tajikistan Tanzania Thailand Togo Tunisia Turkey Turkmenistan
  Uganda Ukraine Universal Uruguay USA Uzbekistan
  Vanuatu Venezuela Vietnam
  Wales
  Yemen Yugoslavia
  Zambia Zimbabwe
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
  Bulgaria => ['bg', 'bulgarya', 'bul', 'bulgar', 'bulgari',
    'bulgria'],
  Canada => ['kanada'],
  'Czech Republic' => ['czr', 'czechia'],
  'Chinese Taipei' => ['taipei'],
  Colombia => ['columbia'],
  Croatia => ['croatie', 'cro'],
  'Democratic Republic of the Congo' => ['congo-kinshasa'],
  Denmark => ['danmark', 'danemark', 'denmarrk', 'den', 'dk',
    'denmark*'],
  Egypt => ['egy', 'egytp', 'egypte'],
  England => ['eng', 'angleterre', 'englnd'],
  Estonia => ['estonie', 'est'],
  Eswatini => ['swaziland'],
  Finland => ['finnland', 'fi', 'fin'],
  'Faroe Islands' => ['faroes'],
  France => ['fra', 'fnc', 'frandce'],
  'French Guyana' => ['guyana', 'guayana', 'guayana'],
  Germany => ['deutschland', 'ger'],
  'Great Britain' => ['gb'],
  Greece => ['gre', 'hellas'],
  Guadeloupe => ['guadelupe'],
  'Hong Kong' => ['hk', 'hongkong', 'xianggang'],
  Hungary => ['hungar', 'hun'],
  Iceland => ['ice', 'islande'],
  India => ['indýa', 'hindusthan', 'hidusthan', 'indiaa'],
  Indonesia => ['timnas', 'ina'],
  Ireland => ['roireland', 'irelnd', 'irelsnd', 'irlande',
    'irelend', 'irelena', 'ire', 'eire'],
  Israel => ['isreal', 'israil', 'isarel', 'israël', 'isr'],
  Italy => ['italia', 'it', 'ita', 'italie'],
  Jordan => ['jor'],
  Latvia => ['lavtia', 'latvija', 'lat'],
  Lebanon => ['leb'],
  Liechtenstein => ['lichtenstein'],
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
  Philippines => ['philipppines', 'phillipina', 'phillipines'],
  Poland => ['polen', 'pologne', 'polska', 'pol', 'polland',
    'porland'],
  Portugal => ['por', 'pl', 'portogallo'],
  'Republic of the Congo' => ['congo-brazzaville'],
  Reunion => ['réunion'],
  Romania => ['rumania', 'rum', 'rom'],
  Russia => ['russian', 'rus', 'rusia', 'sbornaya', 'sbornaia'],
  'Saudi Arabia' => ['ksa'],
  'Serbia and Montenegro' => ['serbia&mon', 'srbija'],
  Scotland => ['scotlsnd', 'scotlands', 'scotlans', 'sco'],
  Singapore => ['sgp'],
  Slovenia => ['sovenia', 'slovenija'],
  'South Korea' => ['korea'],
  Spain => ['esp', 'españa', 'espana'],
  'Sri Lanka' => ['srilanka'],
  Sweden => ['swe', 'swedem', 'schweden', 'sweeden'],
  Switzerland => ['suitzerland', 'switserland', 'swiitzerland'],
  Taiwan => ['tw'],
  Thailand => ['thai', 'thailnad', 'thaland'],
  'Trinidad and Tobago' => ['trinidad'],
  Tunisia => ['tunisie', 'tunisian'],
  Turkey => ['tur', 'turkish', 'turkiye', 'türkýye'],
  'United Arab Emirates' => ['uae'],
  'United Kingdom' => ['uk'],
  'Venezuela' => ['venezuala'],
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
