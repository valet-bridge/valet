#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Indonesia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Alex Nurdin Cup',
  'Electric Cup',
  'FTBC Tanjungpura University',
  'Gabrial UI Bastaman Cup',
  'Geologi Cup',
  'IBWI Women Cup',
  'Indonesian Inter-City Championship',
  'Indonesian Inter-Club Championship',
  'Indonesian Inter-Province Championship',
  'Indonesian Invitational Teams',
  'Indonesian Junior League Online',
  'Indonesian Mixed Pair Trials',
  'Indonesian Mixed Teams',
  'Indonesian Open Pair Trials',
  'Indonesian Open Teams',
  'Indonesian Open Trials',
  'Indonesian Premier League',
  'Indonesian U16 Pair Trials',
  'Indonesian U18 Teams',
  'Indonesian U21 Pair Trials',
  'Indonesian U21 Teams',
  'Indonesian U26 Pair Trials',
  'Indonesian U26 Teams',
  'Indonesian U26 Women Pair Trials',
  'Indonesian U31 Teams',
  'Indonesian U31 Women Teams',
  'Indonesian Women Pair Trials',
  'Indonesian Women Teams',
  'Indonesian Women Trials',
  "Kepri Governor's Cup",
  'Menpora-Pertamina Cup',
  'Pahlawan Cup',
  'Pertamina Field Tambun Cup',
  'PLN Cup',
  'PT Timah Invitational Teams',
  'Rector University of Brawijaya Cup',
  'Sarundajang Cup',
  'Semen Padang Cup',
  'Telkom Indonesia Open',
);

my %MULTI_TYPOS =
(
  'Alex Nurdin Cup' => ['test event sea games'],
  'FTBC Tanjungpura University' => ['ftbc university tanjungpura'],
  'Gabrial UI Bastaman Cup' => [
    'bastaman cup',
    'gabrial-ui cup',
    'gabrial ui cup'],
  'Geologi Cup' => ['geo cup'],
  'IBWI Women Cup' => ['ibwi cup'],
  'Indonesian U26 Women Pair Trials' => [
    'indonesian girls u26 selection',
    'indonesia girls u26 selection'],
  'Indonesian Inter-City Championship' => [
    'ina intercity national chams',
    'ina intercity national champs'],
  'Indonesian Inter-Club Championship' => [
    'ina interclub national champs',
    'national indonesian championship (inter-club'],
  'Indonesian Inter-Province Championship' => [
    'uji coba'],
  'Indonesian Junior League Online' => [
    'icba junior league online'],
  'Indonesian U16 Pair Trials' => [
    'indonesian kids national selection',
    'indonesian kids trials'],
  'Indonesian Premier League' => [
    'indonesian bridge league',
    'indonesia bridge league',
    'indonesia premier league'],
  'Indonesian Mixed Pair Trials' => [
    'indonesian mixed national selection'],
  'Indonesian Open Pair Trials' => ['indonesian pairs trials'],
  'Indonesian Open Teams' => [
    'indonesia open team',
    'indonesian open team',
    'indonesia national open team',
    'indonesian national open team'],
  'Indonesian Open Trials' => [
    'indonesian men national selection',
    'indonesian men selection'],
  'Indonesian U21 Trials' => ['indonesian u21 selection',
    'indonesia u21 selection', 'indoneian u21 selection',
    'indonesian u21 selekction'],
  'Indonesian U26 Trials' => ['indonesian u26 selection'],
  'Indonesian Women Trials' => [
    'indonesian women national selection'],
  "Kepri Governor's Cup" => [
    'bi cup',
    'gov bi cup',
    'governor cup',
    'governor kepri cup',
    'gubernur kepri cup',
    'guvernor kepri cup',
    'kepri bridge championship',
    'kepri cup',
    'kepri governor cup',
    'kepri governors cup',
    'kepri international tournament',
    'kepri international bridge tournament',
    'riau governor cup'],
  'Pertamina Field Tambun Cup' => ['pertamina ep field tambun cup'],
  'PLN Cup' => ['pln fortuga'],
  'PT Timah Invitational Teams' => [
    'invitasi pt timah',
    'invitasi pt_ timah',
    'invitasi pt_timah',
    'invitasi terbatas pt timah',
    'invitasi terbatas pt_timah',
    'invitasi terbatas pt_ timah',
    'pt timah limited invitational teams',
    'pt_ timah limited invitation teams',
    'pt_ timah limited invitational teams',
    'pt_ timah ltd invitational teams'],
  'Sarundajang Cup' => ['the sarundajang cup'],
  'Telkom Indonesia Open' => [
    'telkom cup',
    'telkom speedy',
    'telkom indonesian open'],
);

my %SINGLE_TYPOS =
(
  "Kepri Governor's Cup" => ['kepricup'],
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
