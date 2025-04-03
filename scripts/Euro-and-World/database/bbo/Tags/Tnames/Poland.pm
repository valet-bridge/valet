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
  'Bermuda Triangle Cup',
  'bridge24.pl Trophy',
  'Elblag Twin Towns Open Teams',
  'Forest Trophy',
  'Grand Prix of Poland Pairs',
  'Grand Prix of Poland Teams',
  'Janina Wielkoszewska Memorial Open',
  'Janos Levai Memorial',
  'Józef Pochron Jubilee Pairs',
  'Jurek Gres Open Teams Memorial',
  'Krakow Spring Teams',
  'Leszek Kwiatkowski Memorial Pairs',
  'Leszek Kwiatkowski Memorial Teams',
  'Lodz Twin Towns Open Teams',
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
  'Polish Girls Championship',
  'Polish IMP Pairs',
  'Polish Individual Championship',
  'Polish Junior Pairs Trials',
  'Polish Mixed Pairs',
  'Polish Mixed Pairs Trials',
  'Polish Mixed Teams',
  'Polish Mixed Team Trials',
  'Polish Online Open Teams',
  'Polish Open Pairs',
  'Polish Open Pair Trials',
  'Polish Open Teams',
  'Polish Open Trials',
  'Polish Pairs Cup',
  'Polish Patton Pairs',
  'Polish Patton Teams',
  'Polish Premier League',
  'Polish School Pairs',
  'Polish School Teams',
  'Polish Second League',
  'Polish Senior Pairs',
  'Polish Senior Trials',
  'Polish U16 Pairs',
  'Polish U16 Teams',
  'Polish U20 Trials',
  'Polish U21 Pair Trials',
  'Polish U21 Team Trials',
  'Polish U25 Trials',
  'Polish U26 Women Team Trials',
  'Polish U26 Women Pair Trials',
  'Polish U31 Pair Trials',
  'Polish Women Pairs',
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
  'Bermuda Triangle Cup' => [
    'bermuda triangle teams cup'],
  'bridge24.pl Trophy' => [
    'bridge24_pl trophy'],
  'Elblag Twin Towns Open Teams' => [
    'twin towns elblag'],
  'Forest Trophy' => [
    'forest bridge trophy'],
  'Grand Prix of Poland Pairs' => [
    'gp polski par',
    'gpp mpp open',
    'grand prix plolski par',
    'grand priix polski par',
    'grand prix pairs of poland',
    'gran prix pairs of poland',
    'grand prix polski par',
    'otp puchar grodu staszica gpp',
    'pair grand prix of poland',
    'pairs grand prix of poland'],
  'Grand Prix of Poland Teams' => [
    'gp of poland teams',
    'gpp teamow',
    'gppt of poland',
    'gpt of poland',
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
  'Jurek Gres Open Teams Memorial' => [
    'jurek gres in memoriam',
    'the jurek memorial',
    'memorial jurka gresia',
    'the jurek gres memorial'],
  'Krakow Spring Teams' => [
    'krakowska wiosna',
    'spring of cracow'],
  'Leszek Kwiatkowski Memorial Teams' => [
    'teams memorial of leszek kwiatkowski'],
  'Lodz Twin Towns Open Teams' => [
    'lodz twin towns'],
  'Plock District League' => [
    'plockiej ligi okregowej'],
  'Polish BAM Teams' => [
    'bam team championship of poland',
    'polish bam championships',
    'teams bam championship of poland'],
  'Polish Boys Championship' => [
    'polish championship boys'],
  'Polish Business League' => [
    'blb'],
  'Polish Girls Championship' => [
    'polish championship girls'],
  'Polish IMP Pairs' => [
    'butler polish championship',
    'butler (imp) polish pairs championship'],
  'Polish Individual Championship' => [
    'forumbridge.pl top individual',
    'forumbridge_pl top individual',
    'individual championship of poland',
    'polish top individual',
    'top indyvidual'],
  'Polish Mixed Pairs' => [
    'otwarte mistrzostwa poznania mixt',
    'mixed championship of poland',
    'mixed pairs championship of poland',
    'polish mixed pairs championship',
    'polish mixed pairs championships',
    'polish mixt pairs championship'],
  'Polish Mixed Teams' => [
    'mistrzostwa polski teamów mikst',
    'polish mixt team championships'],
  'Polish Mixed Team Trials' => [
    'polish mixed trials',
    'polish national mxt team trials',
    'polish national mixed team trials'],
  'Polish Online Open Teams' => [
    'polish online teams'],
  'Polish Open Pairs' => [
    'championship of poland open pairs',
    'forumbridge.pl top pairs',
    'forumbridge_pl top pairs',
    'inea cup',
    'mistrzostwa polski teamów',
    'open pairs championship of poland',
    'pairs championship od poland',
    'pairs championship of poland',
    'polish championship open pairs',
    'polish open pairs championship'],
  'Polish Open Teams' => [
    'mistrzostwa polski teamów',
    'polish open team championship',
    'polish open tems',
    'polish team championship',
    'polish team championships',
    'polish team imps',
    'polich team imp championship',
    'polish team imp championship',
    'polish teams championship',
    'polish teams championships',
    'team championship of poland',
    'teams championship of poland'],
  'Polish Open Trials' => [
    'polish bermuda bowl trials',
    'polish national open trials',
    'polish national team trials',
    'polish national teams trials',
    'polish national trials',
    'polish open team trials',
    'polish team trials',
    'polish teams trials',
    'polish trials',
    'polish trials open'],
  'Polish Patton Teams' => [
    'poland championship patton',
    'polish championships team patton',
    'polish teams patton'],
  'Polish Premier League' => [
    'i liga',
    'mecz o superlig©',
    'mecz o superlige',
    'mecz o superligê',
    'polish 1st division',
    'polish first division',
    'polish first league',
    'polish premier leauge',
    'polish premier legaue',
    'polish premier legue',
    'polish premier leuge',
    'polish premier leaugue',
    'polish premiere league'],
  'Polish Second League' => [
    'polish 2 league',
    'polish 2nd league'],
  'Polish Senior Pairs' => [
    'polish seniors pairs championship'],
  'Polish Senior Trials' => [
    'polish seniors national trials',
    'polish seniors trials'],
  'Polish Third League' => [
    'podlaska 3 liga',
    'podlaska 3rd division',
    'polish league: division 3'],
  'Polish U16 Teams' => [
    'polish u-16 championships',
    'polish u16 championships'],
  'Polish U20 Trials' => [
    'u20 polish trials'],
  'Polish U21 Pair Trials' => [
    'polish u21 pairs trials',
    'polish u21 trials pairs',
    'rozgrywki kadry u-21'],
  'Polish U25 Trials' => ['poish u25 trials'],
  'Polish U26 Women Team Trials' => [
    'polish girls trials',
    'polish national girls team trials'],
  'Polish U31 Pair Trials' => [
    'rozgrywki kadr u-21 i u-26'],
  'Polish Women Pairs' => [
    'women pairs championship of poland'],
  'Polish Women Trials' => [
    'polish trials women',
    'polish trials ladies', 
    'woman trial poland',
    "polish bridge union women's trials"],
  'Pomerania Cup' => [
    'grand prix of greater poland voivodeship',
    'grand prix of wielkopolski',
    'rozgrywek pucharowych pwzbs'],
  'SPS Trophy' => [
    'lojdy cup', 
    'meeting sps construction',
    'mityng sps construction',
    'sps construction trophy'],
  'Staszek Wybranowski Memorial' => ['memorial staszka wybranowskiego'],
  'Warsaw Online Teams' => [
    'enthusiast bridge zlot',
    'warsaw bboers champ', 
    'warsaw bboers championship'],
  'Zulawski Cup' => [
    'cup zulawy',
    'zulawy cup',
    'zulawski teams']
);

my %SINGLE_TYPOS =
(
  'Grand Prix of Poland Pairs' => ['gppp'],
  'Grand Prix of Poland Teams' => ['gppt']
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
