#!perl

package Title::Interpret;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(interpret deteam);

use lib './Connections';

use Connections::Matrix;
use Title::Tmatch;
use Util;

my @ACCEPT_FIELDS = qw(AGE CITY CLUB COUNTRY DATE DATE_START DATE_END
  DAY FORM FLIGHT GENDER GROUP HALF LOCALITY MATCH MEET MONTH MOVEMENT 
  NATIONALITY ORGANIZATION ORIGIN PERSON PLACE PHASE QUARTER REGION ROF
  ROUND SCORING SECTION SEGMENT SERIES SESSION SPONSOR STAGE STANZA 
  TABLE TIME TNAME TWORD UNIVERSITY WEEK WEEKDAY WEEKEND YEAR ZONE);

my @KILL_FIELDS = qw(ROOM);

my %ACCEPT = map { $_ => 1 } @ACCEPT_FIELDS;
my %KILL = map { $_ => 1 } @KILL_FIELDS;


my %RECOGNIZE_LETTER_GROUPS =
(
  'European National Championships' => 1,
  'European Bridge Teams Championship' => 1,
  'European Open Bridge Championship' => 1,
  'Sunchime Fund Cup' => 1,
  'World Mind Games' => 1,
  'World Women Elite Tournament' => 1
);


# BBOVG numbers for which special occurrences are OK.
my %TITLE_MATCHES_ROUND;
my %TITLE_MATCHES_SCORING;
my %TITLE_MATCHES_INTUIT;

sub init_hashes
{
  Title::Tmatch::set_tmatch_round(\%TITLE_MATCHES_ROUND);
  Title::Tmatch::set_tmatch_scoring(\%TITLE_MATCHES_SCORING);
  Title::Tmatch::set_tmatch_intuit(\%TITLE_MATCHES_INTUIT);
}


sub post_process_single
{
  my ($chains, $scoring, $bbono) = @_;

  # Check for a last chain with only a numeral.
  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token0 = $chain->check_out(0);
    my $field0 = $token0->field();

    if ($field0 eq 'ROUND' &&
      exists $TITLE_MATCHES_ROUND{$bbono})
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($field0 eq 'SCORING')
    {
      my $full = $token0->value();
      my $short = scoring_full_to_short($full);
      if ($short ne $$scoring)
      {
        if (exists $TITLE_MATCHES_SCORING{$bbono})
        {
          $$scoring = $short;
        }
        elsif (! exists $TITLE_MATCHES_INTUIT{$bbono})
        {
          warn "$bbono: Got $full -> $short, expected $$scoring";
        }
      }

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
  }
}


# Fields that appear in title teams.

my %TEAM_FIELDS = 
(
  AGE => 1,
  CAPTAIN => 1,
  CITY => 1,
  COUNTRY => 1,
  GENDER => 1,
  REGION => 1,
  SPONSOR => 1
);


sub field_found_in
{
  my ($value, $field, $list) = @_;

  return 0 unless exists $list->{$field};
  for my $entry (@{$list->{$field}})
  {
    return 1 if $value eq lc($entry);
  }
  return 0;
}


