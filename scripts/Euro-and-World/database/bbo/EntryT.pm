#!perl

package EntryT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Storable qw(dclone);

use Time::Piece;

use lib '.';
use lib './Connections';

use FScorr;
use OGAcorr;
use Connections::Matrix;

use Whole;
my $whole = Whole->new();
$whole->init_hashes();

Connections::Matrix::set_matrix($whole);

my @HEADER_FIELDS = qw(
  MEET
  MEET_ORDINAL

  TNAME
  ORDINAL

  ORIGIN
  ORGANIZATION
  SPONSOR
  PERSON
  CLUB

  ZONE
  COUNTRY
  NATIONALITY
  REGION
  CITY
  LOCALITY
  CLUB

  FORM
  SCORING

  AGE 
  GENDER

  DATE_START
  DATE_END
);

my %HEADER_HASH = (
  TITLE_MEET => 'MEET',
  TITLE_ORDINAL => 'ORDINAL', # Could be MEET_ORDINAL as well
  TITLE_TNAME => 'TNAME',

  TITLE_ORIGIN => 'ORIGIN',
  EVENT_ORIGIN => 'ORIGIN',
  TITLE_ORGANIZATION => 'ORGANIZATION',
  EVENT_ORGANIZATION => 'ORGANIZATION',
  TITLE_SPONSOR => 'SPONSOR',
  EVENT_SPONSOR => 'SPONSOR',
  TITLE_PERSON => 'PERSON',
  EVENT_PERSON => 'PERSON',
  TITLE_CLUB => 'CLUB',
  EVENT_CLUB => 'CLUB',

  TITLE_ZONE => 'ZONE',
  TITLE_COUNTRY => 'COUNTRY',
  EVENT_COUNTRY => 'COUNTRY',
  TITLE_NATIONALITY => 'NATIONALITY',
  TITLE_REGION => 'REGION',
  EVENT_REGION => 'REGION',
  TITLE_CITY => 'CITY',
  EVENT_CITY => 'CITY',
  TITLE_LOCALITY => 'LOCALITY',
  TITLE_CLUB => 'CLUB',

  TITLE_FORM => 'FORM',
  EVENT_FORM => 'FORM',
  TEAM1_FORM => 'FORM',
  TEAM2_FORM => 'FORM',
  TITLE_SCORING => 'SCORING',
  EVENT_SCORING => 'SCORING',

  TITLE_AGE => 'AGE',
  EVENT_AGE => 'AGE',
  TITLE_GENDER => 'GENDER',
  EVENT_GENDER => 'GENDER',

  TITLE_DATE_START => 'DATE_START',
  TITLE_DATE_END => 'DATE_END',
);

$HEADER_HASH{$_} = $_ for @HEADER_FIELDS;

my @CHAPTER_FIELDS_NEW = qw(
  YEAR
  YEAR_MONTH
  MONTH_DAY
  DAY
  DATE_ADDED
  WEEKDAY
  WEEKEND
  TIME
  BOARDS
  STAGE
  MOVEMENT
  COLOR
);

my %CHAPTER_HASH_NEW;
for my $cf (@CHAPTER_FIELDS_NEW)
{
  next if $cf eq 'DATE_ADDED';
  $CHAPTER_HASH_NEW{'TITLE_' . $cf} = $cf;
  $CHAPTER_HASH_NEW{'EVENT_' . $cf} = $cf;
}
$CHAPTER_HASH_NEW{TITLE_DATE} = 'DATE_ADDED';
$CHAPTER_HASH_NEW{EVENT_DATE} = 'DATE_ADDED';

$CHAPTER_HASH_NEW{$_} = $_ for @CHAPTER_FIELDS_NEW;

my @COUNTER_FIELDS_NEW = qw(
  PHASE
  FLIGHT
  GROUP
  SECTION
  PLACE

  DAY
  YEAR_MONTH
  MONTH_DAY
  TIME

  SESSION
  ROUND
  MATCH
  SEGMENT
  SET
  STANZA
  HALF
  QUARTER
  TABLE
);

