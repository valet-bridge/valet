#!perl

use strict;
use warnings;
use v5.10;

use IO::Handle;
use File::Copy;
use File::Fetch;
use HTML::TreeBuilder;

my $output_file = "record.txt"; # Is appended
my $output_bak = "record.bak";

my $tournament_file = "tournaments.txt"; # Is appended
my $tournament_bak = "tournaments.bak";


# Where the fetch ends up.
my $fetched = 'wbf/playerdetail.asp';


# Player file.

my $fp;
if (-e $output_file)
{
  copy($output_file, $output_bak) or die "File copy failed: $!";
  open $fp, '>>', $output_file or die
    "Cannot open $output_file for appending: $!";
}
else
{
  open $fp, '>', $output_file or die
    "Cannot open $output_file for appending: $!";
}


# Tournament file.

my $ft;
my @tournaments;
if (-e $tournament_file)
{
  copy($tournament_file, $tournament_bak) or die "File copy failed: $!";

  read_tournaments($tournament_file, \@tournaments, $ft);

  open $ft, '>>', $tournament_file or die
    "Cannot open $tournament_file for appending: $!";
}
else
{
  open $ft, '>', $tournament_file or die
    "Cannot open $tournament_file for appending: $!";
}


my $tree = HTML::TreeBuilder->new;
$tree->parse_file($fetched);

my $table = navigate_to_table();

my @table_data;
read_key_table();

$tree->delete;

my %player;
get_player_info($table_data[0][0], \%player);

# Check that row 7 is the first row of the history table.
die "Not a table header" unless $#{$table_data[7]} == 7;

my @played;
get_tournaments(\@table_data, \@played, \@tournaments, $ft);

print_player($fp, \%player, \@played);

close $fp;
close $ft;

exit;


sub read_tournaments
{
  my($tournament_file, $tref) = @_;

  open $ft, '<', $tournament_file or 
    die "Can't open $tournament_file for reading: $!";

  my $line;
  while ($line = <$ft>)
  {
    chomp $line;
    next unless $line =~ /^TOURNAMENT (.*)$/;

    my @elements = split /\|/, $1;
    die "Need 3 elements" unless $#elements == 2;

    $tref->[$elements[0]]{year} = $elements[1];
    $tref->[$elements[0]]{name} = $elements[2];
  }
    
  close $ft;
}


sub navigate_to_table
{
  # Find the specific table
  my $table = $tree->look_down(
    _tag => 'table', 
      class => qr/table table-responsive table-condensed table-hover table-striped/);
  die "No table" unless $table;
  return $table;
}


sub read_key_table
{
  foreach my $tr ($table->look_down(_tag => 'tr')) 
  {
    # Skip <tr> with align="right" as this is a masterpoint table.
    next if $tr->attr('align') && $tr->attr('align') eq 'right';

    # Initialize an array for this row
    my @row_data;

    # Process each <td> in the row
    foreach my $td ($tr->look_down(_tag => 'td')) 
    {
      my $text = $td->as_text;
      $text =~ s/^\s+|\s+$//g;

      if (my $a_tag = $td->look_down(_tag => 'a'))
      {
        # Check for an href attribute contained txttid.
        if (my ($txttid) = $a_tag->attr('href') =~ /txttid=(\d+)/)
        {
          push @row_data, $txttid;
          push @row_data, $text;
        }
        else
        {
          die "No txttid";
        }
      }
      else
      {
        push @row_data, $text;
      }
    }

    # Add the row to the table data
    push @table_data, \@row_data;
  }
}


