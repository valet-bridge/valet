#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamOrganization;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_organization);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Jilin Sheng Qiaopa',
  'Shanghai Contract Bridge Association'
);

my %MULTI_TYPOS =
(
  EBU => ['eng bridge union'],
  GABSI => ['gabungan bridge seluruh indonesia'],
  IBWI => ['ikatan bridge wanita indonesia'],
  JBA => ['j.b.a.'],
);

my @SINGLE_WORDS = qw(
  APBF AZS
  CBAI CBLT
  EBU
  FMB
  GABSI
  IBWI
  JBA
  MCBA
  NIBU
  PTBA
  SBTW SBU
  WBU
);

my %SINGLE_TYPOS =
(
  APBF => ['PABF'],
  CBAI => ['cabi'],
  FMB => ['fm'],
  'Jilin Sheng Qiaopa' => ['jilinshengqiaopa'],
  'Shanghai Contract Bridge Association' => ['scba']
);


sub set_hashes_team_organization
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
