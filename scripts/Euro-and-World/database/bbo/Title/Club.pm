#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Club;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  "'t Onstein",
  'Alumni Club Chennai',
  'AVI Club Noida',
  'Bombay Gymkhana Club',
  'Calcutta Cricket & Football Club',
  'Delhi Gymkhana Club',
  'Gabrial University of Indonesia',
  'Jubilee Hills International Centre',
  'Madras Gymkhana Club',
  'Otters Club',
  'White House',
  'Royal Airforce Club',
  'Ruch AZS',
  'Willingdon Sports Club'
);

my %MULTI_TYPOS =
(
  "'t Onstein" => ['at onstein', 't onstein'],
  'Alumni Club Chennai' => ['alumni club'],
  'Bombay Gymkhana Club' => ['bombay gym', 'bomay gym'],
  'Calcutta Cricket & Football Club' => ['cc&fc', 'cc & fc', 'cc &fc'],
  'Delhi Gymkhana Club' => ['delhi gymkhana'],
  'Gabrial University of Indonesia' => ['gabrial ui', 'gaberial ui',
    'gabrial-ui', 'gabrial - ui'],
  'Jubilee Hills International Centre' => ['jhic'],
  'Madras Gymkhana Club' => ['madras gymkhana', 'madras gumkhana',
    'maras gymkhana'],
  'Otters Club' => ["otters' club", "otter's club", "otter's"],
  'Willingdon Sports Club' => ['the willingdon sports club', 'wcg']
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'AVI Club Noida' => ['avi'],
  'Delhi Gymkhana Club' => ['dgc'],
  'Madras Gymkhana Club' => ['mgc'],
  'Otters Club' => ['otters'],
  'Royal Airforce Club' => ['rac'],
  'Ruch AZS' => ['ruch']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
