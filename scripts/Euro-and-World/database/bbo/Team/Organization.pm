#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Organization;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_organization set_hashes);

use lib '.';

use TeamBBO;
use TitleBBO;

my @MULTI_WORDS =
(
  'Bridge Great Britain',
  'Jilin Sheng Qiaopa',
  'Shanghai Contract Bridge Association'
);

my %MULTI_TYPOS =
(
  ACBL => ['american contract bridge league'],
  AfBF => ['african bridge federation'],
  APBF => ['asia pacific bridge federation'],
  AuBF => ['australian bridge federation'],
  AZS => ['university sports association of poland'],
  BFAME => ['bridge federation of asia & the middle east'],
  BGB => ['Bridge Great Britain'],
  BFI => ['bridge federation of india'],
  BuBF => ['bulgarian bridge federation'],
  CBAI => ['contract bridge association of ireland'],
  CBF => ['canadian bridge federation'],
  CBLT => ['contract bridge league of thailand'],
  CCBA => ['chinese contract bridge association'],
  CrBF => ['croatian bridge federation'],
  CSB => ['south american bridge federation'],
  CTCBA => ['chinese taipei contract bridge association'],
  DBV => ['deutscher bridge-verband'],
  EBL => ['european bridge league'],
  EBU => ['eng bridge union'],
  FIGB => ['italian bridge federation'],
  FFB => ['fédération francaise de bridge'],
  FMB => ['fédération monegasque de bridge'],
  FSB => ['fédération suisse de bridge'],
  GABSI => ['gabungan bridge seluruh indonesia'],
  HKCBA => ['hong kong contract bridge association'],
  IBF => ['israel bridge federation'],
  IBWI => ['ikatan bridge wanita indonesia'],
  JBA => ['j.b.a.', 'jordan bridge federation'],
  MCBA => ['macau contract bridge association'],
  NBB => ['dutch bridge federation'],
  NBF => ['norsk bridgeforbund'],
  NIBU => ['northern ireland bridge union'],
  ÖBV => ['austrian bridge federation'],
  PZBS => ['polish bridge union'],
  PTBA => ['philippine tournament bridge association'],
  SBF => ['svenska bridgeförbundet'],
  SBU => ['scottish bridge union'],
  TBF => ['turkish bridge federation'],
  USBF => ['united states bridge federation'],
  WBF => ['world bridge federation'],
  WBU => ['welsh bridge union']
);

my @SINGLE_WORDS = qw(
  ACBL AfBF APBF AuBF AZS
  BFAME BFI BuBF
  CBAI CBF CBLT CCBA CrBF CSB CTCBA
  DBV
  EBL EBU
  FIGB FFB FMB FSB
  GABSI
  HKCBA
  IBF IBWI
  JBA
  MCBA
  NBB NBF NIBU
  ÖBV
  PZBS PTBA
  SBF SBU
  TBF
  USBF
  WBF
  WBU
);

my %SINGLE_TYPOS =
(
  APBF => ['PABF'],
  CBAI => ['cabi'],
  FMB => ['fm'],
  GABSI => ['iba'],
  'Jilin Sheng Qiaopa' => ['jilinshengqiaopa'],
  'Shanghai Contract Bridge Association' => ['scba']
);


sub set_hashes_team_organization
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}


sub set_hashes
{
  my ($callback, $key) = @_;

  $callback->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