sub post_process_title_teams
{
  my ($chains, $teams, $bbono) = @_;

  my %matches = (TEAM1 => 0, TEAM2 => 0);
  my %counts = (TEAM1 => 0, TEAM2 => 0);
  my $captain_no = 1;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';

    for my $i (0 .. $chain->last())
    {
      my $token = $chain->check_out($i);
      my $field = $token->field();
      if ($field =~ /^(TEAM\d)_(.*)$/)
      {
        my ($team, $main) = ($1, $2);
        $counts{$team}++;
        for my $t (qw(TEAM1 TEAM2))
        {
          $matches{$t}++ if 
            field_found_in(lc($token->value()), $main, $teams->{$t});
        }
      }
      elsif ($field eq 'CAPTAIN' || $field eq 'COUNTRY')
      {
        $counts{'TEAM' . $captain_no}++;
        $captain_no++;
        for my $t (qw(TEAM1 TEAM2))
        {
          $matches{$t}++ if 
            field_found_in(lc($token->value()), $field, $teams->{$t});
        }
      }
    }
  }

  return unless $counts{TEAM1} > 0 || $counts{TEAM2} > 0;

  # Something like 'Open' can occur multiple times.
  if (($matches{TEAM1} >= $counts{TEAM1} &&
       $matches{TEAM2} >= $counts{TEAM2})  ||
      ($matches{TEAM1} >= $counts{TEAM2} &&
       $matches{TEAM2} >= $counts{TEAM1}))
  {
    # Perfect matches.
    for my $chain (@$chains)
    {
      # next if $chain->status() eq 'KILLED' || 
        # $chain->status() eq 'EXPLAINED';
      next if $chain->status() eq 'KILLED';

      my $token = $chain->check_out(0);
      my $field = $token->field();
      next unless $field =~ /^(TEAM\d)_(.*)$/ || 
        $field eq 'CAPTAIN' ||
        $field eq 'COUNTRY';

      $chain->complete_if_last_is($chain->last(), 'KILLED');
    }
  }
}


sub post_process_captains
{
  my ($chains, $teams, $bbono) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED' || $chain->status() eq 'EXPLAINED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    if ($token->field() eq 'CAPTAIN')
    {
      my $value = $token->value();
      if ($value eq 'Angelini' || $value eq 'Assael' ||
          $value eq 'Carlos Ferreira' || $value eq 'Evgueni Gladysh' ||
          $value eq 'Prashant Desai' || $value eq 'Rui Pinto')
      {
        $token->set_general('SINGLETON', 'PERSON', $value);
        $chain->complete_if_last_is($chain->last(), 'EXPLAINED');
      }
    }
  }
}


sub post_process_leading_number
{
  my ($chains, $teams, $bbono) = @_;

  return unless $#$chains >= 0;
  my $chain = $chains->[0];

  return if $chain->status() eq 'KILLED' || $chain->status() eq 'EXPLAINED';
  return unless $chain->last() == 0;

  my $token = $chain->check_out(0);
  my $field = $token->field();
  if ($field eq 'NUMERAL' || $field eq 'ORDINAL' || $field eq 'ROMAN')
  {
    $token->set_general('COUNTER', 'ORDINAL', $token->value());
    $chain->complete_if_last_is(0, 'EXPLAINED');
  }
  elsif ($field eq 'PARTICLE' && lc($token->value()) eq 'vs')
  {
    # I don't know what this occasional leading VS is.
    $chain->complete_if_last_is(0, 'KILLED');
  }
}


sub post_process_maybe_rof
{
  my ($chains, $bbono) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    next unless $token->field() eq 'ROUND';

    my $value = $token->value();
    next unless $value =~ /^(\d+)[A-Za-z]*$/;
    my $r = $1;
    next unless $r == 8 || $r == 16 || $r == 32 || $r == 64;
    
    my $cno;
    my $tname = find_field_in_chains($chains, 'TNAME', \$cno);
    next unless $tname;

    if ($tname eq 'Spingold Teams' || 
        $tname eq 'Vanderbilt Teams' ||
        $tname eq 'Baze Senior Knock-out' ||
        $tname eq 'United States Bridge Championship')
    {
      $token->set_general('MARKER', 'STAGE', 'Rof' . $r);
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
  }
}


sub fix_metals
{
  my ($chains, $knowledge, $bbono) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() ne 'COMPLETE';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $value = $token->value();
    next unless $token->field() eq 'CAPTAIN' &&
      ($value eq 'Silver' || $value eq 'Gold');

    my $meet = $knowledge->get_field('MEET', $bbono);
    next unless $meet eq 'Tolani Summer Nationals';

    if ($value eq 'Silver')
    {
      $token->set_general('SINGLETON', 'TNAME', 'Tolani Silver Cup');
      $chain->complete('EXPLAINED');
    }
    else
    {
      $token->set_general('SINGLETON', 'TNAME', 'Tolani Gold Trophy');
      $chain->complete('EXPLAINED');
    }
  }
}


