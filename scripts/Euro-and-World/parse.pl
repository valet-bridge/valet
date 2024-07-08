#!perl

use strict;
use warnings;
use v5.10;

my %names;
my $namefile = shift;
read_names($namefile);


my ($no, $eo, $so, $wo, $nc, $ec, $sc, $wc);

my $roundno = 0;

for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";
  my @entries;

  my @players = ();
  my $players_seen = 0;

  $no = 999;
  $eo = 999;
  $so = 999;
  $wo = 999;
  $nc = 999;
  $ec = 999;
  $sc = 999;
  $wc = 999;

  my $boardno = 0;
  my $line;
  my $bracket_state = 0;
  while ($line = <$fh>)
  {
    chomp $line;

    if ($line =~ /people.person.asp/ || $line =~ /personpopup/ ||
        ($line =~ /qryid=/ && $line =~ /person/) ||
        $line =~ /href=11111/) # Kludge for artificially set players.
    {
      die "Too many players" if ($players_seen == 8);
      $line =~ s/\<[^>]*\>//g;
      $line =~ s/\&nbsp;//g;
      $line =~ s/^\s*//;
      $line =~ s/\s*$//;

      push @players, $line;
      if (++$players_seen == 8)
      {
        $no = $names{$players[0]} || die "$fname: $players[0]";
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
    elsif ($line =~ /Round/)
    {
      $line = <$fh>;
      chomp $line;
      if ($line =~ /^\s*(\d+)/)
      {
        $roundno = $1;
      }
    }
    elsif ($line =~ /Board[Aa]cross.asp\?qboard=0*(\d+)/)
    {
      my $newno = $1;
      if ($boardno != 0)
      {
        # print "open $boardno: $no, $eo, $so, $wo\n";
        # print "entries before  ", join(', ', @entries), "\n";

        if ($#entries == 0 && $entries[0] eq '0')
        {
          # Effectively an empty line with only a 0 IMP score.
          # This should not happen, but e.g. Antalya 2007,
          # Women's RR, Round 2 Table 1.

          print_line($fname, $roundno, $boardno, $no, $eo, $so, $wo,
            "None", "", "", "");
          print_line($fname, $roundno, $boardno, $nc, $ec, $sc, $wc,
            "None", "", "", "");

          $boardno = $newno;
          undef @entries;
          next;
        }

        if ($#entries == 1 && $entries[0] eq '0' &&
            $entries[1] eq '0')
        {
          # This too should not happen, but e.g. Beijing 2008,
          # Seniors, Round 1 Table 8.
          print_line($fname, $roundno, $boardno, $no, $eo, $so, $wo,
            "None", "", "", "");
          print_line($fname, $roundno, $boardno, $nc, $ec, $sc, $wc,
            "None", "", "", "");

          $boardno = $newno;
          $boardno = $newno;
          undef @entries;
          next;
        }

        if ($#entries == -1)
        {
          print_line($fname, $roundno, $boardno, $no, $eo, $so, $wo,
            "None", "", "", "");
          print_line($fname, $roundno, $boardno, $nc, $ec, $sc, $wc,
            "None", "", "", "");

          $boardno = $newno;
          undef @entries;
          next;
        }

        # print "entries before  ", join(', ', @entries), "\n";
        fix_entries(\@entries);
        # print "entries after   ", join(', ', @entries), "\n";

        if (! defined $entries[0])
        {
          print "A  ", join(', ', @entries), "\n";
        }

        print_line($fname, $roundno, $boardno, $no, $eo, $so, $wo,
	  $entries[0], $entries[1], $entries[3], $entries[2]);
        # print "\n";

        # print "closed $boardno: $nc, $ec, $sc, $wc\n";

        if (! defined $entries[5])
        {
          # print "B  ", join(', ', @entries), "\n";
          print_line($fname, $roundno, $boardno, $nc, $ec, $sc, $wc,
            "None", "", "", "");
          $boardno = $newno;
          undef @entries;
          next;
        }

        print_line($fname, $roundno, $boardno, $nc, $ec, $sc, $wc,
	  $entries[5], $entries[6], $entries[8], $entries[7]);
        # print "\n";

        undef @entries;
      }
      $boardno = $newno;
# say "Board $boardno";
    }
    elsif ($boardno != 0)
    {
      if ($line =~ /^\<\/table\>/)
      {
        # print "open $boardno: $no, $eo, $so, $wo\n";
        # print "entries before  ", join(', ', @entries), "\n";

        if ($#entries == 0 && $entries[0] eq '0')
        {
          # Effectively an empty line with only a 0 IMP score.
          # This should not happen, but e.g. Antalya 2007,
          # Women's RR, Round 2 Table 1.

          print_line($fname, $roundno, $boardno, $no, $eo, $so, $wo,
            "None", "", "", "");
          print_line($fname, $roundno, $boardno, $nc, $ec, $sc, $wc,
            "None", "", "", "");

          last;
        }

        if ($#entries == 1 && $entries[0] eq '0' &&
            $entries[1] eq '0')
        {
          # This too should not happen, but e.g. Beijing 2008,
          # Mixed TNT, Round 1 Table 11.
          print_line($fname, $roundno, $boardno, $no, $eo, $so, $wo,
            "None", "", "", "");
          print_line($fname, $roundno, $boardno, $nc, $ec, $sc, $wc,
            "None", "", "", "");

          last;
        }

        if ($#entries == -1)
        {
          print_line($fname, $roundno, $boardno, $no, $eo, $so, $wo,
            "None", "", "", "");
          print_line($fname, $roundno, $boardno, $nc, $ec, $sc, $wc,
            "None", "", "", "");

          last;
        }

        # print "entries before  ", join(', ', @entries), "\n";
        fix_entries(\@entries);
        # print "entries after   ", join(', ', @entries), "\n";

        if (! defined $entries[0])
        {
          print "C  ", join(', ', @entries), "\n";
        }

        print_line($fname, $roundno, $boardno, $no, $eo, $so, $wo,
	  $entries[0], $entries[1], $entries[3], $entries[2]);

        # print "closed $boardno: $nc, $ec, $sc, $wc\n";

        if (! defined $entries[5])
        {
          print "D  ", join(', ', @entries), "\n";
        }

        print_line($fname, $roundno, $boardno, $nc, $ec, $sc, $wc,
	  $entries[5], $entries[6], $entries[8], $entries[7]);
        last;
      }
      elsif ($line =~ /\<\/table\>/)
      {
        next;
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
  elsif (lc($e0) =~ /adj/)
  {
    print "$round|$no|$p0|$p1|$p2|$p3|Adj.|S|0\n";
  }
  elsif (lc($e0) =~ /none/)
  {
    print "$round|$no|$p0|$p1|$p2|$p3|None|S|0\n";
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
    elsif ($e3 eq 'X' || $e3 eq '_Z_')
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


sub find_plausible_contract
{
  my ($entries_ref, $cindex_ref) = @_;

  while ($$cindex_ref < $#$entries_ref)
  {
    if (looks_like_contract($entries_ref->[$$cindex_ref]) ||
        lc($entries_ref->[$$cindex_ref]) =~ /adj/)
    {
      return 1;
    }
    $$cindex_ref++;
  }

  return 0;
}


sub pad_plausible_contract
{
  my ($entries_ref, $cindex) = @_;
  if ($cindex < 5)
  {
    # Pad out so the contract is in position 5.
    splice @$entries_ref,  $cindex, 0, ('_Z_') x (5 - $cindex);
  }
  elsif ($cindex > 5)
  {
    die "Haven't seen this before";
  }
}


sub fix_entries
{
  my $entries_ref = pop;

  if ($entries_ref->[0] eq 'PASS' || $entries_ref->[0] eq 'Pass')
  {
    if ($#$entries_ref < 4)
    {
      # TODO Does this generate spurious passes?
      $entries_ref->[5] = 'Pass';
      return;
    }

    my $cindex = 1;
    my $flag = 0;
    if (find_plausible_contract($entries_ref, \$cindex))
    {
      pad_plausible_contract($entries_ref, $cindex);
    }
    else
    {
      # TODO Not sure what this does.
      splice @$entries_ref, 4, 0, '_Z_';
    }
  }
  elsif ($entries_ref->[1] eq 'PASS' || $entries_ref->[1] eq 'Pass')
  {
    $entries_ref->[0] = 'Pass';
    if ($#$entries_ref < 4)
    {
      $entries_ref->[5] = 'Pass';
    }
    else
    {
      splice @$entries_ref, 4, 0, '_Z_';
    }
  }
  elsif (lc($entries_ref->[0]) =~ /adj/)
  {
    $entries_ref->[0] = 'Adj.';

    my $cindex = 1;
    my $flag = 0;
    if (find_plausible_contract($entries_ref, \$cindex))
    {
      pad_plausible_contract($entries_ref, $cindex);
    }
  }
  elsif ($#$entries_ref >= 5 && lc($entries_ref->[5]) =~ /adj/)
  {
    $entries_ref->[5] = 'Adj.';
  }
  elsif (looks_like_front_skip($entries_ref))
  {
    splice @$entries_ref, 1, 0, 'S', '0', '0', '';
    $entries_ref->[0] = 'None';
  }
  elsif (looks_like_back_skip($entries_ref))
  {
    push @$entries_ref, 'S', '0', '0', '';
    $entries_ref->[5] = 'None';
  }
  else 
  {
    if (looks_like_tricks($entries_ref->[2]) &&
        looks_like_score($entries_ref->[3]))
    {
      # Probably the open room misses a lead.
      splice @$entries_ref, 2, 0, '_Z_';
    }

    if (looks_like_tricks($entries_ref->[7]) &&
        looks_like_score($entries_ref->[8]))
    {
      # Probably the closed room misses a lead.
      splice @$entries_ref, 7, 0, '_Z_';
    }
  }
}


sub looks_like_contract
{
  my $text = pop;
  return 1 if ($text =~ /Adj/);

  return 0 unless length($text) >= 2 && length($text) <= 4;

  if (length $text == 3)
  {
    return 0 unless substr($text, 2, 1) eq 'X';
  }
  elsif (length $text == 4)
  {
    return 0 unless substr($text, 2, 2) eq 'XX';
  }

  my $level = substr($text, 0, 1);
  return 0 unless $level =~ /^[1-7]/;
  my $denom = substr($text, 1, 1);
  return 0 unless $denom =~ /^[SHDCN]/;
  return 1;
}


sub looks_like_tricks
{
  my $text = pop;
  if (! defined $text)
  {
    return;
  }
  elsif ($text =~ /^\d+$/)
  {
    return ($text >= 0 && $text <= 13);
  }
  else
  {
    return 0;
  }
}


sub looks_like_score
{
  my $text = pop;
  if (! defined $text)
  {
    return;
  }
  elsif ($text =~ /^\d+$/)
  {
    return ($text > -3000 && $text < 3000 &&
      $text == 10 * int($text/10));
  }
  else
  {
    return 0;
  }
}


sub looks_like_front_skip
{
  my $entries_ref = pop;

  if ($#$entries_ref == 5 &&
      $entries_ref->[0] eq '0' &&
      looks_like_contract($entries_ref->[1]) &&
      looks_like_tricks($entries_ref->[4]) &&
      looks_like_score($entries_ref->[5]))
  {
    return 1;
  }
  else
  {
    return 0;
  }
}


sub looks_like_back_skip
{
  my $entries_ref = pop;

  if ($#$entries_ref == 5 &&
      $entries_ref->[5] eq '0' &&
      looks_like_contract($entries_ref->[0]) &&
      looks_like_tricks($entries_ref->[3]) &&
      looks_like_score($entries_ref->[4]))
  {
    return 1;
  }
  else
  {
    return 0;
  }
}