sub get_player_info
{
  my ($text, $player_ref) = @_;
  my $nbsp = chr(160);
  my @parts = split /$nbsp/, $text;

  # Remove leading and trailing spaces.
  @parts = map { s/^\s+|\s+$//g; $_ } @parts;

  my $plast = $#parts;
  die "Expected 'of' in the right place" unless
    $parts[$plast-3]  =~ /^of/;

  $player_ref->{signifier} = $parts[0];
  if ($player_ref->{signifier} eq 'Mr')
  {
    $player_ref->{gender} = 'M';
  }
  elsif ($player_ref->{signifier} eq 'Mrs')
  {
    $player_ref->{gender} = 'F';
  }
  else
  {
    die "Gender? $player_ref->{signifier}";
  }

  for my $i (1 .. $plast-4)
  {
    push @{$player_ref->{names}}, $parts[$i];
  }

  $player_ref->{name} = uc($parts[$plast-4]);
  for my $i (1 .. $plast-5)
  {
    $player_ref->{name} .= " $parts[$i]";
  }

  die "No country or WBF NBO number" unless
    $parts[$plast-2] =~ /(.+)WBF Player Ref: (.*) \| NBO Number/;

  ($player_ref->{country}, $player_ref->{wbf_nbo_no}) = ($1, $2);

  die "No NBO number" unless
    $parts[$plast-1] =~ /^(\S+) Current WBF/;

  $player_ref->{nbo_no} = $1;

  die "No WBF number" unless
    $parts[$plast] =~ /(.+) \(please/;

  $player_ref->{wbf_no} = $1;

  # Remove leading and trailing spaces.
  %$player_ref = 
    map { $_ => $player_ref->{$_} =~ s/^\s+|\s+$//gr } keys %$player_ref;

  # Remove leading and trailing spaces.
  @{$player_ref->{names}} = 
    map { s/^\s+|\s+$//g; $_ } @{$player_ref->{names}};

}


sub get_tournaments
{
  my ($data_ref, $played_ref, $tournaments_ref, $ft) = @_;

  my $tno = 0;
  for my $rno (8 .. $#$data_ref)
  {
    $played_ref->[$tno]{year} = $data_ref->[$rno][0];
    $played_ref->[$tno]{id} = $data_ref->[$rno][2];
    $played_ref->[$tno]{name} = $data_ref->[$rno][3];
    $played_ref->[$tno]{represent} = $data_ref->[$rno][4];

    my $tid = $data_ref->[$rno][2];

    if (defined $tournaments_ref->[$tid])
    {
      # We've seen this tournament before.
      if ($tournaments_ref->[$tid]{year} ne $played_ref->[$tno]{year})
      {
        print "Tournament ID: $tid: Year ",
          $tournaments_ref->[$tid]{year}, 
          " vs ", 
          $played_ref->[$tno]{year},
          "\n";
        die "Mismatch";
      }

      if ($tournaments_ref->[$tid]{name} ne $played_ref->[$tno]{name})
      {
        print "Tournament ID: $tid: Name ",
          $tournaments_ref->[$tid]{name}, 
          " vs ", 
          $played_ref->[$tno]{name},
          "\n";
        die "Mismatch";
      }
    }
    else
    {
      $tournaments_ref->[$tid]{name} = $played_ref->[$tno]{name};
      $tournaments_ref->[$tid]{year} = $played_ref->[$tno]{year};

      print $ft "TOURNAMENT ", $tid, "|",
        $played_ref->[$tno]{year}, "|",
        $played_ref->[$tno]{name}, "\n";
    }

    $tno++;
  }
}


sub print_player
{
  my ($fh, $pref, $tref) = @_;

  print $fh "NAME $pref->{name}\n";
  print $fh "GENDER $pref->{gender}\n";
  print $fh "COUNTRY $pref->{country}\n";
  print $fh "WBF $pref->{wbf_no}\n";

  if (defined $pref->{nbo_no})
  {
    print $fh "WBF-NBO $pref->{nbo_no}\n";
  }
  elsif (defined $pref->{wbf_nbo_no})
  {
    print $fh "WBF-NBO $pref->{wbf_nbo_no}\n";
  }
  else
  {
    print $fh "WBF-NBO None\n";
  }

  foreach my $t (@$tref)
  {
    print $fh "TOURNAMENT $t->{id}|$t->{year}|$t->{represent}\n";
  }

  print $fh "\n";

  $fh->flush or die "Could not flush filehandle: $!";
}
