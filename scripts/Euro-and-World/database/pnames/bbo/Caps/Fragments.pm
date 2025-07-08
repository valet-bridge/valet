#!perl

package Caps::Fragments;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(match);

my %FRAGMENTS =
(
  andTex => [ CATEGORY => 'MISC', VALUE => 'Texas'],
  cardSang => [ CATEGORY => 'LENGTHS', VALUE => 'cards',
      CATEGORY => 'DENOMINATIONS', VALUE => 'notrump'],
  cayC => [ CATEGORY => 'BASES', VALUE => 'SAYC'],
  clFm => [ CATEGORY => 'DENOMINATIONS', VALUE => 'clubs',
      CATEGORY => 'MISC', VALUE => 'Game Forcing'],
  clFG => [ CATEGORY => 'DENOMINATIONS', VALUE => 'clubs',
      CATEGORY => 'MISC', VALUE => 'Game Forcing'],
  cmNt => [ CATEGORY => 'RANKS', VALUE => 'Card Major',
      CATEGORY => 'DENOMINATIONS', VALUE => 'notrump'],
  convantionsRKCB => [ CATEGORY => 'KEYCARD', VALUE => 'RKCB'],
  gameF => [ CATEGORY => 'MISC', VALUE => 'Game Forcing'],
  gameFS => [ CATEGORY => 'MISC', VALUE => 'Game Forcing'],
  maintenantTOULOUSE => [ CATEGORY => 'CITY', VALUE => 'Toulouse'],
  indyTexas => [ CATEGORY => 'MISC', VALUE => 'Texas'],
  mancH => [ CATEGORY => 'MISC', VALUE => 'Game Forcing'],
  mockingbirdStavanger => [ CATEGORY => 'CITY', VALUE => 'Stavanger'],
  newZealand => [ CATEGORY => 'COUNTRY', VALUE => 'New Zealand'],
  ntBlackwood => [ CATEGORY => 'DENOMINATIONS', VALUE => 'notrump',
      CATEGORY => 'BLACKWOOD', VALUE => 'Blackwood'],
  ntJord => [ CATEGORY => 'DENOMINATIONS', VALUE => 'notrump',
      CATEGORY => 'MISC', VALUE => 'Jordan'],
  poinConvenient => [ CATEGORY => 'MISC', VALUE => 'Points',
      CATEGORY => 'MISC', VALUE => 'Convenient'],
  ptNT => [ CATEGORY => 'DENOMINATIONS', VALUE => 'notrump'],
  ptsOR => [ CATEGORY => 'MISC', VALUE => 'Points',
      CATEGORY => 'WORD', VALUE => 'or'],
  relayBL => [ CATEGORY => 'BLACKWOOD', VALUE => 'Blackwood'],
  saBwood => [ CATEGORY => 'DENOMINATIONS', VALUE => 'notrump',
      CATEGORY => 'BLACKWOOD', VALUE => 'Blackwood'],
  saRKB => [ CATEGORY => 'DENOMINATIONS', VALUE => 'notrump',
      CATEGORY => 'Keycard', VALUE => 'RKCB'],
  sayaCourtesy => [ CATEGORY => 'BASES', VALUE => 'SAYC'],
  spaNISH => [ CATEGORY => 'COUNTRY', VALUE => 'Spain'],
  strongNTweak => [ CATEGORY => 'OPENINGS', VALUE => 'Strong NT',
      CATEGORY => 'STRENGTHS', VALUE => 'Weak'],
  strBLackw => [ CATEGORY => 'STRENGTHS', VALUE => 'strong',
      CATEGORY => 'BLACKWOOD', VALUE => 'Blackwood'],
  strBLKW => [ CATEGORY => 'STRENGTHS', VALUE => 'strong',
      CATEGORY => 'BLACKWOOD', VALUE => 'Blackwood'],
  suitF => [ CATEGORY => 'MISC', VALUE => 'Suit Forcing'],
  suitFG => [ CATEGORY => 'MISC', VALUE => 'Suit Game Forcing'],
  suitG => [ CATEGORY => 'MISC', VALUE => 'Suit Game Forcing'],
  suitGF => [ CATEGORY => 'MISC', VALUE => 'Suit Game Forcing'],
  "suppX's" => [ CATEGORY => 'COMPETITIVE', VALUE => 'Support Double'],
  thstF => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Forcing'],
  thsuitF => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Forcing'],
  thsutGF => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Game Forcing'],
  thCF => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Forcing'],
  thF => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Forcing'],
  thForcing => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Forcing'],
  thGF => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Game Forcing'],
  thS => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit'],
  thSf => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Forcing'],
  thSForce => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Forcing'],
  thSF => [ CATEGORY => 'RANKS', VALUE => 'Ordinal Indicator',
      CATEGORY => 'MISC', VALUE => 'Suit Forcing'],
  waitingTransfers => [ CATEGORY => 'MISC', VALUE => 'Waiting',
      CATEGORY => 'MISC', VALUE => 'Transfer'],
  weakRK => [ CATEGORY => 'STRENGTHS', VALUE => 'Weak',
    CATEGORY => 'KEYCARD', VALUE => 'RKCB'],
  ACBLsayC => [ CATEGORY => 'BASES', VALUE => 'SAYC'],
  ANYNTisGerber => [ CATEGORY => 'CONSTRUCTIVE', VALUE => 'Gerber'],
  FORTenT => [ CATEGORY => 'STRENGTHS', VALUE => 'strong',
      CATEGORY => 'DENOMINATIONS', VALUE => 'clubs'],
  GurrRRRRR => [ CATEGORY => 'NAME_LAST', VALUE => 'Gurr'],
  RubyLM => [ CATEGORY => 'LEVEL', VALUE => 'Ruby Life Master'],
  SaycBoy => [ CATEGORY => 'BASES', VALUE => 'SAYC'],
  SEForSAYC => [ CATEGORY => 'BASES', VALUE => 'SEF',
      CATEGORY => 'BASES', VALUE => 'SAYC'],
  SilverLM => [ CATEGORY => 'LEVEL', VALUE => 'Silver Life Master'],
  VillaReal => [ CATEGORY => 'NAME_LAST', VALUE => 'Villareal'],
  SmyRnA => [ CATEGORY => 'CITY', VALUE => 'Smyrna'],
  ShanghaiNTBridgeClub => [ CATEGORY => 'CITY', VALUE => 'Shanghai'],
  ShangHai => [ CATEGORY => 'CITY', VALUE => 'Shanghai'],
  playPrecisionwithIndianflag => [ CATEGORY => 'BASES', VALUE => 'Precision'],
  PreferPrecision => [ CATEGORY => 'BASES', VALUE => 'Precision'],
  playMich => [ CATEGORY => 'COMPETITIVE', VALUE => 'Michaels'],
  ecIvoN => [ CATEGORY => 'LEVEL', VALUE => 'Novice'],
  senoJ => [ CATEGORY => 'NAME_LAST', VALUE => 'Jones'],
);

sub match
{
  my ($text, $splits) = @_;

  if (exists $FRAGMENTS{$text})
  {
    $splits = $FRAGMENTS{$text};
    return 1;
  }
  else
  {
    return 0;
  }
}

1;
