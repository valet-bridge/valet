#!perl

use strict;
use warnings;
use v5.10;

die "perl extract_players.pl" unless $#ARGV == 0;

my $fname = shift;
open my $fh, '<', $fname or die "Cannot open $fname for reading $!";

my %record;
my $line;
while ($line = <$fh>)
{
  chomp $line; 
  if ($line =~ /^\s*$/)
  {
    if (! defined $record{NAME})
    {
      # Could be a deletion or redirection.
      %record = ();
      next;
    }

    die "No number" unless defined $record{EBL};

    my $name;
    if (defined $record{NAME_PREFERRED})
    {
      $name = $record{NAME_PREFERRED};
    }
    else
    {
      $name = $record{NAME};
    }

    my $reversed_name = reverse_name($name);
    print "$record{EBL} $reversed_name\n";
    
    %record = ();
  }
  elsif ($line eq 'DELETED')
  {
  }
  else
  {
    $line =~ /^(\S+)\s+(.*)$/;
    my ($tag, $content) = ($1, $2);
    $record{$tag} = $content;
  }
}
    
close $fh;


sub reverse_name
{
  my @a = split /\s+/, pop;
  my $i = 0;
  my $flag = 0;
  my $index;
  for $i (0 .. $#a)
  {
    my $n = $a[$i];
    my $l = length $n;
    if ($n eq uc($n) && 
        $n ne '-' &&
        ($l >= 3 || ($l == 2 && substr($n, 1, 1) ne '.')))

    {
      $flag = 1;
      $index = $i;
      last;
    }
  }
    
  $index = $#a if ! $flag;

  my $reversed_name = $a[$index];
  for my $j ($index+1 .. $#a)
  {
    $reversed_name .= " " . $a[$j];
  }

  for my $j (0 .. $index-1)
  {
    $reversed_name .= " " . $a[$j];
  }

  return $reversed_name;
}






