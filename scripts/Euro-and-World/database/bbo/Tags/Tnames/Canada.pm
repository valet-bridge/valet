#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Canada;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Canadian Mixed Teams Championship',
  'Canadian National Teams Championship',
  'Canadian Seniors Teams Championship',
  'Canadian Women Teams Championship',
);

my %MULTI_TYPOS =
(
  'Canadian National Teams Championship' => [
    'canadian a tm',
    'canadian champ open',
    'canadian national team',
    'canadian open teams',
    'canadian open teams championship',
    'canadian tm a',
    'can open teams championship',
    'can open team championship',
    'can_ champ open'],
  'Canadian Seniors Teams Championship' => [
    'canadian champ senior',
    'canadian champs senior',
    'canadian senior championship',
    'canadian senior teams',
    'canadian senior tm',
    'canadian seniors championship'],
  'Canadian Women Teams Championship' => [
    'can ladies bridge champs',
    'can ladies team champ',
    "canadian women's teams championship",
    'cbc womens finals',
    'cbf womens final',
    'cbf womens finals'],
);

my %SINGLE_TYPOS =
(
  'Canadian National Teams Championship' => ['cntc'],
  'Canadian Seniors Teams Championship' => ['cstc', 'cnst'],
  'Canadian Women Teams Championship' => ['cwtc'],
);

sub set_hash
{
  my ($gmulti_words, $gmulti_typos, $gsingle_typos) = @_;

  push @$gmulti_words, @MULTI_WORDS;

  while (my ($key, $value) = each %MULTI_TYPOS)
  {
    @{$gmulti_typos->{$key}} = @$value;
  }

  while (my ($key, $value) = each %SINGLE_TYPOS)
  {
    @{$gsingle_typos->{$key}} = @$value;
  }
}

1;
