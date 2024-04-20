#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamNationality;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_nationality);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Czech Republic'
);

my %MULTI_TYPOS =
(
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
  Australia => ['australian'],
  Bulgaria => ['bulgarian', 'blugarian'],
  Croatia => ['croatian'],
  'Czech Republic' => ['czech'],
  Estonia => ['estonian'],
  France => ['french'],
  Germany => ['german'],
  Greece => ['greek'],
  Hungary => ['hungar'],
  India => ['indian'],
  Indonesia => ['indonesian'],
  Israel => ['israeli'],
  Netherlands => ['dutch'],
  Norway => ['norwegian'],
  Poland => ['polish'],
  Sweden => ['swedish'],
  Tunisia => ['tunisie']
);


sub set_hashes_team_nationality
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
