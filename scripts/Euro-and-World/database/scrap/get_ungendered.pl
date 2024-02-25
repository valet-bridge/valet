#!perl

use strict;
use warnings;
use v5.10;

# Extracts player numbers with entries "GENDER ?".

die "perl get_ungendered.pl" unless $#ARGV == -1;

my $ebl_file = 'ebl/ebl.txt';

my (@ebl, @redirections, @deletions);
read_ebl($ebl_file, \@ebl, \@redirections, \@deletions);

exit;


sub read_ebl
{
  my ($efile, $ebl_ref, $redir_ref, $deletions_ref) = @_;
 
  open my $fe, '<', $efile or die "Cannot open $efile for reading $!";

  my $line;
  my %record;

  while ($line = <$fe>)
  {
    chomp $line;
    if ($line =~ /^\s*$/)
    {
      die "No number" unless defined $record{EBL};

      if ($#{$record{EBL}} != 0)
      {
        die "Multiple numbers";
      }
      my $no = $record{EBL}[0];

      if (! defined $record{GENDER})
      {
        %record = ();
        next;
      }
      
      if ($#{$record{GENDER}} != 0)
      {
        die "More than one gender field";
      }

      my $gender = $record{GENDER}[0];
      if ($gender eq '?')
      {
        print "$no\n";
      }

      %record = ();
    }
    else
    {
      my ($tag, $content);
      if ($line =~ /^(\S+)\s+(.*)$/)
      {
        ($tag, $content) = ($1, $2);
        push @{$record{$tag}}, $content;
      }
      elsif ($line eq 'DELETED')
      {
        push @{$record{DELETED}}, -1;
      }

    }
  }

  close $fe;
}

