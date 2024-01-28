#!perl

package Country;

use strict;
use warnings;
use Exporter;
use v5.10;

my %COUNTRIES = (
  Albania => "ALB", ALB => "ALB",
  Argentina => "ARG", ARG => "ARG",
  Armenia => "ARM", ARM => "ARM",
  Aruba => "ARU", ARU => "ARU", # Not standard
  Australia => "AUS", AUS => "AUS",
  Austria => "AUT", AUT => "AUT",
  Bahrain => "BHR", BHR => "BHR",
  Bangladesh => "BAN", BAN => "BAN", # Not standard
  Barbados => "BAR", BAR => "BAR", # Not standard
  Belarus => "BLR", BLR => "BLR",
  Belgium => "BEL", BEL => "BEL",
  Bermuda => "BER", BER => "BER", # Not standard
  "Bosnia & Herzegovina" => "BIH", BIH => "BIH",
  Botswana => "BOT", BOT => "BOT", # Not standard
  Brazil => "BRA", BRA => "BRA",
  Bulgaria => "BUL", BUL => "BUL", # Not standard
  Canada => "CAN", CAN => "CAN",
  Chile => "CHI", CHI => "CHI", # Not standard
  China => "CHN", CHN => "CHN",
  "Chinese Taipei" => "TPE", TPE => "TPE", # Not standard (Taiwan)
  Colombia => "COL", COL => "COL",
  "Costa Rica" => "CRC", CRC => "CRC",
  Croatia => "CRO", CRO => "CRO", # Not standard
  Cuba => "CUB", CUB => "CUB",
  Cyprus => "CYP", CYP => "CYP",
  "Czech Republic" => "CZE", CZE => "CZE",
  Denmark => "DEN", DEN => "DEN", # Not standard
  Ecuador => "ECU", ECU => "ECU",
  Egypt => "EGY", EGY => "EGY",
  England => "ENG", ENG => "ENG", # Not standard
  Estonia => "EST", EST => "EST",
  "Faroe Islands" => "FRO", FRO => "FRO",
  Finland => "FIN", FIN => "FIN",
  France => "FRA", FRA => "FRA",
  "French Polynesia" => "PYF", PYF => "PYF",
  Georgia => "GEO", GEO => "GEO",
  Germany => "GER", GER => "GER", # Not standard
  "Great Britain" => "GBR", GBR => "GBR",
  Greece => "GRE", GRE => "GRE", # Not standard
  Guadeloupe => "GLP", GLP => "GLP",
  Guatemala => "GUA", GUA => "GUA",
  Guyana => "GUY", GUY => "GUY",
  "Hong Kong" => "HKG", HKG => "HKG", "Hong Kong China" => "HKG",
  Hungary => "HUN", HUN => "HUN",
  Iceland => "ISL", ISL => "ISL",
  India => "IND", IND => "IND",
  Indonesia => "INA", INA => "INA", # Not standard
  Iran => "IRN", IRN => "IRN",
  Ireland => "IRL", IRL => "IRL",
  Israel => "ISR", ISR => "ISR",
  Italy => "ITA", ITA => "ITA",
  "Ivory Coast" => "CIV", CIV => "CIV",
  Jamaica => "JAM", JAM => "JAM",
  Japan => "JPN", JPN => "JPN",
  Jordan => "JOR", JOR => "JOR",
  Kenya => "KEN", KEN => "KEN",
  Korea => "KOR", KOR => "KOR", # South Korea, Republic of Korea
  Kuwait => "KUW", KUW => "KUW", # Not standard
  Latvia => "LAT", LAT => "LAT", # Not standard
  Lebanon => "LIB", LIB => "LIB", # Not standard
  Liechtenstein => "LIE", LIE => "LIE",
  Lithuania => "LTU", LTU => "LTU",
  Luxembourg => "LUX", LUX => "LUX",
  Madagascar => "MAD", MAD => "MAD", # Not standard
  Malaysia => "MAS", MAS => "MAS", # Not standard
  Malta => "MLT", MLT => "MLT",
  Martinique => "MTQ", MTQ => "MTQ",
  Mauritius => "MRI", MRI => "MRI", # Not standard
  Mexico => "MEX", MEX => "MEX",
  Monaco => "MON", MON => "MON", # Not standard
  Mongolia => "MGL", MGL => "MGL", # Not standard
  Montenegro => "MNE", MNE => "MNE",
  Morocco => "MAR", MAR => "MAR",
  Netherlands => "NED", NED => "NED", # Not standard
  "Netherlands Antilles" => "AHO", AHO => "AHO", # Not standard
  "New Guinea" => "PNG", PNG => "PNG",
  "New Zealand" => "NZL", NZL => "NZL",
  Norway => "NOR", NOR => "NOR",
  Online => "ONL", ONL => "ONL", # Not standard
  Pakistan => "PAK", PAK => "PAK",
  Palestine => "PLE", PLE => "PLE",
  Panama => "PAN", PAN => "PAN",
  Peru => "PER", PER => "PER",
  Philippines => "PHI", PHI => "PHI", # Not standard
  Poland => "POL", POL => "POL",
  Portugal => "POR", POR => "POR", # Not standard
  Qatar => "QAT", QAT => "QAT",
  Reunion => "REU", REU => "REU",
  Romania => "ROM", ROM => "ROM", # Not standard
  Russia => "RUS", "RUS" => "RUS",
  "San Marino" => "SMR", SMR => "SMR",
  "Saudi Arabia" => "KSA", KSA => "KSA", # Not standard
  Scotland => "SCO", SCO => "SCO", # Not standard
  Serbia => "SER", SER => "SER", # Not standard
  "Serbia and Montenegro" => "SCG", SCG => "SCG",
  Slovakia => "SVK", SVK => "SVK",
  Slovenia => "SLO", SLO => "SLO", # Not standard
  Singapore => "SIN", SIN => "SIN", # Not standard
  "South Africa" => "RSA", RSA => "RSA", # Not standard
  Spain => "ESP", ESP => "ESP",
  "Sri Lanka" => "SRI", SRI => "SRI", # Not standard
  Sweden => "SWE", SWE => "SWE",
  Switzerland => "SUI", SUI => "SUI", # Not standard
  Syria => "SYR", SYR => "SYR",
  Thailand => "THA", THA => "THA",
  "Trinidad and Tobago" => "TRI", TRI => "TRI", # Not standard
  Tunisia => "TUN", TUN => "TUN",
  Turkey => "TUR", TUR => "TUR", "Turkiye" => "TUR",
  Ukraine => "UKR", UKR => "UKR",
  "United Arab Emirates" => "UAE", UAE => "UAE", # Not standard
  Uruguay => "URU", URU => "URU", # Not standard
  USA => "USA", "U.S.A." => "USA",
  "US Virgin Islands" => "VUS", VUS => "VUS", # Not standard
  Venezuela => "VEN", VEN => "VEN",
  Wales => "WAL", WAL => "WAL", # Not standard
  "Yugoslavia" => "YUG", YUG => "YUG",
  "Zimbabwe" => "ZIM", ZIM => "ZIM"
);


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $COUNTRIES{$text} ? 1 : 0;
}


sub code
{
  my ($self, $text) = @_;
  return $COUNTRIES{$text};
}


sub equal
{
  my ($self, $text1, $text2) = @_;
  return 0 unless exists $COUNTRIES{$text1};
  return 0 unless exists $COUNTRIES{$text2};
  return $COUNTRIES{$text1} eq $COUNTRIES{$text2} ? 1 : 0;
}


1;
