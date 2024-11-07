#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Italy;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Bologna Trophy',
  'Italian Club Open Championship',
  'Italian Club Women Championship',
  'Italian Men Cup',
  'Italian Mixed Cup',
  'Italian Mixed Pairs',
  'Italian Mixed Teams',
  'Italian Open Cup',
  'Italian Open Teams',
  'Italian Open Trials',
  'Italian Senior Cup',
  'Italian Senior Trials',
  'Italian U36 Teams',
  'Italian Women Cup',
  'Milan Trophy',
  'Olona International Teams',
  'Rome Challenger Trophy',
  'Torneo di Rastignano',
  'Torneo di Roma',
  'Toscana Cup',
  'Viareggio Cup'
);

my %MULTI_TYPOS =
(
  'Bologna Trophy' => ["trofeo citta' di bologna",
    "trofeo citta' bologna", "citta' di bologna",
    "trofeo citta' bologna"],
  'Italian Club Open Championship' => ['camp_ soc_ open'],
  'Italian Club Women Championship' => [
    'italian club team champ women',
    'italian club women championships'],
  'Italian Mixed Cup' => ['italy mixed cup'],
  'Italian Mixed Pairs' => ['italy mixed pairs'],
  'Italian Mixed Teams' => ['italian mixed teams championships'],
  'Italian Open Teams' => [
    'camp.it.squadre',
    'camp.it. squadre',
    'italian open team championships',
    'italian team championship'],
  'Italian Open Trials' => ['italian open teams trials'],
  'Italian Senior Trials' => ['italian senior teams trials'],
  'Italian U36 Teams' => ['Italian Master U36'],
  'Milan Trophy' => [
    "citta' di milano",
    "trofeo citta' di milano"], 
  'Olona International Teams' => [
    'international olona bridge team'],
  'Rome Challenger Trophy' => [
    'challenge trofeo città di roma',
    'trofeo challenger città di roma'],
  'Torneo di Roma' => ['angelini teams'],
  'Viareggio Cup' => [
    'coppie viareggio'],
);

my %SINGLE_TYPOS =
(
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
