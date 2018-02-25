#!perl

use strict;
use warnings;
use v5.10;

my %names;
my $namefile = shift;
read_names($namefile);

my @entries;

my ($no, $eo, $so, $wo, $nc, $ec, $sc, $wc);

my $roundno = 0;

for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";

  my @players = ();
  my $players_seen = 0;

  my $boardno = 0;
  my $line;
  my $bracket_state = 0;
  while ($line = <$fh>)
  {
    chomp $line;

    if ($line =~ /people.person.asp/ || $line =~ /personpopup/)
    {
      die "Too many players" if ($players_seen == 8);
      $line =~ s/\<[^>]*\>//g;
      $line =~ s/\&nbsp;//g;
      $line =~ s/^\s*//;
      $line =~ s/\s*$//;

      push @players, $line;
      if (++$players_seen == 8)
      {
        $no = $names{$players[0]} || die "$players[0]";
        $eo = $names{$players[3]} || die "$players[3]";
        $so = $names{$players[6]} || die "$players[6]";
        $wo = $names{$players[2]} || die "$players[2]";
        $nc = $names{$players[1]} || die "$players[1]";
        $ec = $names{$players[5]} || die "$players[5]";
        $sc = $names{$players[7]} || die "$players[7]";
        $wc = $names{$players[4]} || die "$players[4]";
      }
    }
    elsif ($line =~ /Round (\d+)/)
    {
      $roundno = $1;
    }
    elsif ($line =~ /Board[Aa]cross.asp\?qboard=0*(\d+)/)
    {
      my $newno = $1;
      if ($boardno != 0)
      {
        print_line($roundno, $boardno, $no, $eo, $so, $wo,
	  $entries[0], $entries[1], $entries[3], $entries[2]);

        if ($entries[0] eq 'PASS' || $entries[0] eq 'Pass')
        {
          if ($#entries < 4)
          {
            $entries[5] = 'Pass';
          }
          else
          {
            # splice @entries, 4, 0, '_Z_', '_Z_', '_Z_';
            splice @entries, 4, 0, '_Z_';
          }
        }

        print_line($roundno, $boardno, $nc, $ec, $sc, $wc,
	  $entries[5], $entries[6], $entries[8], $entries[7]);
        undef @entries;
      }
      $boardno = $newno;
# say "Board $boardno";
    }
    elsif ($boardno != 0)
    {
      if ($line =~ /\<\/table\>/)
      {
        print_line($roundno, $boardno, $no, $eo, $so, $wo,
	  $entries[0], $entries[1], $entries[3], $entries[2]);

        if ($entries[0] eq 'PASS' || $entries[0] eq 'Pass')
        {
          # splice @entries, 4, 0, '_Z_', '_Z_';
          splice @entries, 4, 0, '_Z_';
        }

        print_line($roundno, $boardno, $nc, $ec, $sc, $wc,
	  $entries[5], $entries[6], $entries[8], $entries[7]);
        last;
      }

      next if ($line =~ /^\s*$/);
      $line =~ s/^\s*//;
      $line =~ s/\s*$//;

      if ($bracket_state)
      {
        if ($line =~ /^\>$/)
	{
	  $bracket_state = 0;
	}
	next;
      }
      elsif ($line =~ s/^\<[^>]*$//)
      {
        $bracket_state = 1;
	next;
      }

      $line =~ s/\<[^>]*\>//g;
      $line =~ s/\&nbsp;//g;
      $line =~ s/x/X/g;
      $line =~ s/NT/N/g;
      $line =~ s/\&spades;/S/g;
      $line =~ s/\&hearts;/H/g;
      $line =~ s/\&diams;/D/g;
      $line =~ s/\&clubs;/C/g;
      $line =~ s/clubs;/C/g;
      if ($line =~ /^\s*$/)
      {
        # $line = '_Z_';
	next;
      }
      push @entries, $line;
      # say $line;
    }
  }
  close $fh;
}

exit;


sub print_line
{
  my ($round, $no, $p0, $p1, $p2, $p3, $e0, $e1, $e2, $e3) = @_;

  if (! defined $e0)
  {
    # say "e0";
    # return;
    die "e0";
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
  die "p0";
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

