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
  Interport => ['inter-port'],
  Interprovince => ['inter provincials', 'inter province',
    'inter provinces', 'inter=provincial', 'inter-provincial',
    'inter provice', 'inter-province', 'inter-provinces'],
  Interregional => ['inter-regional', 'inter-region'],
  Interstate => ['inter-state', 'inter state', 'inter -state'],
  Interuniversity => ['inter-universities'],
  Invitational => ['invitasi terbatas', 'the bridge club invitational t'],
  'Pro-Am' => ['play against the stars', 'play with the champs',
    'pro_am', 'pro am']
);

my @SINGLE_WORDS = qw(
  Intercity 
  Interclub
  International
  Interport
  Interprovince
  Interregional
  Interstate
  Interuniversity
  Invitational
  National
  Transnational
  University
  World
);

my %SINGLE_TYPOS =
(
  Intercity => ['intecity'],
  Interclub => ['interclubs'],
  International => ['internacional', 'internationals',
    'internazionale', 'internationa', 'internat', 'int'],
  Interprovince => ['interprovincal', 'interprovincials',
    'interprovincial', 'ip'],
  Invitational => ['invitacion', 'invitacional', 'invitación',
    'invitasi', 'invitatioanal', 'invitation', 'invitional', 'invis',
    'ivitational', 'invitatational'],
  National => ['natioanl', 'nationale', 'nationals',
    'natinal', 'naational', 'nacional', 'nasional', 'nat'],
  Transnational => ['transnation', 'trans', 'transnatio',
    'transnat'],
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
