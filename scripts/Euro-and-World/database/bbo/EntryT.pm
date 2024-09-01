#!perl

package EntryT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';

my @HEADER_FIELDS = qw(
  TOURNAMENT_ORDINAL
  TOURNAMENT_NAME
  TOURNAMENT_CITY
  ZONE
  ORIGIN
  COUNTRY
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
  WEEKEND
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
  "Gro's Supercup" => [15059, 15070, 
    19725, 19732, 19745,
    24988, 24989, 29535, 29536, 29540, 29541, 29548, 29549,
    34123, 34129, 34132, 34133,
    39117, 39120, 39145, 39146, 39151,
    44699, 44700, 44702, 44704, 44709, 44710, 44723, 44724,
    44730, 44731, 44736, 44737, 44738, 44739, 44764, 44765, 44766]
);

my %FORM_CORRECTIONS = (
  # Says Team 1, Team 2 in BBO file, but is pairs
  'German Open Pairs' => [
    11914, 11917, 11920, 11921, 11932, 11933,
    21016, 21039, 
    26012, 26020, 26027,
    31218, 31228, 31250],
  'German Women Pairs' => [26011, 26021, 26028],
  "Gro's Supercup" => [
    15059, 15070, 
    19725, 19732, 19745,
    24988, 24989,
    29535, 29536, 29540, 29541, 29548, 29549,
    34116, 34117, 34121, 34123, 34129, 34132, 34133,
    44699, 44700, 44702, 44704, 44709, 44710, 44723, 44724,
    44730, 44731, 44736, 44737, 44738, 44739, 44764, 44765, 44766]
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

    if ($read eq 'P' && $value eq 'IMP')
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
    if ($read eq 'Teams' && $value eq 'Pairs')
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


sub fix_list_tags
{
  my ($self) = @_;

  $self->delete_list_tag_if('TITLE_TWORD', 'Championship');

  $self->transfer_list_tag('DATE_ADDED', 'DATE');
  $self->transfer_list_tag('EVENT_DATE', 'DATE');

  $self->transfer_list_tag('EVENT_SESSION', 'SESSION');

  $self->transfer_list_tag('EVENT_SEGMENT', 'SEGMENT');

  $self->transfer_list_tag('EVENT_HALF', 'HALF');

  $self->transfer_list_tag('TITLE_ROUND', 'ROUND');
  $self->transfer_list_tag('EVENT_ROUND', 'ROUND');

  $self->transfer_list_tag('TITLE_YEAR', 'YEAR');

  $self->transfer_list_tag('TITLE_PHASE', 'PHASE');

  $self->transfer_list_tag('TITLE_TABLE', 'TABLE');
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

  for my $key (qw(YEAR DATE PHASE SESSION ROUND SEGMENT TABLE))
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
    warn "Unprinted field $key" unless exists $check_fields->{$key};
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
