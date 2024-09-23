#!perl

package EntryT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Time::Piece;

use lib '.';

my @HEADER_FIELDS = qw(
  TOURNAMENT_NAME
  TOURNAMENT_CITY
  YEAR
  TOURNAMENT_ORDINAL
  ORDINAL
  ZONE
  ORIGIN
  COUNTRY
  LOCALITY
  CITY
  ORGANIZATION
  FORM
  SCORING
  AGE 
  GENDER
);

my %HEADER_HASH_CHECK;
$HEADER_HASH_CHECK{$_} = 1 for @HEADER_FIELDS;

my @CHAPTER_FIELDS = qw(
  YEAR
  MEET
  WEEKEND
  AGE
  GENDER
  DATE_START
  DATE_END
  MOVEMENT
  STAGE
);

my %CHAPTER_HASH_CHECK;
$CHAPTER_HASH_CHECK{$_} = 1 for @CHAPTER_FIELDS;


my @PRUNE_HEADER_FIELDS = (
  ['TOURNAMENT_ORDINAL', 'TITLE_ORDINAL'],
  ['TOURNAMENT_NAME', 'TITLE_TNAME'],
  ['YEAR', 'TITLE_YEAR'],
  ['ZONE', 'TITLE_ZONE'],
  ['ORIGIN', 'TITLE_ORIGIN'],
  ['COUNTRY', 'TITLE_COUNTRY'],
  ['CITY', 'TITLE_CITY'],
  ['ORGANIZATION', 'TITLE_ORGANIZATION'],
  ['FORM', 'TITLE_FORM'],
  ['FORM', 'TEAM1_FORM'],
  ['FORM', 'TEAM2_FORM'],
  ['SCORING', 'TITLE_SCORING'],
  ['SCORING', 'SCORING'],
  ['AGE', 'TITLE_AGE'],
  ['GENDER', 'TITLE_GENDER']
);

my @PRUNE_CHAPTER_FIELDS = (
  ['YEAR', 'TITLE_YEAR'],
  ['MOVEMENT', 'EVENT_MOVEMENT'],
  ['STAGE', 'TITLE_STAGE'],
  ['STAGE', 'EVENT_STAGE']
);

my %SCORING_CORRECTIONS = (
  # Says P in BBO file, but is IMPs
  # Or says I in BBO file, but is MPs
  'European Transnational Mixed Pairs' => [
    18826, 18828, 18829, 18832, 18833, 18834, 18835, 18836, 18837,
    18840, 18841, 18842, 18843, 18844, 18845, 18846, 18847, 18849,
    18850, 18851, 18852, 18853, 18854, 18855, 18856],
  'European Transnational Open Pairs' => [
    18995, 18996, 18997, 18998, 18999, 19000, 19001, 19002, 19003,
    19004, 19005, 19006, 19007, 19008, 19011, 19012, 19013, 19014,
    19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022, 19023,
    19024, 19025, 19027, 19028, 19029, 19030, 19031, 19032, 19033,
    19034, 19035, 19036, 19037, 19038, 19039, 19040, 19041, 19042,
    19043, 19044, 19045, 19046, 19047, 19048, 19049, 19050, 19052,
    19053, 19054, 19055, 19056, 19057, 19058, 19059, 19060, 19061,
    19062, 19063, 19064, 19065, 19066, 19067],
  'Greek Open Pair Trials' => [
    12439, 12440, 12441, 12447, 12463, 12464, 12465, 12468, 12470,
    12471, 12484, 12486, 12487, 12489, 12490, 12492, 12520, 12543,
    12548, 12550, 12554, 12560, 12562, 12564, 12565, 12584, 12587,
    12588, 12596, 12600],
  "Gro's Supercup" => [15059, 15070, 
    19725, 19732, 19745,
    24988, 24989, 29535, 29536, 29540, 29541, 29548, 29549,
    34123, 34129, 34132, 34133,
    39117, 39120, 39145, 39146, 39151,
    44699, 44700, 44702, 44704, 44709, 44710, 44723, 44724,
    44730, 44731, 44736, 44737, 44738, 44739, 44764, 44765, 44766]
);

  # 'Finnish Swiss Teams' => [
    # 16711, 16718, 16719, 16720, 16723, 16724, 16727, 16728, 16730,
    # 16731, 16736, 16739, 16742, 16743, 16746],

