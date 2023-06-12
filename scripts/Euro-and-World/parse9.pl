#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Tourneys;
use Players;
use Names;
use Plausibles qw(%CONTRACTS %DECLARERS %LEADS @TRICKS @SCORES init_plausibles);
use Write qw(set_fronts print_line);
use Scalar::Util qw(looks_like_number);

# Parse the BoardDetails files and make the scores.txt file.
#
# perl specials.pl all
# perl specials.pl 531

my %special_map;
# TODO Needed?
$special_map{'Pass'} = 'P';
$special_map{'adj'} = 'Adj.';
$special_map{'adj.'} = 'Adj.';
$special_map{'Adj'} = 'Adj.';
$special_map{'Adj.'} = 'Adj.';
$special_map{'ADJ'} = 'Adj.';
$special_map{'ADJ.'} = 'Adj.';

# Number of "no player".
my $NO_PLAYER = 999;


# Make the list of directories to examine.
my $input = shift;
init_tourneys();
my @dirlist;
make_dir_list($input, \@dirlist);


# Parse each directory.
init_plausibles();
my (%details, %names);
for my $dir (@dirlist)
{
  my $dirname = $dir->{name};
  # say $dirname;

  # Read the player names.
  my $namefile = "$dirname/names.txt";

  # next unless read_names($namefile);
  next unless read_names($namefile, \%names);

  next unless read_details_directory("$dirname/Matches");

  undef %details;
  undef %names;
}


exit;


sub read_details_directory
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
    read_details_file($dirname . "/" . $fname);
  }

  closedir $dir;
  return 1;
}


sub read_details_file
{
  my $fname = shift;

  open my $fh, "<$fname" or die "Can't open $fname";

  $fname =~ /Board[Dd]etails-r(\d+)-t(\d+).asp/;
  my ($details_round, $details_table) = ($1, $2);

  my @players;
  my $players_seen = 0;
  my @early_tables;
  my %early_stats;
  $early_stats{tr} = 0; # Start outside of a table
  $early_stats{td} = 0; # Start outside of a data cell
  $early_stats{tables} = -1; # No tables completed
  $early_stats{fields} = 0; # Current field

  my @entries;

  my $round_no = 0;
  my $board_no = 0;
  my $column_no = 0;
  my $cell = "";
  my $bracket_state = 0;

  # say $fname;

  while (my $line = <$fh>)
  {
    chomp $line;

    if ($board_no == 0 && ! $players_seen)
    {
      # The tables in front of the board information are a bit
      # heterogeneous.  Here we look for three consecutive tables.
      # The first one has the two North players.
      # The second one has the Wests and Easts, and graphics symbols.
      # The third one has the two South players.
      # The players may be missing.

      $line =~ s///g;
      add_to_early_tables($line, \@early_tables, \%early_stats);
      my @players2;
      if ($early_stats{tr} == 0 &&
          early_tables_parsable(\@early_tables, \%early_stats, \@players2))
      {
        $players_seen = 1;
        names_to_numbers(\%names, \@players2, \@players);
      }
    }

    if ($line =~ /people.person.asp/ || $line =~ /personpopup/ ||
        $line =~ /href=11111/) # Kludge for artificially set players.
    {
      next;
    }

    if ($line =~ /Round (\d+)/)
    {
      $round_no = $1;
      next;
    }
    elsif ($line =~ /Round/)
    {
      $line = <$fh>;
      chomp $line;
      if ($line =~ /^\s*(\d+)/)
      {
        $round_no = $1;
      }
      next;
    }

    my $qboard_flag = 0;
    my $table_end_flag = 0;
    my $new_board_no = 0;
    if ($line =~ /Board[Aa]cross.asp\?qboard=0*(\d+)/)
    {
      $qboard_flag = 1;
      $new_board_no = $1;
    }
    elsif ($line =~ /^\<\/table\>/)
    {
      $table_end_flag = 1;
    }

    if ($qboard_flag || $table_end_flag)
    {
      die "Should not happen\n" if $bracket_state;
    }

    if ($qboard_flag && $board_no == 0)
    {
      # Nothing to show yet.
      $board_no = $new_board_no;
      $column_no = 0;
      next;
    }
    elsif ($board_no == 0)
    {
      next;
    }

    if ($qboard_flag || $line =~ /^\<\/table\>/)
    {
      die "Round $round_no $details_round" unless 
        ($round_no == $details_round);

      if ($#entries <= 6)
      {
        print join ", ", @entries, "\n";
        die "No two contracts?\n";
      }

      my ($front1, $front2);
      set_fronts("$round_no|$board_no|", \@players, \$front1, \$front2);

      print_line($front1, \@entries, 0);
      print_line($front2, \@entries, 6);

      undef @entries;
      $board_no = $new_board_no;
      $column_no = 0;

      next if ($qboard_flag);
      last;
    }

    next if ($line =~ /\<\/table\>/);

    $line =~ s/^\s*//;
    $line =~ s/\s*$//;
    next if $line eq '';

    # Keep track of where we are in potential multi-line
    # <td> </td> pairs.
    if ($bracket_state)
    {
      $cell .= $line;
      $bracket_state = 0 if $line =~ /\<\/td\>$/;
    }
    elsif ($line =~ /^\<td.*\<\/td\>$/)
    {
      # Whole td /td line.
      $cell = $line;
      $bracket_state = 0;
    }
    elsif ($line =~ /^\<td/)
    {
      # Only the opening part.
      $bracket_state = 1;
      $cell = $line;
    }

    next if $bracket_state;

    say $cell;
    $entries[$column_no++] = deHTML($cell);
  }
  close $fh;
}

