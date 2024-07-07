#!perl

package Connections::Fields;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(%SINGLETON_FIELDS %COUNTER_FIELDS %ITERATOR_FIELDS);

# Singletons are words imply a field and that don't have parameters.
# For example, "EBL" is an ORGANIZER.
#
# Iterators are words/concepts that take parameters.
# For example, "Round" can be "Round 4-5 of 8".

# First SINGLETON tags, then ITERATOR tags, then COUNTER tags.
# Some singleton tags also occur in the title, and we have to
# tell them apart if they occur in team names (of which there are two).
# Some of the singleton tags are created without a Tags.

my @SINGLETON_LIST = qw(
  ABBR
  AGE TEAM1_AGE TEAM2_AGE
  AMBIGUOUS
  BOT
  CAPTAIN TEAM1_CAPTAIN TEAM2_CAPTAIN
  CITY TEAM1_CITY TEAM2_CITY
  CLUB
  COLOR
  COUNTRY TEAM1_COUNTRY TEAM2_COUNTRY
  DAY
  DESTROY
  FIRST
  FORM
  FUN
  GENDER TEAM1_GENDER TEAM2_GENDER
  ITERATOR
  MEET
  MONTH
  MOVEMENT
  NATIONALITY
  ORGANIZATION
  ORIGIN
  OTHER
  PARTICLE
  PERSON
  QUARTER TEAM1_QUARTER TEAM2_QUARTER
  REGION TEAM1_REGION TEAM2_REGION
  ROMAN
  SCORING
  SPONSOR TEAM1_SPONSOR TEAM2_SPONSOR
  STAGE
  TIME
  TNAME
  TWORD TEAM1_TWORD TEAM2_TWORD
  UNIVERSITY
  ZONE

  DATE
  DATE_START 
  DATE_END
  YEAR
  YEAR_MONTH
  MONTH_DAY



  BERTH
  BOARDS
  FLIGHT
  GROUP
  HALF
  NUMERAL
  MATCH
  PART
  PHASE
  PLACE
  ROF
  ROOM
  ROUND
  SECTION
  SEGMENT
  SERIES
  SESSION
  SET
  STANZA
  TABLE
  TEMPO
  WEEK
  WEEKEND
  F G J K O P S U W Y
);

my @COUNTER_LIST = qw(
  NUMERAL
  ORDINAL TEAM1_ORDINAL TEAM2_ORDINAL
  LETTER
  ROMAN
  NL
  N_TO_N
  N_OF_N
  N_TO_N_OF_N
  NL_OF_N
  NL_TO_N
  MAJOR_MINOR


  AGE
  GENDER
);

my @ITERATOR_LIST = qw(
  BERTH
  BOARDS
  DAY
  FLIGHT
  GROUP
  HALF
  MATCH
  PART
  PHASE
  PLACE
  QUARTER TEAM1_QUARTER TEAM2_QUARTER
  ROF
  ROOM
  ROUND
  SECTION
  SEGMENT
  SERIES
  SESSION
  SET
  STAGE
  STANZA
  TABLE
  TEMPO
  WEEK
  WEEKEND
);

our %SINGLETON_FIELDS = map { $_ => 1 } @SINGLETON_LIST;
our %COUNTER_FIELDS = map { $_ => 1 } @COUNTER_LIST;
our %ITERATOR_FIELDS = map { $_ => 1 } @ITERATOR_LIST;

1;
