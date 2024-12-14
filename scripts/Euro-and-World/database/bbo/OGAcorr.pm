#!perl

package OGAcorr;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

# Entire tournaments where multiple ages or genders explicitly play
# against each other (as ages and genders).
my %GENDER_SPECIAL = (
  'Denmark Practice' => 
  {
    2015 => { Women => 1},
  },
  'Nordic Junior Teams' => 
  {
    2009 => { Women => 1},
    2013 => { Women => 1},
    2015 => { Women => 1},
  },
  'PT Timah Invitational Teams' =>
  {
    2011 => { Women => 1, Men => 1, Mixed => 1},
  },
  'White House Juniors' => 
  {
    2006 => { Women => 1},
    2007 => { Women => 1},
    2008 => { Women => 1},
    2009 => { Women => 1},
    2010 => { Women => 1},
    2011 => { Women => 1},
    2012 => { Women => 1},
    2014 => { Women => 1},
    2015 => { Women => 1},
  },
  'World Transnational Open Teams' =>
  {
    2011 => { Women => 1},
    2013 => { Mixed => 1},
  },
);

my %AGE_SPECIAL = (
  'Nordic Junior Teams' => 
  {
    2005 => { U21 => 1},
    2010 => { U21 => 1},
    2011 => { U20 => 1},
    2013 => { U20 => 1},
    2015 => { U16 => 1, U20 => 1},
  },
  'Salo Midsummer Juniors Teams' =>
  {
    2015 => { U20 => 1},
  },
  'Taiwan Practice' =>
  {
    2007 => { U20 => 1},
  },
  'White House Juniors' => 
  {
    2006 => { U20 => 1},
    2007 => { U20 => 1},
    2008 => { U20 => 1},
    2009 => { U20 => 1},
    2010 => { U20 => 1},
    2011 => { U20 => 1},
    2012 => { U20 => 1},
    2014 => { U20 => 1},
    2015 => { U20 => 1},
  },
  'World Transnational Open Teams' =>
  {
    2011 => { U26 => 1},
    2013 => { U26 => 1},
  },
);

