#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Turkey;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Aegean Open Teams',
  'Anatolian Club Teams',
  'Anatolian Fall Teams',
  'Anatolian Spring Teams',
  'Ankara Summer Teams',
  'Balikcioglu Open Teams',
  'Bodrum Patton Teams',
  'Cappadocia Open Pairs',
  'Fatih Kiral Pairs',
  'Gelibolu Peace Teams',
  'Goksu-Yalikavak Pairs',
  'Istanbul Summer Teams',
  'Istanbul Winter Teams',
  'Izmir Teams Cup',
  'Izmir Winter Teams Cup',
  'Lüleburgaz Liberation Cup',
  'Marmara Inter-Club Championship',
  'Mersin Open Pairs',
  'Mersin Open Patton Teams',
  'Murat Kilercioglu Turkish Spring Teams',
  'Necmettin Sunget Teams Cup',
  'Salvador Assael IMP Pairs',
  'Salvador Assael Pro-Am Pairs',
  'Sivrioglu BAM Teams',
  'Solakoglu IMP Pairs',
  'Thrace Cup League',
  'Turkish-Greek Open Pairs',
  'Turkish-Greek Open Teams',
  'Turkish Club Championship',
  'Turkish East Mediterranean Teams',
  'Turkish Junior Pairs',
  'Turkish Mixed Team Trials',
  'Turkish Mixed Teams',
  'Turkish Open Pair Trials',
  'Turkish Open Team Trials',
  'Turkish Open Teams',
  'Turkish Swiss Mixed Teams',
  'Turkish U16 Pairs',
  'Turkish University Teams',
  'Turkish Winter Open Teams',
  'Turkish Winter Women Teams',
  'Turkish Women Pair Trials',
  'Turkish Women Team Trials',
  'Turkish Women Teams',
  'Western Mediterranean Club Teams',
);

my %MULTI_TYPOS =
(
  'Aegean Open Teams' => [
    'aegean championships' ],
  'Anatolian Club Teams' => [
    'anatolian club qualifying',
    'eastern anatolian qualification',
    'eastern anatolýa qualýfýcatýon',
    'turkish interclubs champ_ anatolia elections'],
  'Anatolian Fall Teams' => ['anatolian side fall teams'],
  'Anatolian Spring Teams' => ['anatolia spring teams'],
  'Ankara Summer Teams' => ['ankara summer team championship'],
  'Balikcioglu Open Teams' => [
    'balikcioglu teams championship'],
  'Fatih Kiral Pairs' => [
    'fatih kiral cup'],
  'Gelibolu Peace Teams' => ['gelibolu peace cup'],
  'Istanbul Summer Teams' => [
    'istanbul team championship',
    'istanbul team championships',
    'istanbul club teams championship',
    'ýstanbul championship',
    'ýstanbul teams'],
  'Istanbul Winter Teams' => [
    'istanbul kis dortlu takimlar',
    'istanbul kis dortlu takim',
    'istanbul winter champs',
    'istanbul winter open teams',
    'istanbul winter team championship',
    'istanbul kis'],
  'Izmir Teams Cup' => [
    'izmir open teams championship',
    'izmir open teams championships',
    'izmir teams',
    'izmir teams championship',
    'izmýr teams cup'],
  'Izmir Winter Teams Cup' => [
    'izmir winter teams championship',
    'turkish winter open teams izmir'],
  'Lüleburgaz Liberation Cup' => ['luleburgaz kurtulus kupasi'],
  'Murat Kilercioglu Turkish Spring Teams' => [
    'Murat Kilercioglu Spring Teams'],
  'Necmettin Sunget Teams Cup' => [
    'necmettin sunget teams',
    'necmettin sünget dörtlü',
    'necmettin sünget dörtlü takýmlar'],
  'Salvador Assael IMP Pairs' => [
    'assael invitational calcutta',
    "salvador assael imp's across the field"],
  'Salvador Assael Pro-Am Pairs' => [
    'salvador assael pro-am'],
  'Thrace Cup League' => [
    'trachean club teams',
    'Thrace Club Teams',
    'thrace region clubs team championship',
    'trakya kulupler ligi',
    'turkish club teams championship aegean playoffs',
    'türk trakya bölge kulüpler þampýyonasi ekýbý'],
  'Turkish Club Championship' => ['türkýye kulüplerarasi þampýyonasi',
    'turkey club teams championship',
    'türkýye klüpler arasi brýç þampýyonasi',
    'turkish club teams championship',
    'turkish club championships',
    'turkish club teams championship',
    'turkish clubs championship',
    'turkish clubs team championship',
    'turkish clubs teams championship',
    'turkish clubs team championship teams',
    'turkish club team championship',
    'turkish inter club championships',
    'turkish inter-clubs championship',
    'turkiye clubs championship', 'turkey clubs championship'],
  'Turkish East Mediterranean Teams' => [
    'turkish clubs championship east & south east el',
    'turkish east & south-east teams',
    'turkish east mediterranean',
    'turkish east mediterranean club teams',
    'turkish eastern mediterranean club',
    'turkish eastern mediterranean club teams'],
  'Turkish Mixed Team Trials' => ['turkish mixed team trails'],
  'Turkish Mixed Teams' => [
    'turkey mix teams ch',
    'turkey mix teams championship',
    'turkey mixed team championship',
    'turkey mixed teams',
    'turkis mixed teams',
    'turkish mixed teams',
    'turkish mixed team championship',
    'turkish mixed team championships',
    'turkish mixed teams championship',
    'turkiye mixed teams championship',
    'turkýsh mixed teams'],
  'Turkish Open Teams' => [
    'turkey open team championship',
    'turkish national open national selection',
    'turkish open team championship',
    'turkish open teams',
    'turkish open teams championship',
    'turkish open teams championships',
    'turkiye acik takimlar sampiyonasi',
    'turkish national open teams'],
  'Turkish Swiss Mixed Teams' => ['turkey swiss mixed teams'],
  'Turkish U16 Pairs' => [
    'turkey u16 championship'],
  'Turkish University Teams' => [
    'turkish Universities championship',
    'turkish universities bridge championship'],
  'Turkish Winter Open Teams' => [
    'turkey winter open teams',
    'turkey winter teams',
    'turkey winter team championship',
    'turkey winter teams championship',
    'turkis winter teams',
    'turkish winter chanpionship',
    'turkish winter championship',
    'turkish winter championships',
    'turkish winter team championship',
    'turkish winter team championships',
    'turkish winter teams',
    'turkiye kis takimlar sampiyonasi',
    'turkiye kis acik takimlar sampiyonasi'],
  'Turkish Winter Women Teams' => [
    'turkish winter woman team championship',
    "turkish woman's winter teams",
    "turkish women's winter championship",
    "turkish women's winter teams"],
  'Turkish Women Teams' => [
    'türkish ladies teams',
    'turkish ladies teams championships',
    'turkish ladies teams',
    'turkish women championships',
    'turkish womens teams championship'],
  'Western Mediterranean Club Teams' => [
    'western mediterranean clubs team championship'],
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
