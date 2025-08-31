#!perl
use strict;
use warnings;

# Fix some special characters.

if ($#ARGV < 0)
{
  die "Usage: perl nspec.pl file";
}

my $file = shift;
my $lno = 0;
open(my $fh, "<", $file) or die "Cannot open $file: $!";
while (my $line = <$fh>)
{
  chomp $line; $line =~ s///g; my $line1 = $line;

  $line = <$fh>;
  chomp $line; $line =~ s///g; my $line2 = $line;

  $line = <$fh>;
  chomp $line; $line =~ s///g; my $line3 = $line;

  $line = <$fh>;
  chomp $line; $line =~ s///g; my $line4 = $line;

  $lno += 4;

  if ($line4 !~ /^\s*$/)
  {
    die "$lno: $line4";
  }

  my $orig = $line3;

  $line3 =~ s/¹/a/g;
  $line3 =~ s/Ã©/é/g;
  $line3 =~ s/Ã¨/è/g;
  $line3 =~ s/ê/e/g;
  $line3 =~ s/ñ/n/g;

  $line3 =~ s/Ý/I/g;
  $line3 =~ s/ý/i/g;
  $line3 =~ s/þ/s/g;
  $line3 =~ s/Þ/S/g;

  $line3 =~ s/Ä/a/g;
  $line3 =~ s/Å/L/g;
  $line3 =~ s/Ã/A/g;
  $line3 =~ s/Å/l/g;
  $line3 =~ s/Ã/å/g;
  $line3 =~ s/Ã/C/g;
  $line3 =~ s/Ã/E/g;
  $line3 =~ s/Å/ö/g;
  $line3 =~ s/Ã/O/g;
  $line3 =~ s/Ã/Ö/g;
  $line3 =~ s/Ã/Ø/g;
  $line3 =~ s/Å/s/g;
  $line3 =~ s/Ã/Ü/g;
  $line3 =~ s/Å/S/g;
  $line3 =~ s/Ä/g/g;
  $line3 =~ s/Å/s/g;

  $line3 =~ s/Ã¡/a/g;
  $line3 =~ s/Ã²/a/g;
  $line3 =~ s/Ã£/a/g;
  $line3 =~ s/Âª/aria/g;
  $line3 =~ s/Ã¤/ä/g;
  $line3 =~ s/Ã¦/æ/g;
  $line3 =~ s/Ã§/c/g;
  $line3 =~ s/Ã°/d/g;
  $line3 =~ s/Ã«/e/g;
  $line3 =~ s/Ã­/i/g;
  $line3 =~ s/Ã¯/i/g;
  $line3 =~ s/Ä±/i/g;
  $line3 =~ s/Â³/l/g;
  $line3 =~ s/Ã³/o/g;
  $line3 =~ s/Ã´/o/g;
  $line3 =~ s/Ã¶/ö/g;
  $line3 =~ s/Ã¾/s/g;
  $line3 =~ s/Ã¾o/tho/g;
  $line3 =~ s/Ãº/u/g;
  $line3 =~ s/Ã¼/ü/g;
  $line3 =~ s/Ã¸/ø/g;
  $line3 =~ s/Ã¥/å/g;
  $line3 =~ s/Ä°/I/g;
  $line3 =~ s/Ã¯/I/g;

  $line3 =~ s/³/l/g;
  $line3 =~ s/£/L/g;

  $line3 =~ s/[aA]ðal/Adal/g;
  $line3 =~ s/[aA]uður/Audur/g;
  $line3 =~ s/[fF]riðrik/Fridrik/g;
  $line3 =~ s/[gG]uðmundur/Gudmundur/g;
  $line3 =~ s/[hH]eiðar/Heidar/g;
  $line3 =~ s/[hH]örður/Hördur/g;
  $line3 =~ s/[sS]igurður/Sigurdur/g;

  $line3 =~ s/ð/g/g;
  $line3 =~ s/Ð/G/g;

  $line3 =~ s//z/g;

  my $ascii = ($orig =~ tr/\x00-\x7F//);
  my $total = length($orig);
  my $high = $total - $ascii;
  next if $high == 0;

  if ($line3 ne $orig)
  {
    print "$line1\n";
    print "$line2\n";
    print "$line3\n";
    print "$line4\n";
  }
}
close $fh;

