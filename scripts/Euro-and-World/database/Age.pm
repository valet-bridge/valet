#!perl

package Age;

use strict;
use warnings;
use Exporter;
use v5.10;

my @AGE_LIST = qw(Open None Seniors U31 U28 U26 U21 U16 U13 Multiple);

my %AGES = map { $_ => 1} @AGE_LIST;

my %GUESSES =
(
  Juniors => 'U26',
  Youngsters => 'U21',
  Kids => 'U16',
  Schools => 'U13',
  Girls => 'U26'
);


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $AGES{$text} ? 1 : 0;
}


sub guess
{
  my ($self, $text) = @_;
  if (exists $AGES{$text})
  {
    return $text;
  }
  elsif (exists $GUESSES{$text})
  {
    return $GUESSES{$text};
  }
  else
  {
    die "Can't guess Age of $text";
  }
}


sub make_constraint
{
  my ($self, $year, $restriction, $field_ref, $value_ref) = @_;
  return 0 if 
    $restriction eq 'Open' || 
    $restriction eq 'None' || 
    $restriction eq 'Multiple';

  die "Unknown restriction $restriction" unless defined $AGES{$restriction};

  if ($restriction =~ /^U(\d+)$/)
  {
    # This is actually more general and accommodates other Uxx's.
    my $max_age = $1;

    # The rule is that the player must not turn $max_age by 31.12
    # of the current $year.  So as an extreme example, a U1 player
    # must be born within the current $year.
    $$field_ref = 'EARLIEST';
    $$value_ref = $year - $max_age + 1;
    return 1;
  }
  elsif ($restriction eq 'Seniors')
  {
    # The WBF decided in 2017 that a player must be at most:
    # - Starting 2018, 61 in year of play
    # - Starting 2020, 62 in year of play
    # - Starting 2022, 63 in year of play
    # - Starting 2024, 64 in year of play
    # - Starting 2026, 65 in year of play
    # Before that, it was probably 60 in year of play.

    my $limit;
    if ($year >= 2026)
    {
      $limit = 65;
    }
    elsif ($year >= 2018)
    {
      $limit = 61 + (($year - 2018) >> 1);
    }
    elsif ($year >= 2009)
    {
      $limit = 60;
    }
    elsif ($year >= 2005)
    {
      $limit = 56 + $year - 2005;
    }
    else
    {
      $limit = 55;
    }

    # So as an extreme example, if someone must be at least 1 year old
    # in the year of play, they must have been born by the previous year.

    $$field_ref = 'LATEST';
    $$value_ref = $year - $limit;
    return 1;
  }

  return 0;
}


1;
