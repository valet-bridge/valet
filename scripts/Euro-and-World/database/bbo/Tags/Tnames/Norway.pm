#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Norway;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Bergen Grand Open Pairs',
  'Farmen Invitational',
  'FOSS Grand Pairs',
  'FX Securities Pairs Cup',
  'Gardermoen Airport Hotel Pairs',
  'Gardermoen Airport Hotel Teams',
  "Jessheim New Year's Pairs",
  "Jessheim New Year's Teams",
  'Jotun Open Teams',
  'Marit Sveaas Open Pairs',
  'Mo i Rana Ladies Invitational',
  'Namsos Pairs Cup',
  'Norwegian Club Pairs',
  'Norwegian Club Teams',
  'Norwegian Corporate Championship',
  'Norwegian Mixed Pairs',
  'Norwegian Mixed Teams',
  'Norwegian Mixed Team Trials',
  'Norwegian Open IMP Pairs',
  'Norwegian Open Pairs',
  'Norwegian Open Teams',
  'Norwegian Patton Teams',
  'Norwegian Premier League',
  'Norwegian Senior Teams',
  'Norwegian Swiss Pairs',
  'Norwegian Swiss Teams',
  'Norwegian Team Trials',
  'Norwegian Women Invitational Pairs',
  'Norwegian Women Teams',
  'Olrud Easter Mixed Pairs',
  'Olrud Easter Swiss Pairs',
  'Olrud Easter Swiss Teams',
  'Ragn-Sells International Open Pairs',
  'Rondane Pairs Cup',
  'Rondane Teams Cup',
  'Rosfjord Swiss Teams',
  'Ruter 7 Open Pairs',
  'Snåsa Pairs Cup',
  'Telemark Club Pairs',
  'Trondheim Pairs Cup',
  'Trondheim Teams Cup',
  'Vest-Agder Regional Team Championship',
  'Willy Brown Memorial Pairs'
);

