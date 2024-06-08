#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';
use lib './Event';

use Chains;
use Chain;

use TeamBBO;
use EventBBO;

use Event::Despace;
use Event::Patterns;
use Event::Reductions;


# Parse the raw output of
# ./reader -I ... -Q 9=4=0=0 -v 63

die "perl cook.pl raw.txt" unless $#ARGV == 0;

my $do_events = 1; # 1 if we parse EVENT

my @RAW_FIELDS = qw(BBONO TITLE EVENT SCORING TEAMS);

init_hashes();
read_cities();

my $file = $ARGV[0];
open my $fh, '<', $file or die "Cannot read tfile: $!";

my %chunk;
my $line;

my $lno = 0;
my (@chain_team_stats, @chain_event_stats, @reduction_event_stats);
my $unknown_events = 0;

while ($line = <$fh>)
{
  chomp $line;
  $line =~ s///g;
  $lno++;

  if ($line =~ /^([A-Za-z]+)\s+(.*)$/)
  {
    $chunk{$1} = $2;
    next;
  }
  elsif ($line !~ /^\s*$/)
  {
    print "$lno: CAN'T PARSE $line\n";
    next;
  }

  if (defined $chunk{Input} || ! defined $chunk{BBONO})
  {
    %chunk = ();
    next;
  }

  if ($chunk{BBONO} == 99999)
  {
    print "HERE\n";
  }

  # TEAMS

  my $chain_team1 = Chain->new();
  my $chain_team2 = Chain->new();
  my %result;
  study_teams($chunk{TEAMS}, \%result, 
    $chain_team1, $chain_team2, $chunk{BBONO});

  update_chain_team_stats($chain_team1, \@chain_team_stats);
  update_chain_team_stats($chain_team2, \@chain_team_stats);


  if ($do_events)
  {
    # EVENT: Fix some space-related issues.
    my $mashed = despace($chunk{EVENT});
    $mashed = unteam($mashed, \%result);

    my $chain_event = Chain->new();
    my @chains_event;
    push @chains_event, $chain_event;

    study_event($mashed, \%chunk, \%result, $chain_event, \$unknown_events);
    process_event(\@chains_event);
    process_patterns(\@EVENT_REDUCTIONS, \@chains_event, 
      \@reduction_event_stats);

  update_chain_event_stats(\%chunk, \@chains_event, \@chain_event_stats);
  }
}

close $fh;

print_team_stats();
print_team_chain_stats(\@chain_team_stats);

if ($do_events)
{
  print_event_chain_stats(\@chain_event_stats);
  print_event_reduction_stats(\@reduction_event_stats);
  print "\nTotal unknown events: $unknown_events\n\n";
}

exit;


sub print_chunk
{
  my $cref = pop;

  for my $field (@RAW_FIELDS)
  {
    if (defined $cref->{$field} && $cref->{$field} ne '')
    {
      print "$field $cref->{$field}\n";
    }
  }
  print "\n";
}


sub print_chains
{
  my $chains = pop;

  for my $chain_no (0 .. $#$chains)
  {
    my $chain = $chains->[$chain_no];
    printf("Chain %d %2d %8s: %s\n",
      $chain_no,
      $chain->last()+1,
      $chain->status(),
      $chain->text());
      printf("Chain %d %2d %8s: %s\n",
      $chain_no,
      $chain->last()+1,
      $chain->status(),
      $chain->catcat());
  }
  printf "\n";
}


sub update_chain_team_stats
{
  my ($chain, $chain_team_stats) = @_;

  $chain_team_stats->[$chain->last()+1]++;

  if ($chain->last() > 100)
  {
    print $chunk{BBONO}, ":\n";
    print $chain->text(), "\n";
    print $chain->catcat(), "\n";
    print $chain->fields(), "\n\n";
  }
}


sub update_chain_event_stats
{
  my ($chunk, $chains, $chain_event_stats) = @_;

  my $open_flag = 0;
  for my $chain (@$chains)
  {
    my $status = $chain->status();
    $chain_event_stats->[$chain->last()+1]{$status}++;
    $open_flag = 1 if $status eq 'OPEN';
  }

  if ($open_flag)
  {
    print_chunk($chunk);
    print_chains($chains);
  }
}

sub print_team_chain_stats
{
  my ($chain_team_stats) = @_;

  print "\nTeam chain stats\n\n";
  for my $i (0 .. $#$chain_team_stats)
  {
    printf ("%4d %6d\n", $i, $chain_team_stats->[$i]);
  }
}


sub print_event_chain_stats
{
  my $chain_stats = pop;

  my %csum;
  print "\nEvent chain stats\n\n";
  printf("%6s%10s%10s%10s\n", "", "OPEN", "COMPLETE", "KILLED");

  for my $i (0 .. $#$chain_stats)
  {
    my %h;
    for my $key (qw(OPEN COMPLETE KILLED))
    {
      if (exists $chain_stats->[$i]{$key})
      {
        $h{$key} = $chain_stats->[$i]{$key};
      }
      else
      {
        $h{$key} = 0;
      }
      $csum{$key} += $h{$key};
    }
    printf("%6d%10d%10d%10d\n", $i, $h{OPEN}, $h{COMPLETE}, $h{KILLED});
  }

  print '-' x 36, "\n";
  printf("%6s%10d%10d%10d\n\n", "Sum",
    $csum{OPEN}, $csum{COMPLETE}, $csum{KILLED});
}


sub print_event_reduction_stats
{
  my $reduction_stats = pop;

  print "Event reduction matches\n\n";
  for my $i (0 .. $#$reduction_stats)
  {
    next unless defined $reduction_stats->[$i];
    printf("%6d%10d\n", $i, $reduction_stats->[$i]);
  }
}

