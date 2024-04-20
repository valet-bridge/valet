#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamClub;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_club);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'ABA Mumbai',
  'Altay GSKD',
  'Altay Genclik',
  'Bamberger Reiter',
  'Diyarbakýr Sur BSK',
  'Drammen Arbeiderparti',
  'Kota Club',
  'Mike Lawrence Club',
  'Nancy Jarville',
  'Phoenix Oltenita',
  'Qingnian Qiche',
  'Van Bric SK'
);

my %MULTI_TYPOS =
(
  'ABA Mumbai' => ['aba - mumbai', 'aba-mumbai'],
  'Altay GSKD' => ['altay gsk', 'altay sdgskd', 'altay sk'],
  'Diyarbakýr Sur BSK' => ['diyarbakir bs', 'diyarbakir bsbs', 
    'dýyarbakir sur. b.b', 'diyarbakir sur sk', 'sur belediye sk',
    'sur belediye', 'd.bakýr sur', 'd.bakir sur'],
  'Drammen Arbeiderparti' => ['drammen arb']
);

my @SINGLE_WORDS = qw(
  Sakura
);

my %SINGLE_TYPOS =
(
  'ABA Mumbai' => ['aba']
);


sub set_hashes_team_club
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
