#!perl

use strict;
use warnings;
use v5.10;

# Tries to find an EBL entry for each result entry.
# The result entries are broadly in the form LASTNAME Firstname.

die "perl check_results.pl" unless $#ARGV == -1;

my $ebl_file = 'ebl/ebl.txt';
my $results_file = 'results/names.txt';

# For the case when we haven't finished scraping all EBL data yet.
my $MAX_EBL_NUMBER = 145904;

my (@ebl, @redirections, @deletions);
read_ebl($ebl_file, \@ebl, \@redirections, \@deletions);

open my $fr, '<', $results_file or 
  die "Cannot open $results_file for reading $!";

my $line;

while ($line = <$fr>)
{
  chomp $line;
  die "Bad format: $line" unless $line =~ /^(\d+)\|(.*)$/;
  my ($rno, $rname) = ($1, $2);

  if (! defined $ebl[$rno])
  {
    if (defined $deletions[$rno])
    {
      # print "$line: Normal deletion\n";
      next;
    }
    elsif (defined $redirections[$rno])
    {
      if (! defined $ebl[$redirections[$rno]])
      {
        die "Redirecting $rno to non-existent $redirections[$rno]\n";
      }
      $rno = $redirections[$rno];
    }
    elsif ($rno <= $MAX_EBL_NUMBER)
    {
      print "$line: Number $rno not found\n";
      next;
    }
    else
    {
      # It's only OK to miss numbers that we've not scraped yet.
      next;
    }
  }

  my $found = 0;
  for my $name (@{$ebl[$rno]})
  {
    if ($rname eq $name)
    {
      $found = 1;
      last;
    }
  }

  if (! $found)
  {
    print "$line: Name not found. Candidates:\n";
    for my $name (@{$ebl[$rno]})
    {
      print "$name\n";
    }
    print "\n";
  }
}

close $fr;

exit;


sub read_ebl
{
  my ($efile, $ebl_ref, $redir_ref, $deletions_ref) = @_;
 
  open my $fe, '<', $efile or die "Cannot open $efile for reading $!";

  my $line;
  my %record;

  while ($line = <$fe>)
  {
    chomp $line;
    if ($line =~ /^\s*$/)
    {
      die "No number" unless defined $record{EBL};

      if ($#{$record{EBL}} != 0)
      {
        die "Multiple numbers";
      }
      my $no = $record{EBL}[0];

      if (! defined $record{NAME})
      {
        if (defined $record{EBL_PREFERRED})
        {
          if ($#{$record{EBL_PREFERRED}} != 0)
          {
            die "Expected exactly one redirect";
          }
          $redir_ref->[$no] = $record{EBL_PREFERRED}[0];
        }
        elsif (defined $record{DELETED})
        {
          $deletions_ref->[$no] = -1;
        }
        else
        {
          die "Confusing record";
        }

        %record = ();
        next;
      }

      for my $name (@{$record{NAME}})
      {
        push @{$ebl_ref->[$no]}, reverse_name($name);
      }

      for my $name (@{$record{NAME_DEPRECATED}})
      {
        push @{$ebl_ref->[$no]}, $name;
      }

      for my $name (@{$record{NAME_PREFERRED}})
      {
        push @{$ebl_ref->[$no]}, $name;
      }

      %record = ();
    }
    else
    {
      my ($tag, $content);
      if ($line =~ /^(\S+)\s+(.*)$/)
      {
        ($tag, $content) = ($1, $2);
        push @{$record{$tag}}, $content;
      }
      elsif ($line eq 'DELETED')
      {
        push @{$record{DELETED}}, -1;
      }

    }
  }

  close $fe;
}


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

