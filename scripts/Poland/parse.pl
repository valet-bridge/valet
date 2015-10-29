#!perl

use strict;
use warnings;
use v5.10;

my %names;
my $namefile = shift;
read_names($namefile);


for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";
  my $line = <$fh>;
  close $fh;

  chomp $line;
  
  # Suit symbols
  $line =~ s/\<img alt="(\w)[^>]*\>/\u$1/g;

  # Doubles
  $line =~ s/\&times;/X/g;

  # Get some newlines at the end of the table lines
  $line =~ s/\<\/tr\>/\n/g;

  # Get some spaces in each cell
  $line =~ s/\<\/td\>/ /g;

  # Get rid of all other <>'s.
  $line =~ s/\<[^>]*\>//g;

  # Make sure each cell holds something
  $line =~ s/\&nbsp;/ _Z_ /g;
  $line =~ s/\&ndash;/ _Z_ /g;

  my @array = split "\n", $line;
  my $state = 0;
  my $counter = 0;
  my $delay = '';
  my $round = 0;
  my ($n_open, $e_open, $s_open, $w_open);
  my ($n_closed, $e_closed, $s_closed, $w_closed);

  for my $l (@array)
  {
    chomp $l;
    $l =~ s/^\s*//g;
    last if ($l =~ /^Click/ || $l =~ /^Klikn/);
    next if ($l =~ /^\s*$/);
    next if ($l =~ /^\s*_Z_\s*$/);

    if ($state == 0)
    {
      $round = $1 if ($l =~ /ROUND (\d+)/ || $l =~ /RUNDA (\d+)/);
      $state = 1 if ($l =~ /CLOSED/ || $l =~ /ZAMKN/);
    }
    elsif ($state == 1)
    {
      if ($l =~ /^contr/ || $l =~ /^kontr/)
      {
        $state = 2;
      }
      elsif ($l =~ /NS/)
      {
        my @elems = split /_Z_/, $l;
        my ($nn_open, $ss_open) = get_names($elems[0]);
        my ($nn_closed, $ss_closed) = get_names($elems[1]);

        die "$nn_open" if (! defined $names{$nn_open});
        die "$ss_open" if (! defined $names{$ss_open});
        die "$nn_closed" if (! defined $names{$nn_closed});
        die "$ss_closed" if (! defined $names{$ss_closed});

        $n_open = $names{$nn_open};
        $s_open = $names{$ss_open};
        $n_closed = $names{$nn_closed};
        $s_closed = $names{$ss_closed};
      }
      elsif ($l =~ /EW/)
      {
        my @elems = split /_Z_/, $l;
        my ($ee_open, $ww_open) = get_names($elems[0]);
        my ($ee_closed, $ww_closed) = get_names($elems[1]);

        die "$ee_open" if (! defined $names{$ee_open});
        die "$ww_open" if (! defined $names{$ww_open});
        die "$ee_closed" if (! defined $names{$ee_closed});
        die "$ww_closed" if (! defined $names{$ww_closed});

        $e_open = $names{$ee_open};
        $w_open = $names{$ww_open};
        $e_closed = $names{$ee_closed};
        $w_closed = $names{$ww_closed};
      }
      else
      {
        say "What is this?";
      }
    }
    elsif ($state == 2)
    {
      $state = 3 if (++$counter == 1)
    }
    elsif ($state == 3)
    {
      my @elems = split /\s+/, $l;

      # For some reason director decisions look a bit different.
      if ($elems[0] eq 'ARB' || 
          $elems[0] eq 'APP' || 
          $elems[0] eq 'APM' ||
          $elems[0] eq 'AAA')
      {
        splice @elems, 1, 0, ' _Z_ ';
      }

      if ($elems[10] eq 'ARB' || 
          $elems[10] eq 'APP' || 
          $elems[10] eq 'APM' ||
          $elems[10] eq 'AAA')
      {
        splice @elems, 11, 0, ' _Z_ ';
      }

      die "$l, $#elems\n" unless $#elems == 18;

      # Open room
      print_line($round, $elems[7], 
        $n_open, $e_open, $s_open, $w_open,
        $elems[0], $elems[1], $elems[3], $elems[2]);

      # Closed room
      print_line($round, $elems[7],
        $n_closed, $e_closed, $s_closed, $w_closed,
        $elems[10], $elems[11], $elems[13], $elems[12]);
    }
  }
}

exit;


sub print_line
{
  my ($round, $no, $p0, $p1, $p2, $p3, $e0, $e1, $e2, $e3) = @_;

  if ($e0 eq 'PASS' || $e0 eq 'PAS')
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

    my $tricks;
    if ($e2 eq '=')
    {
      $tricks = $level+6;
    }
    else
    {
      my $sign = substr $e2, 0, 1;
      my $diff = substr $e2, 1, 1;
      if ($sign eq '+')
      {
        $tricks = $level + 6 + $diff;
      }
      elsif ($sign eq '-')
      {
        $tricks = $level + 6 - $diff;
      }
      else
      {
        die "$sign\n";
      }
    }

    $e3 =~ s/10$/T/;

    print "$round|$no|$p0|$p1|$p2|$p3|$e0|$e1|$tricks|$e3\n";
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
    my @elems = split /,/, $line;
    $names{$elems[1]} = $elems[0];
  }
}


sub get_names
{
  my ($text) = @_;

  my @list = split /[:-]/, $text;
  $list[2] =~ s/\s+$//;
  return ($list[1], $list[2]);
}

