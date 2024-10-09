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

my $TRACE = 0;

use Connections::Matrix;
use Event::Ematch;
use Util;

my @ACCEPT_FIELDS = qw(AGE CITY COLOR CLUB DATE FORM GENDER GROUP
  HALF MATCH MONTH_DAY MOVEMENT ORGANIZATION ORIGIN PERSON PLACE 
  QUARTER REGION ROF ROUND SCORING SECTION SEGMENT SESSION SET SPONSOR 
  STAGE STANZA TABLE WEEK WEEKDAY WEEKEND YEAR YEAR_MONTH);

my @KILL_FIELDS = qw(ROOM);

# ROUND SEGMENT SESSION STANZA TABLE

my %ACCEPT = map { $_ => 1 } @ACCEPT_FIELDS;
my %KILL = map { $_ => 1 } @KILL_FIELDS;

# Default iterators for some tournaments.
# TODO Probably I will label up all TNAME tournaments later.

my %ITERATORS_MAJOR_MINOR = (
  'APBF Championships' =>  ['SESSION', 'ROUND'],
  'APBF Youth Championships' =>  ['SESSION', 'ROUND'],
  'Asia Cup' => ['SESSION', 'ROUND'],
  "Chairman's Cup" => ['SEGMENT', ''],
  'China First League' => ['SESSION', 'ROUND'],
  'Codan Cup' => ['ROUND', 'SEGMENT'],
  'Indian Senior Trials' => ['SESSION', 'ROUND'],
  'Norwegian Club Teams' =>  ['ROUND', 'SEGMENT'],
  'Norwegian Premier League' => ['ROUND', 'SEGMENT'],
  'Sao Paulo State Championship' => ['SEGMENT', ''],
  'South American Women Teams' => ['SEGMENT', ''],
  'South American Open Teams' => ['SEGMENT', ''],
  'South American Team Championship' => ['SEGMENT', ''],
  'Southeast Asian Games' => ['SESSION', 'ROUND'],
  'Swedish District Teams' => ['ROUND', 'SEGMENT'],
  'Swedish Open Teams' => ['ROUND', 'SEGMENT'],
  'Swedish Premier League' =>  ['ROUND', 'SEGMENT'],
  'Taiwanese Senior Trials' => ['SESSION', 'ROUND'],
  'Turkish Club Championship' => ['ROUND', 'SEGMENT'],
  'Turkish Open Trials' => ['SEGMENT', ''],
  'Yeh Bros Cup' => ['ROUND', 'SEGMENT']
);

