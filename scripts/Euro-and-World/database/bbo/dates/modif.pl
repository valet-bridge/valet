#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use IO::Handle;
use WWW::Mechanize;
use HTML::TreeBuilder;

# Scrape the modification times of .lin files from BBO.
die "perl modif.pl" unless $#ARGV == -1;

my $YEAR_FIRST = 2002;
my $YEAR_LAST = 2002;

my @MONTHS = qw(01 02 03 04 05 06 07 08 09 10 11 12);
my $MONTH_FIRST = 0;
my $MONTH_LAST = 11;

my $prefix = 'https://www.bridgebase.com/vugraph_archives/vugraph_archives.php?';

my $mech = WWW::Mechanize->new(timeout => 500);

my $max_retries = 10;

for my $year ($YEAR_FIRST .. $YEAR_LAST)
{
  for my $month ($MONTH_FIRST .. $MONTH_LAST)
  {
    my $ofile = "added-$year-$MONTHS[$month]";

    my $query = $prefix . "searchstring=$year-" . $MONTHS[$month] .
      '&command=search';

    my $attempt = 0;
    while ($attempt < $max_retries)
    {
      $attempt++;
      eval { $mech->get($query); };

      if (my $error = $@)
      {
        warn "Error $attempt fetching $year, $month: $error";
        next;
      }
      else
      {
        last;
      }
    }

    next if $attempt == $max_retries;

    if (! $mech->success)
    {
      print "Couldn't get";
      next;
    }

    warn "$query";

    my $tree = HTML::TreeBuilder->new_from_content($mech->content);

    open my $fo, '>', $ofile or die "Cannot write $ofile: $!";

    my @lines = split(/\s+/, $tree->as_HTML(undef, '  '. {}));
    my $bbono;
    for my $line (@lines)
    {
      if ($line =~ /popupvug\((\d+)\)/)
      {
        $bbono = $1;
      }
      elsif ($line =~ /(\d\d\d\d-\d\d-\d\d)/)
      {
        print $fo "BBONO $bbono\nDATE_ADDED $1\n\n";
      }
    }
    
    close $fo;
  }
}


