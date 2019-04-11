#!perl

use strict;
use warnings;
use v5.10;

# Usage:
# perl parse.pl namefile pairfile *.html > scores.txt

my %names;
my $namefile = shift;
read_names($namefile);

my @pairs;
my $pairfile = shift;
read_pairs($pairfile);


for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";

  $fname =~ /_k(\d+)_d(\d+)_bd_(\d+)/;
  my $league = $1; # Not used
  my $roundno = $2;
  my $boardno = $3;

  my $line;
  my $lcount = 0;
  while ($line = <$fh>)
  {
    chomp $line;

    last if ($lcount > 0 && $line =~ /Datumsscore/);

    next unless $line =~ /TITLE/;

    $line =~ s/&nbsp/ /g;
    $line =~ s/;/ /g;
    $line =~ s/\<[^>]*\>/ /g;
    $line =~ s/^\s+//;
    my @a = split /\s+/, $line;

    my $na = $#a;

    next if ($na == 10 && $a[5] eq '%');
    next if ($na == 9 && $a[4] eq '%');
    next if ($na == 6 && $a[3] eq 'MP');
    next if ($na == 6 && $a[3] eq '%');

    if ($na != 5 && $na != 8 && $na != 9 && $na != 10 && $na != 11)
    {
      # Likely TD decision.
      next if ($line =~ /gewichtet/);

      my $n = 0;
      for my $l (@a)
      {
        say "$n: $a[$n]";
        $n++;
      }
      die "$fname ($na): Unrecognized line '$line'";
    }

    my $pairNS = $a[1];
    $lcount++;
    my $pairEW = $a[$na-1];

    if (! defined $pairs[$pairNS])
    {
      die "Unrecognized pair number $pairNS";
    }

    if (! defined $pairs[$pairEW])
    {
      die "Unrecognized pair number $pairEW";
    }

    if ($na == 5)
    {
      if ($a[2] ne 'Pass')
      {
        die "$fname not passed out: $line";
      }
      print_line($fname, $roundno, $boardno,
        $names{$pairs[$pairNS][0]}, 
        $names{$pairs[$pairEW][0]}, 
        $names{$pairs[$pairNS][1]},
        $names{$pairs[$pairEW][1]},
        'P', '', 0, '');
      next;
    }

    my $dstr = $a[2];
    my $declarer;
    if ($dstr eq 'O:')
    {
      $declarer = 'E';
    }
    elsif ($dstr eq 'N:')
    {
      $declarer = 'N';
    }
    elsif ($dstr eq 'W:')
    {
      $declarer = 'W';
    }
    elsif ($dstr eq 'S:')
    {
      $declarer = 'S';
    }
    else
    {
      die "Unrecognized declarer $dstr";
    }

    my $lead;
    if ($na == 8 || $na == 9)
    {
      $lead = '';
    }
    else
    {
      $lead = suit($a[$na-4]) . card($a[$na-3]);
    }

    my $cstr;
    if ($na == 8 || $na == 9 || $na == 10)
    {
      $cstr = $a[3] . " " . suit($a[4]) . " " . $a[5];
    }
    else
    {
      $cstr = $a[3] . " " . suit($a[4]) . " " . $a[5] . " " . $a[6];
    }

    my ($contract, $tricks);
    parse_contract($fname, $cstr, \$contract, \$tricks);

    print_line(
      $fname, $roundno, $boardno,
      $names{$pairs[$pairNS][0]}, 
      $names{$pairs[$pairEW][0]}, 
      $names{$pairs[$pairNS][1]},
      $names{$pairs[$pairEW][1]},
      $contract, $declarer, $tricks, $lead);
  }
  close $fh;
}

exit;


sub suit
{
  my $str = pop;
  if ($str eq 'SA' || $str eq 'N')
  {
    return 'N';
  }
  elsif ($str eq 'S' || $str =~ /^&#9824/)
  {
    return 'S';
  }
  elsif ($str eq 'C' || $str =~ /^&#9827/)
  {
    return 'C';
  }
  elsif ($str eq 'H' || $str =~ /^&#9829/)
  {
    return 'H';
  }
  elsif ($str eq 'D' || $str =~ /^&#9830/)
  {
    return 'D';
  }
  else
  {
    die "Bad suit '$str'";
  }
}


sub card
{
  my $str = pop;
  if ($str eq '10')
  {
    return 'T';
  }
  elsif ($str eq 'B')
  {
    return 'J';
  }
  elsif ($str eq 'D')
  {
    return 'Q';
  }
  else
  {
    return $str;
  }
}


sub parse_contract
{
  my ($fname, $cstr, $cref, $tref) = @_;
  $cstr =~ s/^\s*//;
  my @b = split /\s+/, $cstr;

  if ($#b == 2)
  {
    $$cref = $b[0] . suit($b[1]);
  }
  elsif ($#b == 3 && ($b[2] eq 'X' || $b[2] eq 'XX'))
  {
    $$cref = $b[0] . suit($b[1]) . $b[2];
  }
  else
  {
    die "$fname: Can't parse contract string '$cstr'";
  }


  $$tref = $b[0] + 6;
  my $p = ($#b == 2 ? 2 : 3);
  if ($b[$p] =~ /^\+(\d+)/)
  {
    $$tref += $1;
  }
  elsif ($b[$p] =~ /^\-(\d+)/)
  {
    $$tref -= $1;
  }
}


sub print_line
{
  my ($fname, $round, $no, $p0, $p1, $p2, $p3, $e0, $e1, $e2, $e3) = @_;

  if (! defined $e0)
  {
    # say "e0";
    # return;
    die "$fname: e0";
  }

  if ($e0 eq 'PASS' || $e0 eq 'PAS' || $e0 eq 'Pass')
  {
    print "$round|$no|$p0|$p1|$p2|$p3|P|S|0\n";
  }
  elsif ($e0 eq 'ARB' || 
         $e0 eq 'APP' ||
         $e0 eq 'APM' ||
         $e0 eq 'AAA')
  {
    # Skip
  }
  else
  {
    my $level = substr $e0, 0, 1;
    if ($level eq '*')
    {
      # Happens very rarely -- TD decision?
      $e0 = substr $e0, 1;
      $level = substr $e0, 0, 1;
    }

    if (! defined $e2 || ! defined $e3)
    {
      print "$round|$no|$p0|$p1|$p2|$p3|P|S|0\n";
    }
    elsif ($e3 eq 'X')
    {
      print "$round|$no|$p0|$p1|$p2|$p3|$e0|$e1|$e2\n";
    }
    else
    {
if (! defined $p0)
{
  die "$fname: $p0";
}
      $e3 =~ s/10$/T/;
      print "$round|$no|$p0|$p1|$p2|$p3|$e0|$e1|$e2|$e3\n";
    }
  }
}


sub read_names
{
  my ($name) = @_;
  open my $fh, "<$name" or die "Can't open $name";
  my @lines = <$fh>;
  close $fh;

  for my $i (0 .. $#lines)
  {
    my $line = $lines[$i];
    chomp $line;
    $line =~ s///g;
    my @elems = split /\|/, $line;
    $names{$elems[1]} = $elems[0];
  }
}


sub read_pairs
{
  my ($pair) = @_;
  open my $fh, "<$pair" or die "Can't open $pair";
  my @lines = <$fh>;
  close $fh;

  for my $i (0 .. $#lines)
  {
    my $line = $lines[$i];
    chomp $line;
    $line =~ s///g;
    my @elems = split /\|/, $line;
    $pairs[$elems[0]][0] = $elems[1];
    $pairs[$elems[0]][1] = $elems[2];
  }
}