my %ITERATORS_S_FOR_SENIORS = (
  'European Bridge Teams Championship' => 1,
  'World Mind Games' => 1
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
      $chain->complete('KILLED');
    }
    elsif ($field0 eq 'SEGMENT' &&
      exists $EVENT_MATCHES_SEGMENT{$bbono})
    {
      $chain->complete('KILLED');
    }
    elsif (exists $ACCEPT{$field0})
    {
      $chain->complete('EXPLAINED');
    }
    elsif (exists $KILL{$field0})
    {
      $chain->complete('KILLED');
    }
    elsif ($field0 eq 'BERTH' || $field0 eq 'DAY')
    {
      if ($token0->value() =~ /^\d+$/)
      {
        $chain->complete('EXPLAINED');
      }
      else
      {
        # Probably just 'Berth'.
        $chain->complete('KILLED');
      }
    }
    elsif ($field0 eq 'BOARDS')
    {
      if ($token0->value() =~ /^\d+-\d+$/)
      {
        $chain->complete('EXPLAINED');
      }
      else
      {
        # Probably just '16 boards'.
        $chain->complete('KILLED');
      }
    }
    elsif ($field0 eq 'PARTICLE')
    {
      if ($token0->value() =~ /^vs$/)
      {
        # Probably two teams that were recognized from TEAMS,
        # leaving only the 'vs'.
        $chain->complete('KILLED');
      }
    }
    elsif ($field0 eq 'TIME')
    {
      if ($token0->value() eq 'Afternoon' ||
          $token0->value() eq 'Evening' ||
          $token0->value() eq 'Night')
      {
        $chain->complete('KILLED');
      }
      else
      {
        # Probably just '16 boards'.
        $chain->complete('EXPLAINED');
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
    $chain->complete('EXPLAINED');

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
      $chain->complete('EXPLAINED');
      return;
    }

    my $value = $token->value();
    if ($value eq $teams->{TEAM1} || $value eq $teams->{TEAM2})
    {
      $chain->complete('KILLED');
    }
    elsif ($value eq 'Bermuda')
    {
      # Almost always Bermuda Bowl.  Even in the one case where it
      # isn't, it still is... (Year 2000).
      $token->set_general('SINGLETON', 'TNAME', 'Bermuda Bowl');
      $chain->complete('EXPLAINED');
    }
    else
    {
      # It's a normal country.
      $chain->complete('EXPLAINED');
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
      $chain->complete('EXPLAINED');
      push @$chains_title, dclone($chain);
      $chain->complete('KILLED');
    }
    elsif ($value eq $meet)
    {
      # Redundant with TITLE.
      $chain->complete('KILLED');
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
      $chain->complete('EXPLAINED');
      push @$chains_title, dclone($chain);
      $chain->complete('KILLED');
    }
    elsif ($value eq $tname)
    {
      # Redundant with TITLE.
      $chain->complete('KILLED');
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
      $chain->complete('EXPLAINED');
    }
    elsif ($value eq 'Second Half')
    {
      $token->set_general('ITERATOR', 'HALF', 2);
      $chain->complete('EXPLAINED');
    }
    elsif ($value eq 'Open Room')
    {
      $token->set_general('ITERATOR', 'ROOM', 'Open');
      $chain->complete('EXPLAINED');
    }
    elsif ($value eq 'Closed Room')
    {
      $token->set_general('ITERATOR', 'ROOM', 'Closed');
      $chain->complete('EXPLAINED');
    }
    elsif ($value eq 'Second Place')
    {
      $token->set_general('ITERATOR', 'PLACE', 2);
      $chain->complete('EXPLAINED');
    }
    elsif ($value eq 'Championship' || $value eq 'Tournament')
    {
      $chain->complete('KILLED');
    }
    else
    {
      $chain->complete('EXPLAINED');
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
    $chain->complete('EXPLAINED');

    $token_prev->set_general('COUNTER', 'NUMERAL', $first);
    $chain_prev->complete('COMPLETE');
  }
}


sub post_process_ambiguous_letters
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
    $chain1->complete('EXPLAINED');
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
    $chain1->complete('EXPLAINED');
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

  $chain->complete('EXPLAINED');
}


