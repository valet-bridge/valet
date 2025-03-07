#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Bulgaria;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Albena Open Teams',
  'Asenovgrad Open Teams',
  'Bansko Bridge Masters',
  'Bulgarian Anniversary Open Teams',
  'Bulgarian Open Pairs',
  'Bulgarian Club Teams',
  'Bulgarian Open Cup',
  'Bulgarian Open Teams',
  'Bulgarian Open Trials',
  'Bulgarian Women Trials',
  'Chelopech Open Teams',
  'Dimitrovgrad Open Teams',
  'Dobrich Open Teams',
  'Harmanli Open Teams',
  'Haskovski Mineralni Bani Open Pairs',
  'Haskovski Mineralni Bani Open Teams',
  'Karlovo Open Pairs',
  'Karlovo Open Teams',
  'Kaylaka Open Teams',
  'Lozenets Open Teams',
  'Panagyurishte Open Teams',
  'Pleven Open Teams',
  'Plovdiv Open Teams',
  'Popovo Friendship Open Teams',
  'Rusenski Lom Open Teams',
  'Serdika Open Teams',
  'Sliven Open Teams',
  'St. Ivan Rilski Open Teams',
  'Shumen Open Teams',
  'Star Bet Casino Open Teams',
  'Stara Zagora Open Teams',
  'Varna Intercity Teams',
  'Varna Titan Open Teams'
);

my %MULTI_TYPOS =
(
  'Albena Open Teams' => ['ibf albena'],
  'Asenovgrad Open Teams' => [
    'asenovgrad tournament',
    'national bridge tournament asenovgrad'],
  'Bulgarian Open Pairs' => [
    'aris cup',
    'bulgaria open pairs championship',
    'bulgarian champions pairs'],
  'Bulgarian Open Cup' => [
    'bulgarian bridge federation super final'],
  'Bulgarian Open Teams' => ['bulgarian national teams championship',
    'bulgarian national championship',
    'bulgaria national teams championship'],
  'Bulgarian Open Trials' => [
    'bulgaria national team trials',
    'bulgarian national team qualification',
    'bulgarian national team qualifications',
    'bulgarian national team trial',
    'bulgarian national team trials',
    'bulgarian national trials',
    'national team championship bulgaria'],
  'Bulgarian Women Trials' => [
    'bulgaria women national team trials',
    'bulgarian ladies trial'],
  'Chelopech Open Teams' => [
    'national bridge tournament chelopech'],
  'Cherven Briag Open Teams' => [
    'cherven briag',
    'cherven briag national tournament',
    'national tournament cgerven briag',
    'national tournament cherven briag'],
  'Dimitrovgrad Open Teams' => [
    'bridge tournament dimitrovgrad',
    'dimitrovgrad teams'],
  'Harmanli Open Teams' => [
    'bridge tourney harmanli'],
  'Haskovski Mineralni Bani Open Teams' => [
    'haskovski mineralni bani'],
  'Karlovo Open Pairs' => ['karlovo pairs'],
  'Karlovo Open Teams' => [
    'karlovo teams',
    'vasil levski cup'],
  'Kaylaka Open Teams' => [
    'kailaka cup',
    'kaylaka cup',
    'kaylaka masters'],
  'Pleven Open Teams' => [
    "bridge tournament \"gabi\"",
    'gabi pleven teams',
    'gabi teams pleven',
    "national bridge tournament \"gabi\"",
    "national tournament \"gabi\"",
    'national tournament gabi',
    'pleven open teams gabi',
    'teams gabi',
    'teams tournament gabi',
    "tournament \"gabi\" pleven"],
  'Plovdiv Open Teams' => [
    'national bridge tournament alert plovdiv'],
  'Popovo Friendship Open Teams' => [
    'popovo friendship tournament',
    'popovo tournament of friendship'],
  'Rusenski Lom Open Teams' => [
    'tournament ruseneski lom',
    'tournament rusenski lom'],
  'Serdika Open Teams' => ['serdika cup'],
  'St. Ivan Rilski Open Teams' => [
    'international bridge tournament st_ ivan rils',
    'international tournament st_ ivan rilski',
    'ivan rilski open teams'],
  'Star Bet Casino Open Teams' => [
    'star bet casino sunny beach'],
  'Stara Zagora Open Teams' => ['vito teams'],
  'Varna Titan Open Teams' => [
    'varna open teams tournament',
    'varna titan teams',
    'teams titan']
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
