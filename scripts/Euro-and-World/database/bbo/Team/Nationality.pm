#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Nationality;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_nationality set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Czech Republic'
);

my %MULTI_TYPOS =
(
  'Faroe Islands' => ['faroese']
);

my @SINGLE_WORDS = qw(
  Australia
  Bulgaria
  Croatia
  Estonia
  France
  Germany Greece
  Hungary
  India Indonesia Israel
  Netherlands Norway
  Poland
  Sweden
  Tunisia
);

# Mostly not really typos.
my %SINGLE_TYPOS =
(
  Argentina => ['argentinian', 'argentino'],
  Australia => ['australian', 'aussie', 'austalian', 'austarlian',
    'australain'],
  Austria => ['austrian'],
  Belarus => ['belarusian'],
  Belgium => ['belgian'],
  Bolivia => ['bolivariano', 'bolivarian'],
  Brazil => ['brazilian', 'brasilian'],
  Bulgaria => ['bulgarian', 'blugarian', 'bugarian'],
  Canada => ['canadian', 'candian', 'caniadian'],
  Chile => ['chilean'],
  Croatia => ['croatian'],
  'Czech Republic' => ['czech'],
  England => ['english'],
  Estonia => ['estonian'],
  Finland => ['finnish'],
  France => ['french', 'francaise', 'française'],
  Germany => ['german'],
  Greece => ['greek'],
  Hungary => ['hungar', 'hungarian'],
  Iceland => ['icelandic', 'icelandoc'],
  India => ['indian'],
  Indonesia => ['indonesian', 'indoneian'],
  Ireland => ['irish'],
  Israel => ['israeli', 'israli'],
  Italy => ['italian', 'italiano'],
  Lithuania => ['lithianin', 'lithuanian'],
  Netherlands => ['dutch'],
  Norway => ['norwegian', 'norvegian', 'norwegain', 'norwgian',
    'norwigian'],
  Poland => ['polish'],
  Portugal => ['portuguese'],
  Romania => ['romanian'],
  Scotland => ['scottish'],
  Serbia => ['serbian'],
  Spain => ['spanish'],
  Sweden => ['swedish', 'swdish', 'swedis', 'swesish'],
  Tunisia => ['tunisie']
);


sub set_hashes_team_nationality
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