sub post_process_rof
{
  my ($chains, $knowledge, $bbono) = @_;

  for my $cno (0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    my $value = $token->value();

    if ($field eq 'N_OF_N' && 
        ($value =~ /^1_(\d+)$/ || $value =~ /^1 of (\d+)$/))
    {
      my $n = $1;
      if ($n == 16 || $n == 32 || $n == 64)
      {
        # Probably round-of.
        my $rof = "Rof$n";
        $token->set_general('SINGLETON', 'STAGE', $rof);
        $chain->complete('EXPLAINED');

        # No named field to delete.
        $knowledge->add_field('STAGE', $rof, $bbono);
        next;
      }
    }

    next unless $field eq 'ROUND';

    if ($value eq '16' || $value eq '32' || $value eq '64')
    {
      my $tname = $knowledge->get_field('TNAME', $bbono);
      my $meet = $knowledge->get_field('MEET', $bbono);
      if ($tname eq 'Spingold Teams' || 
          $tname eq 'Vanderbilt Teams' || 
          $meet eq 'United States Bridge Championship' ||
         ($meet eq 'European Transnational Championships' &&
          $knowledge->is_knock_out($bbono)))
      {
        # Probably round-of.
        $token->set_general('SINGLETON', 'STAGE', "Rof$value");
        $chain->complete('EXPLAINED');

        $knowledge->delete_field('ROUND', $value, $bbono);
        $knowledge->add_field('STAGE', $value, $bbono);
      }
    }
    elsif ($value =~ /^(16)\+(\d+ of \d+)$/ ||
           $value =~ /^(32)\+(\d+ of \d+)$/ ||
           $value =~ /^(64)\+(\d+ of \d+)$/)
    {
      my ($rof, $segment) = ($1, $2);
      my $tname = $knowledge->get_field('TNAME', $bbono);
      my $meet = $knowledge->get_field('MEET', $bbono);
      if ($tname eq 'Spingold Teams' || 
          $tname eq 'Vanderbilt Teams' || 
          $meet eq 'United States Bridge Championship' ||
         ($meet eq 'European Transnational Championships' &&
          $knowledge->is_knock_out($bbono)))
      {
        # Probably round-of.
        my $new_value = "Rof$rof";
        $token->set_general('SINGLETON', 'STAGE', $new_value);
        $chain->complete('EXPLAINED');

        $knowledge->delete_field('ROUND', $value, $bbono);
        $knowledge->add_field('STAGE', $value, $bbono);

        my $token1 = Token->new();
        $token1->copy_origin_from($token);
        $token1->set_general('MARKER', 'SEGMENT', $segment);

        my $chain1 = Chain->new();
        $chain1->append($token1);
        $chain1->complete('EXPLAINED');

        splice(@$chains, $cno+1, 0, $chain1);
      }
    }
  }
}


sub likely_rof
{
  my ($field, $value, $rof) = @_;
  if ($field eq 'NUMERAL' &&
      ($value eq '16' || $value eq '32' || $value eq '64'))
  {
    $$rof = $value;
    return 1;
  }
  elsif ($field eq 'N_OF_N' && $value =~ /^1 of (\d+)$/ &&
    ($1 eq '16' || $1 eq '32' || $1 eq '64'))
  {
    $$rof = $1;
    return 1;
  }
  else
  {
    return 0;
  }
}


sub post_process_some_explained_mm
{
  my ($chains, $knowledge, $bbono) = @_;

  # This is a quite specific fix of some major-minor counters.
  my $tname = $knowledge->get_field('TNAME', $bbono);
  my $meet = $knowledge->get_field('MEET', $bbono);
  if ($tname eq '' && $meet ne '')
  {
    $tname = $meet;
  }

  return unless ($tname && exists $ITERATORS_MAJOR_MINOR{$tname});

  return unless $#$chains == 0;
  my $chain = $chains->[0];
  return unless $chain->status() eq 'EXPLAINED';
  return unless $chain->last() == 0;

  my $token = $chain->check_out(0);
  my $cat = $token->category();
  return unless $cat eq 'MARKER';

  my ($field1, $field2) = 
    ($ITERATORS_MAJOR_MINOR{$tname}[0],
     $ITERATORS_MAJOR_MINOR{$tname}[1]);

  my $field = $token->field();
  if ($field ne $field1)
  {
    return unless ($field eq 'MATCH' && $field1 eq 'ROUND');
  }
  return if $field2 eq '';

  my $value = $token->value();
  my ($n1, $n2);

  if ($value =~ /^(\d+)\+(\d+)[A-Z]*$/)
  {
    ($n1, $n2) = ($1, $2);
  }
  elsif ($value =~ /^(\d+)-(\d+)$/)
  {
    ($n1, $n2) = ($1, $2);
    return if ($n2 > 2);
  }
  elsif ($value =~ /^(\d+) of (\d+)$/)
  {
    ($n1, $n2) = ($1, $2);
    return if ($n2 > 2);
  }
  else
  {
    return;
  }

  print "$bbono ETRACE-SOMEMMTEAMS-2\n" if $TRACE;
  one_to_two_chains($chains, $chain,0 , $token,
    'MARKER', $field1, $n1,
    'MARKER', $field2, $n2);
}


