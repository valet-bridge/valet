#!perl

use strict;
use warnings;
use v5.10;

# Tries to find an EBL entry for each result entry.
# The result entries are broadly in the form LASTNAME Firstname.

die "perl merge.pl" unless $#ARGV == -1;

my $ebl_file = 'ebl/prelim/ebl.bak';
my $results_file = 'results/names.txt';

# Cases where the EBL names are more complete or convincing.
# So we have aliases for the results.
my $results_aliases_file = 'results/aliases.txt';

# Cases where the results are more complete or convincing.
# So we have aliases for the EBL names.
my $ebl_aliases_file = 'ebl/aliases.txt';

my @results_aliases;
read_aliases($results_aliases_file, \@results_aliases);

my @ebl_aliases;
read_aliases($ebl_aliases_file, \@ebl_aliases);

open my $fr, '<', $results_file or 
  die "Cannot open $results_file for reading $!";

my @ebl;
read_ebl($ebl_file, \@ebl);

my $line;
my $no_number = 0;
my $mismatch = 0;
my $results_alias_match = 0;
my $ebl_alias_match = 0;
my $double_alias_match = 0;
my $match = 0;

while ($line = <$fr>)
{
  chomp $line;
  die "Bad format: $line" unless $line =~ /^(\d+)\|(.*)$/;
  my ($rno, $rname) = ($1, $2);

  if (! defined $ebl[$rno])
  {
    if ($rno <= 12000)
    {
      print "$line: Number $rno not found\n";
    }
    $no_number++;
    next;
  }
  elsif ($ebl[$rno] ne $rname)
  {
    my $error_flag = 1;
    if (defined $results_aliases[$rno] &&
      $results_aliases[$rno]{result} eq $rname &&
      $results_aliases[$rno]{alias} eq $ebl[$rno])
    {
      $results_alias_match++;
    }
    elsif (defined $ebl_aliases[$rno] &&
      $ebl_aliases[$rno]{result} eq $ebl[$rno] &&
      $ebl_aliases[$rno]{alias} eq $rname)
    {
      $ebl_alias_match++;
    }
    elsif (defined $results_aliases[$rno] &&
      defined $ebl_aliases[$rno] &&
      $results_aliases[$rno]{result} eq $rname &&
      $ebl_aliases[$rno]{alias} eq $results_aliases[$rno]{alias})
    {
      $double_alias_match++;
    }
    else
    {
      print "Name mismatch $rno:\n";
      print "  EBL    : $ebl[$rno]\n";
      print "  results: $rname\n";
      $mismatch++;
    }
  }
  else
  {
    $match++;
  }
}

close $fr;

print "\n";
printf("No number: %6d\n", $no_number);
printf("Mismatch : %6d\n", $mismatch);
printf("Alias res: %6d\n", $results_alias_match);
printf("Alias ebl: %6d\n", $ebl_alias_match);
printf("Alias two: %6d\n", $double_alias_match);
printf("Match    : %6d\n", $match);

exit;


sub read_ebl
{
  my ($efile, $ebl_ref) = @_;
 
  open my $fe, '<', $efile or die "Cannot open $efile for reading $!";

  my $line;
  my %record;

  while ($line = <$fe>)
  {
    chomp $line;
    if ($line =~ /^\s*$/)
    {
      die "No name" unless defined $record{NAME};
      die "No number" unless defined $record{EBL};

      my @a = split /\s+/, $record{NAME};
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

      $ebl_ref->[$record{EBL}] = $reversed_name;
    
      %record = ();
    }
    else
    {
      $line =~ /^(\S+)\s+(.*)$/;
      my ($tag, $content) = ($1, $2);
      $record{$tag} = $content;
    }
  }

  close $fe;
}


sub read_aliases
{
  my ($fname, $alias_ref) = @_;

  open my $fa, '<', $fname or die "Cannot open $fname for reading $!";
  my $line;
  while ($line = <$fa>)
  {
    chomp $line;
    next if $line =~ /^#/ or $line =~ /^\s*$/;

    my @a = split /\|/, $line;
    if ($#a != 2)
    {
      die "Need 3 elements: $line";
    }
    $alias_ref->[$a[0]]{result} = $a[1];
    $alias_ref->[$a[0]]{alias} = $a[2];
  }
  close $fa;
}
