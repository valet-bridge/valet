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

my @ACCEPT_FIELDS = qw(AGE CITY COLOR CLUB DATE FORM GENDER GROUP
  HALF MATCH MONTH_DAY MOVEMENT ORGANIZATION ORIGIN PERSON PLACE 
  QUARTER ROF ROUND SCORING SECTION SEGMENT SESSION SET SPONSOR 
  STAGE STANZA TABLE WEEK WEEKDAY WEEKEND YEAR YEAR_MONTH);

my @KILL_FIELDS = qw(ROOM);

# ROUND SEGMENT SESSION STANZA TABLE

my %ACCEPT = map { $_ => 1 } @ACCEPT_FIELDS;
my %KILL = map { $_ => 1 } @KILL_FIELDS;

# Default iterators for some tournaments.
# TODO Probably I will label up all TNAME tournaments later.

my %TITERATORS = (
   'Anatolian Club Qualifying' => 'ROUND',
   'ASEAN Club Championship' => 'ROUND',
   'Buffett Cup' => 'ROUND',
   'Camrose' => 'ROUND',
   "European Champions' Cup" => 'ROUND',
   'European Mixed Junior Pairs' => 'ROUND',
   'European Open Bridge Championship' => 'ROUND',
   'European Small Federation Games' => 'ROUND',
   'European Youth Bridge Teams Championship' => 'ROUND',
   'Finnish Pairs Championship' => 'ROUND',
   'Four Nations Cup' => 'ROUND',
   'FOSS-Tren' => 'ROUND',
   'Gelibolu Peace Cup' => 'ROUND',
   'Goksu-Yalikavak Pairs' => 'ROUND',
   "Gro's Supercup" => 'ROUND',
   'Guangdong Club Championship' => 'ROUND',
   'Higson Cup' => 'ROUND',
   'Hong Kong Inter-City' => 'ROUND',
   'IMSA Cup' => 'ROUND',
   'Israel Open Pairs' => 'ROUND',
   'Lady Milne Trophy' => 'STANZA',
   'Madeira Swiss Teams' => 'ROUND',
   'Mondial de Deauville' => 'ROUND',
   'Nordic Championship' => 'ROUND',
   'Nordic Junior Championship' => 'ROUND',
   'Nordic Junior Pairs' => 'ROUND',
   'Norwegian Mixed Pairs' => 'ROUND',
   'Olrud Easter Mixed Pairs' => 'ROUND',
   'Olrud Easter Pairs' => 'ROUND',
   'Olrud Easter Teams' => 'ROUND',
   'Olrud Easter Swiss Teams' => 'ROUND',
   'Pesta Sukan' => 'ROUND',
   'Portuguese Open Teams' => 'ROUND',
   'Smirnov Cup' => 'ROUND',
   'Spanish Central Zone Teams' => 'ROUND',
   'Thrace Club Teams' => 'ROUND',
   'World Youth Bridge Congress' => 'ROUND'
);

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
      $field eq 'MATCH' ||
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


sub post_process_meet
{
  my ($chains, $chains_title, $bbono) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq 'MEET';

    my $value = $token->value();

    my $cno;
    my $meet = find_field_in_chains($chains_title, 'MEET', \$cno);
    if (! $meet)
    {
      # Move the MEET from here to TITLE.
      $chain->complete_if_last_is(0, 'EXPLAINED');
      push @$chains_title, dclone($chain);
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($value eq $meet)
    {
      # Redundant with TITLE.
      $chain->complete_if_last_is(0, 'KILLED');
    }
    else
    {
      print "$bbono: DIFFER $field, $value vs MEET $meet\n";
    }
  }
}


