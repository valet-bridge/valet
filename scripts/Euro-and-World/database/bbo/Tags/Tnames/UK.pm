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
  'Acol BC Invitational Pairs',
  'British Gold Cup',
  'Camrose Trophy',
  'Commonwealth Nations Bridge Championships',
  'Corn Cairdis Match',
  'Crockfords Cup',
  'English Mixed Teams',
  'English Mixed Trials',
  'English Open Trials',
  'English Open Pair Trials',
  'English Premier League',
  'English Senior Trials',
  'English U28 Trials',
  'English Women Teams',
  'English Women Pair Trials',
  'English Women Team Trials',
  'Garden Cities Teams',
  'Glasgow Transnational Open Teams',
  'Higson Teams Cup',
  'Hubert Phillips Bowl',
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
  'Young Chelsea Knock-out',
  "Young Chelsea Women's Swiss Teams"
);

my %MULTI_TYPOS =
(
  'Acol BC Invitational Pairs' => [
    'acol bc london invitational pairs',
    'acol bc inv pairs',
    'acol bridge club inv pairs',
    'acol bridge club invitational pairs',
    'acol inv pairs',
    'acol invitational pairs'],
  'British Gold Cup' => [
    'bgb gold cup',
    'british gold',
    'gold cup'], 
  'Commonwealth Nations Bridge Championships' => [
    'commonwealth beidge championship',
    'commonwealth nations',
    'commonwealth nations bc',
    'commonwealth nations bridge championship',
    "commonwealth nation's bridge championship",
    'commomwealth bridge championship',
    'commonwealth championship',
    'commonwealth bridge championship'],
  'Corn Cairdis Match' => ['corn cairdis'],
  'Crockfords Cup' => ["crockford's cup"],
  'English Mixed Teams' => [
    'ebu mixed teams'],
  'English Mixed Trials' => [
    'ebu european mixed teams trial',
    'ebu mixed teams trials',
    'england mixed team trials',
    'england mixed teams trials',
    'england mixed trials',
    'english european mixed teams trials',
    'english european mixed trials',
    'english mixed teams trials'],
  'English Open Trials' => [
    'ebu european open trial',
    'ebu european open trials',
    'ebu european trials',
    'ebu olympiad open trials',
    'ebu olympiad trials',
    'ebu open trial',
    'ebu open trials',
    'ebu european trial',
    'england euro team trials',
    'england euro teams trial',
    'england euro teams trials',
    'england european open trials',
    'england open euro trial',
    'england open european trials',
    'england open team trial',
    'england open trial',
    'england open trials',
    'england team trials',
    'english open trial',
    'enlish open trials',
    'english european open trials',
    'english open team trials',
    'english open teams trial',
    'english open teams trials'],
  'English Premier League' => [
    'ebu premier league',
    'ebu premier league div 1',
    'ebu premier league division',
    'ebu premier league division 1',
    'engish premier league',
    'england premier league',
    'english prem league',
    'english premie league',
    'english premiere league',
    'englush premier league',
    'english premier lge'],
  'English Senior Trials' => [
    'ebu european senior trial',
    'ebu european senior trials',
    'ebu seniors trial',
    'ebu seniors trials',
    'england senior euro trial playoff',
    'england senior european trial',
    'england senior euros trial playoff',
    'england senior trial',
    'england senior trials',
    'england senior teams trial',
    'england senior trial',
    'english seniors',
    'english senior european trial',
    'english senior euros trial playoff',
    'english senior trial',
    'english seniors european trial',
    'english seniors trial',
    'english seniors trials',
    'english seniors camrose trials',
    'english senior european trials',
    'english seniors european trials',
    'english senior teams',
    'englnd senior trials'],
  'English U28 Trials' => ['england u28 trials'],
  'English Women Teams' => [
    'english national womens teams',
    'whitelaw cup'],
  'English Women Pair Trials' => [
    'ebu lady milne trial',
    'england lady milne trial',
    'england milne trial',
    'england women pair trials',
    'english lady milne trials',
    'lady milne pairs trials',
    'lady milne pre-trial',
    'lady milne pre trial',
    'lady milne pre trials',
    'lady milne trial',
    'lady milne trials',
    'lm pre-trial'],
  'English Women Team Trials' => [
    'ebu european womens trial',
    'ebu european womens trials',
    "ebu european women's trials",
    'ebu womens trial',
    'england ladies trials',
    "england ladies' trials",
    'england womens trial',
    "england women's trials",
    'england womens trials',
    'english ladies trials',
    "english ladies' trials",
    'english teltcher trials',
    "english women's trials",
    'teltscher trophy trials',
    'teltscher trials'],
  'Garden Cities Teams' => ['garden cities'],
  'Glasgow Transnational Open Teams' => ['tnt glasgow'],
  'Higson Teams Cup' => ['higson cup'],
  'Hubert Phillips Bowl' => ['hubert phillips'],
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
    'english spring fours',
    'schapiro spring fours',
    'schapiro spring foursomes',
    'schapiro spring 4s',
    'schapiro 4s',
    'spring 4s',
    'spring fours',
    'schapirosfs'],
  'Teltscher Trophy' => [
    'senior camrose',
    'seniors camrose',
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
  'Welsh Invitational Pairs' => [
    'welsh invitation pairs'],
  'Welsh Open Trials' => ['welsh open trial', 'welsh trials',
    'welsh trial'],
  'Young Chelsea Knock-out' => [
    'yc ko', 
    'young chelsea knockout',
    'young chelsea ko'],
  "Young Chelsea Women's Swiss Teams" => [
    'yc ladies danish teams',
    'yc ladies swiss',
    'yc ladies swiss teams',
    'yc ladies teams',
    'yc lst',
    'yc womens swiss teams',
    "yc women's swiss teams",
    'yc womens teams',
    'ycbc ladies teams',
    'young chelsea women swiss teams'],
);

my %SINGLE_TYPOS =
(
  'Camrose Trophy' => ['camrose', 'camroae', 'ccmrose'],
  'Commonwealth Nations Bridge Championships' => ['cnbc'],
  'Crockfords Cup' => ['crockfords'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  'Lederer Memorial Trophy' => ['lederer', 'ledered'],
  'Peggy Bayer Trophy' => ['peggybayer'],
  'Scottish Cup' => ['scottishcupplate'],
  'Teltscher Trophy' => [
    'telscher',
    'teltescher',
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