sub active_letter
{
  my ($knowledge, $chain, $token, $value, $bbono) = @_;

  if ($knowledge->is_knock_out($bbono))
  {
    print "$bbono ETRACE-LETTER1\n" if $TRACE;
    $chain->complete('KILLED');
  }
  else
  {
    print "$bbono ETRACE-LETTER2\n" if $TRACE;
    $token->set_general('MARKER', 'GROUP', $value);
    $chain->complete('EXPLAINED');
  }
  return 1;
}


sub active_number_pairs
{
  my ($knowledge, $chains, $chain, $cno, 
    $token, $field, $value, $bbono) = @_;

  if ($field eq 'NUMERAL' || 
      $field eq 'N_OF_N' ||
      $field eq 'ORDINAL')
  {
    print "$bbono ETRACE-NUMP-1\n" if $TRACE;
    $token->set_general('MARKER', 'SESSION', $value);
    $chain->complete('EXPLAINED');
  }
  elsif ($field eq 'NL')
  {
    print "$bbono ETRACE-NUMP-2\n" if $TRACE;
    $value =~ /^(\d+)([A-Za-z]+)$/;
    my ($number, $letter) = ($1, $2);
    one_to_two_chains($chains, $chain, $cno, $token,
      'MARKER', 'GROUP', $letter,
      'MARKER', 'SESSION', $number);
  }
  elsif ($field eq 'N_TO_N_OF_N')
  {
    print "$bbono ETRACE-NUMP-3\n" if $TRACE;
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete('EXPLAINED');
  }
  elsif ($field eq 'NL_OF_N' || $field eq 'NL_TO_N')
  {
    $value =~ /^(\d+)([A-D])-(\d+)$/;
    my ($n1, $n2) = ($1, $2);
    # Skip the letter (which would be a group).
    print "$bbono ETRACE-NUMP-4\n" if $TRACE;
    warn "ORDER ETRACE-NUMP-4" if $n2 <= $n1;
    $token->set_general('MARKER', 'SEGMENT', "$n1 of $n2");
    $chain->complete('EXPLAINED');
  }
  elsif ($field eq 'AMBIGUOUS')
  {
    print "$bbono ETRACE-NUMP-5\n" if $TRACE;
    $value =~ /^S (.*)$/;
    $token->set_general('MARKER', 'SESSION', $1);
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-NUMP-6\n" if $TRACE;
    return 0;
  }
  return 1;
}


sub active_nl_teams
{
  my ($knowledge, $mask ,
    $chains, $chain, $cno, $token, $value, $bbono) = @_;

  $value =~ /^(\d+)([A-Za-z]+)$/;
  my ($number, $letter) = ($1, $2);
  if ($knowledge->is_knock_out($bbono))
  {
    # Discard the letter.
    print "$bbono ETRACE-NLTEAMS-1\n" if $TRACE;
    $token->set_general('MARKER', 'SEGMENT', $number);
    $chain->complete('EXPLAINED');
  }
  elsif ($mask eq '0100')
  {
    # Already have a round.
    print "$bbono ETRACE-NLTEAMS-2\n" if $TRACE;
    $token->set_general('MARKER', 'MATCH', $number);
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-NLTEAMS-3\n" if $TRACE;
    one_to_two_chains($chains, $chain, $cno, $token,
      'MARKER', 'GROUP', $letter,
      'MARKER', 'ROUND', $number);
  }
  return 1;
}


sub active_ambiguous_teams
{
  my ($knowledge, $chain, $token, $value, $bbono) = @_;

  my $meet = $knowledge->get_field('MEET', $bbono);
  $value =~ /^S (.*)$/;
  my $f = $1;

  if (exists $ITERATORS_S_FOR_SENIORS{$meet} ||
      $ITERATORS_S_FOR_SENIORS{$meet})
  {
    print "$bbono ETRACE-AMBTEAMS-1\n" if $TRACE;
    $token->set_general('SINGLETON', 'AGE', 'Seniors');
    $chain->complete('EXPLAINED');
  }
  elsif ($knowledge->is_knock_out($bbono))
  {
    print "$bbono ETRACE-AMBTEAMS-2\n" if $TRACE;
    $token->set_general('MARKER', 'SEGMENT', $f);
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-AMBTEAMS-3\n" if $TRACE;
    $token->set_general('MARKER', 'SESSION', $f);
    $chain->complete('EXPLAINED');
  }
  return 1;
}


