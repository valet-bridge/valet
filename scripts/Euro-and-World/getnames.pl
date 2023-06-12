#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Tourneys;

# Parse the BoardDetails files and the scores.txt file in the
# directory or directories, in order to validate make a names file.
#
# perl getnames.pl all
# perl getnames.pl 531

my $NO_PLAYER = 99999;


# Make the list of directories to examine.
my $input = shift;
init_tourneys();
my @dirlist;
if ($input eq 'all')
{
  for my $i (0 .. $#MAP)
  {
    push @dirlist, $MAP[$i][2] . "/" . $MAP[$i][3]
      if defined $MAP[$i];
  }
}
elsif (defined $MAP[$input])
{
  push @dirlist, $MAP[$input][2] . "/" . $MAP[$input][3];
}
else
{
  die "No such tournament number: $input";
}


my @names;
for my $dir (@dirlist)
{
  say $dir;
  next unless read_special_names("$dir/Matches");
}

for my $i (0 .. $#names)
{
  if (defined $names[$i])
  {
    print "$i|$names[$i]\n";
  }
}

exit;


sub read_special_names
{
  my $dirname = shift;
  my $dir;
  if (! (opendir $dir, $dirname))
  {
    warn "Cannot open direction $dirname: $!";
    return 0;
  }

  for my $fname (readdir $dir)
  {
    next unless $fname =~ /BoardDetails/;
    read_special_names_from_file($dirname . "/" . $fname);
  }

  closedir $dir;
  return 1;
}


sub read_special_names_from_file
{
  my $fname = shift;

  open my $fh, "<$fname" or die "Can't open $fname";

  $fname =~ /Board[Dd]etails-r(\d+)-t(\d+).asp/;
  my ($details_round, $details_table) = ($1, $2);

  # say $fname;

  while (my $line = <$fh>)
  {
    chomp $line;

    if ($line =~ /people.person.asp/ || $line =~ /personpopup/ ||
        $line =~ /href=11111/) # Kludge for artificially set players.
    {
      add_player($line);
      next;
    }
  }
  close $fh;
}


sub add_player
{
  my ($line, $players_ref) = @_;

  $line =~ /qryid=(\d+)/;
  my $qryid = $1;

  $line =~ s/\<[^>]*\>//g;
  $line =~ s/\&nbsp;//g;
  $line =~ s/^\s*//;
  $line =~ s/\s*$//;

  $names[$qryid] = $line;
}

