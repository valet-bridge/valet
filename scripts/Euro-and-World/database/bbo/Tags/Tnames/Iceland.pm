#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Iceland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Gunnars Birgisson Memorial',
  'Iceland Express Pairs',
  'Iceland Express Teams',
  'Icelandair Open Pairs',
  'Icelandair Open Teams',
  'Icelandic Cup',
  'Icelandic First Division',
  'Icelandic Open Teams',
);

my %MULTI_TYPOS =
(
  'Gunnars Birgisson Memorial' => [
    'minningarmót gunnars b',
    'minningarmót gunnars birgisson',
    'minningarmót gunnars birgissonar'],
  'Iceland Express Teams' => ['iceland express team'],
  'Icelandair Open Teams' => [
    'icelandair open',
    'icelandair team championship',
    'icelandari open'],
  'Icelandic Cup' => [
    'bikarkeppni bsí',
    'icelandic champions cup',
    'icelandoc cup',
    'iceland cup'],
  'Icelandic First Division' => [
    'iceland 1_ division',
    'iceland 1 division',
    'iceland 1 vision',
    'iceland division 1',
    'iceland first division',
    'iceland league',
    'icelandic league cup'],
  'Icelandic Open Teams' => [
    'iceland teams',
    'icelandic team',
    'icelandic team championship',
    'icelandic team championsship',
    'icelandic team chapmionship',
    'icelandic team championships',
    'icelandic teamhampionship',
    'icelandic teams',
    'isl_mot i sveitakeppni',
    'Ísl_mót í sveitakeppni',
    'íslandsmót svk',
    'Þristamótið',
    'thristamotid'],
);

my %SINGLE_TYPOS =
(
  'Icelandair Open Teams' => ['icelandair'],
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
