#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';

use Despace;
use Tokenize;
use Chains;
use Chain;
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

my %event_stats;
my @chain_stats;
my $solved_count = 0;

my $time1 = 0;

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
      if ($chunk{BBONO} == 193)
      {
        print "HERE\n";
      }

      # Fix some space-related issues.
      my $mashed = despace($chunk{EVENT});

      my (%event_chains, %event_solved);

      my $chain = Chain->new();
      my @chains;
      push @chains, $chain;

      study_event($mashed, \%chunk, \%event_chains, $chain, \$unknown);

      process_event(\%event_chains, \%event_solved, \@chains);

      process_patterns(\%event_chains, \%event_solved);

      post_process_event(\%event_chains, \%event_solved);

      while (my ($key, $chain) = each %event_chains)
      {
        $chain_stats[$#$chain + 1]++ if $#$chain >= 0;

        for my $elem (@$chain)
        {
          $event_stats{$elem->{CATEGORY}}++;
        }
      }

      $solved_count += scalar keys %event_solved;

      if (open_chains(\%event_chains))
      {
        print_chunk(\%chunk);

        print_solved(\%event_solved);

        print_chains(\%event_chains);
      }
    }
  }
  else
  {
    if ($line !~ /^([A-Za-z]+)\s+(.*)$/)
    {
      print "$lno: CAN'T PARSE $line\n";
      next;
    }

    if ($1 eq 'TEAMS')
    {
      parse_teams($2, \%chunk);
    }
    else
    {
      $chunk{$1} = $2;
    }
  }
}

close $fh;
print "TOTAL $unknown\n\n";

print "Category stats\n";
my $cat_sum = 0;
for my $key (sort keys %event_stats)
{
  printf("%6d %s\n", $event_stats{$key}, $key);
  $cat_sum += $event_stats{$key} unless $key eq 'SEPARATOR';
}
print '-' x 20, "\n";
printf "%6d Effective sum\n\n", $cat_sum;

print "Chain stats\n";
my $chain_count = 0;
my $chain_prod = 0;
for my $i (0 .. $#chain_stats)
{
  my $count = $chain_stats[$i] // 0;
  printf "%4d %6d\n", $i, $count;
  $chain_count += $count;
  $chain_prod += $count * $i;
}
print '-' x 11, "\n";
printf "%4s %6.2f\n", "Avg", $chain_prod / $chain_count;
printf "%4s %6d\n\n", "Sum", $chain_count;

print "Solved $solved_count\n";


# sub mash
# {
  # my $text = pop;
  # my $res = $text;
  # $res =~ s/$MERGE_REGEX/$MERGE_HASH{lc($1)}/ge;
  # return $res;
# }


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


sub print_solved
{
  my $solved_ref = pop;

  my $num_keys = scalar keys %$solved_ref;
  if ($num_keys == 0)
  {
    print "Solved: Nothing\n";
    return;
  }

  print "Solved:\n";
  for my $key (sort keys %$solved_ref)
  {
    print $solved_ref->{$key}->str();
  }
  print "\n";
}


sub open_chains
{
  my $chains_ref = pop;

  my $chain_max = -1 + scalar keys %$chains_ref;

  for my $c (0 .. $chain_max)
  {
    my $chain = $chains_ref->{$c};
    return 1 if $#$chain >= 0;
  }
  return 0;
}


sub print_chains
{
  my $chains_ref = pop;

  my $chain_max = -1 + scalar keys %$chains_ref;

  my $hit = 0;
  for my $c (0 .. $chain_max)
  {
    my $chain = $chains_ref->{$c};
    next unless $#$chain >= 0;
    $hit = 1;

    print "Chain $c (", 1 + $#$chain, "): ", 
      join('|', map { $_->{text} } @$chain), "\n";
    print "Chain $c (", 1 + $#$chain, "): ", 
      join('|', map { $_->{VALUE} } @$chain), "\n";
    print "Chain $c (", 1 + $#$chain, "): ", 
      join('|', map { $_->{CATEGORY} } @$chain), "\n";
  }
  print "\n" if $hit;
}

