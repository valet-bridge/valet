#!perl

package Manual::SubLines;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';

sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub read_file_internal
{
  # Not a class method.
  my ($fname, $hash) = @_;

  open(my $fh, "<$fname") or die "Cannot open $fname: $!";
  my $sno = 0;
  while (my $line = <$fh>)
  {
    $sno++;
    if ($line !~ /^(.+), (\d+), (\d+)$/)
    {
      die "FORMAT $sno: $line";

    }
    my ($handle, $count, $lno) = ($1, $2, $3);
    my $orig = <$fh>; chomp $orig;
    my $sub = <$fh>; chomp $sub;
    my $empty = <$fh>;
    $sno += 3;

    $hash->{$handle}{$count}{$lno}[0] = $orig;
    $hash->{$handle}{$count}{$lno}[1] = $sub;
  }
  close $fh;
}


sub read_file
{
  my ($self, $fname) = @_;

  read_file_internal($fname, \%{$self->{SUB}});
}


sub consolidate_with
{
  my ($self, $newfile) = @_;

  my %newhash;
  read_file_internal($newfile, \%newhash);

  my $total_new_handles = 0;
  my $copied_handles = 0;
  my $copied_instances = 0;
  my $copied_lines = 0;
  my $adapted_lines = 0;

  for my $handle (keys %newhash)
  {
    $total_new_handles++;
    my $entry = $newhash{$handle};
    if (! exists $self->{SUB}{$handle})
    {
      %{$self->{SUB}{$handle}} = %$entry;
      $copied_handles++;
      next;
    }

    for my $instance (sort keys %$entry)
    {
      my $lines = $entry->{$instance};
      if (! exists $self->{SUB}{$handle}{$instance})
      {
        %{$self->{SUB}{$handle}{$instance}} = %$lines;
        $copied_instances++;
        next;
      }

      for my $lno (sort keys %$lines)
      {
        my $unit = $lines->{$lno};
        if (! exists $self->{SUB}{$handle}{$instance}{$lno})
        {
          @{$self->{SUB}{$handle}{$instance}{$lno}} = @$unit;
          $copied_lines++;
          next;
        }

        my $old_unit = $self->{SUB}{$handle}{$instance}{$lno};

        if ($old_unit->[1] eq $unit->[0])
        {
          $old_unit->[1] = $unit->[1];
          $adapted_lines++;
        }
        else
        {
          print "CONSOLIDATE: $handle, $instance, $lno\n";
          print "Old[0] ", $old_unit->[0], "\n";
          print "Old[1] ", $old_unit->[1], "\n";
          print "New[0] ", $unit->[0], "\n";
          print "New[1] ", $unit->[1], "\n";
        }
      }
    }
  }

  printf("Total new handles%8d\n", $total_new_handles);
  printf("Copied handles   %8d\n", $copied_handles);
  printf("Copied instances %8d\n", $copied_instances);
  printf("Copied lines     %8d\n", $copied_lines);
  printf("Adapted lines    %8d\n", $adapted_lines);
}


sub lookup
{
  my ($self, $handle, $instance, $lno, $text) = @_;

  return '' unless exists $self->{SUB}{$handle};
  my $entry = $self->{SUB}{$handle};

  return '' unless exists $entry->{$instance};
  my $lines = $entry->{$instance};

  return '' unless exists $lines->{$lno};
  my $unit = $lines->{$lno};

  if ($unit->[0] ne $text)
  {
    print "LOOKUP $handle, $instance, $lno\n";
    print "Old[0] ", $unit->[0], "\n";
    print "Old[1] ", $unit->[1], "\n";
    print "Text   ", $text, "\n";
    return '';
  }
  else
  {
    return $unit->[1];
  }
}


sub print
{
  my ($self) = @_;

  for my $handle (sort keys %{$self->{SUB}})
  {
    my $entry = $self->{SUB}{$handle};
    for my $instance (sort keys %$entry)
    {
      my $lines = $entry->{$instance};
      for my $lno (sort keys %$lines)
      {
        my $unit = $lines->{$lno};
        print "$handle, $instance, $lno\n";
        print $unit->[0], "\n";
        print $unit->[1], "\n\n";
      }
    }
  }
}

1;
