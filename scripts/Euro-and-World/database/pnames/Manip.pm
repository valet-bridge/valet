#!perl

# Manipulate name lists.

package Manip;

use strict;
use warnings;
use utf8;
use v5.10;

use Exporter 'import';
our @EXPORT = qw(reprint);


sub reprint
{
  my ($list, $name) = @_;
  my @unique_sorted = sort { lc($a) cmp lc($b) } do 
  {
    my %seen;
    grep { !$seen{lc $_}++ } @$list;
  };

  # Reprint in formatted style
  print "my \@$name =\nqw(\n";

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