sub active_nton_teams
{
  my ($knowledge, $chains, $chain, $cno, 
    $token, $field, $value, $bbono) = @_;

  my $movement = $knowledge->get_field('MOVEMENT', $bbono);

  my ($n1, $n2);
  if ($value =~ /^(\d+)-(\d+)([A-D])$/)
  {
    ($n1, $n2) = ($1, $2);
  }
  elsif ($value =~ /^(\d+)([A-D]) of (\d+)$/)
  {
    ($n1, $n2) = ($1, $3);
  }
  elsif ($value =~ /^(\d+)([A-D]) to (\d+)$/)
  {
    ($n1, $n2) = ($1, $3);
  }
  else
  {
    die "Odd N_TO_N format: $value";
  }

  if ($movement eq 'Round-robin')
  {
    # Skip the letter (which would be a group).
    print "$bbono ETRACE-NTONT-3\n" if $TRACE;
    one_to_two_chains($chains, $chain, $cno, $token,
      'MARKER', 'ROUND', $n1,
      'MARKER', 'MATCH', $n2);
  }
  elsif ($knowledge->is_knock_out($bbono))
  {
    # Skip the letter (which would be a group).
    print "$bbono ETRACE-NTONT-3\n" if $TRACE;
    warn "ORDER ETRACE-NTONT-1" if $n2 < $n1;
    $token->set_general('MARKER', 'SEGMENT', "$n1 of $n2");
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-NTONT-3\n" if $TRACE;
    return 0;
  }
  return 1;
}


sub active_some_mm_teams
{
  my ($knowledge, $chains, $chain, $cno, 
    $token, $field, $value, $bbono) = @_;

  my $tname = $knowledge->get_field('TNAME', $bbono);
  if ($tname eq '')
  {
    $tname = $knowledge->get_field('MEET', $bbono);
  }

  my ($n1, $n2);
  if ($field eq 'MAJOR_MINOR')
  {
    if ($value !~ /^(\d+)\+(\d+)[A-Z]*$/)
    {
      die "Unexpected: $bbono, $value";
    }
    ($n1, $n2) = ($1, $2);
  }
  else
  {
    if ($value !~ /^(\d+)-(\d+)$/)
    {
      die "Unexpected: $bbono, $value";
    }
    ($n1, $n2) = ($1, $2);
  }

  my ($field1, $field2) = 
    ($ITERATORS_MAJOR_MINOR{$tname}[0],
     $ITERATORS_MAJOR_MINOR{$tname}[1]);

  if ($field2 eq '')
  {
    print "$bbono ETRACE-SOMEMMTEAMS-1\n" if $TRACE;
    $token->set_general('MARKER', $field1, "$n1 of $n2");
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-SOMEMMTEAMS-2\n" if $TRACE;
    one_to_two_chains($chains, $chain, $cno, $token,
      'MARKER', $field1, $n1,
      'MARKER', $field2, $n2);
  }
  return 1;
}


sub active_sr_complete_teams
{
  my ($knowledge, $chain, $token, $value, $field, $bbono) = @_;

  my $rof;
  if (likely_rof($field, $value, \$rof))
  {
    print "$bbono ETRACE-SRC-1\n" if $TRACE;
    $token->set_general('SINGLETON', 'STAGE', "Rof$rof");
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-SRC-2\n" if $TRACE;
    $token->set_general('MARKER', 'SEGMENT', $value);
    $chain->complete('EXPLAINED');
  }
  return 1;
}


