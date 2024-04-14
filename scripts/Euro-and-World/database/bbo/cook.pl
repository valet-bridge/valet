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


my @FIELDS = qw(BBONO TITLE MONIKER DATE LOCATION EVENT 
  SEGMENT ROUND COUNTER
  RESTRICTION_ORIGIN FORM GENDER AGE
  SESSION SCORING TEAMS TEAM1 TEAM2);

die "perl cook.pl raw.txt" unless $#ARGV == 0;

my $file = $ARGV[0];

open my $fh, '<', $file or die "Cannot read tfile: $!";

my %chunk;
my $line;
my $lno = 0;
my $unknown = 0;

my @chain_stats;
my $time1 = 0;

my @reduction_stats;

while ($line = <$fh>)
{
  chomp $line;
  $line =~ s///g;
  $lno++;

  if ($line =~ /^\s*$/)
  {
    if (defined $chunk{Input} || ! defined $chunk{BBONO})
    {
      %chunk = ();
      next;
    }
    else
    {
      if ($chunk{BBONO} == 28588)
      {
        print "HERE\n";
      }

      my %result;
      study_teams($chunk{TEAMS}, \%result);

      # Fix some space-related issues.
      my $mashed = despace($chunk{EVENT});
      $mashed = unteam($mashed, \%result);

      my $chain = Chain->new();
      my @chains;
      push @chains, $chain;

      study_event($mashed, \%chunk, \%result, $chain, \$unknown);

      process_event(\@chains);

      process_patterns(\@EVENT_REDUCTIONS, \@chains, \@reduction_stats);

      # post_process_event(\%event_chains, \%event_solved);

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

        for my $chain_no (0 .. $#chains)
        {
          printf("Chain %d %2d %8s: %s\n",
            $chain_no,
            $chains[$chain_no]->last()+1,
            $chains[$chain_no]->status(),
            $chains[$chain_no]->text());
          printf("Chain %d %2d %8s: %s\n",
            $chain_no,
            $chains[$chain_no]->last()+1,
            $chains[$chain_no]->status(),
            $chains[$chain_no]->catcat());
        }
        printf "\n";
      }
    }
  }
  elsif ($line =~ /^([A-Za-z]+)\s+(.*)$/)
  {
    $chunk{$1} = $2;
  }
  else
  {
    print "$lno: CAN'T PARSE $line\n";
  }
}

close $fh;
print "TOTAL $unknown\n\n";

my %csum;
print "Chain stats\n\n";
printf("%6s%10s%10s%10s\n", "", "OPEN", "COMPLETE", "KILLED");
for my $i (0 .. $#chain_stats)
{
  my %h;
  for my $key (qw(OPEN COMPLETE KILLED))
  {
    if (exists $chain_stats[$i]{$key})
    {
      $h{$key} = $chain_stats[$i]{$key};
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

print "Reduction matches:\n";
for my $i (0 .. $#reduction_stats)
{
  next unless defined $reduction_stats[$i];
  printf("%6d%10d\n", $i, $reduction_stats[$i]);
}

sub print_chunk
{
  my $cref = pop;

  for my $field (@FIELDS)
  {
    if (defined $cref->{$field} && $cref->{$field} ne '')
    {
      print "$field $cref->{$field}\n";
    }
  }
  print "\n";
}

