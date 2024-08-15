#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

# Merge the scraped files from BBO containing dates added
# for each lin file.
die "perl merge.pl" unless $#ARGV == -1;

my $YEAR_FIRST = 2002;
my $YEAR_LAST = 2024;

my @MONTHS = qw(01 02 03 04 05 06 07 08 09 10 11 12);
my $MONTH_FIRST = 0;
my $MONTH_LAST = 11;

my $seqno = 0;
my $bbono;
my @data;

for my $year (reverse $YEAR_FIRST .. $YEAR_LAST)
{
  for my $month (reverse $MONTH_FIRST .. $MONTH_LAST)
  {
    my $ofile = "added-$year-$MONTHS[$month]";
    next unless -e $ofile;

    open my $fo, '<', $ofile or die "Cannot read $ofile: $!";

    while (my $line = <$fo>)
    {
      chomp $line;
      if ($line =~ /^BBONO (\d+)$/)
      {
        $bbono = $1;
      }
      elsif ($line =~ /^DATE_ADDED (\d+\-\d+\-\d+)/)
      {
        my $date = $1;
        $data[$seqno]{BBONO} = $bbono;
        $data[$seqno]{DATE_ADDED} = $date;
        $seqno++;
      }
    }
    close $fo;
  }
}

my $len = $#data;
for my $i (reverse 0 .. $len)
{
  printf("%6d  %6d  %s\n",
    $len-$i, $data[$i]{BBONO}, $data[$i]{DATE_ADDED});
}