sub active_milne
{
  my ($knowledge, $chains, $chain, $cno, 
    $token, $field, $value, $bbono) = @_;

  if ($value =~ /^(\d+[ABC])[+-](\d+)$/)
  {
    print "$bbono ETRACE-MILNE-1\n" if $TRACE;
    my ($match, $stanza) = ($1, $2);
    one_to_two_chains($chains, $chain, $cno, $token,
      'MARKER', 'MATCH', $1, 
      'MARKER', 'STANZA', $2);
  }
  elsif ($field eq 'NUMERAL')
  {
    print "$bbono ETRACE-MILNE-2\n" if $TRACE;
    $token->set_general('COUNTER', 'NUMERAL', $value);
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-MILNE-3\n" if $TRACE;
    print "$bbono: WARN Unexpected MAJOR_MINOR format (Lady Milne)\n";
    return 0;
  }
  return 1;
}


sub active_knock_out
{
  my ($knowledge, $chain, $token, $value, $field, $bbono) = @_;

  if ($field eq 'NUMERAL' || 
      $field eq 'N_OF_N' ||
      $field eq 'N_TO_N_OF_N' ||
      $field eq 'ORDINAL' ||
      $field eq 'ROMAN')
  {
    print "$bbono ETRACE-KO_1\n" if $TRACE;
    $token->set_general('MARKER', 'SEGMENT', $value);
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-KO_2\n" if $TRACE;
    return 0;
  }
  return 1;
}


sub active_othn_teams
{
  my ($knowledge, $chain, $token, $value, $field, $bbono) = @_;

  if ($field eq 'NUMERAL' || 
        $field eq 'N_OF_N' ||
        $field eq 'N_TO_N_OF_N' ||
        $field eq 'ORDINAL' ||
        $field eq 'ROMAN')
  {
    print "$bbono ETRACE-OTHN-1\n" if $TRACE;
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-OTHN-1\n" if $TRACE;
    return 0;
  }
  return 1;
}


sub active_seg_complete_teams
{
  my ($knowledge, $chain, $token, $value, $field, $bbono) = @_;

  my $movement = $knowledge->get_field('MOVEMENT', $bbono);
  if ($movement eq 'Round-robin')
  {
    print "$bbono ETRACE-SEGC-1\n" if $TRACE;
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete('EXPLAINED');
    return 1;
  }

  my $rof;
  if (likely_rof($field, $value, \$rof))
  {
    print "$bbono ETRACE-SEGC-2\n" if $TRACE;
    $token->set_general('SINGLETON', 'STAGE', "Rof$rof");
    $chain->complete('EXPLAINED');
  }
  else
  {
    print "$bbono ETRACE-SEGC-3\n" if $TRACE;
    $token->set_general('MARKER', 'SEGMENT', $value);
    $chain->complete('EXPLAINED');
  }
  return 1;
}


