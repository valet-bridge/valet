#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Poland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Andrzej Wilkosz Memorial Pairs',
  'Bermuda Triangle Cup',
  'bridge24.pl Trophy',
  'Forest Trophy',
  'Grand Prix of Poland Pairs',
  'Grand Prix of Poland Teams',
  'Janina Wielkoszewska Memorial Open',
  'Janos Levai Memorial',
  'Józef Pochron Jubilee Pairs',
  'Krakow Spring Teams',
  'Leszek Kwiatkowski Memorial Pairs',
  'Leszek Kwiatkowski Memorial Teams',
  'Mondi Cup',
  'MTP Cup',
  'Palace Pairs Cup',
  'Palace Teams Cup',
  'Plock District League',
  'Polish BAM Cup',
  'Polish BAM Teams',
  'Polish Boys Championship',
  'Polish Business League',
  'Polish Business Pairs',
  'Polish First League',
  'Polish Girls Championship',
  'Polish Girls Trials',
  'Polish IMP Pairs',
  'Polish Individual Championship',
  'Polish Junior Pairs Trials',
  'Polish Mixed Pairs',
  'Polish Mixed Teams',
  'Polish Open Pairs',
  'Polish Open Teams',
  'Polish Open Trials',
  'Polish Pairs Cup',
  'Polish Patton Teams',
  'Polish Premier League',
  'Polish School Championship',
  'Polish Second League',
  'Polish Senior Trials',
  'Polish U16 Pairs',
  'Polish U16 Teams',
  'Polish U20 Trials',
  'Polish U25 Trials',
  'Polish Women Trials',
  'Pomerania Cup',
  'Sigismund Bell Krakow',
  'SPS Trophy',
  'Staszek Wybranowski Memorial',
  'Warsaw Online Teams',
  'Wronie Summer Teams',
  'Zulawski Cup'
);

my %MULTI_TYPOS =
(
  'Andrzej Wilkosz Memorial Pairs' => ['a_ wilkosz pro memoriam'],
  'Bermuda Triangle Cup' => ['bermuda triangle teams cup'],
  'bridge24.pl Trophy' => ['bridge24_pl trophy'],
  'Forest Trophy' => ['forest bridge trophy'],
  'Grand Prix of Poland Pairs' => [
    'gp polski par',
    'gpp mpp open',
    'grand prix plolski par',
    'grand priix polski par',
    'grand prix pairs of poland',
    'gran prix pairs of poland',
    'grand prix polski par',
    'otp puchar grodu staszica gpp',
    'pair grand prix of poland'],
  'Grand Prix of Poland Teams' => [
    'gp of poland teams',
    'gpp teamow',
    'grand prix of poland zulawski teams',
    'grand prix polski teamow',
    'grand prix team of poland',
    'poznan open teams',
    'poznan teams tournament',
    'team grand prix of poland',
    'teams grand prix of poland'],
  'Janina Wielkoszewska Memorial Open' => [
    'memorial im_ janiny wielkoszewskiej open'],
  'Janos Levai Memorial' => [
    'janos levai memorial match',
    'levai janos cup',
    'levai janos memorial'],
  'Józef Pochron Jubilee Pairs' => [
    'around 52 cards in 80 years by joe pochron'],
  'Krakow Spring Teams' => [
    'krakowska wiosna',
    'spring of cracow'],
  'Leszek Kwiatkowski Memorial Teams' => [
    'teams memorial of leszek kwiatkowski'],
  'Plock District League' => ['plockiej ligi okregowej'],
  'Polish BAM Teams' => ['bam team championship of poland'],
  'Polish Boys Championship' => ['polish championship boys'],
  'Polish Business League' => ['blb'],
  'Polish First League' => [
    'polish 1st division',
    'polish first division',
    'i liga'],
  'Polish Girls Championship' => ['polish championship girls'],
  'Polish IMP Pairs' => [
    'butler polish championship',
    'butler (imp) polish pairs championship'],
  'Polish Individual Championship' => [
    'forumbridge.pl top individual',
    'individual championship of poland',
    'polish top individual',
    'top indyvidual'],
  'Polish Mixed Pairs' => [
    'otwarte mistrzostwa poznania mixt',
    'mixed championship of poland',
    'polish mixed pairs championship',
    'polish mixed pairs championships',
    'polish mixt pairs championship'],
  'Polish Mixed Teams' => [
    'mistrzostwa polski teamów mikst',
    'polish mixt team championships'],
  'Polish Open Pairs' => [
    'forumbridge.pl top pairs',
    'inea cup',
    'open pairs championship of poland',
    'polish championship open pairs',
    'polish open pairs championship'],
  'Polish Open Teams' => [
    'mistrzostwa polski teamów',
    'polish open team championship',
    'polish open tems',
    'polish team championship',
    'polish teams championship',
    'team championship of poland',
    'teams championship of poland'],
  'Polish Open Trials' => [
    'polish bermuda bowl trials',
    'polish national trials',
    'polish team trials',
    'polish trials',
    'polish trials open'],
  'Polish Patton Teams' => [
    'poland championship patton',
    'polish championships team patton',
    'polish teams patton'],
  'Polish Premier League' => [
    'mecz o superlig©',
    'mecz o superlige',
    'mecz o superligê',
    'polish premier leauge',
    'polish premier legaue',
    'polish premier legue',
    'polish premier leuge',
    'polish premier leuge',
    'polish premier leaugue',
    'polish premiere league'],
  'Polish School Championship' => [
    'polish schools champ',
    'polish schools championships'],
  'Polish Second League' => ['polish 2 league'],
  'Polish Third League' => ['polish league: division 3'],
  'Polish U16 Teams' => [
    'polish u-16 championships',
    'polish u16 championships'],
  'Polish U20 Trials' => ['u20 polish trials'],
  'Polish U25 Trials' => ['poish u25 trials'],
  'Polish Women Trials' => ['polish trials women',
    'polish trials ladies', 'woman trial poland',
    "polish bridge union women's trials"],
  'Pomerania Cup' => [
    'grand prix of greater poland voivodeship',
    'grand prix of wielkopolski',
    'rozgrywek pucharowych pwzbs'],
  'SPS Trophy' => [
    'lojdy cup', 
    'sps construction trophy'],
  'Staszek Wybranowski Memorial' => ['memorial staszka wybranowskiego'],
  'Warsaw Online Teams' => ['enthusiast bridge zlot',
    'warsaw bboers champ', 'warsaw bboers championship'],
  'Zulawski Cup' => ['zulawski teams']
);

my %SINGLE_TYPOS =
(
  'Grand Prix of Poland Pairs' => ['gppp']
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
