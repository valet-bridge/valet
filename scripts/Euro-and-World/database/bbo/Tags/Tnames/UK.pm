#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::UK;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'British Gold Cup',
  'Camrose Trophy',
  'Commonwealth Nations Bridge Championships',
  'Corn Cairdis Match',
  'English Open Trials',
  'English Premier League',
  'English Senior Trials',
  'English U28 Trials',
  'English Women Teams',
  'English Women Trials',
  'Garden Cities Teams',
  'Glasgow Transnational Open Teams',
  'Higson Teams Cup',
  'Junior Camrose',
  'Lady Milne Trophy',
  'Lederer Memorial Trophy',
  'Peggy Bayer Trophy',
  'Scottish Cup',
  'Scottish National League',
  'Spring Foursomes',
  'Teltscher Trophy',
  'TGR Auction Pairs',
  'TGR Auction Teams',
  'TGR Super League',
  'Welsh Invitational Pairs',
  'Welsh Open Trials',
  'Young Chelsea Knock-out'
);

my %MULTI_TYPOS =
(
  'British Gold Cup' => [
    'british gold',
    'gold cup'], 
  'Commonwealth Nations Bridge Championships' => [
    'commonwealth beidge championship',
    'commonwealth nations bridge championship',
    "commonwealth nation's bridge championship",
    'commomwealth bridge championship',
    'commonwealth championship',
    'commonwealth bridge championship'],
  'Corn Cairdis Match' => ['corn cairdis'],
  'English Open Trials' => [
    'english open trial',
    'enlish open trials',
    'english open team trials',
    'english open teams trial',
    'english open teams trials'],
  'English Premier League' => [
    'engish premier league',
    'england premier league',
    'english premie league',
    'englush premier league',
    'english premier lge'],
  'English Senior Trials' => [
    'england senior trial',
    'england senior trials',
    'england senior teams trial',
    'england senior trial',
    'english seniors',
    'english senior european trials',
    'english seniors european trials',
    'english senior teams',
    'englnd senior trials'],
  'English U28 Trials' => ['england u28 trials'],
  'English Women Teams' => [
    'english national womens teams',
    'whitelaw cup'],
  'English Women Trials' => [
    "england ladies' trials",
    'english ladies trials',
    "english ladies' trials",
    'lady milne trials'],
  'Garden Cities Teams' => ['garden cities'],
  'Glasgow Transnational Open Teams' => ['tnt glasgow'],
  'Higson Teams Cup' => ['higson cup'],
  'Junior Camrose' => ['juniior camrose'],
  'Lady Milne Trophy' => ['lady milne', 'lady mile'],
  'Lederer Memorial Trophy' => [
    'lederer memorial',
    'lederer trophy'],
  'Peggy Bayer Trophy' => [
    'peggy bayer'],
  'Scottish Cup' => [
    'scot cuo', 
    'scot cup', 
    'scottish cup plate'],
  'Scottish National League' => ['scotland national league'],
  'Spring Foursomes' => [
    'spring 4s',
    'spring fours',
    'schapirosfs'],
  'Teltscher Trophy' => [
    'senior camrose',
    'teltcher trophy'],
  'TGR Auction Pairs' => [
    'tgr auction',
    "tgr's auction pairs",
    'tgrs auction pair',
    'tgrs auction pairs'],
  'TGR Auction Teams' => ['tgrs auction teams'],
  'TGR Super League' => [
    "tgr's league", 
    "tgr's super league", 
    "tgr's super legue",
    'tgrs 2nd auction pairs', 
    'tgrs league', 
    'tgrs super league',
    "trg's super league"],
  'Welsh Open Trials' => ['welsh open trial', 'welsh trials',
    'welsh trial'],
  'Young Chelsea Knock-out' => [
    'yc ko', 
    'young chelsea knockout',
    'young chelsea ko']
);

my %SINGLE_TYPOS =
(
  'Camrose Trophy' => ['camrose', 'camroae', 'ccmrose'],
  'Commonwealth Nations Bridge Championships' => ['cnbc'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  'Lederer Memorial Trophy' => ['lederer', 'ledered'],
  'Peggy Bayer Trophy' => ['peggybayer'],
  'Scottish Cup' => ['scottishcupplate'],
  'Teltscher Trophy' => [
    'teltschertrophy',
    'teltscher',
    'telschertrophy'],
  'Young Chelsea Knock-out' => ['ycko'],
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
