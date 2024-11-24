#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib './Tags';

use LinksT;
use DateCalc;
use Tags::Tname;
use Tags::Meet;

my $debug;
my $debug_division = '';

my (%links_t, %links_m);
my (%links_thash, %links_mhash);

my %IGNORE_MEETS = (
  'Anatolian Club Teams|2012|C0' => 'Assael Festival',
  'APBF Women Elite Tournament|2006|C2' => 
    'FISU World University Championships',
  'APBF Women Elite Tournament|2006|C3' =>
    'FISU World University Championships',
  'Bologna Trophy|2014|C0' => 'Italy Cup',
  'Torneo di Roma|2014|C0' => 'Italy Cup',
  'Viareggio Cup|2005|C0' => 'Italian Club Championship',
  'Polish Individual Championship|2012A|C0' => 'Polish Championships',
  # This is true, but too hard to track down other Open Trials.
  'Polish Open Trials|2004|SINGLE' => 'Luczniczka Meeting',
  'Polish Premier League|2006|C1' => 'Polish Pairs Championship',
  'Polish Premier League|2012|C2' => 'Zulawski Congress',
  'Polish Premier League|2013|C2' => 'Zulawski Congress',
  'All India Bangur Cement Hindusthan Club|2015|C0' =>
    'Goa Bridge Festival',
  'All India Bangur Cement Hindusthan Club|2015|C1' =>
    'Goa Bridge Festival',
  'Israel Open Teams Cup|2010|SINGLE' => 'Israel Grand Prix',
  'Italian Mixed Teams|2024|C0' => 'Italy Cup', # For now
  'Izmir Winter Teams Cup|2016|SINGLE' => 'Sivrioglu Festival'
);


# Check that tournaments and Tname/Meet have the same primary names.
# Also check that whether a tournament would have a compatible meet.

die "perl checkT.pl [INDONESIA]" unless ($#ARGV <= 0);

if ($#ARGV == 0)
{
  $debug = 1;
  $debug_division = $ARGV[0];
}
else
{
  $debug = 0;
}

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
  suggest_meets($debug_division);
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
  suggest_meets($key);
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


sub suggest_meets
{
  my ($key) = @_;

  my @keys = sort keys %links_t;
  return unless $#keys == 0;

  for my $tname (sort keys %{$links_t{$keys[0]}})
  {
    my $editions = $links_t{$keys[0]}{$tname}{EDITIONS};
    for my $tag (sort keys %$editions)
    {
      my $edition = $editions->{$tag};
      next if exists $edition->{MEET};

      for my $ctag (sort keys %{$edition->{CHAPTERS}})
      {
        my $chapter = $edition->{CHAPTERS}{$ctag};
        my $cdate1 = $chapter->{DATE_START};
        my $cdate2 = $chapter->{DATE_END};

        for my $meet (sort keys %{$links_m{$keys[0]}})
        {
          my $meditions = $links_m{$keys[0]}{$meet}{EDITIONS};
          for my $mtag (sort keys %$meditions)
          {
            my $mchapter = $meditions->{$mtag};
            my $mdate1 = $mchapter->{DATE_START};
            my $mdate2 = $mchapter->{DATE_END};

            # warn "$tname, $ctag: $cdate1, $mdate1";

            my $tdate = DateCalc->new();
            $tdate->set_by_field($cdate1);
            next unless $tdate->distance($mdate1, $mdate2) == 0;

            $tdate->set_by_field($cdate2);
            next unless $tdate->distance($mdate1, $mdate2) == 0;

            my $str = $tname . '|' . $mtag . '|' . $ctag;
            next if exists $IGNORE_MEETS{$str};

            warn "$tname, $ctag: Matches meet $meet, $mtag?";
          }
        }
      }
    }
  }
}