my %FORM_CORRECTIONS = (
  # Says Team 1, Team 2 in BBO file, but is pairs or individual
  'Argentinian Mixed Pairs' => [
    43946],
  'Belgian Open Pairs' => [3075, 3076, 9813, 9824, 18125,18133],
  'Chilean Cup' => [26199, 26218, 26237, 26265],
  'Chilean Open Pairs' => [31502, 31503],
  'Copenhagen Invitational Pairs' => [36915, 36941, 36954],
  'Copenhagen Open Pairs' => [
    27782, 27784, 27789, 27790,
    32623, 32631, 32640, 32644,
    38027, 38046],
  'Danish Mixed Pairs' => [
    19096, 19103, 19105, 19107, 19120, 19124, 19125, 19130, 19133, 19134,
    24114, 24128, 24132, 24133,
    29177, 29184, 29188, 29192,
    34362, 34368, 34373,
    45696, 45707, 45724, 45728],
  'Danish Open Pairs' => [
    10471, 10474,
    14732, 14733, 14736, 14737, 14738,
    19209, 19211, 19219, 19223, 19236, 19242, 19250,
    24207, 24212, 24217, 24236, 24240,
    29278, 29286, 29301, 29328, 29338,
    34427, 34438, 34464, 34471],
  'Danish Women Pairs' => [
    14716,
    19120, 19124, 19125, 19130, 19133, 19134],
  'European Transnational Mixed Pairs' => [
    28786, 28787, 28788, 28789, 28790, 28791, 28792, 28793, 28794,
    28795, 28796, 28797, 28798, 28799, 28800, 28801, 28802, 28803,
    28804, 28805, 28806, 28807, 28808, 28809, 28810, 28811, 28812,
    28813, 28814, 28815, 28816, 28817, 28818, 28819, 28820, 28821,
    28822, 28824, 28825, 28826, 28827, 28828, 28829, 28830, 28831,
    28832, 28833, 28834, 28835, 28836, 28837, 28838, 28839, 28840,
    28841, 28842, 28843, 28844, 28845, 28846, 28847, 28848, 28849,
    28850, 28851, 28852, 28853, 28854, 28855, 28856, 28857, 28858,
    28859, 28860, 28862, 28863, 28864, 28865, 28866, 28867, 28868,
    28869, 28870, 28871, 28872, 28873, 28874, 28875, 28876, 28878,
    28879, 28880, 28881, 28882, 28883, 28884, 28885, 28886, 28887,
    39759, 39760, 39761, 39762, 39763, 39764, 39765, 39766, 39767,
    39768, 39769, 39770, 39771, 39772, 39773, 39774, 39775, 39776,
    39777, 39778, 39779, 39780, 39781, 39782, 39783, 39784, 39785,
    39786, 39787, 39788, 39789, 39790, 39791, 39792, 39793, 39794,
    39795, 39796, 39797, 39798, 39799, 39800, 39801, 39802, 39803,
    39804, 39805, 39806, 39807, 39808, 39809, 39810, 39811, 39812,
    39813, 39814, 39815, 39816, 39817, 39818, 39819, 39820, 39821,
    39822, 39823, 39824, 39825, 39826, 39827, 39828, 39829, 39830,
    39831, 39832, 39833, 39834, 39835, 39836, 39837, 39838],
  'European Transnational Open Pairs' => [
    10351, 10352, 10355, 10356, 10367, 10368, 10372, 10373,
    29084, 29085, 29086, 29087, 29088, 29089, 29090, 29091, 29092,
    29093, 29094, 29095, 29096, 29097, 29098, 29099, 29100, 29101,
    29102, 29103, 29104, 29105, 29106, 29107, 29108, 29109, 29110,
    29111, 29112, 29113, 29114, 29115, 29116, 29117, 29118, 29119,
    29120, 29121, 29122, 29123, 29127, 29128, 29129, 29130, 29131,
    29132, 29133, 29134, 29135, 29136, 29137, 29138, 29139, 29140,
    29141, 29142, 29143, 29144, 29145, 29146, 29148, 29149, 29150,
    29151, 29152, 29153, 29154, 29155, 29156, 29157, 29158, 29159,
    29160, 29161, 29162, 29163, 29164, 29165, 29166, 29167,
    39944, 39945, 39946, 39947, 39948, 39949, 39950, 39951, 39952,
    39953, 39954, 39955, 39956, 39957, 39958, 39959, 39960, 39961,
    39962, 39963, 39964, 39965, 39966, 39967, 39968, 39969, 39970,
    39971, 39972, 39973, 39975, 39976, 39977, 39978, 39979, 39980,
    39981, 39982, 39983, 39984, 39985, 39986, 39987, 39988, 39989,
    39990, 39991, 39992, 39993, 39994, 39995, 39996, 39997, 39998,
    39999, 40000, 40001, 40002, 40003, 40004, 40005, 40006, 40007,
    40008, 40009, 40010, 40011, 40012, 40013, 40014, 40015, 40016,
    40017, 40018, 40019, 40021, 40022, 40023, 40024, 40025, 40026,
    40027],
  'Finnish Open Pairs' => [
     1282,  1287,  1288,  1289,  1293,  1295,  1296,
     2900,  2901,  2902,  2903,  2904,  2905,  2906,  2907,  2908,
     2909,  2910,  2911,  2912,  2913,  2914,  2915,  2916,  2917,
     2918,  2919,
     4717,  4718,
    11737, 11746, 11750, 11768, 11781,
    15783, 15786,
    30627, 30646, 30657, 30670, 30683, 30687,
    35809, 35825, 35845, 35859, 35860,
    41675, 41688],
  'Finnish Swiss Pairs' => [
    22031, 22034, 22035, 22037, 22040, 22041, 22045, 22048, 22053,
    22055, 22056, 22059, 22060,
    26966, 26970, 26973, 26977, 26980, 26984, 26989, 26992, 26993,
    26999, 27003, 27004, 27006, 27009,
    32863,
    39104, 39106, 39107, 39108, 39109, 39110, 39112, 39114, 39115, 
    39116, 39125, 39128, 39129, 39135, 39136, 39142],
  'Full Tilt Irish Bridge Masters' => [
    29654, 29666, 29677 ],
  'German Open Pairs' => [
    11914, 11917, 11920, 11921, 11932, 11933,
    21016, 21039, 
    26012, 26020, 26027,
    31218, 31228, 31250],
  'German Women Pairs' => [26011, 26021, 26028],
  'Grand Prix of Poland Pairs' => [
     3077,  3078,
     3453,  3454,  3455,
     4979,  4980,  4981,  4982,
     9230,  9235,
    11229, 11232, 11233, 11234, 11237, 11239, 11242, 11243, 11245,
    11247,
    12222, 12223, 12236, 12240, 12253,
    15457, 15458, 15460, 15461, 15462, 15463,
    16307, 16309, 16312, 16317, 16324,
    20051, 20055, 20059, 20062, 20063,
    21520, 21521, 21523, 21531, 21534, 21541, 21543, 21544, 21552,
    21553,
    37029, 37032,
    38023, 38028],
  'Greek Central Regional Pairs' => [
    20136, 20162, 20176],
  'Greek Mixed Pairs' => [
    18103, 18134, 18148],
  'Greek Open Pair Trials' => [
    12439, 12440, 12441, 12447, 12463, 12464, 12465, 12468, 12470,
    12471, 12484, 12486, 12487, 12489, 12490, 12492, 12520, 12526,
    12527, 12528, 12529, 12530, 12542, 12543, 12547, 12548, 12550,
    12552, 12553, 12554, 12558, 12560, 12561, 12562, 12563, 12564,
    12565, 12567, 12581, 12584, 12586, 12587, 12588, 12590, 12593,
    12594, 12595, 12596, 12599, 12600],
  "Gro's Supercup" => [
    15059, 15070, 
    19725, 19732, 19745,
    24988, 24989,
    29535, 29536, 29540, 29541, 29548, 29549,
    34116, 34117, 34121, 34123, 34129, 34132, 34133,
    44699, 44700, 44702, 44704, 44709, 44710, 44723, 44724,
    44730, 44731, 44736, 44737, 44738, 44739, 44764, 44765, 44766],
  'Hungarian IMP Pairs' => [
     1113,  1117,  1126,
    12005, 12016],
  'Irish Invitational Pairs' => [
    44185, 44186,
    45160, 45161, 45164, 45166, 45168, 45171, 45172],
  'Israel IMP Pairs' => [ 
     3814,
     9383, 9385 ],
  'Israel Juniors Pairs' => [ 
     1781,  1783,  
    12273, 12274 ],
  'Israel School Trials' => [ 12406 ],
  'Italian Mixed Pairs' => [
    36287, 36289, 36293, 36295, 36296, 36308, 36309,
    41672, 41674, 41691, 41692, 41704, 41705],
  'Polish Individual Championship' => [
    13235, 13236, 13237, 13242,
    16511, 16513, 16514, 16515, 16526, 16532, 16537],
  'Polish Junior Pairs Trials' => [
    22677, 22678, 22679, 22680, 22681],
  'Polish Open Pairs' => [
     4285,  4286],
);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub read
{
  my ($self, $fh) = @_;

  %$self = ();

  my $line;
  return 0 unless defined($line = <$fh>);

  die "Not a BBONO: $line" unless $line =~ /^BBONO\s+(\d+)$/;
  $self->{BBONO} = $1;

  do
  {
    $line = <$fh>;
    chomp $line;
  }
  while ($line ne '');

  while (1)
  {
    $line = <$fh>;
    chomp $line;
    return 1 if $line eq '';

    if ($line !~ /^([A-Z0-9_]+)\s(.*)$/)
    {
      die "$self->{BBONO}: Malformed line $line";
    }

    my ($tag, $value) = ($1, $2);
    push @{$self->{$tag}}, $value;
  }

  return 1;
}


