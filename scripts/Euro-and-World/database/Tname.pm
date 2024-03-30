#!perl

# Specific tournament names
package Tname;

use strict;
use warnings;
use Exporter;
use v5.10;

my %TOURNAMENT_HASH = 
(
  "Australian National Open Teams" => 
  { 
    COUNTRY => 'Australia',
    ORIGIN => 'Country',
    GEOGOVER => 'Country',
    GENDER => 'Open',
    FORM => 'Teams'
  },

  "Australian National Senior Teams" => 
  {
    COUNTRY => 'Australia',
    ORIGIN => 'Country',
    GEOGOVER => 'Country',
    AGE => 'Seniors',
    FORM => 'Teams'
  },

  "Australian National Women Teams" => 
  {
    COUNTRY => 'Australia',
    ORIGIN => 'Country',
    GEOGOVER => 'Country',
    GENDER => 'Women',
    FORM => 'Teams'
  },

  "Bermuda Bowl" => 
  {
    ORIGIN => 'National',
    GEOGOVER => 'World',
    GENDER => 'Open',
    FORM => 'Teams'
  },

  "Canadian National Teams" => 
  {
    COUNTRY => 'Canada',
    ORIGIN => 'Country',
    GEOGOVER => 'Country',
    GENDER => 'Open',
    FORM => 'Teams'
  },

  "D'Orsi Senior Cup" =>
  {
    ORIGIN => 'National',
    GEOGOVER => 'World',
    AGE => 'Seniors',
    FORM => 'Teams'
  },

  "European Championship" => 
  {
    ORIGIN => 'Country',
    GEOCOVER => 'Europe'
  },

  "Fortuna Cup" => 
  {
    COUNTRY => 'Estonia',
    CITY => 'Tallinn',
    GENDER => 'Open',
    AGE => 'Open',
    FORM => 'Pairs'
  },

  "Geologi Cup" => 
  {
    COUNTRY => 'Indonesia',
    FORM => 'Teams'
  },

  "Israel Grand Prix" => 
  {
    COUNTRY => 'Israel',
    FORM => 'Pairs',
    SCORING => 'IMP'
  },

  "Gro's Supercup" => 
  {
    COUNTRY => 'Germany',
    ORIGIN => 'Invitational',
    FORM => 'Pairs'
  },

  "Hungarian Cup" => 
  {
    COUNTRY => 'Hungary'
  },

  "Kepri Cup" => 
  {
    COUNTRY => 'Indonesia',
    REGION => 'Kepri',
    ORGANIZER => 'Kepri Contract Bridge Association'
  },

  "Nations Cup" => 
  {
    COUNTRY => 'Germany',
    CITY => 'Bonn',
    ORGANIZER => 'Bridge Club Bonn',
    ORIGIN => 'Country',
    FORM => 'Teams'
  },

  "Nordic Championship" => 
  {
    ORIGIN => 'Country',
    GEOCOVER => 'Nordic',
    FORM => 'Teams'
  },

  "Ruia Gold" => 
  {
    COUNTRY => 'India',
    FORM => 'Teams',
    MEMORIAL => 'Shri Ram Niwas Ruia'
  },

  "Ruia Silver" => 
  {
    COUNTRY => 'India',
    FORM => 'Teams',
    MEMORIAL => 'Shri Ram Niwas Ruia'
  },

  "Ruia Cup" => 
  {
    COUNTRY => 'India',
    FORM => 'Teams',
    MEMORIAL => 'Shri Ram Niwas Ruia'
  },

  "Serdika Cup" => 
  {
    COUNTRY => 'Bulgaria',
    CITY => 'Serdika',
    ORGANIZER => 'Bulgarian Bridge Federation'
  },

  "United States Bridge Championship" => 
  {
    COUNTRY => 'USA',
    ORGANIZER => 'USBF',
    ORIGIN => 'Country',
    GEOCOVER => 'Country'
  },

  "Vanderbilt" => 
  {
    COUNTRY => 'USA',
    ORGANIZER => 'ACBL',
  },

  "Venice Cup" => 
  {
    ORIGIN => 'National',
    GEOGOVER => 'World',
    GENDER => 'Women',
    FORM => 'Teams'
  },

  "Vest-Agder Club Championship" => 
  {
    COUNTRY => 'Norway',
    REGION => 'Vest-Agder',
    ORIGIN => 'Club'
  },
 
  "VITO Teams" => 
  {
    COUNTRY => 'Bulgaria',
    FORM => 'Teams'
  },

  "World Mind Sports Games" => 
  {
    ORIGIN => 'Country',
    GEOCOVER => 'World',
    ORGANIZER => 'International Mind Sports Association',
    FORM => 'Teams'
  },

  "World Transnational Open Teams" => 
  {
    ORIGIN => 'Transnational',
    GEOCOVER => 'World',
    GENDER => 'Open',
    FORM => 'Teams',
    SCORING => 'IMP'
  },

  "World Transnational Mixed Teams" => 
  {
    ORIGIN => 'Transnational',
    GEOCOVER => 'World',
    GENDER => 'Mixed',
    FORM => 'Teams',
    SCORING => 'IMP'
  }
);

my %TOURNAMENTS = map { $_ => 1} keys %TOURNAMENT_HASH;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $TOURNAMENTS{$text} ? 1 : 0;
}


1;
