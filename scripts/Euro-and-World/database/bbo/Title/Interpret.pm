#!perl

package Title::Interpret;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(interpret);

use lib './Connections';

use Connections::Matrix;
use Title::Tmatch;

my @ACCEPT_FIELDS = qw(AGE CITY CLUB COUNTRY DATE DATE_START DATE_END
  DAY FORM FLIGHT GENDER GROUP LOCALITY MATCH MEET MONTH MOVEMENT 
  NATIONALITY ORGANIZATION ORIGIN PERSON QUARTER REGION SCORING SECTION 
  SEGMENT SERIES SESSION SPONSOR STAGE STANZA TIME TNAME TWORD 
  UNIVERSITY WEEK WEEKDAY WEEKEND YEAR ZONE);

my @KILL_FIELDS = qw(ROOM);

my %ACCEPT = map { $_ => 1 } @ACCEPT_FIELDS;
my %KILL = map { $_ => 1 } @KILL_FIELDS;


# BBOVG numbers for which special occurrences are OK.
my %TITLE_MATCHES_ROUND;

sub init_hashes
{
  Title::Tmatch::set_tmatch_round(\%TITLE_MATCHES_ROUND);
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
      exists $TITLE_MATCHES_ROUND{$bbono})
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
  }
}


sub interpret
{
  my ($whole, $chains, $scoring, $bbono) = @_;

  post_process_single($chains, $bbono);
}

1;