# TODO WEEKEND goes in CHAPTER?
my %COUNTER_HASH_NEW = (
  TITLE_WEEKEND => 'WEEKEND',
  EVENT_WEEKEND => 'WEEKEND',

  TITLE_SESSION => 'SESSION',
  EVENT_SESSION => 'SESSION',

  TITLE_PHASE => 'PHASE',

  TITLE_FLIGHT => 'FLIGHT',

  TITLE_GROUP => 'GROUP',
  EVENT_GROUP => 'GROUP',

  TITLE_DAY => 'DAY',
  EVENT_DAY => 'DAY',

  EVENT_YEAR_MONTH => 'YEAR_MONTH',
  EVENT_MONTH_DAY => 'MONTH_DAY',

  TITLE_TIME => 'TIME',

  TITLE_ROUND => 'ROUND',
  EVENT_ROUND => 'ROUND',

  TITLE_SEGMENT => 'SEGMENT',
  EVENT_SEGMENT => 'SEGMENT',

  TITLE_SET => 'SET',
  EVENT_SET => 'SET',

  TITLE_SECTION => 'SECTION',
  EVENT_SECTION => 'SECTION',

  EVENT_STANZA => 'STANZA',

  TITLE_HALF => 'HALF',
  EVENT_HALF => 'HALF',

  TITLE_QUARTER => 'QUARTER',
  EVENT_QUARTER => 'QUARTER',

  TITLE_MATCH => 'MATCH',
  EVENT_MATCH => 'MATCH',

  TITLE_TABLE => 'TABLE',
  EVENT_TABLE => 'TABLE',

  TITLE_PLACE => 'PLACE',
  EVENT_PLACE => 'PLACE',
);

$COUNTER_HASH_NEW{$_} = $_ for @COUNTER_FIELDS_NEW;

my @TEAM_FIELDS_NEW = qw(
  SPONSOR
  COUNTRY
  NATIONALITY
  ORGANIZATION
  CAPTAIN
  BOT
  TEAM
  ZONE
  REGION
  CITY
  LOCALITY
  CLUB
  UNIVERSITY
  FIRST
  FUN
  AGE
  GENDER
  OTHER
);

my %TEAM_HASH;
$TEAM_HASH{$_} = $_ for @TEAM_FIELDS_NEW;

my @MULTI_VALUED_TEAM_LIST = qw(
  CAPTAIN
  SPONSOR
  BOT
  ORGANIZATION
  CLUB
  UNIVERSITY
  FIRST
  FUN
  GENDER
  AGE
  OTHER
  ZONE
  COUNTRY
  NATIONALITY
  REGION
  CITY
  LOCALITY
  ORIGIN
);

my %MULTI_VALUED_TEAM_FIELD;

for my $mv (@MULTI_VALUED_TEAM_LIST)
{
  $MULTI_VALUED_TEAM_FIELD{'TEAM1_' . $mv} = ['TEAM1', $mv];
  $MULTI_VALUED_TEAM_FIELD{'TEAM2_' . $mv} = ['TEAM2', $mv];
}

my %POST_PROCESS_FIELD = (
  'TITLE_YEAR' => 'YEAR',
  'EVENT_YEAR' => 'YEAR',

  'TITLE_DATE' => 'DATE_ADDED',
  'EVENT_DATE' => 'DATE_ADDED',

  'TITLE_STAGE' => 'STAGE',
  'EVENT_STAGE' => 'STAGE',

  'TITLE_TEAM1_COUNTRY' => 'TEAM1_COUNTRY',
  'TITLE_TEAM2_COUNTRY' => 'TEAM2_COUNTRY',
);

