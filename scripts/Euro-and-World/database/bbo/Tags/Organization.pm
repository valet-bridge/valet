#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Organization;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Bridge Great Britain',
  'CBA WZ',
  'Indonesian Ministry of Youth and Sports',
  'Jilin Sheng Qiaopa',
  'Rajasthan Bridge Association',
  'Shanghai Contract Bridge Association'
);

my %MULTI_TYPOS =
(
  ABA => ['argentinian bridge association'],
  ACBL => ['american contract bridge league'],
  AEB => ['asociación española de bridge'],
  AfBF => ['african bridge federation'],
  APBF => ['asia pacific bridge federation'],
  AuBF => ['australian bridge federation'],
  AZS => ['university sports association of poland'],
  BCBF => ['belarus contract bridge federation'],
  BFAME => ['bridge federation of asia & the middle east'],
  BGB => ['Bridge Great Britain'],
  BFI => ['bridge federation of india'],
  BrBaOn => ['bridge base online'],
  BSS => ['bridž savez srbije'],
  BuBF => ['bulgarian bridge federation'],
  BZS => ['bridge zveza slovenije'],
  CACBF => ['central american and caribbean bridge federation'],
  'CBA WZ' => ['Contract Bridge Association West Zone', 'cbz wz'],
  CBAI => ['contract bridge association of ireland'],
  CBF => ['canadian bridge federation'],
  CBLT => ['contract bridge league of thailand'],
  CCBA => ['chinese contract bridge association'],
  CrBF => ['croatian bridge federation'],
  CSB => ['south american bridge federation'],
  CTCBA => ['chinese taipei contract bridge association'],
  CzBF => ['czech bridge federation'],
  DBF => ['danish bridge federation'],
  DBV => ['deutscher bridge-verband'],
  EBL => ['european bridge league', 'e_b_l'],
  EBU => ['eng bridge union'],
  EgBF => ['egyptian bridge federation'],
  EOM => ['greek bridge federation'],
  EstBL => ['estonian bridge league'],
  EUSA => ['european university sports association'],
  FaBF => ['faroese bridge federation'],
  FBB => ['Federação Brasileira de Bridge'],
  FCB => ['Federacion Chilena de Bridge'],
  FEB => ['Ecuador Bridge Federation'],
  FIGB => ['italian bridge federation'],
  FISU => ['international university sports federation'],
  FFB => ['fédération francaise de bridge'],
  FPB => ['federação portuguesa de bridge'],
  FRB => ['federatia romana de bridge'],
  FMB => ['fédération monegasque de bridge'],
  FSB => ['fédération suisse de bridge'],
  GABSI => ['gabungan bridge seluruh indonesia'],
  HKCBA => ['hong kong contract bridge association'],
  IBF => ['israel bridge federation'],
  IBWI => ['ikatan bridge wanita indonesia'],
  ICBA => ['indore contract bridge association'],
  IceBF => ['icelandic bridge federation'],
  IBU => ['irish bridge union'],
  JBA => ['j.b.a.', 'jordan bridge federation', 'j_b_a', 'j_ba'],
  JCBL => ['japanese contract bridge league'],
  KSBA => ['karnataka state bridge association'],
  LaBF => ['latvian bridge federation'],
  LeBF => ['lebanese bridge federation'],
  LiBA => ['lithuanian bridge association'],
  MBA => ['maharashtra bridge association'],
  MBSZ => ['hungarian bridge federation'],
  MCBA => ['macau contract bridge association'],
  NBB => ['dutch bridge federation'],
  NBF => ['norsk bridgeforbund'],
  NBU => ['nordic bridge union'],
  NIBU => ['northern ireland bridge union'],
  NZB => ['new zealand bridge'],
  ÖBV => ['austrian bridge federation'],
  PuBA => ['Punjab Bridge Association', 'punjab bridge assn'],
  PRBA => ['Pune Region Bridge Association'],
  PZBS => ['polish bridge union'],
  PTBA => ['philippine tournament bridge association'],
  RBBF => ['royal belgian bridge federation'],
  SABF => ['south african bridge federation'],
  SBL => ['suomen bridgeliitto'],
  SBF => ['svenska bridgeförbundet'],
  SBU => ['scottish bridge union'],
  SPBF => ['south pacific bridge federation', 'zone 7'],
  TBF => ['turkish bridge federation'],
  TDBA => ['Thane District Bridge Association'],
  USBF => ['united states bridge federation'],
  VBF => ['venezuelan bridge federation'],
  WBF => ['world bridge federation'],
  WBU => ['welsh bridge union']
);

my @SINGLE_WORDS = qw(
  ACBL AfBF APBF AuBF AZS
  BFAME BFI BuBF
  CACBF CBAI CBF CBLT CCBA CrBF CSB CTCBA
  DBF DBV
  EBL EBU
  FIGB FFB FMB FSB
  GABSI
  HKCBA
  IBF IBU IBWI ICBA
  JBA
  KSBA
  MBA MCBA
  NBB NBF NIBU NZB
  ÖBV
  PRBA PZBS PTBA
  SBF SBU SPBF
  TBF TDBA
  USBF
  WBF
  WBU
);

my %SINGLE_TYPOS =
(
  CBAI => ['cabi'],
  FMB => ['fm'],
  HKBCA => ['hncba'],
  GABSI => ['iba'],
  'Indonesian Ministry of Youth and Sports' => ['menpora'],
  'Jilin Sheng Qiaopa' => ['jilinshengqiaopa'],
  'Shanghai Contract Bridge Association' => ['scba']
);


sub set_hashes
{
  my ($callback, $key) = @_;

  $callback->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
