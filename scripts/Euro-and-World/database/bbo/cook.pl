#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';

use Despace;
use Chains;
use Chain;

use TeamBBO;
use EventBBO;
use EventRed;
use Patterns;

# Parse the raw output of
# ./reader -I ... -Q 9=4=0=0 -v 63
# especially w.r.t. EVENT

die "perl cook.pl raw.txt" unless $#ARGV == 0;

my @RAW_FIELDS = qw(BBONO TITLE EVENT SCORING TEAMS);

init_hashes();

read_cities();

my $file = $ARGV[0];
open my $fh, '<', $file or die "Cannot read tfile: $!";

my %chunk;
my $line;

my $lno = 0;
my $unknown = 0;
my @chain_stats;
my @reduction_stats;

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

  if ($chunk{BBONO} == 16603)
  {
    print "HERE\n";
  }

  my $chain1 = Chain->new();
  my $chain2 = Chain->new();
  my %result;
  study_teams($chunk{TEAMS}, \%result, $chain1, $chain2);

=pod
  # Fix some space-related issues.
  my $mashed = despace($chunk{EVENT});
  $mashed = unteam($mashed, \%result);

  my $chain = Chain->new();
  my @chains;
  push @chains, $chain;

  study_event($mashed, \%chunk, \%result, $chain, \$unknown);
  process_event(\@chains);
  process_patterns(\@EVENT_REDUCTIONS, \@chains, \@reduction_stats);

  my $open_flag = 0;
  for my $chain (@chains)
  {
    my $status = $chain->status();
    $chain_stats[$chain->last()+1]{$status}++;
    $open_flag = 1 if $status eq 'OPEN';
  }

  if ($open_flag)
  {
    print_chunk(\%chunk);
    print_chains(\@chains);
  }
=cut
}

close $fh;

print_team_stats();

# print "TOTAL $unknown\n\n";

# print_chain_stats(\@chain_stats);

# print_reduction_stats(\@reduction_stats);

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


sub print_chain_stats
{
  my $chain_stats = pop;

  my %csum;
  print "Chain stats\n\n";
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


sub print_reduction_stats
{
  my $reduction_stats = pop;

  print "Reduction matches:\n";
  for my $i (0 .. $#$reduction_stats)
  {
    next unless defined $reduction_stats->[$i];
    printf("%6d%10d\n", $i, $reduction_stats->[$i]);
  }
}

