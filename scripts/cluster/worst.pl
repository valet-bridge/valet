#!perl

use strict;
use warnings;
use Scalar::Util 'looks_like_number';

# Parse the output from cluster.py for the board information.
# Show the N worst distances.

if ($#ARGV != 1)
{
  print "Usage: perl delta.pl file number\n";
  exit;
}

my $file = $ARGV[0];
my $number = $ARGV[1];

my (@store, @marginal_actual0, @marginal_pred0);
my $sum_act = 0;
my $sum_pred = 0;

read_board_file($file, \@store, \@marginal_actual0, \@marginal_pred0,
  \$sum_act, \$sum_pred);

my @sorted = sort {$b->{value} <=> $a->{value}} @store;

my $count = 0;
my $sum = 0.;
foreach my $rr (@sorted)
{
  printf("%-20s%8.4f\n", $rr->{key}, $rr->{unsquared});
  $count++;
  $sum += $rr->{value};
  last if ($count >= $number);
}
print "Sum of $number largest = $sum\n\n";

@marginal_actual0 = sort @marginal_actual0;
@marginal_pred0 = sort @marginal_pred0;

print "marginal for actual == 0:\n";
for my $x (@marginal_actual0)
{
  print "$x\n";
}
print "\n";

print "marginal for predicted == 0:\n";
for my $x (@marginal_pred0)
{
  print "$x\n";
}
print "\n";

print "sum actuals : $sum_act\n";
print "sum prediction : $sum_pred\n";


sub read_board_file
{
  my ($fname, $store_ref, $marg_act0_ref, $marg_pred0_ref,
    $sum_act_ref, $sum_pred_ref) = @_;
  open my $fr, '<', $fname or die "Can't open $fname: $!";

  my $sqdiff = 0.;
  my $tot = 0.;

  while (my $line = <$fr>)
  {
    chomp $line;
    $line =~ s///g;

    if ($line =~ /^BOARD/)
    {
      $line =~ /^BOARD\s+(.+)$/;
      my $tag = $1;
      my $actual;

      while ($line = <$fr>)
      {
        chomp $line;
        $line =~ s///g;
        if ($line =~ /^actual\s+(.+)/)
        {
          $actual = $1;
        }
        elsif ($line =~ /^predicted\s+(.+)/)
        {
          my $pred = $1;
          my $diff = abs($pred - $actual);
          $sqdiff = ($pred - $actual) ** 2;
          $tot += $sqdiff;

          $$sum_act_ref += $actual;
          $$sum_pred_ref += $pred;

          push @$store_ref, { 'key' => $tag, 'value' => $sqdiff,
            'unsquared' => $diff };

          if ($pred == 0.)
          {
            push @$marg_pred0_ref, $actual if $actual > 0.;
          }
          if ($actual == 0.)
          {
            push @$marg_act0_ref, $pred if $pred > 0.;
          }
          last;
        }
      }
    }
  }
  print "tot $tot\n";
}

