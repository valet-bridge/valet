#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Australia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Altman Swiss Pairs',
  'Australian Autumn National Open Teams',
  'Australian Grand National Open Teams',
  'Australian Junior Teams',
  'Australian Mixed Teams',
  'Australian Mixed Trials',
  'Australian National Open Teams',
  'Australian National Senior Teams',
  'Australian National Women Teams',
  'Australian Open Teams',
  'Australian Open Trials',
  'Australian Senior Pairs',
  'Australian Senior Teams',
  'Australian Spring Open Teams',
  'Australian Spring Senior Teams',
  "Australian Spring Women Teams",
  "Australian Women Teams",
  'Australian Youngster Teams',
  'Australian Youth IMP Pairs',
  'Australian Youth Teams',
  'Australian Youth Tri Individual',
  'Australian Youth Tri Pairs',
  'Australian Youth Tri Teams',
  'Bobby Evans Senior Teams',
  'Cliff Wake Challenge',
  'Gold Coast Open Pairs',
  'Gold Coast Open Teams',
  'Gold Coast Senior Teams',
  "Hans Rosendorff Memorial Women's Teams",
  'John Arkinstall State Teams',
  'Kings and Queens Blaine Howe Teams',
  "Linda Stern Women's Teams",
  'New South Wales Open Teams',
  'New South Wales Open Trials',
  'North Shore Mixed Teams',
  'Northern Territory Gold Swiss Pairs',
  'Northern Territory Gold Teams',
  'Queensland Women Trials',
  'Queensland Senior Trials',
  'Smirnov Cup',
  'South Australia Open Teams',
  'Victor Swiss Pairs',
  'Victor Open Teams',
  'Victoria Cup',
  'Victorian Mixed Teams',
  'Victorian Open Trials',
  'Victorian Pennant',
  'Victorian Senior Trials',
  'Victorian Women Trials',
  'Victorian Youth Trials',
  'Watermark Open Teams'
);

