#!perl

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Exporter;

package Despace;

our @ISA = qw(Exporter);
our @EXPORT = qw(despace);

# There are several cases of words that will get separated into
# different tokens if they remain separated by spaces or separators.
# Then they can be difficult to put together again.  So we squeeze
# out the separators into a recognizable single word, and later
# on we recognize them if needed.

my %MERGE_ALIASES = (

  # TNAME
  Bermudabowl => ['bermuda bowl'],
  Eurochamp => ['eur champ'],
  Fortunacup => ['fortuna cup'],
  IsrGP => ['israel grand prix'],
  Hungariancup => ['hungarian cup'],
  Kepricup => ['kepri cup'],
  Grocup => ["gro's supercup"],
  Nationscup => ['nations cup'],
  Ruiagold => ['ruia gold', 'ruia gols'],
  Ruiasilver => ['ruia silver'],
  Serdikacup => ['serdika cup'],
  Superleague => ['super league', 'sup league', 'sup l', 'sup-l',
    'super leahue', 'sup leg', 's l'],
  VAKM => ['vest-agder km', 'vest - agder'],
  Vitoteams => ['vito teams'],

  # SPONSOR
  FXSec => ['fx sec_'],
  Jetimmo => ['get immo', 'get-immo', 'jet immo'],
  LYLaw => ['L&Y'],

  # MEMORIAL
  Mohansicka => ['mohan sicka'],
  Muratkilercioglu => ['murat kilercioglu'],

  # ORGANIZER
  EBL => ['e_b_l_'],
  BridgeBaseOnline => ['bridge base online'],
  Guangdongbridgeclub => ['guangdong briagclub'],

  # TOURNAMENT: none

  # MOVEMENT
  Roundrobin => ['round robin', 'roun robin', 'round bobin',
    'round-robin', 'r_robin', 'r robin', 'round roubin', 'rrobin',
    'round ronin', 'grup maçlari', 'r_r_', 'r_r', 'rrr'],

  # ORIGIN
  Interclub => ['inter club', 'inter-club', 'inter-clubs'],
  Interprovince => ['inter province', 'inter-province',
    'inter-provinces', 'inter provinces'],
  Interregion => ['inter-region', 'inter-regional'],
  Proam => ['pro am'],

  # FORM: none

  # SCORING
  BAM => ['b-a-m'],

  # AGE
  U28 => ['under 28'],

  # GENDER: none
  # COUNTRY: none
  # CITY: none
  # YEAR: none
  # MONTH: none
  # DATE: none
  # WEEKDAY: none
  # ORDINAL: none
  fifth => ['5 eme'],
  "12th" => ['12 th'],

  # NUMERAL: none
  # ROMAN: none

  # PARTICLE
  of => ['out of', '0f'],
  of5 => ['0f5'],
  off => ['0ff'],

  # ITERATOR
  Final => ['phase finale', 'fin als', 'f i n a l'],
  Semifinal => ['meia final', 'meias finais', 
    'semi final', 'semi-final', 'semi finals', 'semi-finals',
    'demi-finale', 'demi-finales', '1_2finale', 'semi <final',
    'yarý final', 'simi final', 'round of 4', 's_f'],
  Quarterfinal => ['quarter final', 'quarter finals',
    'quarter-final', 'quet final', 'quartal final',
    'quarti finale', 'qtr finals', 'q-final',
    'round of 8', 'r of 8', '1_4 finale'], 
    # Error-prone: "1st Quarter Final" can be either
  PreQF => ['pre qf', 'pr qf'],
  PO => ['play-off', 'play_off', 'play off'],
  Rof128 => ['round of 128'],
  Rof64 => ['round of 64'],
  Rof32 => ['round of 32', 'r of 32'],
  Rof18 => ['phase a 18'],
  Rof16 => ['round of 16', 'phase a 16', '1_8e de finale',
    'rd of 16', 'r.of 16', 'r of 16', 'rd of 16', 'rn of 16'],
  Rof12 => ['phase a 12'],
  Tiebreak => ['extra boards', 'extra time', 'extra stanza', 
    'semifinals extra', 'tie break', 'tie reak', 'tiebreak', 'o_t'],
  'Second half' => ['second ha'],
  Bronze => ['small final'],
  'Session 1' => ['única sesión'],
  'Knockout' => ['knock out', 'knock-out', 'k o', 'k _ o'],

  # Misc.
  'untitled' => ['untitled segment'],
  'Open RR' => ['orr'],
  'Women RR' => ['wrr'],
  'First half' => ['1mt', '1emt', 'andata'],
  'Second half' => ['2mt', '2emt', 'ritorno', 'retur'],
  'Second' => ['2e'],
  'Third' => ['3e'],
  'Fourth' => ['4e'],
  'vs ni' => ['vni'],
  '()' => ['(\+2)'] # Uninteresting
);


my %MERGE_HASH;
for my $key (keys %MERGE_ALIASES)
{
  for my $alias (@{$MERGE_ALIASES{$key}})
  {
    $MERGE_HASH{lc($alias)} = $key;
  }
}

my $MERGE_PATTERN = join('|', map { quotemeta } keys %MERGE_HASH);

my $MERGE_REGEX = qr/\b($MERGE_PATTERN)\b/i;


sub despace
{
  my $text = pop;
  $text =~ s/$MERGE_REGEX/$MERGE_HASH{lc($1)}/ge;
  return $text;
}

1;
