#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamUniversity;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_university);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Anadolu University',
  'Bilkent University',
  'Gunadurma',
  'ITS IKOMA',
  'ITÜ Vakfi',
  'Koc University',
  'KwaZulu Natal',
  'University of California at Berkeley',
  'University of Chicago',
  'University of Gdansk',
  'University of Illinois',
  'University of North Carolina',
  'University of Warsaw',
  'University of Wroclaw',
  'Universität Potsdam'
);

my %MULTI_TYPOS =
(
  'Anadolu University' => ['uni. anadolu'],
  'Bilkent University' => ['bilkent uni.'],
  'Gunadurma' => ['guna darma'],
  'ITÜ Vakfi' => ['itu vakfi'],
  'Koc University' => ['koc university bk'],
  'University of California at Berkeley' => ['cal berkeley',
    'cal-berkeley', 'uc berkeley', 'berkeley'],
  'University of Chicago' => ['u chicago'],
  'University of Gdansk' => ['uni gdansk', 'gdank univ poland',
    'gdansk univ poland'],
  'University of Illinois' => ['u of illinois'],
  'University of North Carolina' => ['u n. carolina'],
  'University of Warsaw' => ['uni warsaw'],
  'University of Wroclaw' => ['uni wroclaw'],
  'Universität Potsdam' => ['uni potsdam']
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
);


sub set_hashes_team_university
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
