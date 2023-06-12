#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Tourneys;

# Make a script to make and check scores.txt counts
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
  print "perl summscore.pl $dir->{name}/scores.txt\n";
  print "\n";
}

exit;