sub set
{
  my ($self, $fields) = @_;
  for my $tag (keys %$fields)
  {
    $self->{$tag} = $fields->{$tag};
  }
}


sub fix_some_fields
{
  my ($self) = @_;
  if (exists $self->{TITLE_ROF})
  {
    if (exists $self->{TITLE_STAGE})
    {
      warn "Confused";
      return;
    }
    for my $v (@{$self->{TITLE_ROF}})
    {
      push @{$self->{TITLE_STAGE}}, 'Rof' . $v;
    }
    delete $self->{TITLE_ROF};
  }

  if ($self->field('TITLE_TNAME') eq 'Reisinger BAM Teams')
  {
    if ($self->field('TITLE_ORDINAL'))
    {
      delete $self->{TITLE_ORDINAL};
    }
  }
}


sub prune_field_using
{
  my ($self, $field, $value, $header) = @_;

  return unless defined $self->{$field};
  my $len = $#{$self->{$field}};
  for my $i (0 .. $len)
  {
    if ($self->{$field}[$i] eq $value)
    {
      if ($len == 0)
      {
        delete $self->{$field};
      }
      else
      {
        splice(@{$self->{$field}}, $i, 1);
      }
      return;
    }
  }

  if ($field eq 'SCORING')
  {
    die "Multiple scoring values" unless $len == 0;
    my $read = $self->{$field}[0];
    if (($read eq 'I' && $value eq 'IMP') ||
        ($read eq 'P' && ($value eq 'MP' || $value eq 'Pairs')))
    {
      delete $self->{$field};
      return;
    }

    if ($read eq 'B' && $value eq 'BAM')
    {
      delete $self->{$field};
      return;
    }

    if (($read eq 'P' && $value eq 'IMP') ||
        ($read eq 'I' && $value eq 'MP'))
    {
      if (exists $header->{TOURNAMENT_NAME})
      {
        my $tname = $header->{TOURNAMENT_NAME};
        if (exists $SCORING_CORRECTIONS{$tname})
        {
          for my $ok (@{$SCORING_CORRECTIONS{$tname}})
          {
            if ($ok eq $self->{BBONO})
            {
              # Value is deemed correct.
              delete $self->{$field};
              return;
            }
          }
        }
      }

      warn "$self->{BBONO}, $header->{TOURNAMENT_NAME}: Scoring";
      return;
    }
  }
  elsif ($field eq 'TEAM1_FORM' || $field eq 'TEAM2_FORM')
  {
    die "Multiple form values" unless $len == 0;
    my $read = $self->{$field}[0];
    if (($read eq 'Teams' || $read eq 'Pairs') && 
        ($value eq 'Pairs' || $value eq 'Individual'))
    {
      if (exists $header->{TOURNAMENT_NAME})
      {
        my $tname = $header->{TOURNAMENT_NAME};
        if (exists $FORM_CORRECTIONS{$tname})
        {
          for my $ok (@{$FORM_CORRECTIONS{$tname}})
          {
            if ($ok eq $self->{BBONO})
            {
              # Value is deemed correct.
              delete $self->{$field};
              return;
            }
          }
        }
      }

      warn "$self->{BBONO}, $header->{TOURNAMENT_NAME}, $field: " .
        "Form $read, $value";
      return;
    }
  }
  elsif ($field eq 'TITLE_ORDINAL')
  {
    die "Multiple ordinal values" unless $len == 0;
    my $read = $self->{$field}[0];
    if ($value !~ /^(\d+)([a-z]+)$/)
    {
      die "Strange ordinal: $value";
    }

    my ($number, $ending) = ($1, $2);

    if ($read ne $number)
    {
      die "Ordinal $read is not $number";
    }

    if ($ending ne 'st' && $ending ne 'nd' &&
        $ending ne 'rd' && $ending ne 'th')
    {
      die "Ordinal ending: $value";
    }

    delete $self->{$field};
    return;
  }


  warn "$self->{BBONO}, pruning field $field, value $value, but have " .
    join '|', @{$self->{$field}};
}