my %SKIP_BBO = (
  YEAR => 1,
  YEAR_MONTH => 1,
  MONTH_DAY => 1,
  DAY => 1,
  DATE_ADDED => 1,
  WEEKDAY => 1,
  WEEKEND => 1,
  TIME => 1,
  BOARDS => 1,
  STAGE => 1,
  MOVEMENT => 1,
  COLOR => 1
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


sub form_fixable
{
  my ($self, $new_field, $map, $stored_value, $new_value) = @_;

  return (0, 0) unless $map eq 'FORM';

  if (($stored_value eq 'Pairs' || $stored_value eq 'Individual') && 
      $new_field =~ /^TEAM[12]/ &&
      $new_value eq 'Teams')
  {
    # Probably keep Pairs/Individual.
    if (exists $self->{HEADER}{TNAME} &&
      FScorr::form_fixable($self->{HEADER}{TNAME}, $self->bbono()))
    {
      # Definitely OK.
      return (1, $stored_value);
    }
    elsif (! exists $self->{HEADER}{TNAME} &&
      FScorr::form_number_fixable($self->bbono()))
    {
      # Probably OK.
      return (1, $stored_value);
    }
  }
  elsif ($stored_value eq 'Teams' && 
      $new_field !~ /^TEAM[12]/ &&
      ($new_value eq 'Pairs' || $new_value eq 'Individual'))
  {
    # Probably the initial value was from a TEAM field,
    # and now we get the correct value from another field.
    if (exists $self->{HEADER}{TNAME} &&
      FScorr::form_fixable($self->{HEADER}{TNAME}, $self->bbono()))
    {
      # Definitely OK.
      return (1, $new_value);
    }
    elsif (! exists $self->{HEADER}{TNAME} &&
      FScorr::form_number_fixable($self->bbono()))
    {
      # Probably OK.
      return (1, $new_value);
    }
  }

  return (0, 0);
}


sub boards_fixable_ordered
{
  my ($self, $boards_range, $header_range) = @_;

  if ($boards_range !~ /^(\d+)-(\d+)$/)
  {
    die $self->bbono() . ": Not a board range: $boards_range";
  }
  my ($newb1, $newb2) = ($1, $2);

  if ($header_range !~ /^header (\d+) (\d+)/)
  {
    die $self->bbono() . ": Not an automatic board range: $header_range";
  }
  my ($header1, $header2) = ($1, $2);
  if ($header1 != $newb1 || $header2 != $newb2)
  {
    die $self->bbono() . ": different board ranges";
  }
}


sub boards_fixable
{
  my ($self, $new_field, $map, $stored_value, $new_value) = @_;

  return (0, 0) unless $map eq 'BOARDS';

  if ($new_field eq 'BOARDS')
  {
    $self->boards_fixable_ordered($stored_value, $new_value);
    return (1, $new_value);
  }
  else
  {
    $self->boards_fixable_ordered($new_value, $stored_value);
    return (1, $stored_value);
  }

  return (0, 0);
}


sub scoring_fixable
{
  my ($self, $new_field, $map, $stored_value, $new_value) = @_;

  return (0, 0) unless $map eq 'SCORING';

  if ($new_value eq 'Patton' && 
      ($stored_value eq 'IMP' || $stored_value eq 'BAM'))
  {
    return (1, 'Patton');
  }
  elsif (($new_value eq 'IMP' || $new_value eq 'BAM') && 
      $stored_value eq 'Patton')
  {
    return (1, 'Patton');
  }

  return (0, 0);
}


sub stage_fixable
{
  my ($self, $new_field, $map, $stored_value, $new_value) = @_;

  return (0, 0) unless $map eq 'STAGE';

  # TODO When 'Round-robin' becomes a movement rather than a stage,
  # we won't need this test.
  if ($stored_value eq 'Round-robin')
  {
    (return 1, $new_value);
  }
  elsif ($new_value eq 'Round-robin')
  {
    (return 1, $stored_value);
  }
  elsif ($stored_value eq 'Knock-out' && $new_value =~ /[Ffinal]/)
  {
    (return 1, $new_value);
  }
  elsif ($new_value eq 'Knock-out' && $stored_value =~ /[Ffinal]/)
  {
    (return 1, $stored_value);
  }

  warn "STAGE: $stored_value vs $new_value";
  return (0, 0);
}


sub format_group
{
  my ($self, $group, $field, $hash, $value) = @_;

  return 0 unless exists $hash->{$field};
  my $map = $hash->{$field};
  if (exists $self->{$group}{$map} && $self->{$group}{$map} ne $value)
  {
    my ($ok, $fixed_value) = $self->form_fixable(
        $field, $map, $self->{$group}{$map}, $value);

    if ($ok)
    {
      $self->{$group}{$map} = $fixed_value;
      delete $self->{$field};
      return 1;
    }

    ($ok, $fixed_value) = $self->boards_fixable(
        $field, $map, $self->{$group}{$map}, $value);

    if ($ok)
    {
      $self->{$group}{$map} = $fixed_value;
      delete $self->{$field};
      return 1;
    }

    ($ok, $fixed_value) = $self->scoring_fixable(
        $field, $map, $self->{$group}{$map}, $value);

    if ($ok)
    {
      $self->{$group}{$map} = $fixed_value;
      delete $self->{$field};
      return 1;
    }

    ($ok, $fixed_value) = $self->stage_fixable(
        $field, $map, $self->{$group}{$map}, $value);

    if ($ok)
    {
      $self->{$group}{$map} = $fixed_value;
      delete $self->{$field};
      return 1;
    }

    warn $self->bbono() . ": $group $map duplicated, " .
      "$self->{$group}{$map} vs. $value";
  }
  $self->{$group}{$map} = $value;
  delete $self->{$field};
  return 1;
}


sub format_multi_group
{
  my ($self, $group, $field, $hash, $value) = @_;

  my $map = $hash->{$field};
  push @{$self->{$group}{$map}}, $value;
}


sub really_single_valued
{
  my ($self, $field) = @_;

  # If they are all the same, also OK.
  my $value = $self->{$field}[0];
  for my $v (@{$self->{$field}})
  {
    return 0 unless $v eq $value;
  }
  return 1;
}


sub format_two_years
{
  my ($self, $year1, $year2) = @_;

  # One must agree with DATE_ADDED and one must be adjacent.
  return 0 unless $year1 == $year2 || $year1 + 1 == $year2;

  return 0 unless exists $self->{CHAPTER}{DATE_ADDED};
  my $d = Time::Piece->strptime($self->{CHAPTER}{DATE_ADDED}, "%Y-%m-%d");
  my $y = $d->year;

  return ($y == $year1 || $y == $year2);
}


sub post_process_year
{
  my ($self, $field, $value_list) = @_;

  my $count = 1 + $#$value_list;
  if ($count == 1)
  {
    return 1 if 
      $self->format_group('CHAPTER', $field, \%CHAPTER_HASH_NEW,
      $value_list->[0]);
  }
  elsif ($count == 2)
  {
    if ($self->format_two_years($value_list->[0], $value_list->[1]))
    {
      delete $self->{$field};
      return 1;
    }
  }
  return 0;
}


sub format_boards
{
  my ($self) = @_;
  my $boards = $self->{CHAPTER}{BOARDS};
  if ($boards !~ /^header (\d+) (\d+) \| actual (\d+) (\d+) \| counts (\d+) (\d+) (\d+) \| (\d+) lines$/)
  {
    warn $self->bbono() . ": Malformed boards, $boards";
    return;
  }

  my ($h1, $h2, $a1, $a2, $c1, $c2, $c3, $lines) =
    ($1, $2, $3, $4, $5, $6, $7, $8);

  return unless $h1 == $a1 && $h2 == $a2;
  my $count = $h2-$h1+1;

  if ($c1 == $c2 && $c1 == $c3 && $c1 == $count)
  {
    $self->{CHAPTER}{BOARDS} = "$h1 $h2 | $lines lines";
  }
  elsif ($c1 == $count && $c2 == 0)
  {
    $self->{CHAPTER}{BOARDS} = "$h1 $h2 NS | $lines lines";
  }
  elsif ($c2 == $count && $c1 == 0)
  {
    $self->{CHAPTER}{BOARDS} = "$h1 $h2 EW | $lines lines";
  }
}


sub format
{
  my ($self) = @_;

  my %postproc;

  for my $field (sort keys %$self)
  {
    next if $field eq 'BBONO';
    if (exists $MULTI_VALUED_TEAM_FIELD{$field})
    {
      my ($group, $map) = @{$MULTI_VALUED_TEAM_FIELD{$field}};
      @{$self->{$group}{$map}} = @{$self->{$field}};
      delete $self->{$field};
      next;
    }

    if (exists $POST_PROCESS_FIELD{$field})
    {
      # $self gets deleted later.
      push @{$postproc{$field}}, @{$self->{$field}};
      next;
    }

    if ($#{$self->{$field}} > 0 &&
        ! $self->really_single_valued($field))
    {
      warn $self->bbono() . ": Field $field has multiple values";
      next;
    }

    my $value = $self->{$field}[0];

    next if $self->format_group('HEADER', $field, \%HEADER_HASH,
      $value);

    next if $self->format_group('CHAPTER', $field, \%CHAPTER_HASH_NEW,
      $value);

    next if $self->format_group('COUNTER', $field, \%COUNTER_HASH_NEW,
      $value);

    if ($field =~ /^TEAM1_(.+)$/)
    {
      my $map = $1;
      next if $self->format_group('TEAM1', $map, \%TEAM_HASH,
        $value);
    }

    if ($field =~ /^TEAM2_(.+)$/)
    {
      my $map = $1;
      next if $self->format_group('TEAM2', $map, \%TEAM_HASH,
        $value);
    }

    warn $self->bbono() . ": $field";
  }

  for my $field (sort keys %postproc)
  {
    my $count = 1 + $#{$postproc{$field}};
    if ($field eq 'TITLE_YEAR' || $field eq 'EVENT_YEAR')
    {
      next if $self->post_process_year($field, $postproc{$field});
      warn $self->bbono() . ": $field ($count)";
    }
    elsif ($field eq 'TITLE_DATE' || $field eq 'EVENT_DATE')
    {
      if ($count == 1)
      {
        # Should match DATE_ADDED if present.
        next if $self->format_group('CHAPTER', $field, \%CHAPTER_HASH_NEW,
          $postproc{$field}[0]);
      }

      warn $self->bbono() . ": $field ($count)";
    }
    elsif ($field eq 'TITLE_STAGE' || $field eq 'EVENT_STAGE')
    {
      my $error_flag = 0;
      for my $value (@{$postproc{$field}})
      {
        next if $self->format_group('CHAPTER', $field, \%CHAPTER_HASH_NEW,
          $value);
      }

      next unless $error_flag;
    }
    elsif ($field eq 'TITLE_TEAM1_COUNTRY' || 
        $field eq 'TITLE_TEAM2_COUNTRY')
    {
      if ($field !~ /^TITLE_(TEAM\d)_(.+)$/)
      {
        warn $self->bbono() . ": $field ($count)";
        next;
      }

      my ($team, $map) = ($1, $2);

      $self->format_multi_group($team, $map, \%TEAM_HASH,
        $postproc{$field}[0]);
      delete $self->{$field};
      next;
    }

    warn $self->bbono() . ": $field ($count)";
  }

  # It can happen that both teams are given as e.g. Women, and this
  # can be useful to determine the tournament (there may be two
  # simultaneous ones, one Open and one Women).
  for my $field (qw(GENDER AGE))
  {
    if (exists $self->{TEAM1}{$field} &&
        exists $self->{TEAM2}{$field} &&
        $self->{TEAM1}{$field}[0] eq $self->{TEAM2}{$field}[0])
    {
      $self->{HINT}{$field} = $self->{TEAM1}{$field}[0];
    }
  }

  $self->format_boards();
}


sub concat_team
{
  my ($self, $team) = @_;

  my $concat = '';
  return $concat unless exists $self->{$team};
  for my $key (sort keys %{$self->{$team}})
  {
    $concat .= join(',', @{$self->{$team}{$key}}) . '|';
  }
  return $concat;
}


sub match_letter_to_number
{
  my ($self) = @_;

  for my $field (qw(MATCH SESSION SECTION FLIGHT POOL TABLE))
  {
    next unless defined $self->{COUNTER}{$field};

    my $value = uc($self->{COUNTER}{$field});
    if ($value =~ /^[A-K]$/)
    {
      $self->{COUNTER}{$field} = ord($value) - ord('A') + 1;
    }
    elsif ($value eq 'U')
    {
      # As V "is" 5...
      $self->{COUNTER}{$field} = 4;
    }
    elsif ($value =~ /^\d+[A-D] [oO][fF] \d+$/)
    {
      $self->{COUNTER}{$field} =~ s/[A-D]//;
    }
  }
}


sub prune_using
{
  my ($self, $header, $chapter) = @_;

  $self->match_letter_to_number();

  while (my ($ekey, $evalue) = each %{$self->{HEADER}})
  {
    if (! exists $header->{$ekey})
    {
      if ($ekey eq 'TNAME')
      {
        delete $self->{HEADER}{TNAME};
        next;
      }

      if ($ekey eq 'ORDINAL')
      {
        if (exists $header->{MEET_ORDINAL} &&
          $evalue eq $header->{MEET_ORDINAL})
        {
          delete $self->{HEADER}{ORDINAL};
          next;
        }
      }

      if ($ekey eq 'NATIONALITY' && exists $header->{COUNTRY})
      {
        my $single = $whole->get_matrix_element('NATIONALITY',
          'COUNTRY', lc($evalue));
        if ($single eq $header->{COUNTRY})
        {
          delete $self->{HEADER}{NATIONALITY};
          next;
        }
      }

      if ($ekey eq 'CITY' && exists $chapter->{CITY})
      {
        if ($evalue eq $chapter->{CITY})
        {
          delete $self->{HEADER}{CITY};
          next;
        }
      }

      print $self->bbono(), ": No $ekey (", $header->{COUNTRY}, ")\n";
      next;
    }

    if ($evalue eq $header->{$ekey})
    {
      delete $self->{HEADER}{$ekey};
      next;
    }

    if ($ekey eq 'SCORING')
    {
      if (($header->{$ekey} eq 'IAF' || $header->{$ekey} eq 'Patton') &&
          $evalue eq 'IMP')
      {
        delete $self->{HEADER}{$ekey};
        next;
      }
    }

    else
    {
      warn $self->bbono() . ": Header " . $header->{$ekey} .
        " vs. $evalue";
    }
  }

  while (my ($ckey, $cvalue) = each %{$self->{CHAPTER}})
  {
    if ($ckey eq 'MONTH_DAY')
    {
      if ($self->{CHAPTER}{DATE_ADDED} =~ /$cvalue$/)
      {
        delete $self->{CHAPTER}{$ckey};
      }
      else
      {
        warn $self->bbono() . ": Chapter " . $chapter->{$ckey} .
          " vs. $cvalue";
      }
      next;
    }
    elsif ($ckey eq 'YEAR_MONTH')
    {
      if ($self->{CHAPTER}{DATE_ADDED} =~ /^$cvalue/)
      {
        delete $self->{CHAPTER}{$ckey};
      }
      else
      {
        warn $self->bbono() . ": Chapter " . $chapter->{$ckey} .
          " vs. $cvalue";
      }
      next;
    }

    next unless exists $chapter->{$ckey};
    if ($cvalue eq $chapter->{$ckey})
    {
      delete $self->{CHAPTER}{$ckey};
    }
    else
    {
      warn $self->bbono() . ": Chapter " . $chapter->{$ckey} .
        " vs. $cvalue";
    }
  }

  for my $team (qw(TEAM1 TEAM2))
  {
    while (my ($ckey, $cvalue) = each %{$self->{$team}})
    {
      next unless $ckey eq 'GENDER' || $ckey eq 'AGE';
      next unless exists $header->{$ckey};
      if ($#$cvalue == 0 && $header->{$ckey} eq $cvalue->[0])
      {
        delete $self->{$team}{$ckey};
      }
      else
      {
        # warn $self->bbono() . ": " .
          # $header->{TOURNAMENT_NAME} . ", chapter " . $header->{$ckey} .
          # " vs. $cvalue->[0]";
      }
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


sub push_datum
{
  my ($self, $date_list, $tname, $edition, $chapter,
    $header_entry, $chapter_entry) = @_;
  
  push @$date_list,
    { 
      TNAME => $tname,
      EDITION => $edition,
      CHAPTER => $chapter,
      HEADER_REF => $header_entry,
      CHAPTER_REF => $chapter_entry,
      BBOLIST => [dclone($self)]
    };
}


sub update_tournaments
{
  my ($self, $data, $tname, $edition, $chapter,
    $header_entry, $chapter_entry) = @_;

  my $date_start = $chapter_entry->{DATE_START};
  if (! exists $data->{$date_start})
  {
    $self->push_datum(\@{$data->{$date_start}},
      $tname, $edition, $chapter, $header_entry, $chapter_entry);
    return;
  }

  my $anchor = $data->{$date_start};
  for my $i (0 .. $#$anchor)
  {
    my $datum = $anchor->[$i];
    if ($datum->{TNAME} eq $tname &&
        $datum->{EDITION} eq $edition &&
        $datum->{CHAPTER} eq $chapter)
    {
      push @{$datum->{BBOLIST}}, dclone($self);
      return;
    }
  }

  $self->push_datum($anchor, 
    $tname, $edition, $chapter, $header_entry, $chapter_entry);
}


sub apply_pre_map
{
  my ($self, $pre_map) = @_;

  for my $mappable (keys %$pre_map)
  {
    if (exists $self->{COUNTER}{$mappable})
    {
      if ($pre_map->{$mappable} ne 'IGNORE')
      {
        if (exists $self->{COUNTER}{$pre_map->{$mappable}})
        {
          die "$self->{BBONO}: " . 
            "Mapping $mappable to $pre_map->{$mappable}, but exists";
        }
        $self->{COUNTER}{$pre_map->{$mappable}} =
          $self->{COUNTER}{$mappable};
      }

      delete $self->{COUNTER}{$mappable};
    }
  }
}


sub fix_of
{
  my ($self, $field_map, $of_map) = @_;

  for my $field (@$field_map)
  {
    if (! exists $of_map->{$field})
    {
      warn "Field $field has no OF map";
      warn $self->str_as_read();
      return 1;
    }

    next if $of_map->{$field} == 0;
    next unless exists $self->{COUNTER}{$field};

    my $value = $self->{COUNTER}{$field};
    if ($value =~ /^(\d+)$/)
    {
      $self->{COUNTER}{$field} .= " of " . $of_map->{$field};
    }
  }
  return 0;
}


sub check_origin
{
  my ($self, $header) = @_;

  my $origin = $header->{ORIGIN};
  for my $team (qw(TEAM1 TEAM2))
  {
    for my $field (sort keys %{$self->{$team}})
    {
      next if OGAcorr::origin_team_field_ok($origin, $field);
      next if $field eq 'AGE' || $field eq 'GENDER'; 

      my $tname = $header->{TOURNAMENT_NAME} // '';
      if ($tname &&
        OGAcorr::origin_fixable($tname, $self->bbono()))
      {
        # Definitely OK.
      }
      elsif (! $tname && OGAcorr::origin_number_fixable($self->bbono()))
      {
        die "UNTOUCHED?";
        # Probably OK.
      }
      elsif ($tname && 
        $field eq 'ORGANIZATION' && 
        OGAcorr::origin_org_ok($tname))
      {
        # Camrose has an extra host team, for example.
      }
      else
      {
        warn $self->{BBONO} . 
          ": $header->{TOURNAMENT_NAME}, $field does not match $origin";
      }
    }
  }
}


sub check_zone
{
  my ($self, $header) = @_;
  my $zone = $header->{ZONE};
  return if $zone eq 'World';

  # Don't have to be from the zone.  'Supranational' is a more
  # permissive form of 'International', so still between nations.
  # 'Transnational' is not limited to nations.
  my $origin = $header->{ORIGIN} // '';
  return if 
    $origin eq 'Supranational' || 
    $origin eq 'Transnational' || 
    $origin eq 'Invitational';

  my @list;
  push @list, @{$self->{HEADER}{COUNTRY}} 
    if exists $self->{HEADER}{COUNTRY};
  push @list, @{$self->{TEAM1}{COUNTRY}} 
    if exists $self->{TEAM1}{COUNTRY};
  push @list, @{$self->{TEAM2}{COUNTRY}} 
    if exists $self->{TEAM2}{COUNTRY};

  for my $country (@list)
  {
    next if OGAcorr::zone_country_ok($zone, $country);

    if ( ! OGAcorr::origin_number_fixable($self->bbono()))
    {
      warn $self->{BBONO} . 
        ": $header->{TOURNAMENT_NAME}, $country does not match ZONE $zone";
    }
  }
}


sub check_gender_age
{
  my ($self, $header, $chapter) = @_;

  my $tname = $header->{TOURNAMENT_NAME} // '';
  my $year = $chapter->{YEAR} // '';

  return if OGAcorr::origin_number_fixable($self->bbono());

  for my $field (qw(GENDER AGE))
  {
    next unless exists $header->{$field};
    my $header_value = $header->{$field};

    for my $team (qw(TEAM1 TEAM2))
    {
      next unless exists $self->{$team}{$field};
      if ($#{$self->{$team}{$field}} > 0)
      {
        warn $self->{BBONO} . 
          ": $tname, multi-valued $field read from BBO";
        next;
      }
      my $value = $self->{$team}{$field}[0];
      
      next if $field eq 'AGE' && 
        OGAcorr::age_special($tname, $year, $value);
      next if $field eq 'GENDER' && 
        OGAcorr::gender_special($tname, $year, $value);

      if ($value ne $header_value)
      {
        warn $self->{BBONO} . 
          ": $tname, $value does not match header $header_value";
      }
    }
  }
}


sub check_fields
{
  my ($self, $header, $chapter) = @_;

  if (exists $header->{ORIGIN} &&
      OGAcorr::origin_checkable($header->{ORIGIN}))
  {
    $self->check_origin($header);
  }

  if (exists $header->{ZONE})
  {
    $self->check_zone($header);
  }

  $self->check_gender_age($header, $chapter);
}


sub spaceship
{
  my ($self, $other, $priorities) = @_;

  # This is a sorting operator.
  for my $field (@$priorities)
  {
    if (exists $self->{COUNTER}{$field})
    {
      if (! exists $other->{COUNTER}{$field})
      {
        # Empty is ranked before full.
        return 1;
      }
      else
      {
        my $value_self = $self->{COUNTER}{$field};
        my $value_other = $other->{COUNTER}{$field};

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
    elsif (exists $other->{COUNTER}{$field})
    {
      # Empty is ranked before full.
      return -1;
    }
  }

  my $d0 = Time::Piece->strptime($self->{CHAPTER}{DATE_ADDED}, "%Y-%m-%d");
  my $d1 = Time::Piece->strptime($other->{CHAPTER}{DATE_ADDED}, "%Y-%m-%d");
  return -1 if ($d0 < $d1);
  return 1 if ($d1 < $d0);

  return $self->{BBONO} <=> $other->{BBONO};
}


sub header_field
{
  my ($self, $field) = @_;
  return $self->{HEADER}{$field} // '';
}


sub chapter_field
{
  my ($self, $field) = @_;
  return $self->{CHAPTER}{$field} // '';
}


sub get_counter_ref
{
  my ($self) = @_;
  return $self->{COUNTER};
}


sub delete_counter
{
  my ($self, $counter) = @_;
  delete $self->{COUNTER}{$counter};
}


sub bbono
{
  my ($self) = @_;
  return $self->{BBONO};
}


sub str_as_read
{
  my ($self) = @_;

  my $s;
  $s = "BBONO $self->{BBONO}\n";

  for my $ckey (@CHAPTER_FIELDS_NEW)
  {
    next if $ckey eq 'YEAR';
    next unless exists $self->{CHAPTER}{$ckey};
    $s .= "$ckey " . $self->{CHAPTER}{$ckey} . "\n";
  }

  for my $ckey (keys %{$self->{CHAPTER}})
  {
    next if exists $SKIP_BBO{$ckey};
    warn $self->{BBONO} . ": $ckey in CHAPTER?";
  }

  for my $ckey (sort keys %{$self->{COUNTER}})
  {
    $s .= "$ckey " . $self->{COUNTER}{$ckey} . "\n";
  }

  for my $order (qw(TEAM1 TEAM2))
  {
    for my $key (sort keys %{$self->{$order}})
    {
      my $ok = "${order}_$key ";
      for my $v (@{$self->{$order}{$key}})
      {
        $s .= "$ok$v\n";
      }
    }
  }

  return "$s\n";
}

1;