sub post_process_single_active
{
  my ($knowledge, $chains, $chain, $cno, $bbono) = @_;

  # Can happen if there are some late hits in interpret().
  return if $chain->status() eq 'EXPLAINED';

  my $token = $chain->check_out(0);
  my $field = $token->field();
  my $value = $token->value();

  my $tname = $knowledge->get_field('TNAME', $bbono);
  my $form = $knowledge->get_field('FORM', $bbono);
  my $mask = $knowledge->get_iter_mask($bbono);

  if ($form eq '')
  {
    my $scoring = $knowledge->get_field('SCORING', $bbono);
    # TODO This is not clean.  Should go by TNAME or TWORD.
    $form = ($scoring eq 'IMP' || $scoring eq 'I' ||
      $scoring eq 'BAM' || $scoring eq 'B' ?  
      'Teams' : 'Pairs');
  }

  if ($field eq 'LETTER')
  {
    return if active_letter($knowledge, $chain, $token, $value, $bbono);
  }
  elsif ($form eq 'Pairs')
  {
    if ($mask eq '0000' || $mask eq '1000')
    {
      # Might have group, but no other relevant iterator.
      return if active_number_pairs($knowledge, $chains, $chain, $cno, 
        $token, $field, $value, $bbono);
    }
  }
  elsif ($field eq 'NL')
  {
    return if active_nl_teams($knowledge, $mask,
      $chains, $chain, $cno, $token, $value, $bbono);
  }
  elsif ($field eq 'AMBIGUOUS')
  {
    return if active_ambiguous_teams($knowledge, $chain, 
      $token, $value, $bbono);
  }
  elsif ($mask eq '0000' || $mask eq '1000')
  {
    my $tname_ext = $tname;
    if ($tname eq '')
    {
      $tname_ext = $knowledge->get_field('MEET', $bbono);
    }

    if ($field eq 'NL_OF_N' || $field eq 'NL_TO_N')
    {
      # Could be really N_OF_N or two different things.
      return if active_nton_teams($knowledge, $chains, $chain, $cno,
        $token, $field, $value, $bbono);
    }
    elsif ($tname_ext && exists $ITERATORS_MAJOR_MINOR{$tname_ext} &&
        ($field eq 'MAJOR_MINOR' || $field eq 'N_TO_N'))
    {
      return if active_some_mm_teams($knowledge, $chains, $chain, $cno,
        $token, $field, $value, $bbono);
    }
    elsif ($tname eq 'Lady Milne Trophy')
    {
    return if active_milne($knowledge, $chains, $chain, $cno,
        $token, $field, $value, $bbono);
    }
    elsif ($knowledge->is_knock_out($bbono))
    {
      return if active_knock_out($knowledge, $chain, 
        $token, $value, $field, $bbono);
    }
    else
    {
      return if active_othn_teams($knowledge, $chain, 
        $token, $value, $field, $bbono);
    }
  }
  elsif ($mask eq '0100' || $mask eq '0010')
  {
    # Have ROUND or SESSION, so SEGMENT or ROF depending on value.
    return if active_sr_complete_teams($knowledge, $chain, 
      $token, $value, $field, $bbono);
  }
  elsif ($mask eq '0001')
  {
    # Have SEGMENT, so ROF or ROUND depending on value.
    return if active_seg_complete_teams($knowledge, $chain, 
      $token, $value, $field, $bbono);
  }

  print "TODOX " . $knowledge->str($bbono) . ", $field, $value\n";
}


sub post_process_pair
{
  my ($knowledge, $chain0, $chain1, $bbono) = @_;

  my $token0 = $chain0->check_out(0);
  my $token1 = $chain1->check_out(0);

  my $stage = $knowledge->get_field('STAGE', $bbono);
  my $movement = $knowledge->get_field('MOVEMENT', $bbono);

  my $field0 = $token0->field();
  my $field1 = $token1->field();
  my $value0 = $token0->value();
  my $value1 = $token1->value();

  if ($stage eq '' || $movement eq 'Knock-out')
  {
    if (($field0 eq 'LETTER' || $field0 eq 'NUMERAL' || 
          $field0 eq 'N_OF_N') &&
        ($field1 eq 'NUMERAL' || $field1 eq 'N_OF_N' || 
          $field1 eq 'AMBIGUOUS'))
    {
      if ($value0 eq '16' || $value0 eq '32' || $value0 eq '64')
      {
        $token0->set_general('SINGLETON', 'STAGE', "Rof$value0");
        $token1->set_general('MARKER', 'SEGMENT', $value1);

        $chain0->complete('EXPLAINED');
        $chain1->complete('EXPLAINED');
      }
      elsif ($value0 eq '1 of 16' || $value0 eq '1 of 32' || 
          $value0 eq '1 of 64')
      {
        $value0 =~ /^1 of (\d+)$/;
        $token0->set_general('SINGLETON', 'STAGE', "Rof$1");
        $token1->set_general('MARKER', 'SEGMENT', $value1);

        $chain0->complete('EXPLAINED');
        $chain1->complete('EXPLAINED');
      }
      else
      {
        # Drop the letter/numeral.
        $token1->set_general('MARKER', 'SEGMENT', $value1);

        $chain0->complete('KILLED');
        $chain1->complete('EXPLAINED');
      }
    }
    return;
  }
  if ($stage eq 'Rof64' || $stage eq 'Rof32' ||
      $stage eq 'Rof16' || $stage eq 'Quarterfinal' || 
      $stage eq 'Semifinal' || $stage eq 'Final' || 
      $stage eq 'Playoff')
  {
    if ($field1 eq 'NUMERAL' || $field1 eq 'N_OF_N' || 
        $field1 eq 'AMBIGUOUS')
    {
      $token1->set_general('MARKER', 'SEGMENT', $value1);
      $chain1->complete('EXPLAINED');
    }
    return;
  }
  elsif ($movement eq 'Round-robin' && 
      $field0 eq 'N_OF_N' &&
      $field1 eq 'N_OF_N')
  {
    $token0->set_general('MARKER', 'ROUND', $value0);
    $token1->set_general('MARKER', 'SEGMENT', $value1);

    $chain0->complete('EXPLAINED');
    $chain1->complete('EXPLAINED');
    return;
  }

  print "STRETCH pair $bbono\n";
}


