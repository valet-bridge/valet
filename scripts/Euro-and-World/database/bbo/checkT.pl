#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib './Tags';

use LinksT;
use Tags::Tname;
use Tags::Meet;

my $debug = 0;
my $debug_division = 'PAKISTAN';

my (%links_t, %links_m);
my (%links_thash, %links_mhash);


# Check that tournaments and Tname/Meet have the same primary names.
# Also check that whether a tournament would have a compatible meet.

die "perl digest.pl cooked.txt" unless ($#ARGV == -1);

my %divisionsT;
LinksT::init_linksT(\%divisionsT);

if ($debug)
{
  $divisionsT{$debug_division}->(\&set_linksT);

  my (%tname_hash, %meet_hash);
  Tags::Tname::set_masters(\%tname_hash, $debug_division);
  Tags::Meet::set_masters(\%meet_hash, $debug_division);

  check_same_hash("Tname", $debug_division,
    \%links_thash, \%tname_hash);
  check_same_hash("Meet", $debug_division,
    \%links_mhash, \%meet_hash);
}
else
{
  while (my ($key, $links_method) = each %divisionsT)
  {
    $links_method->(\&set_linksT);

    my (%tname_hash, %meet_hash);
    Tags::Tname::set_masters(\%tname_hash, $key);
    Tags::Meet::set_masters(\%meet_hash, $key);

    check_same_hash("Tname", $key,
      \%links_thash, \%tname_hash);
    check_same_hash("Meet", $key,
      \%links_mhash, \%meet_hash);
  }
}


sub set_linksT
{
  my ($meets, $tournaments, $key) = @_;

  %links_t = ();
  %links_m = ();
  %links_thash = ();
  %links_mhash = ();

  for my $meet (sort keys %$meets)
  {
    $links_mhash{$meet} = 1;
  }
  %{$links_m{$key}} = %$meets;

  for my $tournament (sort keys %$tournaments)
  {
    $links_thash{$tournament} = 1;
  }
  %{$links_t{$key}} = %$tournaments;
}


sub check_same_hash
{
  my ($text, $value, $hash1, $hash2) = @_;

  for my $k1 (sort keys %$hash1)
  {
    if (! exists $hash2->{$k1})
    {
      warn "$text, $value: $k1 not in typo hash";
    }
  }

  for my $k2 (sort keys %$hash2)
  {
    if (! exists $hash1->{$k2})
    {
      warn "$text, $value: $k2 not in structure hash";
    }
  }
}