my %MULTI_TYPOS =
(
  'Australian Autumn National Open Teams' => [
    'abf anot',
    'australian autumn national open  teams',
    'autumn national open teams'],
  'Australian Grand National Open Teams' => [
    'abf gnot',
    'australian gnot',
    'grand national open teams'],
  'Australian Junior Teams' => [
    'anc juniors'],
  'Australian Mixed Teams' => [
    'aust mixed teams'],
  'Australian National Open Teams' => [
    'abf national open teams',
    'austarlian not',
    'australian not',
    'national open teams',
    'national openteams'],
  'Australian Open Teams' => [
    'anc open',
    'anc open teams',
    'aust open',
    'australian open championships',
    'australian open tream',
    'australian open team'],
  'Australian Open Trials' => [
    'abf open team trials',
    'abf oprn trials',
    'aust open team trials',
    'aust open teams trial',
    'aust open trials',
    'austalian open team selections',
    'australian open selection',
    'australian open team trials',
    'australian open trials',
    'australian open team selection',
    'australian open team selections',
    'australian open team trial',
    'australian open teams playoff',
    'australian open tream selection',
    'australian playoffs',
    'austalian team selection',
    'australian team selection'],
  'Australian Senior Pairs' => [
    'aust seniors pairs',
    'aust seniors pairs trials',
    'austalian seniors pairs'],
  'Australian Senior Teams' => [
    'abf seniors playoff',
    'anc seniors',
    "anc seniors' teams",
    'aus seniors',
    'aus seniors playoff',
    'aus seniors playoffs',
    'aust seniors open',
    'aust seniors team trial',
    'aust senriors open',
    'australian senior playoffs',
    'australian seniors',
    'australian seniors playoff',
    'australian seniors playoffs',
    'australian seniors po',
    'australian seniors team selection',
    'australian seniors team trial',
    'australian seniors teams',
    'australian seniors teams playoffs',
    'australain seniors',
    "australian seniors' team",
    'sen australian',
    'sen australian playoffs'],
  'Australian Spring Open Teams' => [
    'spring national open teams',
    'spring open teams'],
  'Australian Spring Senior Teams' => [
    'aust spring seniors teams',
    'aust spring seniors',
    'australian spring seniors',
    'australian spring seniors teams',
    'snot seniors',
    'spring national senior teams'],
  'Australian Spring Women Teams' => [
    "australian spring women's teams",
    'australian spring womens',
    'snot womens',
    'spring national women teams'],
  'Australian Women Teams' => [
    'anc women',
    'anc womens',
    "anc women's teams",
    'aust women open team',
    'aust women open team trial',
    "aust women's team",
    "aust women's team trial",
    "aust women's team trials",
    'aust womens team',
    'aust womens team trial',
    'aust womens team trials',
    'aust womens teams',
    'australian women',
    'australian women po',
    'australian women team selection',
    'australian women team trials',
    'australian women trials',
    "australian women's",
    "australian women's po",
    "australian women's team selection",
    "australian women's teams",
    "australian women's selection",
    "australian women's team selection",
    "australian women's team selelection",
    "australian women's team trial",
    "australian women's trials",
    'australian womens team selection',
    'australian womens team trial',
    'australian womens teams',
    'australian womens trial',
    'australian womens trials'],
  'Australian Youth IMP Pairs' => [
    'aust youth butler',
    'australian youth butler'],
  'Australian Youth Teams' => [
    'aust youth',
    'aust youth playoff',
    'aust youth selection',
    'australian youth',
    'australian youth selection',
    'oz youth selection'],
  'Australian Youth Tri Individual' => ['youth tri individual'],
  'Australian Youth Tri Pairs' => ['youth triathlon pairs'],
  'Bobby Evans Senior Teams' => [
    'bobby evans senior',
    "bobby evans senior's teams",
    'bobby evans seniors',
    "bobby evans seniors'",
    "bobby evans seniors' teams",
    'bobby evans seniors teams'],
  'Cliff Wake Challenge' => ['cliff wake invitational'],
  "Hans Rosendorff Memorial Women's Teams" => [
    'han rosendorff memorial womens teams',
    'hans rosendorff memorial womens teams',
    'hans rosendorff memorial  womens teams'],
  'John Arkinstall State Teams' => [
    'john arkinstall state open teams'],
  "Linda Stern Women's Teams" => [
    'linda stern womens teams',
    "linda stern womens'"],
  'New South Wales Open Teams' => [
    'new south wales state teams',
    'nsw open teams',
    'nsw state teams'],
  'New South Wales Open Trials' => [
    'nsw interstate open team trials',
    'nsw interstate open team selection',
    'nsw interstate open teams selection',
    'nsw interstate team selection',
    'nsw interstate teams selection'],
  'Northern Territory Gold Teams' => ['nt gold teams'],
  'Northern Territory Gold Swiss Pairs' => [
    'nt gold swis pairs', 
    'nt gold swiss pairs',
    'nt gold swiss piars'],
  'Queensland Women Trials' => ['qld womens trials'],
  'Queensland Senior Trials' => [
    'qld seniors trial',
    'qld seniors trials'],
  'Victorian Open Trials' => [
    'victoian open',
    'victorian opean',
    'victorian opean teams',
    'victorian open',
    "'victorian open",
    'victorian open team',
    'victorian open team selection',
    'victorian open team trials',
    'victorian open teams',
    'victorian open teams playoff',
    'victorian playoff',
    'victorian team',
    'victorian team selection'],
  'Victorian Pennant' => ['vic pennant'],
  'Victorian Senior Trials' => ['vic seniors trials'],
  'Victorian Women Trials' => ['vic women trials'],
  'Watermark Open Teams' => [
    'nsbc watermark teams',
    'watermark bridge classic',
    'watermark teams',
    'willoughby bridge classic'],
);

my %SINGLE_TYPOS =
(
  'Australian Grand National Open Teams' => ['gnot'],
  'Australian Autumn National Open Teams' => ['anot'],
  'Australian National Open Teams' => ['not'],
  'Australian National Senior Teams' => ['nst'],
  'Australian National Women Teams' => ['nwt'],
  'Australian Spring Open Teams' => ['snot'],
  'Bobby Evans Senior Teams' => ['best'],
  "Linda Stern Women's Teams" => ['lswt'],
  'Victorian Pennant' => ['pennant'],
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
