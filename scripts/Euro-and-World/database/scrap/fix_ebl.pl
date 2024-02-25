#!perl

use strict;
use warnings;
use v5.10;

# Uses edits.txt to edit names.txt.

die "perl edits.pl" unless $#ARGV == -1;

my $ebl_file = 'prelim/ebl.txt';
my $edit_file = 'edits.txt';

my @edits;
read_edits($edit_file, \@edits);

my @TAGS = qw(
  NAME 
  NAME_PREFERRED
  NAME_DEPRECATED
  COUNTRY 
  EBL 
  EBL_PREFERRED
  WBF 
  GENDER 
  TOURNAMENT
  DELETE);

my %TAGS_HASH;
$TAGS_HASH{$_} = 1 for @TAGS;

open my $fn, '<', $ebl_file or 
  die "Cannot open $ebl_file for reading $!";

my %buffer;
my @seen;

while (my $line = <$fn>)
{
  chomp $line;

  if ($line !~ /^\s*$/)
  {
    # Fill the buffer.
    if ( $line !~ /^(\S+)\s+(.*)$/)
    {
      die "$line: Doesn't follow format";
    }

    my ($tag, $rest) = ($1, $2);
    die "$line: Unknown tag $tag" unless defined $TAGS_HASH{$tag};

    push @{$buffer{$tag}}, $rest;
  }
  else
  {
    # Process and empty the buffer.
    next unless keys %buffer;

    if (! defined $buffer{EBL})
    {
      foreach my $tag (@TAGS)
      {
        print "$tag: $buffer{$tag}\n" if (defined $buffer{$tag})
      }
      die "Buffer does not have EBL";
    }

    if ($#{$buffer{EBL}} != 0)
    {
      die "Not exactly one EBL number";
    }

    my $ebl = $buffer{EBL}[0];
    if (defined $edits[$ebl])
    {
      if (defined $edits[$ebl]{DELETE})
      {
        # Skip
        %buffer = ();
        next;
      }

      foreach my $tag (@TAGS)
      {
        next unless defined $edits[$ebl]{$tag};
        foreach my $edit (@{$edits[$ebl]{$tag}})
        {
          push @{$buffer{$tag}}, $edit;
        }
      }
    }

    foreach my $tag (@TAGS)
    {
      next unless defined $buffer{$tag};
      for my $entry (@{$buffer{$tag}})
      {
        print "$tag $entry\n";
      }
    }
    print "\n";

    $seen[$ebl] = 1;
    %buffer = ();
  }
}

close $fn;

# We still have EBL_PREFERRED and some deletions to deal with.

for my $ebl (0 .. $#edits)
{
  next unless defined $edits[$ebl];
  next if defined $seen[$ebl];
  if (defined $edits[$ebl]{DELETE})
  {
    print "EBL $ebl\n";
    print "DELETED\n\n";
  }
  elsif (defined $edits[$ebl]{EBL_PREFERRED})
  {
    if ($#{$edits[$ebl]{EBL_PREFERRED}} != 0)
    {
      die "Expected exactly one redirect: $ebl";
    }

    my $redirect = $edits[$ebl]{EBL_PREFERRED}[0];

    print "EBL $ebl\n";
    print "EBL_PREFERRED $redirect\n\n";
  }
}

exit;


sub read_edits
{
  my ($ename, $edits_ref) = @_;

  open my $fe, '<', $ename or die "Cannot open $ename for reading $!";
  my $line;
  my $ebl = '';
  while ($line = <$fe>)
  {
    chomp $line;
    next if $line =~ /^#/ or $line =~ /^\s*$/;

    if ($line =~ /^EBL\s+(\d+)$/)
    {
      $ebl = $1;
    }
    elsif ($line =~ /^delete$/)
    {
      push @{$edits_ref->[$ebl]{DELETE}}, 1;
    }
    else
    {
      $line =~ /^(\S+)\s+(\S+)\s+(.*)$/;
      my ($action, $tag, $rest) = ($1, $2, $3);
      if ($action eq 'add')
      {
        push @{$edits_ref->[$ebl]{$tag}}, $rest;
      }
      else
      {
        die "Unknown action: $line";
      }
    }
  }
  close $fe;
}