sub finish_numeral
{
  my ($whole, $chains, $chain, $cno,
    $knowledge, $token, $field, $value, $bbono) = @_;

  my $meet = $knowledge->get_field('MEET', $bbono);
  my $tname = $knowledge->get_field('TNAME', $bbono);

  if ($meet eq 'Winter Nationals' ||
      $tname eq 'Gabrial UI Bastaman Cup' ||
      $tname eq 'Geologi Cup' ||
      $tname eq "Kepri Governor's Cup")
  {
    $token->set_general('COUNTER', 'ORDINAL', $value);
    $chain->complete('EXPLAINED');
    return 1;
  }

  # Bit of a kludge for a numeral preceded by 'RR'.
  if ($cno > 0)
  {
    my $chain_prev = $chains->[$cno-1];
    if ($chain_prev->last() == 0)
    {
      my $token_prev = $chain_prev->check_out(0);
      if ($token_prev->value() eq 'Round-robin')
      {
        # That makes the numeral a ROUND.
        $token->set_general('MARKER', 'ROUND', $value);
        $chain->complete('EXPLAINED');
        return 1;
      }
    }
  }

  # Drop the numeral.
  $chain->complete('KILLED');
  return 1;
}


sub finish_n_of_n
{
  my ($chains, $chain, $knowledge, $token, $field, $value, $bbono) = @_;

  my $tname = $knowledge->get_field('TNAME', $bbono);
  my $movement = $knowledge->get_field('MOVEMENT', $bbono);

  if ($tname =~ /Cavendish/ ||
      $movement eq 'Round-robin' ||
      $movement eq 'Swiss')
  {
    $token->set_general('MARKER', 'ROUND', $value);
    $chain->complete('EXPLAINED');
    return 1;
  }
  elsif ($tname eq 'Division Nationale')
  {
    $chain->complete('KILLED');
    return 1;
  }

  # Look for a MARKER token with the same value.
  for my $field0 (qw(GROUP SESSION SEGMENT ROUND))
  {
    my $value0 = $knowledge->get_field($field0, $bbono);
    next unless $value0 eq $value;

    $chain->complete('KILLED');
    return 1;
  }

  return 0;
}


sub finish_letter
{
  my ($chain, $knowledge, $token, $field, $value, $bbono) = @_;

  my $meet = $knowledge->get_field('MEET', $bbono);
  my $tname = $knowledge->get_field('TNAME', $bbono);
  my $movement = $knowledge->get_field('MOVEMENT', $bbono);
  my $stage = $knowledge->get_field('STAGE', $bbono);

  if ($knowledge->is_knock_out($bbono) ||
      $movement eq 'Round-robin' ||
      $stage =~ /^Rof/ ||
      $stage eq 'Qualifying')
  {
    $chain->complete('KILLED');
    return 1;
  }
  elsif (exists $RECOGNIZE_LETTER_GROUPS{$meet} ||
         exists $RECOGNIZE_LETTER_GROUPS{$tname} ||
         $movement eq 'Swiss')
  {
    $token->set_general('MARKER', 'GROUP', $value);
    $chain->complete('EXPLAINED');
    return 1;
  }
  else
  {
    $chain->complete('KILLED');
    return 1;
  }
}


