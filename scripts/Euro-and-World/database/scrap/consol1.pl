#!perl

use strict;
use warnings;
use v5.10;

# Consolidate only the tournament information.

die "perl consol1.pl" unless $#ARGV == -1;

my @orig_files = qw(../5_tsemantics/tindiv.txt 
  ../5_tsemantics/tpairs.txt 
    ../5_tsemantics/tteams.txt);

my @TAGS = qw(TITLE ID CITY COUNTRY ORGANIZER
  DATE_START DATE_END YEAR FORM RESTRICTION_AGE RESTRICTION_GENDER);

my %tag_hash;
$tag_hash{$_} = 1 for @TAGS;

my %buffer;
my @orig;

for my $fname (@orig_files)
{
  my $lno = 0;
  open my $fw, '<', $fname or die "Cannot read $fname $!";

  while (my $line = <$fw>)
  {
    chomp $line;
    $lno++;
    if ($line =~ /^\s*$/)
    {
      if (defined $buffer{ID})
      {
        $orig[$buffer{ID}] = { %buffer };
      }
      else
      {
        print "$fname: No ID\n";
      }

      %buffer = ();
    }
    else
    {
      if ($line !~ /^(\S+)\s+(.*)/)
      {
        print "$fname, $line: Bad format\n";
      }
      else
      {
        my ($tag, $content) = ($1, $2);
        if (! defined $tag_hash{$tag})
        {
          print "$fname, $lno: Tag unknown $tag\n";
        }
        else
        {
          $buffer{$tag} = $content;
        }
      }
    }
  }
}

for my $tno (0 .. $#orig)
{
  next unless defined $orig[$tno];
  for my $tag (@TAGS)
  {
    print "$tag $orig[$tno]{$tag}\n" if defined $orig[$tno]{$tag};
  }
  print "\n";
}


