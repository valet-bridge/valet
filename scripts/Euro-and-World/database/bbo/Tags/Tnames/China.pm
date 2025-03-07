#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::China;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'All-China Mixed Teams',
  'All-China Open Teams',
  'All-China Women Teams',
  'Aoda Cup',
  'Beibu Gulf Open Teams',
  'China Elite Spring Teams',
  'China Elite Winter Teams',
  'China Friend City Senior Teams',
  'China Hosts Europe in Rome',
  'Chinese First League',
  'Chinese Inter-City Teams',
  'Chinese Mixed Teams',
  'Chinese Mixed Trials',
  'Chinese Open Teams',
  'Chinese Open Trials',
  'Chinese University Teams',
  'Chinese Women First League',
  'Chinese Women Teams',
  'Chung Hua Cup',
  'Cross Strait Invitational',
  'Dongfeng Cup',
  'Dongming Knock-out Teams',
  'G60 Cup',
  'GHTD Cup',
  'Guang Qing Memorial Open Teams',
  'Guangdong Club Championship',
  'Guangdong Elite Tournament',
  'Guangzhou-HK-Macau Interport',
  'HNA Open Teams',
  'Haikou Fitness Day',
  'High-Tech Zone Workers Invitational',
  'JPD Open Cup',
  'JPD Women Cup',
  'Jia-Wei Memorial Open Teams',
  'Jiangsu Province Open Teams',
  'Jianshe Cup',
  'Jili Cup',
  'Jinfan Mixed Teams Cup',
  'Jinfan Open Teams Cup',
  'Mountain Sea Cup',
  'Nanshan Mixed Teams Cup',
  'Nanshan Open Teams Cup',
  'Ruihai Shuicheng Senior Teams',
  'Sanchen Cup',
  'Sanya Cup',
  'Shanqing Mountain Open Teams',
  'Shenhua Cup',
  'Shenyang Spring Teams',
  'Shenzhen Lanpu Cup',
  'Shenzhen Nangangdongli Cup',
  'Sunchime Fund Cup',
  'Tielu Jixie Invitational',
  'Vanke Open Teams Cup',
  'Xinyuan Cup',
  'Zhejiang Huamen Cup'
);

my %MULTI_TYPOS =
(
  'Beibu Gulf Open Teams' => [
    'china beibu gulf national bridge open'],
  'China Friend City Senior Teams' => [
    'china friend city senior team tournament'],
  'Chinese First League' => [
    'china first league',
    'china national bridge a club league final to',
    'china national bridge club championships',
    'china premier league',
    'china primier league',
    'club-a grand final china',
    'national club league china',
    'national club league',
    'the national class a club league'],
  'Chinese Inter-City Teams' => [
    'avia inter-city bridge championships',
    'avia intercity championship',
    'china inter-city teams',
    'china resources inter-city',
    'china resources inter-city bridge championships',
    'china resources land inter-city bridge cham',
    'china resources land  inter-city bridge cham',
    'chinese intercity teams',
    'cr power intercity'],
  'Chinese Mixed Teams' => [
    'ccba mix teams',
    'mixed teams china'],
  'Chinese Mixed Trials' => [
   'china national mixed team trial'],
  'Chinese Open Trials' => [
   'chinese open team trials'],
  'Chinese University Teams' => [
    'china university bridge championships'],
  'Chinese Women First League' => [
    'china national women league'],
  'Dongming Knock-out Teams' => [
    'dong ming knockour teams', 
    'dong ming knockout teams',
    'ding ming knockout teams'],
  'Guang Qing Memorial Open Teams' => [
    'guang qing memorial cup'],
  'Guangdong Club Championship' => [
    'guangdong club invitational',
    'guangdong province the bridge club invitational t',
    'guang dong club bridge championship',
    'guang dong club championship'],
  'Guangdong Elite Tournament' => [
    'guangdong bridge club elites tournament',
    'guangdong bridge club  elites  tournament',
    'guangdong bridge club  elites tournament'],
  'HNA Open Teams' => [
    'hainan air cup',
    'hna cup',
    'hna openteams',
    'hna open team',
    "hna's hainan bridge tournament"],
  'Jia-Wei Memorial Open Teams' => [
    'jia-wei memorial tournament'],
  'Jiangsu Province Open Teams' => [
    'jiangsu province bridge team championship',
    'jiangsu province bridge teams championship',
    'jiangsu province grand-a tournament'],
  'Jinfan Open Teams Cup' => ['jinfan cup'],
  'Nanshan Mixed Teams Cup' => [
    'nanshan cup mixed team',
    'nanshan cup mixed teams'],
  'Ruihai Shuicheng Senior Teams' => [
    'ruihai shuicheng senior team'],
  'Shanqing Mountain Open Teams' => [
   'sanqing mountain cup national bridge o',
   'sanqing mountain cup national bridge op',
   'san qing mountain national bridge open team to',
   'shan qingshan open tournament bridge Contest'],
  'Shenhua Cup' => ['shen hua cup'],
  'Shenyang Spring Teams' => ['shenyang spring'],
  'Vanke Open Teams Cup' => [
    'vanke cup']
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