sub finish_ordinal
{
  my ($whole, $chains, $chain, 
    $knowledge, $token, $field, $value, $bbono) = @_;

  my $meet = $knowledge->get_field('MEET', $bbono);
  my $tname = $knowledge->get_field('TNAME', $bbono);
  my $movement = $knowledge->get_field('MOVEMENT', $bbono);
  my $stage = $knowledge->get_field('STAGE', $bbono);

  if ($tname eq 'Vanderbilt Teams' || 
      $tname eq 'Spingold Teams')
  {
    $chain->complete('KILLED');
    return 1;
  }
  elsif ($tname eq 'Reisinger BAM Teams')
  {
    $token->set_general('MARKER', 'SESSION', $value);
    $chain->complete('EXPLAINED');
    return 1;
  }
  elsif ($tname eq 'NEC Cup')
  {
    $chain->complete('EXPLAINED');
    return 1;
  }

  # Bit of a kludge, but it catches a lot of cases.
  # TODO Make a method, clean up.

  if ($#$chains >= 2 &&
      $chains->[1]->status() eq 'COMPLETE' &&
      $chains->[1]->check_out(0)->field() eq 'ORDINAL')
  {

  if ($chains->[0]->status() eq 'KILLED')
  {
    # It's simply an ordinal.
    $chain->complete('EXPLAINED');
    return 1;
  }
  elsif ($chains->[0]->status() eq 'EXPLAINED')
  {
    if ($chains->[0]->check_out(0)->field eq 'TNAME')
    {
      # Probably there are two TNAME's, so call it an ordinal.
      $chain->complete('EXPLAINED');
      return 1;
    }

    # Maybe the ordinal is interspersed between two parts of the
    # tournament name.

    my $composite = $chains->[0]->check_out(0)->value();
    my $found = 0;
    my $cno_found;
    my $tname_comp = '';
    my $meet_comp = '';

    for my $cno (2 .. $#$chains)
    {
      my $elem = $chains->[$cno]->check_out(0)->text();
      $composite .= ' ' .  $elem;

      $tname_comp = $whole->get_multi('TNAME', lc($composite));
      if (defined $tname_comp)
      {
        $found = 1;
        $cno_found = $cno;
        last;
      }

      $meet_comp = $whole->get_multi('MEET', lc($composite));
      if (defined $meet_comp)
      {
        $found = 1;
        $cno_found = $cno;
        last;
      }
    }

    if ($found)
    {
      $chains->[0]->complete('KILLED');
      $chains->[1]->complete('EXPLAINED');
      $chains->[2]->complete('EXPLAINED');

      my $token = $chains->[2]->check_out(0);

      if ($tname_comp)
      {
        $token->set_general('SINGLETON', 'TNAME', $tname_comp);
      }
      elsif ($meet_comp)
      {
        $token->set_general('SINGLETON', 'MEET', $meet_comp);
      }
      else
      {
        die "Odd";
      }

      for my $cno (3 .. $cno_found)
      {
        $chains->[$cno]->complete('KILLED');
      }
      return 1;
    }
  }

  }

  if ($value > 12)
  {
    $chain->complete('EXPLAINED');
    return 1;
  }

  return 0;
}


sub finish_nl
{
  my ($chain, $knowledge, $token, $field, $value, $bbono) = @_;

  my $tname = $knowledge->get_field('TNAME', $bbono);
  if ($tname eq 'Camrose')
  {
    $token->set_general('MARKER', 'MATCH', $value);
    $chain->complete('EXPLAINED');
    return 1;
  }
  else
  {
    # Can probably ignore.
    $chain->complete('KILLED');
    return 1;
  }
}


sub finish_roman
{
  my ($chain, $knowledge, $token, $field, $value, $bbono) = @_;

  my $tname = $knowledge->get_field('TNAME', $bbono);
  if ($value eq '5' && $token->text() eq 'v')
  {
    # Probably a left-over 'v' for vs.
    $chain->complete('KILLED');
    return 1;
  }
  elsif ($value > 12)
  {
    $token->set_general('COUNTER', 'ORDINAL', $value);
    $chain->complete('EXPLAINED');
    return 1;
  }
  elsif ($tname eq 'Chilean Team Trials' ||
      $tname eq 'Swedish District Championship' ||
      $tname eq 'Romanian League')
  {
    # Ignore Roman.
    $chain->complete('KILLED');
    return 1;
  }
  else
  {
    # Roman is OK.
    $token->set_general('COUNTER', 'ORDINAL', $value);
    $chain->complete('EXPLAINED');
    return 1;
  }
}


sub finish_ambiguous
{
  my ($chains, $chain, $cno,
    $knowledge, $token, $field, $value, $bbono) = @_;

  my $meet = $knowledge->get_field('MEET', $bbono);
  my $tname = $knowledge->get_field('TNAME', $bbono);

  if ($value =~ / of / ||
      $tname =~ /Cavendish/ ||
      $tname eq 'Tolani Grand Prix' ||
      $tname eq 'Greek Open Trials' ||
      $tname eq 'Portuguese Open Teams' ||
      $tname eq 'Portuguese Club Teams')
  {
    $token->set_general('MARKER', 'SESSION', $value);
    $chain->complete('EXPLAINED');
    return 1;
  }
  elsif ($tname eq 'Reisinger BAM Teams')
  {
    if ($value =~ /^S (\d+)$/)
    {
      $token->set_general('MARKER', 'SESSION', $1);
      $chain->complete('EXPLAINED');
    }
    elsif ($value =~ /^[FG]$/)
    {
      $token->set_general('MARKER', 'GROUP', $value);
      $chain->complete('EXPLAINED');
    }
    else
    {
      $token->set_general('MARKER', 'SESSION', $value);
      $chain->complete('EXPLAINED');
    }
    return 1;
  }
  elsif ($tname eq 'Camrose' && $value =~ '^W (\d+)$')
  {
    $token->set_general('MARKER', 'WEEKEND', $1);
    $chain->complete('EXPLAINED');
    return 1;
  }
  elsif ($meet eq 'United States Bridge Championship' ||
      $tname eq 'Gianarrigo Rona Trophy' ||
      $tname eq 'Prince Takamatsu Cup' ||
      $tname eq 'World Youth Bridge Congress' ||
      $tname eq 'ASEAN Club Championship')
  {
    $token->set_general('MARKER', 'STAGE', 'Final');
    $chain->complete('EXPLAINED');
    return 1;
  }
  elsif ($meet eq 'World Mind Games' ||
      $tname eq 'IMSA Elite Mind Games')
  {
    if ($value =~ /^O (\d+)$/)
    {
      one_to_two_chains($chains, $chain, $cno, $token,
        'SINGLETON', 'GENDER', 'Open',
        'SINGLETON', 'AGE', 'Open');
      return 1;
    }
    elsif ($value =~ /^W (\d+)$/)
    {
      $token->set_general('SINGLETON', 'GENDER', 'Women');
      $chain->complete('EXPLAINED');
      return 1;
    }
    elsif ($value =~ /^S (\d+)$/)
    {
      $token->set_general('SINGLETON', 'AGE', 'Seniors');
      $chain->complete('EXPLAINED');
      return 1;
    }
  }
  elsif ($meet eq 'European National Championships' ||
    $tname eq 'World Transnational Teams' ||
    $tname eq 'Reisinger BAM Teams' ||
    $tname eq 'Bermuda Bowl' ||
    $tname eq 'Venice Cup' ||
    $tname eq "d'Orsi")
  {
    $chain->complete('KILLED');
    return 1;
  }

  return 0;
}


sub post_process_single_active
{
  my ($whole, $knowledge, $chains, $chain, $cno, $bbono) = @_;

  my $token = $chain->check_out(0);
  my $field = $token->field();
  my $value = $token->value();

  my $tname = $knowledge->get_field('TNAME', $bbono);
  my $form = $knowledge->get_field('FORM', $bbono);
  my $mask = $knowledge->get_iter_mask($bbono);

  if ($field eq 'NUMERAL')
  {
    return if finish_numeral($whole, $chains, 
      $chain, $cno, $knowledge, $token, $field, $value, $bbono);
  }
  elsif ($field eq 'N_OF_N')
  {
    return if finish_n_of_n($chains, $chain, $knowledge, 
      $token, $field, $value, $bbono);
  }
  elsif ($field eq 'LETTER')
  {
    if ((lc($value) ge 'a' && lc($value) le 'e') || $value eq 'H')
    {
      return if finish_letter($chain, 
        $knowledge, $token, $field, $value, $bbono);
    }
  }
  elsif ($field eq 'ORDINAL')
  {
    return if finish_ordinal($whole, $chains, 
      $chain, $knowledge, $token, $field, $value, $bbono);
  }
  elsif ($field eq 'NL')
  {
    return if finish_nl($chain, $knowledge, 
      $token, $field, $value, $bbono);
  }
  elsif ($field eq 'ROMAN')
  {
    return if finish_roman($chain, $knowledge, 
      $token, $field, $value, $bbono);
  }
  elsif ($field eq 'AMBIGUOUS')
  {
    return if finish_ambiguous($chains, $chain, $cno, $knowledge, 
      $token, $field, $value, $bbono);
  }

  print "TODOX " . $knowledge->str($bbono) . ", $field, $value\n";
}


sub post_process_pair
{
  my ($knowledge, $chain0, $chain1, $cno0, $cno1, $bbono) = @_;

  my $token0 = $chain0->check_out(0);
  my $token1 = $chain1->check_out(0);

  my $tname = $knowledge->get_field('TNAME', $bbono);

  my $field0 = $token0->field();
  my $field1 = $token1->field();
  my $value0 = $token0->value();
  my $value1 = $token1->value();

  if ($cno0 == 0 && $cno1 <= 2 &&
      $field0 eq 'LETTER' && lc($value0) ge 'a' && lc($value0) le 'e' &&
      ($field1 eq 'ORDINAL' || ($field1 eq 'NUMERAL' && $value1 >= 12)))
  {
    $chain0->complete('KILLED');

    $token1->set_general('COUNTER', 'ORDINAL', $value1);
    $chain1->complete('EXPLAINED');
    return 1;
  }
  elsif ($tname eq 'European Open Bridge Championship' &&
    $field0 eq 'LETTER' && $field1 eq 'NUMERAL')
  {
    $chain0->complete('KILLED');
    $chain1->complete('KILLED');
    return 1;
  }
  elsif ($tname eq 'Romanian League' &&
    $field0 eq 'ROMAN' && $field1 eq 'LETTER')
  {
    $chain0->complete('KILLED');
    $chain1->complete('KILLED');
    return 1;
  }
  elsif ($tname eq 'Division Nationale' &&
    $field0 eq 'NUMERAL' && $field1 eq 'NUMERAL')
  {
    $chain0->complete('KILLED');
    $chain1->complete('KILLED');
    return 1;
  }
  elsif ($tname eq 'Chilean Team Trials' &&
    $field0 eq 'ROMAN' && $field1 eq 'ROMAN')
  {
    $chain0->complete('KILLED');
    $chain1->complete('KILLED');
    return 1;
  }

  print "TODOY " . $knowledge->str($bbono) . ", [$cno0: $field0, $value0], " .
    "[$cno1: $field1, $value1]\n";
}


sub post_process_single_numerals
{
  my ($chains, $whole, $knowledge, $stretch, $actives, $bbono) = @_;

  my ($cno0, $cno1) = ($stretch->[0], $stretch->[1]);

  if ($#$actives == 0)
  {
    post_process_single_active($whole, $knowledge,
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

  post_process_pair($knowledge, $chain0, $chain1, 
    $actives->[0], $actives->[1], $bbono);
}


sub interpret
{
  my ($whole, $chains, $scoring, $bbono) = @_;

  post_process_single($chains, $scoring, $bbono);
  post_process_maybe_rof($chains, $bbono);
}


sub deteam
{
  my ($chains, $teams, $bbono) = @_;

  post_process_title_teams($chains, $teams, $bbono);
  post_process_captains($chains, $bbono);
  post_process_leading_number($chains, $bbono);
}


sub finish
{
  my ($whole, $chains_title, $chains_event, $scoring, $bbono) = @_;

  my $knowledge = Knowledge->new();
  $knowledge->add_explained_chains($chains_title, $bbono);
  $knowledge->add_explained_chains($chains_event, $bbono);
  $knowledge->add_field('SCORING', $$scoring, $bbono);

  # A special case: There are both players and tournaments with
  # Silver and Gold in them.
  fix_metals($chains_title, $knowledge, $bbono);

  my (@stretches, @actives);
  post_process_analyze_rest($chains_title, \@stretches, \@actives, $bbono);

  return if $#stretches == -1;

  for my $s (0 .. $#stretches)
  {
    post_process_single_numerals($chains_title,
      $whole, $knowledge, $stretches[$s], $actives[$s], $bbono);
  }
}


1;
