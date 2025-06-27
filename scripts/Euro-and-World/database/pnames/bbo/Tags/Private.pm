#!perl
use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Private;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Private => [
    'as requested',
    'ask me..if want',
    'at request',
    'available upon request',
    'on request',
    'only on request',
    'upon request']
);

my @SINGLE_WORDS = qw(
  Private
);

my %SINGLE_TYPOS =
(
  Private => ['anon', 'anonimous', 'annonnymouse', 'anonym',
    'anonymus', 'anonymous', 'atyourrequest',
    'confdentl', 'confidencial', 'confidential', 'confidentiel',
    'confidentielle', 'great',
    'incognito', 'inconnu', 'inconnue',
    'no@com',
    'other', 'others',
    'pirivate', 'pivate', 'priv', 'priva', 'privado', 'privare',
    'privat', 'privata', 'private.au', 'privatem', 'privates', 
    'privati', 'privative', 'privato', 'prive', 'privee', 'privet', 
    'privite', 'privte', 'privé', 'privée', 'priwate', 'prv', 
    'prvate', 'prvt', 'pryw', 'prývate', 'ptivate',
    'unavailable', 'undisclosed', 'unknown', 'unlisted'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
