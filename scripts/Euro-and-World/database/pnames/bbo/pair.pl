#!perl
use strict;
use warnings;

use lib '..';
use lib '../..';

use FirstFirst;
use FirstMid;
use FirstBBO;

use LastMid;
use LastLast;

my (%FIRST, %FIRST_LC);
$FIRST{$_} = 1 for @FIRST_FIRST_NAMES;
$FIRST{$_} = 1 for @FIRST_MID_NAMES;
$FIRST{$_} = 1 for @FIRST_BBO;
$FIRST_LC{lc($_)} = $_ for @FIRST_FIRST_NAMES;
$FIRST_LC{lc($_)} = $_ for @FIRST_MID_NAMES;
$FIRST_LC{lc($_)} = $_ for @FIRST_BBO;

my (%LAST, %LAST_LC);
$LAST{$_} = 1 for @LAST_MID_NAMES;
$LAST{$_} = 1 for @LAST_LAST_NAMES;
$LAST_LC{lc($_)} = $_ for @LAST_MID_NAMES;
$LAST_LC{lc($_)} = $_ for @LAST_LAST_NAMES;

my $file = 's2.txt';
open(my $fh, "<", $file) or die "Cannot open $file$!";
for my $line (<$fh>)
{
  chomp $line;
  $line =~ s///g;
  my @words = split /\s+/, $line;

  if ($#words != 1)
  {
    print "WARN2 $line\n";
  }
  elsif (exists $FIRST_LC{lc($words[0])})
  {
    if (exists $LAST_LC{lc($words[1])})
    {
      if (exists $FIRST_LC{lc($words[1])})
      {
        print "DOUBLE $line\n";
      }
      else
      {
        print "HIT $line\n";
      }
    }
    else
    {
      print "POSL $words[1] FULL $line\n";
    }
  }
  elsif (exists $LAST_LC{lc($words[1])})
  {
    print "POSF $words[0]\n";
  }
  else
  {
    print "MISS $line\n";
  }
}
close $fh;

