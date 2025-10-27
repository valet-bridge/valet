#!perl

# Manipulate name lists.

package Manip;

use strict;
use warnings;
use utf8;
use v5.10;

use Exporter 'import';
our @EXPORT = qw(dedup reprint);

my $code1 = <<'END_CODE1';
#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::PACKAGE;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
END_CODE1

my $code2 = <<'END_CODE2';

my %SINGLE_TYPOS =
(
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
END_CODE2

sub dedup
{
  my ($hash1, $hash2, $name1, $name2) = @_;

  my %dup;
  foreach my $value (sort 
    { lc($hash1->{$a}->{VALUE}) cmp lc($hash1->{$b}->{VALUE}) } 
    keys %$hash1)
  {
    if (exists $hash2->{$value})
    {
      %{$dup{$value}} = %{$hash1->{$value}};
    }
  }

  reprint(\%dup, 'OVERLAP');

  my (%reduced1, %reduced2);
  foreach my $value (keys %$hash1)
  {
    %{$reduced1{$value}} = %{$hash1->{$value}} 
      unless exists $dup{$value};
  }
  foreach my $value (keys %$hash2)
  {
    %{$reduced2{$value}} = %{$hash2->{$value}} 
      unless exists $dup{$value};
  }

  reprint(\%reduced1, $name1);
  reprint(\%reduced2, $name2);
}


sub reprint
{
  my ($hash, $package) = @_;

  # Reprint in formatted style
  my $pkg = $code1;
  $pkg =~ s/PACKAGE/$package/g;
  print $pkg;

  my $indent = "  ";
  my $line = $indent;
  my $prev_initial = '';

  foreach my $value (sort 
    { lc($hash->{$a}->{VALUE}) cmp lc($hash->{$b}->{VALUE}) } 
    keys %$hash)
  {
    my $initial = uc substr($value, 0, 1);

    # Add blank line when initial changes
    if ($prev_initial ne '' && $initial ne $prev_initial) 
    {
      print "$line\n" if $line =~ /\S/;
      print "\n";
      $line = $indent;
    }

  # Check if adding the name exceeds 70 columns
  if (length($line) + length($value) + 1 > 70) 
  {
    print "$line\n";
    $line = $indent;
  }

  $line .= $hash->{$value}->{VALUE} . ' ';
  $prev_initial = $initial;
}

  # Print any remaining names in the buffer
  print "$line\n" if $line =~ /\S/;
  print ");\n$code2";
}


1;