sub post_process_tname
{
  my ($chains, $chains_title, $bbono) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq 'TNAME';

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


sub post_process_tword
{
  my ($chains, $chains_title, $bbono) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq 'TWORD';

    my $value = $token->value();
    if ($value eq 'First Half')
    {
      $token->set_general('ITERATOR', 'HALF', 1);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    elsif ($value eq 'Second Half')
    {
      $token->set_general('ITERATOR', 'HALF', 2);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    elsif ($value eq 'Open Room')
    {
      $token->set_general('ITERATOR', 'ROOM', 'Open');
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    elsif ($value eq 'Closed Room')
    {
      $token->set_general('ITERATOR', 'ROOM', 'Closed');
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    elsif ($value eq 'Second Place')
    {
      $token->set_general('ITERATOR', 'PLACE', 2);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    elsif ($value eq 'Championship' || $value eq 'Tournament')
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
    else
    {
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
  }
}


sub post_process_match
{
  my ($chains, $teams) = @_;

  return unless $#$chains > 0;
  for my $cno (1 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq 'MATCH';
    next unless $token->value() eq 'Match';

    # Try to fix MATCH Match.
    my $chain_prev = $chains->[$cno-1];
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token_prev = $chain_prev->check_out(0);
    my $field_prev = $token_prev->field();
    next unless $field_prev eq 'MAJOR_MINOR';

    my $value_prev = $token_prev->value();
    $value_prev =~ /^(\d+)\+(\d+)$/;
    my ($first, $second) = ($1, $2);

    # So probably the MINOR is really the match number.
    $token->set_general('MARKER', 'MATCH', $second);
    $chain->complete_if_last_is(0, 'EXPLAINED');

    $token_prev->set_general('COUNTER', 'NUMERAL', $first);
    $chain_prev->complete_if_last_is(0, 'COMPLETE');
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


sub post_process_stand_alone_number
{
  # There is one chain and it's a number, without a direct indication
  # of the name of the iterator.  We can use the title to guess with.

  my ($chain, $chains_title, $bbono) = @_;
  
  my $token = $chain->check_out(0);
  my $field = $token->field();
  my $value = $token->value();

  my $cno;
  my $tname = find_field_in_chains($chains_title, 'TNAME', \$cno);
  if ($tname && $field eq 'NUMERAL')
  {
    if (exists $TITERATORS{$tname})
    {
      my $iter = $TITERATORS{$tname};
      $token->set_general('MARKER', $iter, $value);
    }
    else
    {
      print "TODO $bbono, $tname: $field $value\n";
    }
  }
}


sub post_process_single_numerals
{
  my ($chains, $chains_title, $bbono) = @_;

  # Find a single non-final chain.
  my $cno_single;
  my $count_complete = 0;
  my $count_active = 0;
  for my $cno (0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    my $status = $chain->status();
    next if $status eq 'KILLED';
    $count_active++;
    next if $status eq 'EXPLAINED';
    $count_complete++;
    $cno_single = $cno;
  }
  return unless $count_complete == 1;

  my $chain = $chains->[$cno_single];
  return unless $chain->last() == 0;

  if ($count_active == 1 && $count_complete == 1)
  {
    post_process_stand_alone_number($chain, $chains_title, $bbono);
  }

  return;

  my $token = $chain->check_out(0);
  my $field = $token->field();


  if ($field eq 'NUMERAL')
  {
    if ($cno_single == 0)
    {
        print "TODO0\n";
    }
    else
    {
      my $chain_prev = $chains->[$cno_single-1];
      my $status_prev = $chain_prev->status();
      if ($status_prev eq 'KILLED')
      {
        print "TODO1\n";
      }
      elsif ($chain_prev->last() > 0)
      {
        print "TODO2\n";
      }
      else
      {
        my $token_prev = $chain_prev->check_out(0);
        my $value_prev = $token_prev->value();

        if ($value_prev eq 'Round-robin')
        {
          $token->set_general('ITERATOR', 'ROUND', $token->value());
          $chain->complete_if_last_is(0, 'EXPLAINED');
        }
      }
    }
  }
}


sub interpret
{
  my ($whole, $chains, $chains_title, $teams, $scoring, $bbono) = @_;

  post_process_single($chains, $bbono);
  post_process_some_iterators($chains);
  post_process_countries($chains, $teams);
  post_process_meet($chains, $chains_title, $bbono);
  post_process_tname($chains, $chains_title, $bbono);
  post_process_tword($chains, $chains_title, $bbono);
  post_process_match($chains, $bbono);
  post_process_letters($chains);

  post_process_single_numerals($chains, $chains_title, $bbono);
}

1;
