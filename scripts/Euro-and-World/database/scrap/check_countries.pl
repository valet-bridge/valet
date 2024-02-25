#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Read;

# Make a table of names/genders for each country.

die "perl check_countries.pl" unless $#ARGV == -1;

my $names_file = 'ebl.txt';
my $comb_file = 'combined.txt';
my $tourn_file = 'tournaments.txt';

my (@name_players, @name_tournaments);
read_names($names_file, \@name_players, \@name_tournaments);

my %count;
my %undefs;

for my $pno (1 .. $#name_players)
{
  next unless defined $name_players[$pno];

  my $country = $name_players[$pno]{COUNTRY}[0];
  my $gender = $name_players[$pno]{GENDER}[0];

  if (! defined $country)
  {
    print "HERE\n";
  }


  if ($gender eq '?')
  {
    my $name = $name_players[$pno]{NAME}[0];
    $name =~ s/\-//g;
    $name =~ s/\b\w\b//g;
    $name =~ s/\. / /g;
    $name =~ s/\s+/ /g;
    $name =~ s/^\s+//g;

    if ($name =~ /\s/)
    {
      # So we have eliminated single-character initials, dots etc.
      push @{$undefs{$country}}, $name;

      $count{$country}{$gender}++;
    }
  }
  else
  {
    $count{$country}{$gender}++;
  }
}

for my $c (keys %count)
{
  $count{$c}{'?'} = 0 unless defined $count{$c}{'?'};
}

for my $c (sort {$count{$b}{'?'} <=> $count{$a}{'?'}} keys %count)
{
  next unless $count{$c}{'?'} > 0;
  printf("%-20s%6d%6d%6d\n",
    $c, 
    $count{$c}{M} || 0,
    $count{$c}{F} || 0,
    $count{$c}{'?'});
}

print "\n";

for my $c (sort keys %undefs)
{
  print "Country $c:\n";
  print "---------------\n\n";
  for my $n (sort @{$undefs{$c}})
  {
    print "$n\n";
  }
  print "\n";
}
