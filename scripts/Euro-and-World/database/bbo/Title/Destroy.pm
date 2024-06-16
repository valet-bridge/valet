#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Destroy;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  '1v4', '2v3', '3x12', '4x12', '4v5', '#7836 teams', '#8405 teams',
  's5r38t2', 's5r40t2', 's5r4t2', 's5r43_t2', 's5r42t2', 's5r45t2',
  's1r7', 's2r1', 'k-8',
  '3way match 3-1 a', '3way match 3-1 b',
  'Around 52 cards in 80 years',
  'before bermuda bowl', 'bridge master champion', 'by joe pochron',
  'BBO1', 'BBO2', 'BBO3', 'BBO4', 'BBO5', 'BBO6', 'BBO7', 'BBO8', 'BBO9',
  '*BBO1', '*BBO2', '*BBO3', '*BBO4',
  'de bridge', 'de vigraph',
  'eng comment', 'eng comments', 'eng comment in',
  'for 3rd pair', 'for pau', 'for the',
  'g_m_',
  'in the',
  'main event',
  'sede', 'special tournament', 'sports event', 'swe comment', 
  'swe comments', 'sw comment', 'sw comments',
  'the 80 grand challenge',
  'untitled match',
  'warm up', 'Welcome to'
);

my %MULTI_TYPOS =
(
  'bridge master champion' => ['bridge master champions'],
  'for Pau' => ['pour pau'],
);

my @SINGLE_WORDS = qw(
  aa abd aft afternoon anniversary annual as at av
  b! BBO bboz bt bv by
  centenary celebrations combat compared
  des du duplicate duplicato
  eagles étoile eve evening extra
  from
  hawks het
  im in
  multievent
  naturalists nature
  popular
  retour retur
  science scientists show
  te teh the tn trn ts tv
  und
  vsa vsb
);

my %SINGLE_TYPOS =
(
  centenary => ['cetenary'],
  multievent => ['multieventof'],
  naturalists => ['nauralists'],
  scientists => ['scientist']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
