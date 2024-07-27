#!perl

package Event::Interpret;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Storable 'dclone';

our @ISA = qw(Exporter);
our @EXPORT = qw(interpret);

use lib './Connections';

use Connections::Matrix;
use Event::Ematch;
use Util;

my @ACCEPT_FIELDS = qw(AGE CITY COLOR CLUB DATE FORM GENDER HALF
  MONTH_DAY MOVEMENT ORIGIN PLACE QUARTER ROUND SCORING SECTION 
  SEGMENT SESSION SET SPONSOR STAGE STANZA WEEK WEEKDAY WEEKEND 
  YEAR YEAR_MONTH);

my @KILL_FIELDS = qw(ROOM);

# ROUND SEGMENT SESSION STANZA TABLE

my %ACCEPT = map { $_ => 1 } @ACCEPT_FIELDS;
my %KILL = map { $_ => 1 } @KILL_FIELDS;


# BBOVG numbers for which special occurrences are OK.
my %EVENT_MATCHES_ROUND;
my %EVENT_MATCHES_SEGMENT;

sub init_hashes
{
  Event::Ematch::set_ematch_round(\%EVENT_MATCHES_ROUND);
  Event::Ematch::set_ematch_segment(\%EVENT_MATCHES_SEGMENT);
}


sub post_process_single
{
  my ($chains, $bbono) = @_;

  # Check for a last chain with only a numeral.
  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token0 = $chain->check_out(0);
    my $field0 = $token0->field();

    if ($field0 eq 'ROUND' &&
      exists $EVENT_MATCHES_ROUND{$bbono})
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($field0 eq 'SEGMENT' &&
      exists $EVENT_MATCHES_SEGMENT{$bbono})
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif (exists $ACCEPT{$field0})
    {
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    elsif (exists $KILL{$field0})
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($field0 eq 'BERTH' || $field0 eq 'DAY')
    {
      if ($token0->value() =~ /^\d+$/)
      {
        $chain->complete_if_last_is(0, 'EXPLAINED');
      }
      else
      {
        # Probably just 'Berth'.
        $chain->complete_if_last_is(0, 'KILLED');
      }
    }
    elsif ($field0 eq 'BOARDS')
    {
      if ($token0->value() =~ /^\d+-\d+$/)
      {
        $chain->complete_if_last_is(0, 'EXPLAINED');
      }
      else
      {
        # Probably just '16 boards'.
        $chain->complete_if_last_is(0, 'KILLED');
      }
    }
    elsif ($field0 eq 'PARTICLE')
    {
      if ($token0->value() =~ /^vs$/)
      {
        # Probably two teams that were recognized from TEAMS,
        # leaving only the 'vs'.
        $chain->complete_if_last_is(0, 'KILLED');
      }
    }
    elsif ($field0 eq 'TIME')
    {
      if ($token0->value() eq 'Afternoon' ||
          $token0->value() eq 'Evening' ||
          $token0->value() eq 'Night')
      {
        $chain->complete_if_last_is(0, 'KILLED');
      }
      else
      {
        # Probably just '16 boards'.
        $chain->complete_if_last_is(0, 'EXPLAINED');
      }
    }
  }
}


