#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

use LWP::UserAgent;
use URI::Escape;
use File::Path qw(make_path);

my $ua = LWP::UserAgent->new;
$ua->timeout(10);

my $prefix = 'https://ergebnisse.bridge-verband.de/gettur.php?turid=46110&site=3&kl=0&';
my $prefix = 'https://ergebnisse.bridge-verband.de/gettur.php?turid=47580&site=3&kl=0&';
my $sprefix = 'club';

# Create output directory if it doesn't exist
make_path($sprefix) unless -d $sprefix;

for my $d (0 .. 3) 
{
  for my $bd (1 .. 24) 
  {
    my $ext = "durch=$d&arg=$bd";
    my $url = $prefix . $ext;
    my $filename = "$sprefix/d${d}_bd_${bd}.html";

    say "Fetching: $url";

    my $response = $ua->get($url);

    if ($response->is_success) 
    {
      open my $fh, '>', $filename or die "Cannot write to $filename: $!";
      print $fh $response->decoded_content;
      close $fh;
    } 
    else 
    {
      warn "Failed to fetch $url: " . $response->status_line;
    }
  }
}

