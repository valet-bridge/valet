#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::India;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'All India HCL Tournament',
  'Goa Bridge Festival',
  'Indian South Zone Championship',
  'Indian Summer Nationals',
  'Indian Winter Nationals',
  'Maharaja Holkar National Championship',
  'Maharashtra State Championship',
  'Rajasthan Invitational Championship',
  'Uttar Pradesh State Championship',
  'West Indian Regional'
);

my %MULTI_TYPOS =
(
  'All India HCL Tournament' => [
    'all india hcl open',
    'hcl bridg tournamnt',
    'hcl bridge champion ship',
    'hcl bridge championship',
    'hcl bridge tournament',
    'hcl championship',
    'hcl international bridge championship',
    'hcl international open',
    'hcl international open championship',
    'hcl open',
    'hcl open championship',
    'hcl open international tournament',
    'hcl open tournament'],
  'Indian South Zone Championship' => [
    'south zone championship',
    'southzone championship',
    'souhzone championship'],
  'Indian Summer Nationals' => [
    'tolani open',
    'tolani open summer nationals',
    'tolani summer nationals',
    'dr tolani open summer nationals',
    'dr_tolani open summer natinal',
    'dr_tolani open summer nationaals',
    'dr_tolani open summer national',
    'dr_tolani open summer nationals',
    'dr tolani summer nationals',
    'dr_tolani summer nationals',
    'dr_ tolani open summer nations',
    'dr_ tolani open summer nationals',
    'dr_ tolani summar nationals',
    'dr_ tolani summer nationals'],
  'Maharaja Holkar National Championship' => [
    'maharaja holakar championship',
    'maharaja holar national open',
    'maharaja holkar bridge championship',
    'maharaja holkar championship',
    'maharaja holkar national open championship',
    'maharaja holkar national tournament',
    'm yeshwantrao holkar national bridge championship'],
  'Maharashtra State Championship' => [
    'maharashtra championship',
    'maharashtra state brahmin sabha',
    'maharashtra state brhman sabha',
    'maharashtra state championships'],
  'Rajasthan Invitational Championship' => [
    'rajasthan bridge association invitational',
    'rajasthan bridge championship',
    'rajasthan championship',
    'rajasthan invitational bridge championship',
    'rajasthan invitational bridge tournament',
    'rajasthan invitational championship',
    'rajasthan invitation tournament',
    'rajasthan invitatational tournament',
    'rajasthan invitational tournament'],
  'Uttar Pradesh State Championship' => [
    'up state championship'],
);

my %SINGLE_TYPOS =
(
  'Indian Winter Nationals' => ['winternationals'],
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
