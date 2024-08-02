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

my %ITERATORS_NUMERAL = (
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
  'Madeira Open' => 'ROUND',
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

my %ITERATORS_NOFN = (
  'European Open Bridge Championship' => 'ROUND',
  'European Small Federation Games' => 'ROUND',
  'Victor Champion Cup' => 'ROUND',
  'World Bridge Series' => 'ROUND'
);

my %ITERATORS_MAJOR_MINOR = (
  'Codan Cup' => 1,
  'Norwegian Club Teams' => 1,
  'Norwegian Premier League' => 1,
  'Swedish Elite Series' => 1,
  'Swedish District Championship' => 1,
  'Swedish Open Teams' => 1,
  'Swedish Premier League' => 1
);

my %ITERATORS_NL = (
  'Camrose' => 'MATCH'
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
  my ($chains, $chain, $token, 
    $cat1, $field1, $cat2, $field2, $value1, $value2) = @_;

  $token->set_general('MARKER', $field1, $value1);
  $chain->complete_if_last_is(0, 'EXPLAINED');

  my $token1 = Token->new();
  $token1->copy_origin_from($token);
  $token1->set_general('MARKER', $field2, $value2);

  my $chain1 = Chain->new();
  $chain1->append($token1);
  $chain1->complete_if_last_is(0, 'EXPLAINED');
  splice(@$chains, 1, 0, $chain1);
}


sub n_of_n
{
  my ($chain, $token, $tname, $stage, $scoring, $value) = @_;

  $value =~ /^(\d+) of (\d+)$/;
  my ($n1, $n2) = ($1, $2);

  if ($stage && $stage =~ /final/i && 
      $scoring eq 'I' && $n2 <= 8)
  {
    # Probably a segment.
    $token->set_general('MARKER', 'SEGMENT', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  elsif ($scoring eq 'I' && $n2 <= 6)
  {
    # Probably a segment.
    $token->set_general('MARKER', 'SEGMENT', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  elsif ($tname && ($tname =~ /Swiss Teams/ || $tname =~ /League/))
  {
    # Probably a round.
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  elsif ($stage && ($stage eq 'Qualifying' || $stage eq 'Round-robin'))
  {
    # Probably a round.
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  elsif (($scoring eq 'P' || ($tname && $tname =~ /Pairs/)) || 
      ($n2 == 11 || $n2 > 12))
  {
    # Probably a round.
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  elsif ($tname && exists $ITERATORS_NOFN{$tname})
  {
    my $iter = $ITERATORS_NOFN{$tname};
    $token->set_general('MARKER', $iter, $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  return 0;
}


sub major_minor
{
  my ($chains, $chain, $token, $tname, $value) = @_;

  if ($tname && exists $ITERATORS_MAJOR_MINOR{$tname})
  {
    if ($value =~ /^(\d+)\+(\d+)$/)
    {
      one_to_two_chains($chains, $chain, $token,
        'MARKER', 'ROUND', 'MARKER', 'SEGMENT', $1, $2);
    }
    else
    {
      print "WARN Unexpected MAJOR_MINOR format\n";
    }
    return 1;
  }
  elsif ($tname eq 'Lady Milne Trophy')
  {
    # Special case.
    if ($value =~ /^(\d+[ABC])[+-](\d+)$/)
    {
      my ($match, $stanza) = ($1, $2);
      one_to_two_chains($chains, $chain, $token,
        'MARKER', 'MATCH', 'MARKER', 'STANZA', $1, $2);
    }
    else
    {
      print "WARN Unexpected MAJOR_MINOR format (Lady Milne)\n";
    }
    return 1;
  }
  return 0;
}


sub number_letter
{
  my ($chains, $chain, $token, $tname, $stage, $scoring, $value) = @_;

  if ($value !~ /^(\d+)([A-Fa-f])$/)
  {
    print "WARN Unexpected NL format\n";
    return 0;
  }
  my ($number, $letter) = ($1, $2);
  my $f_flag = ($token->text() =~ /^F/ ? 1 : 0);

  if ($letter eq 'F')
  {
    if (! $f_flag)
    {
      print "WARN Unexpected NL text ", $token->text(), " (F)\n";
      return 0;
    }
    elsif ($scoring eq 'P')
    {
      one_to_two_chains($chains, $chain, $token,
        'SINGLETON', 'STAGE', 'MARKER', 'ROUND', $1, $2);
    }
    elsif (exists $ITERATORS_NL{$tname})
    {
      one_to_two_chains($chains, $chain, $token,
        'SINGLETON', 'STAGE', 'MARKER', $ITERATORS_NL{$tname}, $1, $2);
    }
    else
    {
      one_to_two_chains($chains, $chain, $token,
        'SINGLETON', 'STAGE', 'MARKER', 'SEGMENT', $1, $2);
    }
    return 1;
  }
  elsif (exists $ITERATORS_NL{$tname})
  {
    $token->set_general('MARKER', $ITERATORS_NL{$tname}, $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  elsif ($stage =~ /final/i)
  {
    $token->set_general('MARKER', 'SEGMENT', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  else
  {
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  return 0;
}


sub event_generic_number
{
  my ($chains, $chain, $token, $tname, $stage, $scoring, $value) = @_;

  if (($scoring eq 'I' || $scoring eq 'B') && $stage =~ /final/i)
  {
    $token->set_general('MARKER', 'SEGMENT', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
  }
  else
  {
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
  }
  return 1;
}


sub post_process_stand_alone_number
{
  # There is one chain and it's a number, without a direct indication
  # of the name of the iterator.  We can use the title to guess with.

  my ($chains, $chain, $chains_title, $scoring, $bbono) = @_;
  
  my $token = $chain->check_out(0);
  my $field = $token->field();
  my $value = $token->value();

  my $cno;
  my $tname = find_field_in_chains($chains_title, 'TNAME', \$cno);

  my $stage = find_field_in_chains($chains_title, 'STAGE', \$cno);
  if (! $stage)
  {
    $stage = find_field_in_chains($chains, 'STAGE', \$cno);
  }

  if ($field eq 'NUMERAL')
  {
    if ($tname && exists $ITERATORS_NUMERAL{$tname})
    {
      my $iter = $ITERATORS_NUMERAL{$tname};
      $token->set_general('MARKER', $iter, $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    else
    {
      # print "TODO1 $bbono, $tname: $stage, $field, $value\n";
    }
  }
  elsif ($field eq 'N_OF_N')
  {
    if (! n_of_n($chain, $token, $tname, $stage, $$scoring, $value))
    {
      # print "TODO2 $bbono, $tname: $stage, $field, $value\n";
    }
  }
  elsif ($field eq 'MAJOR_MINOR')
  {
    if (! major_minor($chains, $chain, $token, $tname, $value))
    {
      print "TODO3 $bbono, $tname: $stage, $field, $value\n";
    }
  }
  elsif ($field eq 'NL')
  {
    if (! number_letter($chains, $chain, $token, 
        $tname, $stage, $$scoring, $value))
    {
      print "TODO4 $bbono, $tname: $stage, $field, $value\n";
    }
  }
  elsif ($field eq 'AMBIGUOUS' ||
      $field eq 'N_TO_N_OF_N' ||
      $field eq 'ORDINAL')
  {
    if (! event_generic_number($chains, $chain, $token, 
        $tname, $stage, $$scoring, $value))
    {
      print "TODO5 $bbono, $tname: $stage, $field, $value\n";
    }
  }
  else
  {
    print "TODO6 $bbono, $tname: $stage, $field, $value\n";
  }
}


sub get_next_one_chain
{
  # If forward_flag, then up in chain number, otherwise down.
  # Return 1 if that chain has exactly one token.

  my ($chains, $cno, $forward_flag, $token_ref) = @_;
   
  if ($forward_flag)
  {
    my $n = $#$chains;
    do
    {
      return 0 if $cno == $n;
      $cno++;
      my $chain_next = $chains->[$cno];
      my $status_next = $chain_next->status();

      if ($status_next ne 'KILLED')
      {
        return 0 if $chain_next->last() > 0;

        $$token_ref = $chain_next->check_out(0);
        return 1;
      }
    }
    while (1);
    return 0;
  }
  else
  {
    do
    {
      return 0 if $cno == 0;
      $cno--;
      my $chain_prev = $chains->[$cno];
      my $status_prev = $chain_prev->status();

      if ($status_prev ne 'KILLED')
      {
        return 0 if $chain_prev->last() > 0;

        $$token_ref = $chain_prev->check_out(0);
        return 1;
      }
    }
    while (1);
    return 0;
  }
}


sub process_front_number
{
  my ($chains, $chain, $cno, $chains_title, $scoring, $bbono) = @_;

  my $token = $chain->check_out(0);
  my $field = $token->field();
  my $value = $token->value();

  my $cnotmp;
  my $tname = find_field_in_chains($chains_title, 'TNAME', \$cnotmp);

  my $stage = find_field_in_chains($chains_title, 'STAGE', \$cnotmp);
  if (! $stage)
  {
    $stage = find_field_in_chains($chains, 'STAGE', \$cnotmp);
  }

  my $token2;
  if ($field eq 'AMBIGUOUS')
  {
    if (get_next_one_chain($chains, $cno, 1, \$token2) &&
      $token2->field() eq 'ROUND')
    {
      $token->set_general('MARKER', 'SESSION', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    else
    {
      print "TODOA $bbono, $tname: $stage, $field, $value\n";
    }
  }
  elsif ($scoring ne 'I' && $scoring ne 'B')
  {
    print "TODOB $bbono, $tname: $stage, $field, $value\n";
  }
  elsif ($stage =~ /final/i)
  {
    if ($field eq 'ORDINAL' || $field eq 'N_OF_N')
    {
      $token->set_general('MARKER', 'SEGMENT', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    else
    {
      print "TODOC $bbono, $tname: $stage, $field, $value\n";
    }
  }
  elsif ($field eq 'N_OF_N' &&
    ($value eq '1 of 16' || $value eq '1 of 32' || $value eq '1 of 64'))
  {
    $value =~ /1 of (\d+)/;
    my $n = $1;
    $token->set_general('MARKER', 'ROF', $n);
    $chain->complete_if_last_is(0, 'EXPLAINED');
  }
  elsif (get_next_one_chain($chains, $cno, 1, \$token2) &&
      ($token2->value() eq 'Round-robin' ||
       $token2->field() eq 'HALF'))
  {
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
  }
  else
  {
    print "TODOD $bbono, $tname: $stage, $field, $value\n";
  }
}


sub process_back_number
{
  my ($chains, $chain, $cno, $chains_title, $scoring, $bbono) = @_;

  my $token = $chain->check_out(0);
  my $field = $token->field();
  my $value = $token->value();

  my $cnotmp;
  my $tname = find_field_in_chains($chains_title, 'TNAME', \$cnotmp);

  my $stage = find_field_in_chains($chains_title, 'STAGE', \$cnotmp);
  if (! $stage)
  {
    $stage = find_field_in_chains($chains, 'STAGE', \$cnotmp);
  }

  my $token2;
  get_next_one_chain($chains, $cno, 0, \$token2);
  my $value2 = $token2->value();

  if ($field eq 'LETTER')
  {
    if ($scoring eq 'P' || $value2 !~ /final/i)
    {
      $token->set_general('MARKER', 'GROUP', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return 1;
    }
    else
    {
      $chain->complete_if_last_is(0, 'KILLED');
      return 1;
    }
  }
  elsif ($field eq 'AMBIGUOUS')
  {
    if ($tname eq 'Camrose')
    {
      $token->set_general('MARKER', 'STANZA', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return 1;
    }
    else
    {
      $token->set_general('MARKER', 'SESSION', $value);
      $chain->complete_if_last_is(0, 'EXPLAINED');
      return 1;
    }
  }
  elsif ($scoring eq 'P' ||
      $stage eq 'Round-robin' ||
      $value2 =~ /swiss/i ||
      $value2 =~ /danish/i ||
      $value2 =~ /pairs/i ||
      $value2 =~ /individual/i ||
      $stage eq 'Qualifying')
  {
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }
  elsif ($stage =~ /final/i || 
     $value2 =~ /^Rof/ ||
     $stage eq 'Elimination' ||
     $stage eq 'Playoff' ||
     $value2 eq 'Super League')
  {
    $token->set_general('MARKER', 'SEGMENT', $value);
    $chain->complete_if_last_is(0, 'EXPLAINED');
    return 1;
  }

  print "TODOX $bbono, $tname: $stage, $field, $value\n";
}


sub post_process_single_numerals
{
  my ($chains, $chains_title, $scoring, $bbono) = @_;

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

  if ($count_active == 1)
  {
    post_process_stand_alone_number($chains, $chain, $chains_title, 
      $scoring, $bbono);
    return;
  }
  elsif ($cno_single == 0)
  {
    process_front_number($chains, $chain, $cno_single, $chains_title, 
      $$scoring, $bbono);
    return;
  }
  elsif ($cno_single == $#$chains)
  {
    process_back_number($chains, $chain, $cno_single, $chains_title, 
      $$scoring, $bbono);
    return;
  }

  return;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    my $value = $token->value();

  my $cnotmp;
  my $tname = find_field_in_chains($chains_title, 'TNAME', \$cnotmp);

  my $stage = find_field_in_chains($chains_title, 'STAGE', \$cnotmp);
  if (! $stage)
  {
    $stage = find_field_in_chains($chains, 'STAGE', \$cnotmp);
  }


    print "TODOX $bbono, $tname: $stage, $field, $value\n";


  if ($field eq 'NUMERAL')
  {
    if ($cno_single == 0)
    {
        print "TODOA\n";
    }
    else
    {
      my $chain_prev = $chains->[$cno_single-1];
      my $status_prev = $chain_prev->status();
      if ($status_prev eq 'KILLED')
      {
        print "TODOB\n";
      }
      elsif ($chain_prev->last() > 0)
      {
        print "TODOC\n";
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

  post_process_single_numerals($chains, $chains_title, $scoring, $bbono);
}

1;
