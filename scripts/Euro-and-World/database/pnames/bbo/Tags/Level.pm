#!perl
use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Level;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Gold Life Master',
  'Life Master',
  'Ruby Life Master',
  'Silver Life Master',
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Advanced 
  Beginner
  Intermediate
  Experienced
  Expert
);

my %SINGLE_TYPOS =
(
  Advanced => ['adv', 'advance', 'avancé', 'avancée',
    'erfahren', 'fortgeschritten'],
  Beginner => [
    'aspirant', 'aspirante',
    'bad', 'basic', 'beginer', 'beginners', 'crazy',
    'beginning', 'begynder', 'learner', 
    'newbie', 'novice', 'poor', 'weakling'],
  Expert => [
    'besta', 'beste', 'bestan', 'class',
    'elite',
    'exp', 'exper', 'experte', 'experto', 'experts',
    'enternasyonel', 'international', 'meilleure', 
    'masters', 'mester', 'mestre',
    'oracle', 'perfect', 'professional',
    'stars', 'super', 'teacher', 'true',
    'weltklasse', 'world', 'worldclass', 'xtreme'],
  Intermediate => [
    'good', 'learner', 'learning',
    'interm', 'intermed', 'intermediaire', 'intermediate',
    'intermediates', 'intermedio',
    'sofistike', 'still.learning@home',
    'strong improving intermediate'],
  'Life Master' => ['lifemaster'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
