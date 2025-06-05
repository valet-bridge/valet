#!perl

# Manipulate name lists.

package Manip;

use strict;
use warnings;
use utf8;
use v5.10;

use Exporter 'import';
our @EXPORT = qw(dedup reprint);


sub dedup
{
  my ($list1, $list2, $name1, $name2) = @_;

  my (%hash1, %hash2, %dup);
  $hash1{lc($_)} = $_ for @$list1;
  $hash2{lc($_)} = $_ for @$list2;

  for my $k (keys %hash1)
  {
    if (exists $hash2{$k})
    {
      $dup{FIRST}{$hash1{$k}} = 1;
      $dup{SECOND}{$hash2{$k}} = 1;
    }
  }

  # To get the original capitalization.
  my @both1 = sort keys %{$dup{FIRST}};
  my @both2 = sort keys %{$dup{SECOND}};

  reprint(\@both1, $name1);
  reprint(\@both2, $name2);

  my (@reduced1, @reduced2);
  for my $v (@$list1)
  {
    push @reduced1, $v unless exists $dup{FIRST}{$v};
  }
  for my $v (@$list2)
  {
    push @reduced2, $v unless exists $dup{SECOND}{$v};
  }

  reprint(\@reduced1, 'FIRST_MID_NAMES');
  reprint(\@reduced2, 'LAST_MID_NAMES');
}


sub reprint
{
  my ($list, $name) = @_;
  my @unique_sorted = sort { lc($a) cmp lc($b) } do 
  {
    my %seen;
    grep { !$seen{lc $_}++ } @$list;
  };

  # Reprint in formatted style
  print "our \@$name =\nqw(\n";

  my $indent = "  ";
  my $line = $indent;
  my $prev_initial = '';

  foreach my $name (@unique_sorted) 
  {
    my $initial = uc substr($name, 0, 1);

    # Add blank line when initial changes
    if ($prev_initial ne '' && $initial ne $prev_initial) 
    {
      print "$line\n" if $line =~ /\S/;
      print "\n";
      $line = $indent;
    }

  # Check if adding the name exceeds 70 columns
  if (length($line) + length($name) + 1 > 70) 
  {
    print "$line\n";
    $line = $indent;
  }

  $line .= "$name ";
  $prev_initial = $initial;
}

  # Print any remaining names in the buffer
  print "$line\n" if $line =~ /\S/;
  print ");\n\n";
}


1;
