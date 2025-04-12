#!perl

package Event::Study;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(study);

use lib '.';
use lib '..';

use Separators;
use Token;
use Util;

my @TAG_ORDER = qw(
  ROMAN
  MEET
  TNAME
  DESTROY
  ORIGIN
  CLUB

  ORGANIZATION
  SPONSOR
  COUNTRY
  NATIONALITY
  REGION
  CITY
  FORM
  MOVEMENT
  GENDER
  AGE
  SCORING
  PERSON
  ITERATOR
  COLOR
  STAGE
  TIME
  MONTH
  WEEKDAY
  NUMERAL
  ORDINAL
  PARTICLE
  AMBIGUOUS
);

my $PREFIX = 'EVENT_';
our $histo_event;

my %HARD_SUBS =
(
  'I A' => ['ia'],
  'I B' => ['ib'],
  'II A' => ['iia'],
  'II B' => ['iib'],
  'III A' => ['iiia'],
  'III B' => ['iiib'],
  'IV A' => ['iva'],
  'IV B' => ['ivb'],
  'V A' => ['va'],
  'V B' => ['vb'],
  'VI A' => ['via'],
  'VI B' => ['vib'],
  'VII A' => ['viia'],
  'VII B' => ['viib'],
  'VIII A' => ['viiia'],
  'VIII B' => ['viiib'],
  'IX A' => ['ixa'],
  'IX B' => ['ixb'],

  'Segment 1' => ['i t_', 'i t'],
  'Segment 2' => ['ii t_', 'ii t'],

  'Final Round' => ['fr'],
  'Final Segment' => ['fs'],
  'First Half' => ['1emt', '1mt', 'andata', '1st half'],
  'Group A' => ['groupa'],
  'Group B' => ['groupb'],
  'Open A' => ['opena'],
  'Open B' => ['openb'],
  'Open Round Robin' => ['orr'],
  'QF A' => ['qfa'],
  'QF B' => ['qfb'],
  'Second Half' => ['2emt', '2mt', 'ritorno', 'retur', '2nd half'],
  'Semifinal A' => ['sfa'],
  'Semifinal B' => ['sfb'],
  'SF A' => ['semia'],
  'SF B' => ['semib'],
  'Table A' => ['ta'],
  'USA' => ['usa1', 'usa2', 'usa 1', 'usa 2'],
  'Table B' => ['tb'],
  'Women Round Robin' => ['wrr']
);

# This is like a tag substitution, but it is just a hard substitution
# without the attachment of any tag, so it's rather direct and primitive.

my %FLAT_HARD_SUBS;
while (my ($key, $ref) = (each %HARD_SUBS))
{
  $FLAT_HARD_SUBS{$_} = $key for @$ref;
}

my $HARD_MREGEX_DIRECT = join('|', map { quotemeta }
  sort { length($b) <=> length($a) } keys %FLAT_HARD_SUBS);

my $HARD_MREGEX = qr/(?<!\p{L})($HARD_MREGEX_DIRECT)(?=\P{L}|\z)/i;


sub sub_hard_fragments
{
  my ($text) = @_;
  $text =~ s/$HARD_MREGEX/$FLAT_HARD_SUBS{lc($1)}/gi;
  return $text;
}


