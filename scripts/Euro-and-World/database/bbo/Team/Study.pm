#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Study;

our @ISA = qw(Exporter);
our @EXPORT = qw(study print_team_stats init_hashes);

use lib '.';
use lib './Team';
use lib './Tags';
use lib '../Connections';

use Token;
use Util;
use Separators;

use Team::Suggestors;
use Team::Repeats;

use Connections::Matrix;

my @TAG_ORDER = qw(
  FUN 
  FIRST 
  SPONSOR 
  ORGANIZATION 
  COUNTRY 
  REGION 
  ZONE 
  CLUB 
  OTHER 
  LOCALITY 
  CITY 

  ABBR 
  CAPTAIN
  BOT
  NATIONALITY
  UNIVERSITY 
  ROMAN
  GENDER
  AGE
  COLOR
  SCORING
  FORM
  MOVEMENT
  TWORD
  ORIGIN
  MEET
  TIME
  MONTH
  WEEKDAY
  NUMERAL
  DESTROY
);

my $PREFIX = 'TEAM_';
our $histo_team;


# BBOVG numbers for which repeated, but different fields are OK.
my %REPEATS;


sub init_hashes
{
  set_repeats(\%REPEATS);
}


sub eliminate_districts
{
  my ($team_ref) = @_;

  $$team_ref =~ s/district \d+//i;
  $$team_ref =~ s/\(D\d+\)//;
  $$team_ref =~ s/\bD\d+\b//;
  return ($$team_ref =~ /^\s*$/ ? 1 : 0);
}


sub study_value
{
  my ($whole, $value, $pos, $chain, $unsolved_flag) = @_;

  return if singleton_non_tag_matches($value, $pos, $chain,
    $main::histo_team, $PREFIX);

  return if singleton_tag_matches($whole, \@TAG_ORDER, 
    $pos, $value, 0, $chain, $main::histo_team, $PREFIX);

  my $token = Token->new();
  $token->set_origin($$pos, $value);
  $chain->append($token);
  $$pos++;

  return if Separators::set_token($value, $token);

  print "UUU value $value\n";
  $$unsolved_flag = 1;

  $token->set_unknown($value);
}


sub study_component
{
  my ($whole, $value, $chain, $token_no, $unsolved_flag) = @_;

  # Split on trailing digits.
  my $digits = '';
  if ($value =~ /^(.*[a-z])(\d+)$/i &&
      $1 ne 'U' && $1 ne 'D')
  {
    ($value, $digits) = ($1, $2);
  }

  study_value($whole, $value, $token_no, $chain, $unsolved_flag);

  if ($digits ne '')
  {
    # Add the digits if they exist.
    singleton_numeral($digits, $token_no, $chain,
      $main::histo_team, $PREFIX);
  }
}


sub study
{
  my ($whole, $text, $chain, $bbono, $unknowns) = @_;

  return if $text eq '';

  my $token_no = 0;
  if (my $s = suggest_form($text))
  {
    append_token($chain, 'SINGLETON', 'FORM', $s, $text, \$token_no,
      $main::histo_team, $PREFIX);
    return;
  }

  return if eliminate_districts(\$text);

  my @tags = (0);
  my @values = ($text);
  my @texts = ();
  split_on_multi($whole, \@TAG_ORDER, 0, \@tags, \@values, \@texts);

  # Split on separators.
  my $sep = qr/[\s+\-\+\._;&"\/\(\)\|]/;

  my $unsolved_flag = 0;

  for my $i (0 .. $#values)
  {
    if ($tags[$i] ne '0')
    {
      # We had a multi-word hit.
      append_token($chain, 'SINGLETON', $tags[$i], $values[$i],
        $texts[$i], \$token_no, $main::histo_team, $PREFIX);
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
      foreach my $part (@a)
      {
        study_component($whole, $part, $chain, \$token_no, 
          \$unsolved_flag);
      }
    }
  }

  if ($unsolved_flag)
  {
    $$unknowns++;
    print "UUU $bbono: $text\n" if $chain->last() > 0;
    print "\n";
  }
}

1;