my %MULTI_TYPOS =
(
  'Bergen Grand Open Pairs' => [
    'bergen grand tournament',
    'bergen grand tournamnet',
    'bergen open',
    'bergen storturnering',
    'bergen storturnering mester',
    'bergen stor mester',
    'bst mester'],
  'FOSS Grand Pairs' => [
    'foss grnad tourn',
    'foss grand tourney',
    'foss grand torunament',
    'foss grand toruney',
    'foss grand tournament',
    'foss grand torurnament',
    'foss grand torurney',
    'foss grand tourament',
    'foss grand tournement',
    'foss-tren',
    'ftredriklstad and sarpsborg grand tournet'],
  'FX Securities Pairs Cup' => [
    'fx securities cup',
    'fx sec_ cup'],
  'Gardermoen Airport Hotel Teams' => [
    'gardermoen airport hotel cup'],
  "Jessheim New Year's Pairs" => [
    'warm up jessheim new years cup'],
  "Jessheim New Year's Teams" => [
    "Jessheim New Year's Cup",
    'jessheim new years cup',
    'jesshiem new years cup',
    'jessheim new years cup swiss teams'],
  'Jotun Open Teams' => [
    'jotun bridge open teams'],
  'Marit Sveaas Open Pairs' => [
    'marit sveaas international bridge tournament',
    'marit sveaas international  bridge tournament',
    'marit sveaas tournament',
    'marit sveås ibt',
    'marit sveaas ibt'],
  'Namsos Pairs Cup' => ['namsos cup'],
  'Norwegian Club Teams' => [
    'codan cup',  
    'codan teams cup',
    'club team championship norway',
    'nor club teams ch_ship',
    'nor_club teams ch_ship',
    'nor club teams',
    'nor. club teams ch.ship',
    'norwegian ch ship teams',
    'norwegian club team',
    'norwegian club-team',
    'norwegian club team championship',
    'norwegian clubteams championship',
    'norwegian clubteams ch_ship',
    'norwegian clubteam championship',
    'norwegian clubs team',
    'norway club team championship',
    'norway club-team championship',
    'norway km teams'],
  'Norwegian Corporate Championship' => [
    'norwegian corp_ championship'],
  'Norwegian Mixed Pairs' => [
    'nbf mixed pairs',
    'nm mix pairs',
    'nor mixed pairs ch_ship',
    'norwegian championship mix swiss pair',
    'norwegian championship mix swiss pairs',
    'norwegian championship mixed swiss pairs',
    'norwegian championship open mixed pairs',
    'norwegian championships mixed pairs',
    'norwegian mixed pair championship',
    'norwegian mixed pairs championship',
    'norwegian mix pairs championship'],
  'Norwegian Mixed Team Trials' => [
    'norwegian mix team trials'],
  'Norwegian Mixed Teams' => [
    'nbf mixed teams',
    'norwegian championship mix swiss teams',
    'norwegian championship mix teams'],
  'Norwegian Open Pairs' => [
    'nbf norwegian pairs',
    'nm pairs',
    'nm-pairs',
    'norwegian championship open pairs',
    'norwegian pairs championship',
    'norwegain pairs',
    'norwegian pairs'],
  'Norwegian Open Teams' => [
    'nm klubblag',
    'nm lag',
    'nm-lag',
    'nm lagfinale',
    'nm open teams',
    'norwegian championship open teams',
    'norwegian chship teams',
    'norwegian chships teams',
    'norwgian open teams championship',
    'norwegian chmp teams'],
  'Norwegian Patton Teams' => [
    'nbf patton teams'],
  'Norwegian Premier League' => [
    'nbf 1_division',
    'nbf 1_divisjon',
    'nbf 1_ division',
    'nbf premier league',
    'nor team clubs',
    'nor premier league',
    'norvegian premier league',
    'norw premier league',
    'norway sm',
    'norwegian 1_division',
    'norwegian 1_ division',
    'norwegian 1 division',
    'norwegian prremier league',
    'sm norway'],
  'Norwegian Senior Teams' => [
    'nbf senior team championship'],
  'Norwegian Swiss Pairs' => [
    'nbf swiss pairs',
    'nm monrad pairs',
    'nm swiss pairs',
    'nor swiss pairs',
    'norwegian championship siwss pairs',
    'norwegian open swiss pairs',
    'norwegian swiss open pairs',
    'norwegian swiss pairs championship'],
  'Norwegian Swiss Teams' => [
    'nbf swiss teams',
    'nm-monrad-lag',
    'nm monrad lag',
    'nm-monrad-teams',
    'nm-monrad teams',
    'nor swiss teams',
    'norwegian championship open teams swiss',
    'norwegian championship swiss teams',
    'norwegian swiss team championship'],
  'Norwegian Team Trials' => ['nor team trials',
    'norwegian open trials',
    'norwegian wbg qualification'],
  'Norwegian Women Teams' => [
    'nbf nm damer lag',
    'nbf women team championship',
    'nbf women teams championship',
    'nbf womens team championship',
    'norwegian ladies team championship',
    'norwegian ladies teams',
    'norwegian women swiss teams',
    'norwegian women team championship',
    'norwegian womens team championship'],
  'Olrud Easter Mixed Pairs' => ['olrud easter mixed'],
  'Olrud Easter Swiss Pairs' => [
    'olrud easter pairs'],
  'Olrud Easter Swiss Teams' => [
    'olrudpaasken monrad lag',
    'olrud easter',
    'olrud easter tournament',
    'olrud easter swiss event',
    'olrud easter swiss team',
    'olrud easter teams',
    'olrud easter team-event',
    'olrud easter tourn',
    'olrud estern teamevent',
    'olrud estern team-event',
    'olrud paasken monrad lag',
    'olrud swiss teams',
    'olrudpaasken teams'],
  'Ragn-Sells International Open Pairs' => [
    'ragn sells international',
    'ragn-sells international grand tournament',
    'ragn-sells intl grand tournament',
    'ragn-sells intl_ grand tournament',
    'ragn sells intl_ grand tournament'],
  'Rondane Pairs Cup' => ['rondanecupen swiss pairs'],
  'Rondane Teams Cup' => ['rondane cup teams', 'rondanecupen teams',
    'rondanecupen swiss teams'],
  'Rosfjord Swiss Teams' => ['rosfjord monrad team',
    'rosfjord monrad teams'],
  'Ruter 7 Open Pairs' => [
    'ruter7 elitetournament',
    'ruter 7 open'],
  'Snåsa Pairs Cup' => [
    'snåsa cup'],
  'Telemark Club Pairs' => [
    'km par telemark'],
  'Trondheim Pairs Cup' => ['trondheim cup swiss pairs'],
  'Trondheim Teams Cup' => [
    'trondheim cup swiss teams',
    'trondheim cup team'],
  'Vest-Agder Regional Team Championship' => [
    'norw district',
    'norway regional champship',
    'norwegian district',
    'norwegian district championship',
    'norwegian regional chship vest-agder',
    'regional champship vest-agder',
    'regional chship vest-agder', 
    'vest-agder km lag'],
  'Willy Brown Memorial Pairs' => [
    'willy brown memorial'],
);

my %SINGLE_TYPOS =
(
  'FOSS Grand Pairs' => ['foss'],
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