sub post_process_some_iterators
{
  my ($chains) = @_;

  for my $cno (0 .. $#$chains)
  {
    next unless $cno > 0; # Skip the first chain.

    my $chain = $chains->[$cno];
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq 'STANZA' || 
      $field eq 'QUARTER' ||
      $field eq 'ROUND' ||
      $field eq 'SEGMENT' ||
      $field eq 'SESSION' ||
      $field eq 'SET';

    next unless lc($token->value()) eq lc($field);

    # So STANZA Stanza, or QUARTER Quarter.
    # Could be that there is a Final in the chain before.

    my $chain0 = $chains->[$cno-1];
    next unless $chain0->last() == 0;

    my $token0 = $chain0->check_out(0);
    next unless lc($token0->value()) eq 'final';

    # So 'Final', 'Stanza' without any number.
    $token->set_general('MARKER', $field, 'last');
    $chain->complete_if_last_is(0, 'EXPLAINED');

    splice(@$chains, $cno-1, 1);
    return;
  }
}


sub post_process_countries
{
  my ($chains, $teams) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq 'COUNTRY';

    my $text = $token->text();
    if (lc($text) eq 'fin')
    {
      # Normally 'Final', not 'Finland' in EVENT.
      $token->set_general('SINGLETON', 'STAGE', 'Final');
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return;
    }

    my $value = $token->value();
    if ($value eq $teams->{TEAM1} || $value eq $teams->{TEAM2})
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($value eq 'Bermuda')
    {
      # Almost always Bermuda Bowl.  Even in the one case where it
      # isn't, it still is... (Year 2000).
      $token->set_general('SINGLETON', 'TNAME', 'Bermuda Bowl');
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    else
    {
      # It's a normal country.
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
  }
}


sub post_process_title
{
  my ($chains, $chains_title, $bbono) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    if ($field eq 'TNAME')
    {
      my $value = $token->value();

      my $cno;
      my $tname = find_field_in_chains($chains_title, 'TNAME', \$cno);
      if (! $tname)
      {
        # Move the TNAME from here to TITLE.
        $chain->complete_if_last_is(0, 'EXPLAINED');
        push @$chains_title, dclone($chain);
        $chain->complete_if_last_is(0, 'KILLED');

      }
      elsif ($value eq $tname)
      {
        # Redundant with TITLE.
        $chain->complete_if_last_is(0, 'KILLED');
      }
      else
      {
        print "$bbono: DIFFER $field, $value vs TNAME $tname\n";
      }
    }
  }
}


sub post_process_letters
{
  my ($chains) = @_;

  my $chain = $chains->[0];
  return if $chain->status() eq 'KILLED';
  return unless $chain->last() == 0;

  my $token = $chain->check_out(0);
  return unless $token->category() eq 'AMBIGUOUS';
  
  my $field = $token->field();

  if ($field eq 'G')
  {
    $token->set_general('SINGLETON', 'AGE', 'Juniors');

    my $token1 = Token->new();
    $token1->copy_origin_from($token);
    $token1->set_general('SINGLETON', 'GENDER', 'Women');

    my $chain1 = Chain->new();
    $chain1->append($token1);
    $chain1->complete_if_last_is(0, 'EXPLAINED');
    splice(@$chains, 1, 0, $chain1);
  }
  elsif ($field eq 'J')
  {
    $token->set_general('SINGLETON', 'AGE', 'Juniors');
  }
  elsif ($field eq 'K')
  {
    $token->set_general('SINGLETON', 'AGE', 'Kids');
  }
  elsif ($field eq 'O')
  {
    $token->set_general('SINGLETON', 'AGE', 'Open');

    my $token1 = Token->new();
    $token1->copy_origin_from($token);
    $token1->set_general('SINGLETON', 'GENDER', 'Open');

    my $chain1 = Chain->new();
    $chain1->append($token1);
    $chain1->complete_if_last_is(0, 'EXPLAINED');
    splice(@$chains, 1, 0, $chain1);
  }
  elsif ($field eq 'S')
  {
    $token->set_general('SINGLETON', 'AGE', 'Seniors');
  }
  elsif ($field eq 'W')
  {
    $token->set_general('SINGLETON', 'GENDER', 'Women');
  }
  elsif ($field eq 'Y')
  {
    $token->set_general('SINGLETON', 'AGE', 'Youngsters');
  }
  else
  {
    die "Unknown ambiguous letter: $field";
  }

  $chain->complete_if_last_is(0, 'EXPLAINED');
}


sub interpret
{
  my ($whole, $chains, $chains_title, $teams, $scoring, $bbono) = @_;

  post_process_single($chains, $bbono);
  post_process_some_iterators($chains);
  post_process_countries($chains, $teams);
  post_process_title($chains, $chains_title, $bbono);
  post_process_letters($chains);
}

1;
