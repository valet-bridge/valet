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
  'AgBC Open Cup',
  'Alex Nurdin Cup',
  'Bank Nagari Cup',
  'Batam Open Teams',
  'Bupati Badung Cup',
  'Denny Sacul Memorial Open Teams',
  "East Java Governor's Cup",
  'East Java Open Teams',
  'Electric Cup',
  'FTBC Tanjungpura University',
  'FTBC Tanjungpura University Pairs',
  'Gabrial UI Bastaman Cup',
  'Geologi Cup',
  'IBWI Women Cup',
  'IKA UNDIP Open Teams',
  'Indonesian Inter-City Championship',
  'Indonesian Inter-Club Championship',
  'Indonesian Inter-Province Championship',
  'Indonesian Invitational Teams',
  'Indonesian Junior League Online',
  'Indonesian Men Pairs',
  'Indonesian Men Teams',
  'Indonesian Mixed Pair Trials',
  'Indonesian Mixed Pairs',
  'Indonesian Mixed Teams',
  'Indonesian Open Pair Trials',
  'Indonesian Open Teams',
  'Indonesian Open Trials',
  'Indonesian Pre-Sports Open Teams',
  'Indonesian Premier League',
  'Indonesian Prima Pair Programme',
  'Indonesian U16 Pair Trials',
  'Indonesian U18 Teams',
  'Indonesian U21 Pair Trials',
  'Indonesian U21 Teams',
  'Indonesian U26 Pair Trials',
  'Indonesian U26 Teams',
  'Indonesian U26 Women Pair Trials',
  'Indonesian U31 Teams',
  'Indonesian U31 Women Teams',
  'Indonesian University Teams',
  'Indonesian Women Pair Trials',
  'Indonesian Women Pairs',
  'Indonesian Women Teams',
  'Indonesian Women Trials',
  'Kemenpora Cup',
  "Kepri Governor's Cup",
  'Kijang Mas Open Teams',
  'MBH Invitational Cup',
  'Manado Fiesta Open Teams',
  'Menpora-Pertamina Cup',
  'Minangkabau Open Teams',
  'Pahlawan Cup',
  'Pertamina Field Tambun Cup',
  'PLN Cup',
  'PT Timah Invitational Teams',
  'Rector University of Brawijaya Cup',
  'Riau Governor Cup',
  'Sarundajang Cup',
  'Semen Padang Cup',
  'Telkom Indonesia Open',
  'Tomohon Open Teams',
  'Tugu Muda Cup',
  'Walikota Solo Pairs Cup',
  'West Java Open Teams',
  'West Kalimantan Open Teams'
);

my %MULTI_TYPOS =
(
  'AgBC Open Cup' => [
    'agbc cup',
    'open tournament bridge agbc cup'],
  'Alex Nurdin Cup' => [
    'indonesian sea open team trials',
    'test event sea games'],
  'Batam Open Teams' => [
    'batam international bot'],
  'Bupati Badung Cup' => [
    'piala bupati badung'],
  'Denny Sacul Memorial Open Teams' => [
    'denny sacul memorial bridge tournament'],
  'East Java Open Teams' => [
    'kejuaraan provinsi bridge jatim',
    'kejuaraan provinsi bridge jawa timur',
    'kejurprov jatim'],
  'FTBC Tanjungpura University' => [
    'championship of tanjungpura university',
    'ftbc university tanjungpura'],
  'Gabrial UI Bastaman Cup' => [
    'bastaman cup',
    'gabrial-ui cup',
    'gabrial ui cup'],
  'Geologi Cup' => ['geo cup'],
  'IBWI Women Cup' => ['ibwi cup'],
  'IKA UNDIP Open Teams' => ['ika undip'],
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
    'liga bridge indonesia',
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
  'Indonesian University Teams' => [
    'kejuaraan nasional bridge mahasiswa'],
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
    'kepri international bridge tournament'],
  'Kijang Mas Open Teams' => [
    'kijang mas bridge open',
    'kijangmas bridge open'],
  'MBH Invitational Cup' => ['mbh cup'],
  'Manado Fiesta Open Teams' => [
    'manado fiesta bridge tournament'],
  'Minangkabau Open Teams' => [
    'minangkabau bridge open tournament'],
  'Pahlawan Cup' => ['piala pahlawan'],
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
  'Rector University of Brawijaya Cup' => [
    'rc ugm',
    'rektor cup tanjungpura of university',
    'rektor cup ugm',
    'rektor ugm cup'],
  'Sarundajang Cup' => ['the sarundajang cup'],
  'Telkom Indonesia Open' => [
    'telkom cup',
    'telkom speedy',
    'telkom indonesian open'],
  'Tomohon Open Teams' => [
    'tomohon international bridge tournament'],
  'Walikota Solo Pairs Cup' => [
    'kejurnas 58 solo',
    'walikota cup'],
  'West Java Open Teams' => [
    'banten sports week',
    'porda west java',
    'regional west java',
    'west java regional',
    'west java regional games',
    'west java regional sport games',
    'west java regional spots event'],
  'West Kalimantan Open Teams' => [
    'kejurprop kalbar']
);

my %SINGLE_TYPOS =
(
  "Kepri Governor's Cup" => ['kepricup'],
  'Rector University of Brawijaya Cup' => ['pilrek'],
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
