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
  'Bombay Gymkhana Club',
  'Calcutta Cricket & Football Club',
  'Delhi Gymkhana Club',
  'Madras Gymkhana Club',
  'White House',
  'Royal Airforce Club',
  'Willingdon Sports Club'
);

my %MULTI_TYPOS =
(
  "'t Onstein" => ['at onstein', 't onstein'],
  'Bombay Gymkhana Club' => ['bombay gym', 'bomay gym'],
  'Calcutta Cricket & Football Club' => ['cc&fc', 'cc & fc'],
  'Delhi Gymkhana Club' => ['delhi gymkhana'],
  'Madras Gymkhana Club' => ['madras gymkhana', 'madras gumkhana',
    'maras gymkhana'],
  'Willingdon Sports Club' => ['the willingdon sports club', 'wcg']
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Delhi Gymkhana Club' => ['dgc'],
  'Madras Gymkhana Club' => ['mgc'],
  'Royal Airforce Club' => ['rac'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
