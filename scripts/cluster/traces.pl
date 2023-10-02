#!perl

use strict;
use warnings;

# Parse the output of correlate.py and make traces for each
# distribution and suit separateley.

if ($#ARGV != 0)
{
  print "Usage: perl traces.pl file\n";
  exit;
}

my $fname = $ARGV[0];

my (@dist_traces, @suit_traces);
my $dist_block_counter = 0;
my $suit_block_counter = 0;
my @iter_names;

open my $fr, '<', $fname or die "Can't open $fname: $!";

my ($iter_global, $iter_lp);

while (my $line = <$fr>)
{
  chomp $line;
  $line =~ s///g;

  if ($line =~ /^Starting overall iteration (\d+)/)
  {
    $iter_global = $1;
  }
  elsif ($line =~ /^LP iteration\s+(\d+)/)
  {
    $iter_lp = $1;
  }
  elsif ($line =~ /^Distribution variables/)
  {
    $iter_names[$dist_block_counter] = "${iter_global}-${iter_lp}";

    $line = <$fr>; # Empty
    my $dist_line_counter = 0;
    while ($line = <$fr>)
    {
      chomp $line;
      $line =~ s///g;
      last if ($line =~ /^\s*$/);

      my @a = split /\s+/, $line;

      update_trace(\@dist_traces,
        \@a, $dist_block_counter, $dist_line_counter);
      $dist_line_counter++;
    }
    $dist_block_counter++;
  }
  elsif ($line =~ /^Suit variables/)
  {
    $line = <$fr>; # Empty
    my $suit_line_counter = 0;
    while ($line = <$fr>)
    {
      chomp $line;
      $line =~ s///g;
      last if ($line =~ /^\s*$/);

      my @a = split /\s+/, $line;

      update_trace(\@suit_traces,
        \@a, $suit_block_counter, $suit_line_counter);
      $suit_line_counter++;
    }
    $suit_block_counter++;
  }
}

print_trace(\@dist_traces, "Distribution");
print_trace(\@suit_traces, "Suit");

print_avg20(\@dist_traces);
print_avg20(\@suit_traces);



sub print_avg20
{
  my($traces_ref, $name) = @_;
  for my $index (0 .. $#$traces_ref)
  {
    my $last_iter = $#{$traces_ref->[$index]};

    printf("%6s%16s%10.4f\n", 
      $traces_ref->[$index][0]{suitno},
      $traces_ref->[$index][0]{text},
      $traces_ref->[$index][$last_iter]{avg20});
  }
  print "\n";
}


sub print_trace
{
  my($traces_ref, $name) = @_;
  for my $index (0 .. $#$traces_ref)
  {
    print("$name ", $traces_ref->[$index][0]{suitno}, ", ",
      $traces_ref->[$index][0]{text}, "\n\n");

    printf("%-4s%10s%10s%10s%10s%10s\n", "no", "value",
      "delta6", "delta20", "avg6", "avg20");
    for my $iter (0 .. $#{$traces_ref->[$index]})
    {
      if ($iter < 6)
      {
        printf("%-4s%10.4f\n",
          $iter,
          $traces_ref->[$index][$iter]{value});
      }
      elsif ($iter < 20)
      {
        printf("%-4s%10.4f%10.4f%10s%10.4f%10s\n",
          $iter,
          $traces_ref->[$index][$iter]{value},
          $traces_ref->[$index][$iter]{delta6},
          "",
          $traces_ref->[$index][$iter]{avg6},
          "");
      }
      else
      {
        printf("%-4s%10.4f%10.4f%10.4f%10.4f%10.4f\n",
          $iter,
          $traces_ref->[$index][$iter]{value},
          $traces_ref->[$index][$iter]{delta6},
          $traces_ref->[$index][$iter]{delta20},
          $traces_ref->[$index][$iter]{avg6},
          $traces_ref->[$index][$iter]{avg20});
      }
    }
    print "\n";
  }
}


sub update_trace
{
  my($traces_ref, $elements_ref, $block_counter, $suit_counter) = @_;

  $traces_ref->[$suit_counter][$block_counter]{suitno} = $elements_ref->[1];
  $traces_ref->[$suit_counter][$block_counter]{text} = $elements_ref->[2];
  $traces_ref->[$suit_counter][$block_counter]{value} = $elements_ref->[3];

  if ($block_counter >= 6)
  {
    $traces_ref->[$suit_counter][$block_counter]{delta6} = 
      $traces_ref->[$suit_counter][$block_counter]{value} -
      $traces_ref->[$suit_counter][$block_counter-6]{value};

    my $sum6 = 0;
    for my $i ($block_counter-5 .. $block_counter)
    {
if (! defined $traces_ref->[$suit_counter][$i]{value})
{
  print "HERE\n";
}
      $sum6 += $traces_ref->[$suit_counter][$i]{value};
    }
    $traces_ref->[$suit_counter][$block_counter]{avg6} = $sum6 / 6;
  }

  if ($block_counter >= 20)
  {
    $traces_ref->[$suit_counter][$block_counter]{delta20} = 
      $traces_ref->[$suit_counter][$block_counter]{value} -
      $traces_ref->[$suit_counter][$block_counter-20]{value};

    my $sum20 = 0;
    for my $i ($block_counter-19 .. $block_counter)
    {
      $sum20 += $traces_ref->[$suit_counter][$i]{value};
    }
    $traces_ref->[$suit_counter][$block_counter]{avg20} = $sum20 / 20;
  }
}


