#!perl

package Event::Interpret;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(interpret);

use lib './Connections';

use Connections::Matrix;
use Event::Ematch;

my @ACCEPT_FIELDS = qw(AGE COLOR DATE GENDER MONTH_DAY MOVEMENT 
  PLACE SCORING SECTION WEEK WEEKDAY WEEKEND YEAR YEAR_MONTH);

my @KILL_FIELDS = qw(ROOM);

# ROUND SEGMENT SESSION STANZA TABLE

my %ACCEPT = map { $_ => 1 } @ACCEPT_FIELDS;
my %KILL = map { $_ => 1 } @KILL_FIELDS;


# BBOVG numbers for which special occurrences are OK.
my %EVENT_MATCHES;

sub init_hashes
{
  Event::Ematch::set_ematch(\%EVENT_MATCHES);
}


sub post_process_single
{
  my ($chains) = @_;

  # Check for a last chain with only a numeral.
  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token0 = $chain->check_out(0);
    my $field0 = $token0->field();

    if (exists $ACCEPT{$field0})
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


sub find_field_in_chains
{
  my ($chains, $tag, $cno_found) = @_;

  my $found = 0;
  my $value;

  for my $cno (0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq $tag;

    $$cno_found = $cno;
    return $token->value();
    last;
  }

  return 0;
}


sub interpret
{
  my ($whole, $chains, $scoring, $bbono) = @_;

  post_process_single($chains);
}

1;
