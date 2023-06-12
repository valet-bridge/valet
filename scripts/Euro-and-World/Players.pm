#!perl

use strict;
use warnings;
use Exporter;
use v5.10;

our @ISA = qw(Exporter);
our @EXPORT = qw(add_to_early_tables early_tables_parsable
  parse_player print_HTML_tables print_text_tables
  deHTML_names deHTML);

# Number of "no player".
my $NO_PLAYER = 999;


sub add_to_early_tables
{
  my ($line, $early_tables_ref, $early_stats_ref) = @_;

  if ($line =~ /^\s*\<tr[^>]*\>\s*$/)
  {
    $early_stats_ref->{td} = 0;
    $early_stats_ref->{fields} = 0;

    if ($early_stats_ref->{tr} == 0)
    {
      # This is not a hierarchically nested table, so we don't
      # discard an outer table.
      $early_stats_ref->{tables}++;
    }
    else
    {
    }

    $early_stats_ref->{tr} = 1;
    @{$early_tables_ref->[$early_stats_ref->{tables}]} = ();
  }
  elsif ($early_stats_ref->{tr} && $line =~/^\s*\<\/tr\>\s*$/)
  {
    # The end of a table we have been looking at (but not the
    # end of an outer hierarchical table which we are discarding).
    die unless $early_stats_ref->{tr};

    $early_stats_ref->{tr} = 0;
    $early_stats_ref->{td} = 0;

    # Make a note of the table containing the East-West's.
    my $flag = 0;
    for my $l (@{$early_tables_ref->[$early_stats_ref->{tables}]})
    {
      if ($l =~ /graphics/)
      {
        $flag = 1;
        last;
      }
    }
      
    $early_stats_ref->{kinds}[$early_stats_ref->{tables}] = $flag;

    # $early_stats_ref->{tables}++;
    # @{$early_tables_ref->[$early_stats_ref->{tables}]} = ();
    # $early_stats_ref->{fields} = 0;
  }
  elsif ($early_stats_ref->{td})
  {
    # We are in a table data field.
    die unless $early_stats_ref->{tr};
    $early_tables_ref->[$early_stats_ref->{tables}]
      [$early_stats_ref->{fields}] .= $line;

    if ($line =~ /\<\/td\>\s*$/)
    {
      # The field is ending.
      $early_stats_ref->{td} = 0;
      $early_stats_ref->{fields}++;
    }
  }
  elsif ($line =~ /^\s*\<td.*\<\/td\>\s*$/)
  {
    # Whole td entry in one line.
    die unless $early_stats_ref->{tr};
    die if $early_stats_ref->{td};

    $early_tables_ref->[$early_stats_ref->{tables}]
      [$early_stats_ref->{fields}] = $line;
    $early_stats_ref->{fields}++;
  }
  elsif ($line =~ /^\s*\<td/)
  {
    # td entry is starting.
    die unless $early_stats_ref->{tr};
    die if $early_stats_ref->{td};

    $early_stats_ref->{td} = 1;
    $early_tables_ref->[$early_stats_ref->{tables}]
      [$early_stats_ref->{fields}] = $line;
  }
}


sub early_tables_parsable
{
  my ($early_tables_ref, $early_stats_ref, $players_ref) = @_;

  if ($early_stats_ref->{tables} < 3)
  {
    # Not enough tables to look for players.
    return 0;
  }

  my $flag = 0;
  my $index = -1;
  for my $i (0 .. $early_stats_ref->{tables}-1)
  {
    last unless defined $early_stats_ref->{kinds}[$i];

    if ($early_stats_ref->{kinds}[$i] == 1)
    {
      $flag = 1;
      $index = $i;
      last;
    }
  }

  if (! $flag || $index == 0 || $index == $early_stats_ref->{tables}-1)
  {
    # No central table.
    return 0;
  }

  my $table1_ref = $early_tables_ref->[$index-1];
  my $table2_ref = $early_tables_ref->[$index];
  my $table3_ref = $early_tables_ref->[$index+1];

  if ($#$table1_ref != 1)
  {
    warn "Expected two fields in first table";
    return 0;
  }

  if (! parse_player($table1_ref->[0], \%{$players_ref->[0]}))
  {
    # warn "Expected first player in first line of first table";
  }

  if (! parse_player($table1_ref->[1], \%{$players_ref->[1]}))
  {
    # warn "Expected second player in first line of first table";
  }

  if ($#$table2_ref != 5)
  {
    # warn "Expected six fields in first table";
  }

  if (! parse_player($table2_ref->[0], \%{$players_ref->[2]}))
  {
    # warn "Expected first player in first line of second table";
  }

  if (! parse_player($table2_ref->[2], \%{$players_ref->[3]}))
  {
    # warn "Expected second player in third line of second table";
  }

  if (! parse_player($table2_ref->[3], \%{$players_ref->[4]}))
  {
    # warn "Expected first player in fourth line of second table";
  }

  if (! parse_player($table2_ref->[5], \%{$players_ref->[5]}))
  {
    # warn "Expected second player in sixth line of second table";
  }

  if ($#$table3_ref != 1)
  {
    # warn "Expected two fields in first table";
  }

  if (! parse_player($table3_ref->[0], \%{$players_ref->[6]}))
  {
    # warn "Expected first player in first line of third table";
  }

  if (! parse_player($table3_ref->[1], \%{$players_ref->[7]}))
  {
    # warn "Expected second player in second line of third table";
  }

  return 1;
}


sub parse_player
{
  my($str, $pref) = @_;

  my $t = deHTML_names($str);

  if ($str =~ /qryid=(\d+)/)
  {
    $pref->{number} = $1;
  }
  else
  {
    $pref->{number} = $NO_PLAYER;
  }

  if ($t =~ /^\s*$/)
  {
    $pref->{name} = "DUMMY";
    return 0;
  }
  else
  {
    $pref->{name} = $t;
    return 1;
  }
}


sub print_HTML_tables
{
  my $tables_ref = pop;

  for my $i (0 .. $#$tables_ref)
  {
    print "Table $i:\n";
    for my $j (0 .. $#{$tables_ref->[$i]})
    {
      print "$j: $tables_ref->[$i][$j]\n";
    }
    print "\n";
  }
}


sub print_text_tables
{
  my $tables_ref = pop;

  for my $i (0 .. $#$tables_ref)
  {
    print "Table $i:\n";
    for my $j (0 .. $#{$tables_ref->[$i]})
    {
      print "$j: " . deHTML($tables_ref->[$i][$j]) . "\n";
    }
    print "\n";
  }
}


sub deHTML_names
{
  my $text = shift;
  $text =~ s/\<[^>]*\>//g;
  $text =~ s/\&nbsp;//g;
  $text =~ s/^\s+//;
  $text =~ s/\s+$//;
  return $text;
}


sub deHTML
{
  my $text = shift;
  $text =~ s/\<[^>]*\>//g;
  $text =~ s/\&nbsp;//g;
  $text =~ s/x/X/g;
  $text =~ s/NT/N/g;
  $text =~ s/\&spades;/S/g;
  $text =~ s/\&hearts;/H/g;
  $text =~ s/\&diams;/D/g;
  $text =~ s/\&clubs;/C/g;
  $text =~ s/clubs;/C/g;
  $text =~ s/^\s+//;
  $text =~ s/\s+$//;
  return $text;
}

1;
