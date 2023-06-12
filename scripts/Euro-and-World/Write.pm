#!perl

use strict;
use warnings;
use Exporter;
use v5.10;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_fronts print_line);

my $NO_PLAYER = 999;

sub set_fronts
{
  my ($piece, $players_ref, $front1_ref, $front2_ref) = @_;

  if (defined $players_ref->[0])
  {
    $$front1_ref = $piece .
    "$players_ref->[0]|$players_ref->[3]|" .
    "$players_ref->[6]|$players_ref->[2]";

    $$front2_ref = $piece .
    "$players_ref->[1]|$players_ref->[5]|" .
    "$players_ref->[7]|$players_ref->[4]";
  }
  else
  {
    $$front1_ref = $piece .
      "$NO_PLAYER|$NO_PLAYER|$NO_PLAYER|$NO_PLAYER";

    $$front2_ref = $piece .
      "$NO_PLAYER|$NO_PLAYER|$NO_PLAYER|$NO_PLAYER";
  }
}


sub print_line
{
  my ($front, $entries_ref, $offset) = @_;

  if (! defined $entries_ref->[$offset])
  {
    print "$front|(Missing)|S|0\n";
  }
  elsif (lc($entries_ref->[$offset]) =~ /adj/)
  {
    print "$front|Adj.|S|0\n";
  }
  elsif ($entries_ref->[$offset] =~ /^\s*$/)
  {
    print "$front|None|S|0\n";
  }
  elsif ($entries_ref->[$offset] eq 'Pass')
  {
    print "$front|P|S|0\n";
  }
  elsif (! defined $entries_ref->[$offset+2] ||
    $entries_ref->[$offset+2] eq 'X' ||
    $entries_ref->[$offset+2] eq '_Z_' ||
    $entries_ref->[$offset+2] eq '')
  {
    print "$front|$entries_ref->[$offset]|$entries_ref->[$offset+1]|" .
      "$entries_ref->[$offset+3]\n";
  }
  else
  {
    my $lead = $entries_ref->[$offset+2];
    $lead =~ s/10/T/;
    print "$front|$entries_ref->[$offset]|$entries_ref->[$offset+1]|" .
      "$entries_ref->[$offset+3]|$lead\n";
  }
}


sub print_bids
{
  my ($front, $contract, $bids_ref) = @_;

  if (lc($contract) =~ /adj/)
  {
    print "$front|Adj.\n";
  }
  elsif (lc($contract) =~ /none/)
  {
    print "$front|None\n";
  }
  else
  {
    print $front . "|" . join('|', @$bids_ref) . "\n";
  }

}

1;