my %ORIGIN_ACCEPTS = (
  # Says Youngsters in the team, but is Open tournament
  # (for example)
  'Aegean Open Teams' => [
    24034, 24046,
    29284, 29332],
  'Albena Open Teams' => [
    45721],
  'Alex Nurdin Cup' => [
    19897, 19922, 19952],
  'ArboNed Team Cup' => [
     6471,  6472,  6473],
  'ASEAN Open Club Teams' => [
    26291],
  'Asenovgrad Open Teams' => [
    39259],
  'Azores Open Teams' => [
    20287, 20288, 20299,
    25644, 25646, 25649, 25668, 25678,
    30503,
    35824],
  'Balaton Invitational Teams' => [
    33539],
  'Balkan Friendship Open Teams' => [
     2173],
  'Balkan Intercity Cup' => [
    20320,
    35754],
  'Balkan Open Teams' => [
    30575, 30590],
  'Bolivian Open Teams' => [
    30864, 30882, 31017],
  'Bonn Nations Cup' => [
     2637,
     8891,
     9846],
  'Cavendish Teams' => [
    25729, 25730,
    30860,
    41447],
  'China Elite Winter Teams' => [
    31160, 31170],
  'Chinese Inter-City Teams' => [
    19454,
    24543, 24554, 24559, 24600],
  'Commonwealth Nations Bridge Championships' => [
    15693, 15696,
    35346, 35376],
  'Danish Open Teams' => [
    19140, 19147, 19161, 19174,
    29203, 29204, 29214, 29216, 29221, 29222,
    34375],
  'Danish Open Team Trials' => [
    13619, 13624, 13634, 13640, 13647, 13654, 13663, 13671, 13676],
  "European Champions' Cup" => [
    31277, 31279],
  'European Transnational Open Teams' => [
     4660,
    18883, 18885, 18912, 18940, 18946, 18950],
  'European Winter Games' => [
    43148, 43167, 43173, 43183, 43194],
  'Finnish Cup' => [
    10560, 10564],
  'Finnish Open Teams' => [
    38282],
  'Forbo-Krommenie Nations Cup' => [
     6987],
  'Forest Trophy' => [
    18138, 18142, 18147],
  'Gabrial UI Bastaman Cup' => [
     1276,  1277,
    11895,
    14815, 14835],
  'Geologi Cup' => [
     3673,  3674,
    12213, 12219, 12235,
    16228,
    24629,
    29601, 29609,34404],
  'German Open Teams' => [
    19909, 19913,
    46399],
  'German Team Trophy' => [
    18396,
    23413, 23441, 23352, 23373,
    28022, 28030, 28044, 28047, 28063,
    33282,
    38526,
    44382],
  'Grand Prix of Poland Pairs' => [
    28473, 28479],
  'Grand Prix of Poland Teams' => [
    28446],
  'Greek Islands Festival' => [
    15108],
  'Haskovski Mineralni Bani Open Teams' => [
    10049],
  'Hong Kong Inter-City Open Teams' => [
    45876],
  'Hungary Exhibition' => [
      719,  720,  722,  723,  724],
  'Iceland Express Teams' => [
    16611],
  'IMSA Elite Women Teams' => [
    30778],
  'Indonesian Inter-Club Championship' => [
    35550, 35559, 35582, 35589,
    38871, 38900, 38901,
    44635, 44638, 44639, 44644, 44649, 44651, 44664, 44665, 44667,
    44669, 44670, 44672, 44673, 44678, 44762, 44767],
  'Indonesian Open Teams' => [
    35616],
  'Indonesian Premier League' => [
     9392,  9505,
    12580, 12766],
  'Israel Open Trials' => [
    22150, 22172, 22177, 22190, 22205, 22213],
  'Istanbul Winter Teams' => [
    26994],
  'Italy Friendly' => [
    41430, 41433],
  'Jinfan Open Teams Cup' => [
    28419,
    38385, 38396],
  "Kepri Governor's Cup" => [
     4116,
     8441,  8442,  8444,  8445,  8450,  8453,  8454,  8461,  8465,
    10616, 10617, 10631, 10634, 10645, 10652,
    15820,
    19330, 19337,
    35169, 35178, 35203,
    40703, 40716, 40752, 40783, 40789,
    46307, 46310, 46312],
  'Krishnapatnam Port National Masters' => [
    46272, 46281, 46282, 46283, 46284],
  'Lederer Memorial Trophy' => [
     2178,  2181,
     3775,  3779,
     8512,  8514,
    31021, 31048,
    37770, 37779,
    43442, 43496],
  'Lozenets Open Teams' => [
     9951],
  'Menpora-Pertamina Cup' => [
    41513, 41528, 41551, 41555, 41559, 41587, 41591],
  'Mersin Patton Open Teams' => [
    35420, 35428, 35431],
  'NEC Cup' => [
     3086,
     8134,
     9051,  9053,  9056,  9061,  9062,  9063,  9066,
    12639, 12644, 12653,
    16661,
    21884, 21885, 21890, 21891, 21894, 21907, 21908, 21914, 21921,
    21925,
    27725, 27727, 27728, 27737, 27746, 27755, 27757, 27758, 27760,
    27761, 27762, 27769, 27772, 27773, 27778,
    32251, 32263, 32271, 32275, 32276, 32278, 32282,
    37560, 37563, 37567, 37570, 37573],
  'Norway Practice' => [
    22211, 22214],
  'Norwegian Open Teams' => [
    34796, 34798],
  'Norwegian Swiss Teams' => [
     2573],
  'Norwegian Women Teams' => [
    38393],
  'Pan Arab Inter-Club Championship' => [
    31174],
  'Olrud Easter Swiss Teams' => [
     3808,  3809,  3811,
     8534,
    13253,
    17448],
  'Patton de Monaco' => [
     4420,  4421,  4423,  4428,  4430,
    11487,
    25707, 25709, 25716,
    30792, 30793],
  'Pertamina Field Tambun Cup' => [
    24192, 24200, 24204, 24211, 24224],
  'Pesta Sukan' => [
    29670],
  'Plovdiv Open Teams' => [
    13620, 13641,
    23118, 23119, 23137, 23140, 23145, 23153, 23155, 23174, 23177,
    23181,
    38566, 38571, 38585],
  'PLN Cup' => [
    41377, 41397, 41408, 41409],
  'Pula Open Teams' => [
     3631, 
     5652,
    25299],
  'Puutalo Open' => [
     2926],
  'Rosenblum Cup' => [
    36069, 36072, 36081],
  'Semen Padang Cup' => [
    24083, 24086, 24089, 24092, 24096],
  'Serdika Open Teams' => [
     9814,  9818,
    13945,
    23402,],
  'Shumen Open Teams' => [
    41013],
  'Singapore Open Teams' => [
     3380,  3381,  3382,  3383],
  'Slava Cup' => [
    43270, 43305, 43336, 43355, 43363, 43373],
  'Stara Zagora Open Teams' => [
    20362, 20367, 20370, 20371, 20379, 20370, 20379, 20386, 20394],
  'Swedish Open Teams' => [
    44479, 44480, 44485, 44486, 44495, 44497, 44509, 44518],
  'Swedish Open Team Trials' => [
     8298, 8309],
  'Swiss Cup' => [
    45208, 45214, 45216,45217],
  'Swiss Open Teams' => [
    44286, 44306, 44310, 44315],
  'Telkom Indonesia Open' => [
    14538, 14544, 14569, 14570, 14574,
    19082,
    22338, 22340, 22349,
    27779,
    33869, 33878, 33883, 33904, 33950,
    42046, 42048, 42053, 42059, 42067, 42070, 42093, 42109],
  'Teltscher Trophy' => [
     9946,  9964,  9988,  9995,
    39014,
    44818, 44830, 44843, 44849],
  'The Hague Bridge Experience' => [
    46355],
  'Thrace Club League' => [
    34398],
  'Torneo di Rastignano' => [
    40753],
  'Torneo di Roma' => [
    30729, 30743, 30770],
  'Towns Cup' => [
     2126,  2127,
     9944,  9952,
    18204, 18205,
    33771,
    39222,
    44900],
  'Turkish Club Championship' => [
    19580,
    25024],
  'Turkish Open Teams' => [
     9604,  9630],
  'Varna Titan Open Teams' => [
    29867, 29870, 29872,
    34923, 34924],
  'Vilnius Open Teams' => [
    40788, 40791, 40795],
  'Western Mediterranean Club Teams' => [
    33891],
  'White House Interntional' => [
     8188,  8199],
  'White House Top 16' => [
     1329],
  'World Open Junior Teams' => [
    10745, 10747, 10775, 10779,
    19615, 19621, 19641],
  'Yeh Bros Cup' => [
     9119,  9120,  9133,
    27796, 27798, 27800, 27806, 27807, 27808, 27810, 27813],
  'Zurich Open' => [
    22228],
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


sub age_special
{
  my ($tname, $year, $value) = @_;
  return 
    exists $AGE_SPECIAL{$tname} &&
    exists $AGE_SPECIAL{$tname}{$year} &&
    exists $AGE_SPECIAL{$tname}{$year}{$value};
}


sub gender_special
{
  my ($tname, $year, $value) = @_;
  return 
    exists $GENDER_SPECIAL{$tname} &&
    exists $GENDER_SPECIAL{$tname}{$year} &&
    exists $GENDER_SPECIAL{$tname}{$year}{$value};
}

1;