my @LOCAL_SUBS =
(
  { START => 39721, END => 39730, TEXT => 'R16', CORR => 'Rof16' },
  { START => 39899, END => 39907, TEXT => 'R16', CORR => 'Rof16' },
  { START => 43183, END => 43194, TEXT => 'R16', CORR => 'Rof16' },

  { START => 46702, END => 46916, TEXT => '^M-', CORR => 'Mixed ' },
  { START => 47933, END => 48068, TEXT => '^RR2-', CORR => 'RR ' },
  { START => 51560, END => 51665, TEXT => '^M-', CORR => 'Mixed Teams - ' },
  { START => 51666, END => 51673, TEXT => '^M-R16-', 
    CORR => 'Mixed Teams - Rof16 - ' },
  { START => 51695, END => 51730, TEXT => '^M-', CORR => 'Mixed Pairs - ' },
  { START => 51805, END => 51816, TEXT => '^O-R16 ', 
    CORR => 'Open Teams - Rof16 ' },
  { START => 51865, END => 51892, TEXT => '^W-', CORR => 'Women Pairs - ' },
  { START => 51893, END => 51935, TEXT => '^O-', CORR => 'Open Pairs - ' },
  { START => 52257, END => 52290, TEXT => 'Prov A\d ', CORR => 'Prov ' },
  { START => 52564, END => 52577, TEXT => '1_8', CORR => 'QF' },
  { START => 52671, END => 53031, 
    TEXT => '^OT-', CORR => "d'Orsi - " },
  { START => 52979, END => 53013, TEXT => '^BB\d+-', CORR => '' },
  { START => 53043, END => 53052, TEXT => '^TN-', 
    CORR => 'Transnational ' },
  { START => 53497, END => 53894, TEXT => 'Preselection', CORR => '' },
  { START => 53889, END => 53894, TEXT => 'Preselection', CORR => '' },
  { START => 54344, END => 54454, TEXT => '\bMen', CORR => 'Open' },
  { START => 54611, END => 54659, TEXT => 'O L', CORR => 'Open' },
  { START => 54750, END => 54794, TEXT => '^O-', CORR => 'Open Pairs - ' },
  { START => 54756, END => 54793, TEXT => '^W-', 
    CORR => 'Women Pairs - ' },
  { START => 55469, END => 55480, TEXT => '^Swiss A ', 
    CORR => 'Swiss - Session ' },
  { START => 55562, END => 55598, TEXT => 'Grup ', CORR => 'Round ' },
  { START => 55665, END => 55853, TEXT => '^ZC-', CORR => '' },
  { START => 55813, END => 55854, TEXT => 'FMBBAM', CORR => 'BAM' },
  { START => 56298, END => 56314,
    TEXT => 'Open Teams*', CORR => 'U26 Teams' },
  { START => 57027, END => 57129, TEXT => '^RR ', CORR => 'Round ' },
  { START => 57388, END => 57530, TEXT => '\bMen', CORR => 'Open' },
  { START => 57990, END => 58008, TEXT => '^Open', CORR => 'U26 ' },
  { START => 58273, END => 58329, TEXT => '^Swiss A ', 
    CORR => 'Swiss - Session ' },
  { START => 58338, END => 58359, TEXT => '^Pre QF A ', CORR => 'Pre QF ' },
  { START => 58404, END => 58417, TEXT => '^Silver ', 
    CORR => 'Indian Silver Open Teams ' },
  { START => 58405, END => 58418, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 58490, END => 58578, TEXT => '\bMen', CORR => 'Open' },
  { START => 58898, END => 58921, TEXT => '^O-R64-', 
    CORR => 'Open Teams - Rof64 - ' },
  { START => 58923, END => 58946, TEXT => '^O-R32-', 
    CORR => 'Open Teams - Rof32 - ' },
  { START => 58950, END => 58985, TEXT => 'R16-', 
    CORR => ' Rof16 - Segment ' },
  { START => 59103, END => 59286, TEXT => '^M-', CORR => 'Mixed Teams - ' },
  { START => 59315, END => 59382, 
    TEXT => "^Men Team", CORR => 'Open Teams - ' },
  { START => 59520, END => 59525, TEXT => "^Men's", CORR => 'Open' },
  { START => 60491, END => 60616, TEXT => '^Prov ', 
    CORR => 'Interprovince ' },
  { START => 60484, END => 60615, TEXT => '^Provincial', 
    CORR => 'Interprovince' },
  { START => 60491, END => 60616, TEXT => '^Prov\>', 
    CORR => 'Interprovince' },
  { START => 60605, END => 60720, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 60699, END => 60717, TEXT => '^Silver ', 
    CORR => 'Indian Silver Open Teams ' },
  { START => 62558, END => 62583, TEXT => '^Teams ', CORR => 'Pairs ' },
  { START => 63000, END => 63059, TEXT => '^Men ', 
    CORR => 'Open Team - ' },
  { START => 63131, END => 63261, TEXT => '^WT-', 
    CORR => 'Women Teams - ' },
  { START => 63133, END => 63253, TEXT => '^OT-', 
    CORR => 'Open Teams - ' },
  { START => 63739, END => 63796, TEXT => '^Silver ', 
    CORR => 'Indian Silver Open Teams ' },
  { START => 63932, END => 64168, TEXT => 'APBF Ladies', 
    CORR => 'APBF Women Teams' },
  { START => 63740, END => 63797, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 64111, END => 64122, TEXT => '^M-R32-', 
    CORR => 'Mixed Teams - Rof32 - ' },
  { START => 64124, END => 64131, TEXT => '^M-R16-', 
    CORR => 'Mixed Teams - Rof16 - ' },
  { START => 64233, END => 64242, TEXT => '^O-R32-', 
    CORR => 'Open Teams - Rof32 - ' },
  { START => 64243, END => 64254, TEXT => '^O-R16-', 
    CORR => 'Open Teams - Rof16 - ' },
  { START => 64413, END => 64445, TEXT => 'Putra', CORR => 'Open' },
  { START => 64859, END => 64899, TEXT => '^SL *Gold ', 
    CORR => 'SL - Indian Gold Open Teams ' },
  { START => 64905, END => 64964, TEXT => '^Gold ', 
    CORR => 'SL - Indian Gold Open Teams ' },
  { START => 64957, END => 64970, TEXT => '^Silver ', 
    CORR => 'Indian Silver Open Teams ' },
  { START => 65050, END => 65133, TEXT => '^U26O[ -]', CORR => "U26 " },
  { START => 65399, END => 66001, TEXT => '^SD-', CORR => "d'Orsi " },
  { START => 65928, END => 66003, TEXT => '^TN-', 
    CORR => "Transnational " },
  { START => 66027, END => 66063, TEXT => '^LM ', CORR => 'Open Teams ' },
  { START => 66696, END => 66918, TEXT => '^Men ', CORR => 'Open ' },
  { START => 67132, END => 67230, TEXT => '^K_O_ ', CORR => 'KO ' },
  { START => 67400, END => 67411, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 67982, END => 68005, TEXT => '^DR ', CORR => "RR " },
  { START => 68794, END => 68814, TEXT => '^FMB ', CORR =>  '' },
  { START => 68814, END => 68897, TEXT => '^TOP ', 
    CORR =>  'European Winter Pairs - Pairs ' },
  { START => 72015, END => 72023, TEXT => 'SwR', CORR => 'Swiss - Round' },
  { START => 72887, END => 73251, TEXT => 'første halvleg', 
    CORR => 'Half 1' },
  { START => 72890, END => 73253, TEXT => 'anden halvleg', 
    CORR => 'Half 2' },
  { START => 73113, END => 73153, TEXT => 'SwR', CORR => 'Swiss - Round' },
  { START => 73853, END => 73866, TEXT => 'CEYREK FINAL', CORR => 'QF' },
  { START => 73853, END => 73866, TEXT => 'CEYREK', CORR => 'QF' },
  { START => 74374, END => 74380, TEXT => '^1_8 ', CORR => 'QF ' },
  { START => 75064, END => 75089, TEXT => 'SwR', CORR => 'Swiss - Round' },
  { START => 75090, END => 75098, TEXT => '^DR ', CORR => "RR " },
  { START => 75599, END => 75641, TEXT => '^U26O-', CORR => "U26 " },
  { START => 76428, END => 76472, TEXT => '^DR ', CORR => "RR " },
  { START => 76643, END => 76683, TEXT => '^SL *Gold ', 
    CORR => 'SL - Indian Gold Open Teams ' },
  { START => 76698, END => 76806, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 76744, END => 76807, TEXT => '^Silver ', 
    CORR => 'Indian Silver Open Teams ' },
  { START => 76821, END => 76917, TEXT => '\bMen', CORR => 'Open' },
  { START => 77141, END => 77157, TEXT => 'SWISS LEAGUE', CORR => 'SL' },
  { START => 77354, END => 77426, TEXT => 'Kelas [AB]', CORR => '' },
  { START => 77685, END => 77698, TEXT => '^Silver ', 
    CORR => 'Indian Silver Open Teams ' },
  { START => 77692, END => 77712, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 79317, END => 79342, TEXT => 'SwR', CORR => 'Swiss - Round' },
  { START => 79346, END => 79362, TEXT => '^DR ', CORR => "RR " },
  { START => 79783, END => 79789, TEXT => '^Silver ', 
    CORR => 'Indian Silver Open Teams ' },
  { START => 79784, END => 79791, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 80031, END => 80043, TEXT => ' Mix ', 
    CORR => ' - Mixed Pairs - ' },
  { START => 80031, END => 80114, TEXT => '^U21', 
    CORR => 'U21 Pairs - ' },
  { START => 80056, END => 80113, TEXT => '^U26', 
    CORR => 'U26 Pairs - ' },
  { START => 80419, END => 80674, TEXT => '^WC-', 
    CORR => 'Wuhan Cup ' },
  { START => 80433, END => 80675, TEXT => '^OT-', 
    CORR => "d'Orsi " },
  { START => 80860, END => 80887, TEXT => '^DR ', CORR => "RR " },
  { START => 81359, END => 81373, TEXT => '^Silver ', 
    CORR => 'Indian Silver Open Teams ' },
  { START => 81361, END => 81377, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 82113, END => 82118, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 82252, END => 82271, TEXT => '^1_8 ', CORR => "QF " },
  { START => 82304, END => 82325, TEXT => '^SL ', CORR => "Swiss " },
  { START => 83207, END => 83317, TEXT => '^WTC-', CORR => '' },
  { START => 83051, END => 83058,
    TEXT => 'Open Team', CORR => 'U26 Teams' },
  { START => 83976, END => 84086, TEXT => '^M-', CORR => 'Mixed - ' },
  { START => 84245, END => 84256, TEXT => '^FNRR', CORR => "Final RR " },
  { START => 84630, END => 84649, TEXT => 'Eleme ', CORR => "Final " },
  { START => 84833, END => 84949, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
  { START => 86039, END => 86098, TEXT => '^Gold ', 
    CORR => 'Indian Gold Open Teams ' },
);

my @LOCAL_SUBS_INTERPOL =
(
  { START => 49185, END => 49228, TEXT => '^Segment Q(\d_\d)', 
    CORR => 'Qualifying - Segment $1' },
  { START => 52291, END => 52298, TEXT => '^Junior U-(\d+)', 
    CORR => 'U$1' },
  { START => 52933, END => 52975, TEXT => '^BB\d+-', CORR => '' },
  { START => 53648, END => 53672, TEXT => '^RR\d ', CORR => 'RR ' },
  { START => 53828, END => 53833, TEXT => '^KO 1_8 ', CORR => 'Rof16 ' },
  { START => 53845, END => 53848, TEXT => '^KO 1_4 ', CORR => 'QF ' },
  { START => 53849, END => 53868, TEXT => '^KO 1_2 ', CORR => 'SF ' },
  { START => 54144, END => 54152, 
    TEXT => '^T\d S(\d)RR(\d)$', CORR => 'Session $1 - RR - Round $2' },
  { START => 54565, END => 54598, 
    TEXT => '^T\d+ S(\d)RR(\d)$', CORR => 'Session $1 - RR - Round $2' },
  { START => 54649, END => 54718, TEXT => 'RR(\d) (\d[-_]\d)', 
    CORR => 'RR Round $1 - Segment $2' },
  { START => 55780, END => 55793, TEXT => '^OF(\d)$', 
    CORR => 'Rof16 Segment $1' },
  { START => 59165, END => 59208, TEXT => 'R(\d\d)', CORR => ' Rof$1 ' },
  { START => 59755, END => 59848, TEXT => '(\d+)-4$', CORR => '$1 of 4' },
  { START => 59996, END => 60040, TEXT => '^(\d+):(\d+)$', 
    CORR => '$1 of $2' },
  { START => 60199, END => 60240, TEXT => '^(\d)-(\d)$', 
    CORR => '$1 of $2' },
  { START => 61117, END => 61166, TEXT => '^(\d+)-(\d)$', 
    CORR => '$1 of $2' },
  { START => 61207, END => 61247, TEXT => '^(\d+)-(\d)$', 
    CORR => '$1 of $2' },
  { START => 61339, END => 61388, TEXT => '^QL(\d)_4-S(\d)$', 
    CORR => 'Qualifying - Round $1 of 4 - Session $2' },
  { START => 62377, END => 62538, TEXT => '^(\d+)-(\d)$', 
    CORR => '$1 of $2' },
  { START => 63013, END => 63040, TEXT => '(\d+)-(\d+)$', 
    CORR => '$1 of $2' },
  { START => 63926, END => 64145, TEXT => '^RR(\d+)-(\d+)$', 
    CORR => 'RR $2' },
  { START => 67439, END => 67482, TEXT => '^RR (\d)-(\d)$', 
    CORR => 'RR Round $1 Segment $2' },
  { START => 67502, END => 67557, TEXT => '^(\d+)-(\d+)$', 
    CORR => '$1 of $2' },
  { START => 67767, END => 67840, TEXT => '^(\d+)-(\d+)$', 
    CORR => '$1 of $2' },
  { START => 69777, END => 69787, TEXT => '^(\d+):(\d)$', 
    CORR => '$1 of $2' },
  { START => 69792, END => 69812, TEXT => '^(\d+):(\d+)$', 
    CORR => '$1 of $2' },
  { START => 69814, END => 69834, TEXT => '^(\d+):(\d+)$', 
    CORR => '$1 of $2' },
  { START => 69837, END => 69849, TEXT => '^(\d+):(\d+)$', 
    CORR => '$1 of $2' },
  { START => 72393, END => 72395, TEXT => '^(\d+):(\d+)$', 
    CORR => '$1 of $2' },
  { START => 72397, END => 72416, TEXT => '(\d+):12', CORR => '$1 of 12' },
  { START => 72421, END => 72428, TEXT => '^(\d+):(\d+)$', 
    CORR => '$1 of $2' },
  { START => 72441, END => 72455, TEXT => '(\d+):14', CORR => '$1 of 14' },
  { START => 72865, END => 72875, TEXT => '^(\d+):(\d)$', 
    CORR => 'Match $1 Segment $2' },
  { START => 73378, END => 73409, TEXT => '^Q(\d)', 
    CORR => 'Quarter $1 of 4' },
  { START => 73670, END => 73677, TEXT => '^(\d+):([12])$', 
    CORR => 'Match $1 Segment $2' },
  { START => 73943, END => 74042, TEXT => 'Q *(\d) of 4$', 
    CORR => 'Quarter $1 of 4' },
  { START => 75149, END => 75165, TEXT => 'Q *(\d) of 4$', 
    CORR => 'Quarter $1 of 4' },
  { START => 75171, END => 75367, TEXT => 'Q *(\d) of 4$', 
    CORR => 'Quarter $1 of 4' },
  { START => 75480, END => 75496, TEXT => '^(\d+):(\d)$', 
    CORR => 'Match $1 Segment $2' },
  { START => 74358, END => 74372, TEXT => '^1_(\d+)', CORR => 'Rof$1' },
  { START => 75506, END => 75538, TEXT => '^(\d+):12$', 
    CORR => '$1 of 12' },
  { START => 75547, END => 75570, TEXT => '^(\d+):(\d)$', 
    CORR => 'Match $1 Segment $2' },
  { START => 75595, END => 75631, TEXT => '^(\d+):14$', 
    CORR => '$1 of 14' },
  { START => 76484, END => 76546, TEXT => '^R(\d+) of R(\d+)$', 
    CORR => 'Round $1 of $2' },
  { START => 77123, END => 77177, TEXT => '(\d+):([45])$', 
    CORR => '$1 of $2' },
  { START => 78095, END => 78126, TEXT => '^(\d+)-5$', CORR => '$1 of 5' },
  { START => 78357, END => 78378, TEXT => '^(\d+)-4$', CORR => '$1 of 4' },
  { START => 78442, END => 78503, TEXT => '^Q(\d) of 4$', 
    CORR => 'Quarter $1 of 4' },
  { START => 78678, END => 78699, TEXT => '^(\d+):(\d)$', 
    CORR => 'Match $1 Segment $2' },
  { START => 79288, END => 79351, TEXT => '^(\d+)-(\d)$', 
    CORR => '$1 of $2' },
  { START => 82004, END => 82028, TEXT => '^Q(\d)$', 
    CORR => 'Quarter $1 of 4' },
  { START => 82823, END => 82830, TEXT => '(\d+)-(\d)$', 
    CORR => '$1 of $2' },
  { START => 82685, END => 82716, TEXT => '^(\d)-5$', 
    CORR => 'Segment $1 of 5' },
  { START => 82758, END => 82817, TEXT => '^(\d).. S$', 
    CORR => 'Segment $1' },
  { START => 82932, END => 83019, TEXT => '^Q(\d) of 4$', 
    CORR => 'Quarter $1 of 4' },
  { START => 83546, END => 83587, TEXT => '^(\d+)-(\d)$', 
    CORR => '$1 of $2' },
  { START => 84317, END => 84396, TEXT => '^Q(\d) of 4$', 
    CORR => 'Quarter $1 of 4' },
  { START => 84427, END => 84453, TEXT => '^(\d+):(\d+)$', 
    CORR => '$1 of $2' },
  { START => 84472, END => 84500, TEXT => '^(\d+):(\d+)$', 
    CORR => '$1 of $2' },
  { START => 84872, END => 84882, TEXT => '^Final (\d)-3$', 
    CORR => 'Final - Segment $1 of 3' },
  { START => 85831, END => 85860, TEXT => '^Q(\d) of 4$', 
    CORR => 'Quarter $1 of 4' },
  { START => 85774, END => 85826, TEXT => '^Q(\d) of 4$', 
    CORR => 'Quarter $1 of 4' },
);


sub local_substitutions
{
  my ($text, $bbono) = @_;

  for my $entry (@LOCAL_SUBS)
  {
    if ($bbono >= $entry->{START} && $bbono <= $entry->{END})
    {
      $text =~ s/$entry->{TEXT}/$entry->{CORR}/i;
    }
  }

  for my $entry (@LOCAL_SUBS_INTERPOL)
  {
    if ($bbono >= $entry->{START} && $bbono <= $entry->{END})
    {
      $text =~ s/$entry->{TEXT}/linterpol($1, $2, $entry->{CORR})/ie;
    }
  }

  if ($bbono >= 28879 && $bbono <= 28887)
  {
    $text =~ s/^(T\d+) (\d+_\d+)$/$1 Round $2/;
  }
  return $text;
}


sub linterpol
{
  my ($m1, $m2, $corr) = @_;
  $corr =~ s/\$1/$m1/;
  return $corr =~ s/\$2/$m2/r;
}


sub event_specific_inline
{
  my ($text) = @_;

  $text =~s/#(\d)/$1/g; # Remove hash

  $text =~ s/(\d)([a-zA-Z]{2,})/$1 $2/g; # Digit, then 2+ letters
  $text =~ s/([a-zA-TV-Z]{2,})(\d)/$1 $2/g; # Other way round
  $text =~ s/(\d)([g-zG-Z])/$1 $2/g;
  $text =~ s/([g-zG-TV-Z])(\d)/$1 $2/g;

  # Various ordinals.
  $text =~ s/(\d)\s+th/$1th /gi;
  $text =~ s/(\d)\s+rth/$1rth /gi;
  $text =~ s/(\d)\s+nd/$1nd /gi;
  $text =~ s/(\d)\s+rd/$1rd /gi;
  $text =~ s/(\d)\s+st(?=\b|_)/$1st /gi; # Either \b or _
  $text =~ s/(\d)\s+er/$1th /gi;
  $text =~ s/(\d)\s+eme/$1th /gi;

  $text =~ s/n°(\d)/ $1/gi;
  $text =~ s/(\d)ª/${1}th /gi;
  $text =~ s/(\d)°/${1}th /gi;

  $text =~ s/\bF(\d)([AB])\b/F $1$2/g;
  $text =~ s/\bF(\d+)_(\d+)\b/F $1_$2/g;

  $text =~ s/\b([FQ])([ABRSabrs])\b/$1 $2/g;
  $text =~ s/\bORR\b/Open RR/g;
  $text =~ s/\bWRR\b/Women RR/g;

  $text =~ s/^FO([\s-]|\z)/Final Open$1/;
  $text =~ s/^OF([\s-]|\z)/Open Final$1/;

  $text =~ s/\s+/ /g;

  return $text;
}


sub is_lettered_number
{
  my ($part, $token, $chain) = @_;

  my ($number, $letter);
  if ($part =~ /^(\d+)([A-Fa-f])$/)
  {
    ($number, $letter) = ($1, $2);
  }
  elsif ($part =~ /^([A-Fa-f])(\d+)$/)
  {
    ($number, $letter) = ($2, $1);
  }
  else
  {
    return 0;
  }

  $token->set_general('COUNTER', 'NL', $number . $letter);
  return 1;
}


sub study_value
{
  my ($whole, $value, $result, $pos, $chain, $unsolved_flag) = @_;

  return if singleton_non_tag_matches($value, $pos, $chain,
    $main::histo_event, $PREFIX);

  return if singleton_tag_matches($whole, \@TAG_ORDER, 
    $pos, $value, 1, $chain, $main::histo_event, $PREFIX);

  my $token = Token->new();
  $token->set_origin($$pos, $value);
  $chain->append($token);
  $$pos++;

  return if Separators::set_token($value, $token);

  return 0 if is_lettered_number($value, $token);

  print "EEE value $value\n";
  $$unsolved_flag = 1;

  $token->set_unknown($value);
}


sub study
{
  my ($whole, $chunk, $result, $chain, $histo, $unknowns) = @_;

  if ($chunk->{BBONO} >= 4790 && $chunk->{BBONO} <= 4860 &&
      $chunk->{TITLE} =~ /^Buffet/)
  {
    # I think we can discard these.  I don't understand what they mean.
    return;
  }

  my $ltext = local_substitutions($chunk->{EVENT}, $chunk->{BBONO});
  my $utext = unteam($ltext, $result);
  my $htext = sub_hard_fragments($utext);
  my $ctext = split_on_capitals($htext);
  my $etext = event_specific_inline($ctext);

  my @tags = (0);
  my @values = ();
  my @texts = ();
  split_on_dates($etext, \@tags, \@values, \@texts, 1);
  split_on_multi($whole, \@TAG_ORDER, 1, \@tags, \@values, \@texts);

  # Split on separators.
  my $sep = qr/([\s+\-\+._:;"\/\(\)\|])/;

  my $token_no = 0;
  my $unsolved_flag = 0;

  # Make a semantic, studied version of the event.

  for my $i (0 .. $#values)
  {
    if ($tags[$i] ne '0')
    {
      # We had a hit.
      if ($tags[$i] eq 'SEPARATOR')
      {
        $chain->append_separator($values[$i], $texts[$i], $token_no);
      }
      else
      {
        $chain->append_general('SINGLETON', $tags[$i], $values[$i],
          $texts[$i], $i);
      }
      $token_no++;
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
      foreach my $value (@a)
      {
        study_value($whole, $value, $result, \$token_no, 
          $chain, \$unsolved_flag);
      }
    }
  }

  if ($unsolved_flag)
  {
    $$unknowns++;
    print "EEE $chunk->{BBONO}: $chunk->{EVENT}\n" if $chain->last() > 0;
    print "\n";
  }
}

1;
