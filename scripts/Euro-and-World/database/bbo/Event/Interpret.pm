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

my $TRACE = 1;

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
  'Southeast Asian Games' => ['SESSION', 'ROUND'],
  'Swedish District Championship' => ['ROUND', 'SEGMENT'],
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


sub one_to_two_chains
{
  my ($chains, $chain, $cno, $token, 
    $cat1, $field1, $value1, $cat2, $field2, $value2) = @_;

  $token->set_general($cat1, $field1, $value1);
  $chain->complete_if_last_is(0, 'EXPLAINED');

  my $token1 = Token->new();
  $token1->copy_origin_from($token);
  $token1->set_general($cat2, $field2, $value2);

  my $chain1 = Chain->new();
  $chain1->append($token1);
  $chain1->complete_if_last_is(0, 'EXPLAINED');
  splice(@$chains, $cno+1, 0, $chain1);
}


sub post_process_analyze_rest
{
  # There is supposed to be one remaining stretch of chain numbers.
  # That stretch is supposed to have 1 or 2 chain numbers with content
  # that is not KILLED.  These go in actives.

  my ($chains, $stretches, $actives, $bbono) = @_;
  
  # Some chains are just considered done.  Others, ideally one 
  # contiguous set, must still be analyzed for their number content.
  my $open_flag = 0;
  my $counter_flag = 0;
  my $open_start = 0;
  for my $cno (0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    my $status = $chain->status();

    if ($status eq 'COMPLETE' && $chain->last() == -1)
    {
      $chain->complete_if_last_is(-1, 'KILLED');
      next;
    }

    my $token = $chain->check_out(0);

    if ($status eq 'KILLED' || $status eq 'EXPLAINED')
    {
      next if ($status eq 'KILLED' &&
          $chain->last() == 0 && 
          $token->value() eq '');

      if ($open_flag && $counter_flag)
      {
        push @$stretches, [$open_start, $cno-1];
      }

      $open_flag = 0;
      $counter_flag = 0;
      next;
    }

    if ($status eq 'OPEN')
    {
      print "ANALYZE: odd $bbono\n";
      next;
    }

    if ($chain->last() != 0)
    {
      print "ANALYZE: expected one-token chain, $bbono\n";
      next;
    }

    if (! $open_flag)
    {
      $open_flag = 1;
      $open_start = $cno;
    }

    if ($token->category() eq 'COUNTER' || $token->field() eq 'AMBIGUOUS')
    {
      $counter_flag = 1;
    }
  }

  if ($open_flag)
  {
    push @$stretches, [$open_start, $#$chains];
  }

  if ($#$stretches > 0)
  {
    print "STRETCH multiple $bbono\n";
  }

  for my $s (0 .. $#$stretches)
  {
    for my $cno ($stretches->[$s][0] .. $stretches->[$s][1])
    {
      if ($chains->[$cno]->status() ne 'KILLED')
      {
        push @{$actives->[$s]}, $cno;
      }
    }
  }
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
    next unless $field eq 'ROUND';

    my $value = $token->value();
    next unless $value eq '16' || $value eq '32' || $value eq '64';

    my $tname = $knowledge->get_field('TNAME', $bbono);
    my $meet = $knowledge->get_field('MEET', $bbono);
    if ($tname eq 'Spingold' || 
        $tname eq 'Vanderbilt' || 
        $meet eq 'United States Bridge Championship' ||
       ($tname eq 'European Open Bridge Championship' &&
        $knowledge->is_knock_out($bbono)))
    {
      # Probably round-of.
      $token->set_general('MARKER', 'ROF', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');

      $knowledge->delete_field('ROUND', $value, $bbono);
      $knowledge->add_field('ROF', $value, $bbono);
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
    $$rof = $value;
    return 1;
  }
  else
  {
    return 0;
  }
}


sub post_process_single_active
{
  my ($knowledge, $chains, $chain, $cno, $bbono) = @_;

  my $token = $chain->check_out(0);
  my $field = $token->field();
  my $value = $token->value();

  my $meet = $knowledge->get_field('MEET', $bbono);
  my $tname = $knowledge->get_field('TNAME', $bbono);
  my $form = $knowledge->get_field('FORM', $bbono);
  my $stage = $knowledge->get_field('STAGE', $bbono);
  my $movement = $knowledge->get_field('MOVEMENT', $bbono);
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
    if ($knowledge->is_knock_out($bbono))
    {
      print "$bbono ETRACE10\n" if $TRACE;
      $chain->complete_if_last_is(0, 'KILLED');
      return;
    }
    else
    {
      print "$bbono ETRACE11\n" if $TRACE;
      $token->set_general('MARKER', 'GROUP', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return;
    }
  }
  elsif ($form eq 'Pairs')
  {
    if ($mask eq '0000' || $mask eq '1000')
    {
      if ($field eq 'NUMERAL' || 
          $field eq 'N_OF_N' ||
          $field eq 'ORDINAL')
      {
        print "$bbono ETRACE1\n" if $TRACE;
        $token->set_general('MARKER', 'SESSION', $value);
        $chain->complete_if_last_is(0, 'EXPLAINED');
        return;
      }
      elsif ($field eq 'NL')
      {
        print "$bbono ETRACE2\n" if $TRACE;
        $value =~ /^(\d+)([A-Za-z]+)$/;
        my ($number, $letter) = ($1, $2);
        one_to_two_chains($chains, $chain, $cno, $token,
          'MARKER', 'GROUP', $letter,
          'MARKER', 'SESSION', $number);
        return;
      }
      elsif ($field eq 'N_TO_N_OF_N')
      {
        print "$bbono ETRACE3\n" if $TRACE;
        $token->set_general('MARKER', 'ROUND', $value);
        $chain->complete_if_last_is(0, 'EXPLAINED');
        return;
      }
      elsif ($field eq 'NL_OF_N' || $field eq 'NL_TO_N')
      {
        $value =~ /^(\d+)([A-D])-(\d+)$/;
        my ($n1, $n2) = ($1, $2);
        # Skip the letter (which would be a group).
        print "$bbono ETRACE4\n" if $TRACE;
        warn "ORDER ETRACE4" if $n2 <= $n1;
        $token->set_general('MARKER', 'SEGMENT', "$n1 of $n2");
        $chain->complete_if_last_is(0, 'EXPLAINED');
        return;
      }
      elsif ($field eq 'AMBIGUOUS')
      {
        print "$bbono ETRACE5\n" if $TRACE;
        $value =~ /^S (.*)$/;
        $token->set_general('MARKER', 'SESSION', $1);
        $chain->complete_if_last_is(0, 'EXPLAINED');
        return;
      }
      else
      {
        print "$bbono ETRACE6\n" if $TRACE;
      }
    }

    print "TODOY $bbono, $mask, $tname: $form, $stage, $movement, $field, $value\n";
    return;
  }
  elsif ($field eq 'NL')
  {
    $value =~ /^(\d+)([A-Za-z]+)$/;
    my ($number, $letter) = ($1, $2);
    if ($knowledge->is_knock_out($bbono))
    {
      # Discard the letter.
      print "$bbono ETRACE20\n" if $TRACE;
      $token->set_general('MARKER', 'SEGMENT', $number);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return;
    }
    elsif ($mask eq '0100')
    {
      # Already have a round.
      print "$bbono ETRACE21\n" if $TRACE;
      $token->set_general('MARKER', 'MATCH', $number);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return;
    }
    else
    {
      print "$bbono ETRACE22\n" if $TRACE;
      one_to_two_chains($chains, $chain, $cno, $token,
        'MARKER', 'GROUP', $letter,
        'MARKER', 'ROUND', $number);
      return;
    }
  }
  elsif ($field eq 'AMBIGUOUS')
  {
    $value =~ /^S (.*)$/;
    my $f = $1;
    if (exists $ITERATORS_S_FOR_SENIORS{$meet} ||
        $ITERATORS_S_FOR_SENIORS{$meet})
    {
      print "$bbono ETRACE30\n" if $TRACE;
      $token->set_general('SINGLETON', 'AGE', 'Seniors');
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return;
    }
    elsif ($knowledge->is_knock_out($bbono))
    {
      print "$bbono ETRACE31\n" if $TRACE;
      $token->set_general('MARKER', 'SEGMENT', $f);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return;
    }
    else
    {
      print "$bbono ETRACE32\n" if $TRACE;
      $token->set_general('MARKER', 'SESSION', $f);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return;
    }
  }
  elsif ($mask eq '0000' || $mask eq '1000')
  {
    if ($field eq 'NL_OF_N' || $field eq 'NL_TO_N')
    {
      $value =~ /^(\d+)-(\d+)([A-D])$/;
      my ($n1, $n2) = ($1, $2);
      if ($movement eq 'Round-robin')
      {
        # Skip the letter (which would be a group).
        print "$bbono ETRACE40\n" if $TRACE;
        one_to_two_chains($chains, $chain, $cno, $token,
          'MARKER', 'ROUND', $n1,
          'MARKER', 'MATCH', $n2);
        return;
      }
      elsif ($knowledge->is_knock_out($bbono))
      {
        # Skip the letter (which would be a group).
        print "$bbono ETRACE41\n" if $TRACE;
        warn "ORDER ETRACE41" if $n2 <= $n1;
        $token->set_general('MARKER', 'SEGMENT', "$n1 of $n2");
        $chain->complete_if_last_is(0, 'EXPLAINED');
        return;
      }
      else
      {
        print "$bbono ETRACE42\n" if $TRACE;
      }
    }
    elsif ($tname && exists $ITERATORS_MAJOR_MINOR{$tname} &&
        ($field eq 'MAJOR_MINOR' || $field eq 'N_TO_N'))
    {
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
        print "$bbono ETRACE43\n" if $TRACE;
        $token->set_general('MARKER', $field1, "$n1 of $n2");
        $chain->complete_if_last_is(0, 'EXPLAINED');
        return;
      }
      else
      {
        print "$bbono ETRACE44\n" if $TRACE;
        one_to_two_chains($chains, $chain, $cno, $token,
          'MARKER', $field1, $n1,
          'MARKER', $field2, $n2);
      }
      return;
    }
    elsif ($tname eq 'Lady Milne Trophy')
    {
      # Special case.
      if ($value =~ /^(\d+[ABC])[+-](\d+)$/)
      {
        print "$bbono ETRACE45\n" if $TRACE;
        my ($match, $stanza) = ($1, $2);
        one_to_two_chains($chains, $chain, $cno, $token,
          'MARKER', 'MATCH', 'MARKER', 
          'STANZA', $1, $2);
      }
      elsif ($field eq 'NUMERAL')
      {
        print "$bbono ETRACE45a\n" if $TRACE;
        $token->set_general('COUNTER', 'NUMERAL', $value);
        $chain->complete_if_last_is(0, 'EXPLAINED');
        return;
      }
      else
      {
        print "$bbono ETRACE46\n" if $TRACE;
        print "$bbono: WARN Unexpected MAJOR_MINOR format (Lady Milne)\n";
      }
      return 1;
    }
    elsif ($knowledge->is_knock_out($bbono))
    {
      if ($field eq 'NUMERAL' || 
          $field eq 'N_OF_N' ||
          $field eq 'N_TO_N_OF_N' ||
          $field eq 'ORDINAL' ||
          $field eq 'ROMAN')
      {
        print "$bbono ETRACE47\n" if $TRACE;
        $token->set_general('MARKER', 'SEGMENT', $value);
        $chain->complete_if_last_is(0, 'EXPLAINED');
        return;
      }
      else
      {
        print "$bbono ETRACE48\n" if $TRACE;
      }
    }
    elsif ($field eq 'NUMERAL' || 
          $field eq 'N_OF_N' ||
          $field eq 'N_TO_N_OF_N' ||
          $field eq 'ORDINAL' ||
          $field eq 'ROMAN')
    {
      print "$bbono ETRACE49\n" if $TRACE;
      $token->set_general('MARKER', 'ROUND', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return;
    }
    else
    {
      print "$bbono ETRACE50\n" if $TRACE;
    }
  }
  elsif ($mask eq '0100' || $mask eq '0010')
  {
    # Have ROUND, so SEGMENT or ROF depending on value.
    my $rof;
    if (likely_rof($field, $value, \$rof))
    {
      print "$bbono ETRACE55\n" if $TRACE;
      $token->set_general('MARKER', 'ROF', $rof);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    else
    {
      print "$bbono ETRACE56\n" if $TRACE;
      $token->set_general('MARKER', 'SEGMENT', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    return;
  }
  elsif ($mask eq '0001')
  {
    # Have SEGMENT, so ROF or ROUND depending on value.
    if ($movement eq 'Round-robin')
    {
      print "$bbono ETRACE60\n" if $TRACE;
      $token->set_general('MARKER', 'ROUND', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return;
    }

    my $rof;
    if (likely_rof($field, $value, \$rof))
    {
      print "$bbono ETRACE61\n" if $TRACE;
      $token->set_general('MARKER', 'ROF', $rof);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    else
    {
      print "$bbono ETRACE62\n" if $TRACE;
      $token->set_general('MARKER', 'SEGMENT', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    return;
  }

  if ($tname eq '')
  {
    $tname = 'MEET ' . $knowledge->get_field('MEET', $bbono);
  }

  print "TODOX $bbono, $mask, $tname: $form, $stage, $movement, $field, $value\n";
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

  if ($stage eq '' || $stage eq 'Quarterfinal' || $stage eq 'Semifinal' ||
      $stage eq 'Final' || $stage eq 'Playoff' || 
      $movement eq 'Knock-out')
  {
    if (($field0 eq 'LETTER' || $field0 eq 'NUMERAL' || 
          $field0 eq 'N_OF_N') &&
        ($field1 eq 'NUMERAL' || $field1 eq 'N_OF_N' || 
          $field1 eq 'AMBIGUOUS'))
    {
      if ($value0 eq '16' || $value0 eq '32' || $value0 eq '64')
      {
        $token0->set_general('MARKER', 'ROF', $value0);
        $token1->set_general('MARKER', 'SEGMENT', $value1);

        $chain0->complete_if_last_is(0, 'EXPLAINED');
        $chain1->complete_if_last_is(0, 'EXPLAINED');
      }
      elsif ($value0 eq '1 of 16' || $value0 eq '1 of 32' || 
          $value0 eq '1 of 64')
      {
        $value0 =~ /^1 of (\d+)$/;
        $token0->set_general('MARKER', 'ROF', $1);
        $token1->set_general('MARKER', 'SEGMENT', $value1);

        $chain0->complete_if_last_is(0, 'EXPLAINED');
        $chain1->complete_if_last_is(0, 'EXPLAINED');
      }
      else
      {
        # Drop the letter/numeral.
        $token1->set_general('MARKER', 'SEGMENT', $value1);

        $chain0->complete_if_last_is(0, 'KILLED');
        $chain1->complete_if_last_is(0, 'EXPLAINED');
      }
    }
    return;
  }
  elsif ($movement eq 'Round-robin' && 
      $field0 eq 'N_OF_N' &&
      $field1 eq 'N_OF_N')
  {
    $token0->set_general('MARKER', 'ROUND', $value0);
    $token1->set_general('MARKER', 'SEGMENT', $value1);

    $chain0->complete_if_last_is(0, 'EXPLAINED');
    $chain1->complete_if_last_is(0, 'EXPLAINED');
    return;
  }

  print "STRETCH pair $bbono\n";
}


sub post_process_single_numerals
{
  my ($chains, $chains_title, $knowledge,
    $stretch, $actives, $bbono) = @_;

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
  post_process_letters($chains);

  my (@stretches, @actives);
  post_process_analyze_rest($chains, \@stretches, \@actives, $bbono);

  $knowledge->add_explained_chains($chains_title, $bbono);
  $knowledge->add_explained_chains($chains, $bbono);
  $knowledge->add_field('SCORING', $$scoring, $bbono);

  post_process_rof($chains, $knowledge, $bbono);

  for my $s (0 .. $#stretches)
  {
    post_process_single_numerals($chains, $chains_title, 
      $knowledge, $stretches[$s], $actives[$s], $bbono);
  }
}

1;
