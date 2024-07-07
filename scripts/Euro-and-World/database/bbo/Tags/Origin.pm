#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Origin;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Pro-Am'
);

my %MULTI_TYPOS =
(
  Intercity => ['inter-city', 'inter city', 'land inter-city'],
  Interclub => ['inter-club', 'inter-clubs', 'inter club',
    "de l'interclub"],
  Interprovince => ['inter provincials', 'inter province',
    'inter provinces', 'inter=provincial', 'inter-provincial',
    'inter provice', 'inter-province', 'inter-provinces'],
  Interregional => ['inter-regional', 'inter-region'],
  Invitational => ['invitasi terbatas', 'the bridge club invitational t'],
  'Pro-Am' => ['play against the stars', 'play with the champs',
    'pro_am', 'pro am']
);

my @SINGLE_WORDS = qw(
  Intercity 
  Interclub
  Interprovince
  Interregional
  Invitational
  Transnational
  University
  World
);

my %SINGLE_TYPOS =
(
  Intercity => ['intecity'],
  Interclub => ['interclubs'],
  Interprovince => ['interprovincal', 'interprovincials',
    'interprovincial', 'ip'],
  Invitational => ['invitacion', 'invitacional', 'invitación',
    'invitasi', 'invitatioanal', 'invitation', 'invitional', 'invis',
    'ivitational', 'invitatational'],
  Transnational => ['transnation', 'trans', 'transnatio',
    'transnat', 'tn'],
  University => ['uni', 'univ', 'universities', 'univeristies'],
  World => ['mondial']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
