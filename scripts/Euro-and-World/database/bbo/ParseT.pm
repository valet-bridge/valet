#!perl

package ParseT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib '..';

use DateCalc;
use EntryT;
use Tournaments::Germany;


my %DIVISIONS =
(
  GERMANY => \&Tournaments::Germany::set_links
);

my @MEET_FIELDS = qw(ORGANIZATION COUNTRY CITY ORIGIN ZONE);

my @MEET_EDITION_FIELDS = qw(YEAR CITY);
my @MEET_EDITION_PREFIXED_FIELDS = qw(ORDINAL DATE_START DATE_END);

my @TOURNAMENT_EDITION_PREFIXED_FIELDS = qw(ORDINAL);
my @TOURNAMENT_CHAPTER_FIELDS = qw(YEAR);

my @TOURNAMENT_FIELDS = qw(ORGANIZATION COUNTRY CITY ORIGIN ZONE
  FORM SCORING GENDER AGE);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub set_parse_links
{
  my ($self, $meets, $tournaments, $key) = @_;

  for my $meet (sort keys %$meets)
  {
    for my $mfield (@MEET_FIELDS)
    {
      if (exists $meets->{$meet}{$mfield})
      {
        $self->{MEET}{$meet}{$mfield} = $meets->{$meet}{$mfield};
      }
    }

    %{$self->{MEET}{$meet}{EDITIONS}} = %{$meets->{$meet}{EDITIONS}};
  }

  for my $tournament (sort keys %$tournaments)
  {
    for my $tfield (@TOURNAMENT_FIELDS)
    {
      if (exists $tournaments->{$tournament}{$tfield})
      {
        $self->{TOURNAMENT}{$tournament}{$tfield} = 
          $tournaments->{$tournament}{$tfield};
      }
    }

    %{$self->{TOURNAMENT}{$tournament}{EDITIONS}} = 
      %{$tournaments->{$tournament}{EDITIONS}};
  }
}


sub init_links
{
  my ($self) = @_;
  my $callback_method = sub { $self->set_parse_links(@_); };

  while (my ($key, $set_method) = each %DIVISIONS)
  {
    $set_method->($callback_method);
    
  }
}


sub get_edition_and_chapter
{
  my ($self, $tname, $date_added) = @_;
  return ('', '') unless exists $self->{TOURNAMENT}{$tname};
  my $t = $self->{TOURNAMENT}{$tname};

  my $target = DateCalc->new();
  $target->set_by_field($date_added);

  my $lowest_dist = 9999;
  my ($lowest_edition, $lowest_chapter);
  for my $edition_str (keys %{$t->{EDITIONS}})
  {
    my $edition = $t->{EDITIONS}{$edition_str};
    for my $chapter_str (keys %{$edition->{CHAPTERS}})
    {
      my $chapter = $edition->{CHAPTERS}{$chapter_str};

      next unless ref($chapter) eq 'HASH';

      my $dist = $target->distance(
        $chapter->{DATE_START},
        $chapter->{DATE_END});
    
      if ($dist < $lowest_dist)
      {
        $lowest_dist = $dist;
        $lowest_edition = $edition_str;
        $lowest_chapter = $chapter_str;
      }
    }
  }

  if ($lowest_dist <= 7)
  {
    # Within one week
    return ($lowest_edition, $lowest_chapter);
  }
  else
  {
    warn "Not found (dist $lowest_dist): $tname, $date_added";
    return ('', '');
  }
}


sub transfer_field
{
  # Not a class method.
  my ($fields, $field, $value) = @_;

  return unless defined $value;

  if (exists $fields->{$field} && $fields->{$field} ne $value)
  {
    die "Trying to reset from $fields->{$field} to $value";
  }

  $fields->{$field} = $value;
}


sub set_header_entry
{
  my ($self, $tname, $edition_str, $chapter_str) = @_;
  my $entry = EntryT->new();

  my %fields;

  # In principle we can override meeting-level data with other data,
  # but I'd like to keep it sparse.

  my $tournament = $self->{TOURNAMENT}{$tname};
  my $t_edition = $tournament->{EDITIONS}{$edition_str};
  my $t_chapter = $t_edition->{CHAPTER}{$chapter_str};

  if (exists $t_edition->{MEET})
  {
    my $meet_str = $t_edition->{MEET};
    my $meet = $self->{MEET}{$meet_str};
    my $m_edition = $meet->{EDITIONS}{$edition_str};

    for my $mfield (@MEET_FIELDS)
    {
      transfer_field(\%fields, $mfield, $meet->{$mfield});
    }

    for my $mfield (@MEET_EDITION_FIELDS)
    {
      transfer_field(\%fields, $mfield, $meet->{$mfield});
    }

    for my $mfield (@MEET_EDITION_PREFIXED_FIELDS)
    {
      transfer_field(\%fields, 'MEET_' . $mfield, $meet->{$mfield});
    }
  }

  for my $tfield (@TOURNAMENT_FIELDS)
  {
    if (exists $tournament->{$tfield})
    {
      transfer_field(\%fields, $tfield, $tournament->{$tfield});
    }
  }

  for my $tfield (@TOURNAMENT_EDITION_PREFIXED_FIELDS)
  {
    if (exists $t_edition->{$tfield})
    {
      transfer_field(\%fields, 'TOURNAMENT_' . $tfield, 
        $t_edition->{$tfield});
    }
  }

  for my $tfield (@TOURNAMENT_CHAPTER_FIELDS)
  {
    if (exists $t_chapter->{$tfield})
    {
      transfer_field(\%fields, $tfield, $t_chapter->{$tfield});
    }
  }

  for my $dfield (qw(DATE_START DATE_END))
  {
    if (exists $t_chapter->{$dfield} &&
        exists $fields{MEET_DATE_START} &&
        exists $fields{MEET_DATE_END})
    {
      my $datecalc = DateCalc->new();
      $datecalc->set_by_field($t_chapter->{$dfield});
      if (! date_calc->inside($fields{MEET_DATE_START},
        $fields{MEET_DATE_END}))
      {
        die "$t_chapter->{$dfield} is not inside " .
          $fields{MEET_DATE_START} . " to " .
          $fields{MEET_DATE_END};
      }
    }
  }

  transfer_field(\%fields, 'DATE_START', $t_chapter->{DATE_START});
  transfer_field(\%fields, 'DATE_END', $t_chapter->{DATE_END});
}


1;