sub post_process_multiple_stages
{
  my ($chains) = @_;

  my @stages;
  my $ccount = $#$chains;
  for my $cno (0 .. $ccount)
  {
    my $chain = $chains->[$cno];
    next unless $chain->last() == 0;
    next unless $chain->status() eq 'EXPLAINED';

    my $token = $chain->check_out(0);
    next unless $token->field() eq 'STAGE';
    push @stages, $cno;
  }

  return unless $#stages == 1;
  my ($ko_index, $other_index);
  my $value = $chains->[$stages[0]]->check_out(0)->value();
  if ($value eq 'Knock-out')
  {
    $ko_index = 0;
    $other_index = 1;
    $value = $chains->[$stages[1]]->check_out(0)->value();
  }
  elsif ($chains->[$stages[1]]->check_out(0)->value() eq 'Knock_out')
  {
    $ko_index = 1;
    $other_index = 0;
  }
  else
  {
    return;
  }

  # No need for KO when we also have the actual KO stage.
  $chains->[$ko_index]->complete('KILLED');
}


sub post_process_single_numerals
{
  my ($chains, $knowledge, $stretch, $actives, $bbono) = @_;

  my ($cno0, $cno1) = ($stretch->[0], $stretch->[1]);

  if ($#$actives == 0)
  {
    post_process_single_active($knowledge,
      $chains, $chains->[$actives->[0]], $actives->[0], $bbono);
    return;
  }

  if ($#$actives != 1)
  {
    print "STRETCH long $bbono\n";
    return;
  }

  my $chain0 = $chains->[$actives->[0]];
  my $chain1 = $chains->[$actives->[1]];

  if ($chain0->last() != 0)
  {
    print "STRETCH chain0 $bbono\n";
    return;
  }
  if ($chain1->last() != 0)
  {
    print "STRETCH chain1 $bbono\n";
    return;
  }

  post_process_pair($knowledge, $chain0, $chain1, $bbono);
}


sub interpret
{
  my ($whole, $chains, $chains_title, $teams, 
    $knowledge, $scoring, $bbono) = @_;

  post_process_single($chains, $bbono);
  post_process_some_iterators($chains);
  post_process_countries($chains, $teams);
  post_process_meet($chains, $chains_title, $bbono);
  post_process_tname($chains, $chains_title, $bbono);
  post_process_tword($chains, $chains_title, $bbono);
  post_process_match($chains, $bbono);
  post_process_ambiguous_letters($chains);

  my (@stretches, @actives);
  post_process_analyze_rest($chains, \@stretches, \@actives, $bbono);

  $knowledge->add_explained_chains($chains_title, $bbono);
  $knowledge->add_explained_chains($chains, $bbono);
  $knowledge->add_field('SCORING', $$scoring, $bbono);

  post_process_rof($chains, $knowledge, $bbono);
  post_process_some_explained_mm($chains, $knowledge, $bbono);
  post_process_multiple_stages($chains);

  for my $s (0 .. $#stretches)
  {
    post_process_single_numerals($chains,
      $knowledge, $stretches[$s], $actives[$s], $bbono);
  }
}

1;