sub prune_using
{
  my ($self, $header, $chapter) = @_;

  for my $pair (@PRUNE_HEADER_FIELDS)
  {
    $self->prune_field_using($pair->[1], $header->{$pair->[0]}, $header) if
      exists $header->{$pair->[0]};
  }

  for my $pair (@PRUNE_CHAPTER_FIELDS)
  {
    $self->prune_field_using($pair->[1], $chapter->{$pair->[0]}, $header) if
      exists $chapter->{$pair->[0]};
  }

  # This is not so clean -- modifying a method argument.
  if (exists $header->{YEAR} && exists $chapter->{YEAR})
  {
    die "Different years" unless $header->{YEAR} eq $chapter->{YEAR};
    delete $chapter->{YEAR};
  }

  # This is not so clean -- modifying a method argument.
  $header->transfer_list_tag_from($self, 'TITLE_ORDINAL', 'ORDINAL');
  $header->transfer_list_tag_from($self, 'TITLE_COUNTRY', 'COUNTRY');
  $header->transfer_list_tag_from($self, 'TITLE_LOCALITY', 'LOCALITY');


  # TODO TWORD?
}


sub find_tname_index
{
  # Not a class method.
  # For a given DATE_START.
  my ($data, $date_start, $tname, $index) = @_;
  return 0 unless exists $data->{$date_start};

  for my $i (0 .. $#{$data->{$date_start}})
  {
    if ($data->{$date_start}[$i]{HEADER}{TOURNAMENT_NAME} eq $tname)
    {
      $$index = $i;
      return 1;
    }
  }
  return 0;
}


sub check_tname
{
  my ($self, $datum, $tname, $edition, $header_entry) = @_;

  if ($datum->{TOURNAMENT_NAME} ne $tname)
  {
    warn "$self->{BBONO}: $datum->{TNAME} vs $tname";
  }

  for my $key (keys %$header_entry)
  {
    if (exists $datum->{$key} && $datum->{$key} ne $header_entry->{$key})
    {
      warn "$self->{BBONO}, $key: $datum->{$key} vs $header_entry->{$key}";
    }
  }
}


sub check_chapter
{
  my ($self, $dchapter, $chapter_entry) = @_;

  for my $key (keys %$chapter_entry)
  {
    if (exists $chapter_entry->{$key} && exists $dchapter->{$key})
    {
      if ($chapter_entry->{$key} ne $dchapter->{$key})
      {
        warn "$self->{BBONO}, $key: $chapter_entry->{$key} vs " .
          "$dchapter->{$key}";
      }
    }
  }
}


sub update_tournaments
{
  my ($self, $data, $tname, $edition, $chapter,
    $header_entry, $chapter_entry) = @_;

  my $tindex;
  if (find_tname_index($data, $chapter_entry->{DATE_START},
    $tname, \$tindex))
  {
    my $dhdr = $data->{$chapter_entry->{DATE_START}}[$tindex]{HEADER};
    $self->check_tname($dhdr, $tname, $edition, $header_entry);
  }
  else
  {
    $tindex = 1 + $#{$data->{$chapter_entry->{DATE_START}}};
  }

  $data->{$chapter_entry->{DATE_START}}[$tindex]{HEADER} //= EntryT->new();
  my $datum = $data->{$chapter_entry->{DATE_START}}[$tindex];
  $datum->{HEADER}->set($header_entry);

  if (exists $datum->{CHAPTER}{$chapter})
  {
    my $dchapter = $datum->{CHAPTER}{$chapter};
    $self->check_chapter($dchapter, $chapter_entry);
  }

  $datum->{CHAPTER}{$chapter}{HEADER} //= EntryT->new();
  my $dchapter = $datum->{CHAPTER}{$chapter};
  $dchapter->{HEADER}->set($chapter_entry);

  my $dindex = 1 + $#{$dchapter->{LIST}};
  $dchapter->{LIST}[$dindex] = EntryT->new();
  $dchapter->{LIST}[$dindex]->set($self);
}


sub delete_list_tag_if
{
  my ($self, $tag, $value) = @_;

  return unless exists $self->{$tag};
  for my $n (reverse 0 .. $#{$self->{$tag}})
  {
    if ($self->{$tag}[$n] eq $value)
    {
      splice(@{$self->{$tag}}, $n, 1);
    }
  }

  if ($#{$self->{$tag}} == -1)
  {
    delete $self->{TITLE_TWORD};
  }
}


sub tag_list_contains
{
  my ($self, $tag, $value) = @_;

  for my $v (@{$self->{$tag}})
  {
    return 1 if ($v eq $value);
  }
  return 0;
}


sub transfer_list_tag
{
  my ($self, $tag_from, $tag_to) = @_;

  return unless exists $self->{$tag_from};

  if (! exists $self->{$tag_to})
  {
    @{$self->{$tag_to}} = @{$self->{$tag_from}};
    delete $self->{$tag_from};
    return;
  }

  for my $value (@{$self->{$tag_from}})
  {
    if (! $self->tag_list_contains($tag_to, $value))
    {
      push @{$self->{$tag_to}}, $value;
    }
  }
  delete $self->{$tag_from};
}


sub transfer_list_tag_from
{
  my ($self, $from, $tag_from, $tag_to) = @_;

  return unless exists $from->{$tag_from};
  if ($#{$from->{$tag_from}} != 0)
  {
    die "Need exactly one $tag_from";
  }

  my $value_from = $from->field($tag_from);

  if (exists $self->{$tag_to})
  {
    if ($self->field($tag_to) ne $value_from)
    {
      die "Attempting to rewrite $tag_to";
    }
  }
  else
  {
    $self->{$tag_to} = $value_from;
  }

  delete $from->{$tag_from};
}


sub fix_list_tags
{
  my ($self) = @_;

  $self->delete_list_tag_if('TITLE_TWORD', 'Championship');

  $self->transfer_list_tag('DATE_ADDED', 'DATE');
  $self->transfer_list_tag('EVENT_DATE', 'DATE');

  $self->transfer_list_tag('TITLE_SESSION', 'SESSION');
  $self->transfer_list_tag('EVENT_SESSION', 'SESSION');

  $self->transfer_list_tag('EVENT_SECTION', 'SECTION');

  $self->transfer_list_tag('EVENT_SEGMENT', 'SEGMENT');

  $self->transfer_list_tag('EVENT_AGE', 'AGE');

  $self->transfer_list_tag('EVENT_GENDER', 'GENDER');

  $self->transfer_list_tag('EVENT_HALF', 'HALF');

  $self->transfer_list_tag('TITLE_ROUND', 'ROUND');
  $self->transfer_list_tag('EVENT_ROUND', 'ROUND');

  $self->transfer_list_tag('TITLE_QUARTER', 'QUARTER');
  $self->transfer_list_tag('EVENT_QUARTER', 'QUARTER');

  $self->transfer_list_tag('EVENT_MATCH', 'MATCH');

  $self->transfer_list_tag('TITLE_YEAR', 'YEAR');

  $self->transfer_list_tag('TITLE_PHASE', 'PHASE');

  $self->transfer_list_tag('TITLE_TABLE', 'TABLE');
}


sub fix_counters
{
  my ($self, $field_map, $of_map) = @_;

  for my $field (keys %$field_map)
  {
    next unless exists $self->{$field};

    if ($field_map->{$field} ne $field)
    {
      if ($field_map->{$field} eq 'TO_DELETE')
      {
        delete $self->{$field};
      }
      else
      {
        $self->transfer_list_tag($field, $field_map->{$field});
      }
    }
  }

  # Now fix OF.
  for my $orig_field (keys %$of_map)
  {
    next if $of_map->{$orig_field} == 0;
    next unless exists $field_map->{$orig_field};
    my $mapped = $field_map->{$orig_field};
    next if $mapped eq 'TO_DELETE';
    next unless exists $self->{$mapped};

    # So we still have the ones mapped to themselves here.
    for my $i (0 .. $#{$self->{$mapped}})
    {
      my $value = $self->{$mapped}[$i];
      if ($value =~ /^(\d+)$/)
      {
        $self->{$mapped}[$i] .= " of " . $of_map->{$orig_field};
      }
    }
  }
}


sub spaceship
{
  my ($self, $other, $priorities) = @_;

  # This is a sorting operator.
  for my $field (@$priorities)
  {
    if (exists $self->{$field})
    {
      if (! exists $other->{$field})
      {
        # Empty is ranked before full.
        return 1;
      }
      else
      {
        if ($#{$self->{$field}} != 0)
        {
          die "Need a single value: $field";
        }
        if ($#{$other->{$field}} != 0)
        {
          die "Need a single value: $field";
        }

        my $value_self = $self->{$field}[0];
        my $value_other = $other->{$field}[0];

        my $num_self;
        if ($value_self eq 'last')
        {
          $num_self = 9999;
        }
        elsif ($value_self =~ /^(\d+)/)
        {
          $num_self = $1;
        }
        else
        {
          die "No leading number: $value_self";
        }

        my $num_other;
        if ($value_other eq 'last')
        {
          $num_other = 9999;
        }
        elsif ($value_other =~ /^(\d+)/)
        {
          $num_other = $1;
        }
        else
        {
          die "No leading number: $value_other";
        }
        
        return -1 if ($num_self < $num_other);
        return 1 if ($num_self > $num_other);
      }
    }
    elsif (exists $other->{$field})
    {
      # Empty is ranked before full.
      return -1;
    }
  }

  if (exists $self->{DATE} && exists $other->{DATE})
  {
    my $d0 = Time::Piece->strptime($self->{DATE}[0], "%Y-%m-%d");
    my $d1 = Time::Piece->strptime($other->{DATE}[0], "%Y-%m-%d");
    return -1 if ($d0 < $d1);
    return 1 if ($d1 < $d0);
  }

  return $self->{BBONO} <=> $other->{BBONO};
}


sub number
{
  my ($self, $field) = @_;

  if (exists $self->{$field})
  {
    return $self->{$field};
  }
  else
  {
    return '';
  }
}


sub field
{
  my ($self, $field) = @_;

  if (exists $self->{$field})
  {
# TODO For now.  What is there is more than one?
    return $self->{$field}[0];
  }
  else
  {
    return '';
  }
}


sub bbono
{
  my ($self) = @_;
  return $self->{BBONO};
}


sub str_fields
{
  my ($self, $key) = @_;

  my $s = '';
  for my $v (@{$self->{$key}})
  {
    $s .= "$key $v\n";
  }
  return $s;
}


sub str_as_read
{
  my ($self) = @_;

  my $s;
  $s = "BBONO $self->{BBONO}\n";

  for my $key (qw(YEAR DATE PHASE SECTION SESSION 
    ROUND MATCH SEGMENT HALF TABLE))
  {
    $s .= $self->str_fields($key) if exists $self->{$key};
  }

  for my $order (qw(TITLE_ DATE_ EVENT_ TEAM1_ TEAM2_))
  {
    for my $key (sort keys %$self)
    {
      if ($key =~ /^$order/)
      {
        $s .= $self->str_fields($key);
      }
    }
  }

  $s .= $self->str_fields('BOARDS') if exists $self->{BOARDS};
  $s .= $self->str_fields('SCORING') if exists $self->{SCORING};

  return "$s\n";
}


sub str_by_ordered_fields
{
  my ($self, $fields, $check_fields) = @_;

  my $s = '';

  for my $key (@$fields)
  {
    # This form of an entry only has one value per key.
    $s .= "$key $self->{$key}\n" if exists $self->{$key};
  }

  for my $key (keys %$self)
  {
    next if $key =~ /[a-z]/; # E.g., 'major' and 'minor'
    warn "Unprinted field $key" unless exists $check_fields->{$key};
if (! exists $check_fields->{$key})
{
print "WARNING: Unprinted $key\n";
}
  }

  return "$s\n";
}


sub str_header
{
  my ($self) = @_;
  return $self->str_by_ordered_fields(\@HEADER_FIELDS,
    \%HEADER_HASH_CHECK);
}


sub str_chapter
{
  my ($self) = @_;
  return $self->str_by_ordered_fields(\@CHAPTER_FIELDS,
    \%CHAPTER_HASH_CHECK);
}


1;
