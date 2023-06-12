#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Tourneys;

# Make a script to make and check scores.txt
#
# perl makescript.pl
# perl makescript.pl 531

init_tourneys();

my $input = shift;
my @dir_list;

# Make the list of directories to examine.
make_dir_list($input, \@dir_list);

for my $dir (@dir_list)
{
  # say $dir;

  print "echo $dir->{name}\n";
  print "perl parse9.pl $dir->{number} | " .
    "sort -n > $dir->{name}/scores.txt\n";
  # print "perl parse8.pl $dir->{number} $dir->{name}/Matches/*.asp | " .
    # "sort -n > scores.txt\n";
  # print "diff scores.txt $dir->{name}\n";
  print "\n";
}

exit;
