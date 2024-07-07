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

# TODO More similar order to others?

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


# Links between different tags, e.g. club to city.
my %MATRIX;

# BBOVG numbers for which repeated, but different fields are OK.
my %REPEATS;


sub init_hashes
{
  Connections::Matrix::set_matrix();
  set_repeats(\%REPEATS);
}


sub set_link_matrix
{
  # 'to' might be TEAM_COUNTRY, 'from' might be TEAM_REGION.
  my ($link, $to, $from) = @_;

  my $mlink = \%{$MATRIX{$from}{$to}};
  for my $key (keys %$link)
  {
    for my $entry (@{$link->{$key}})
    {
      $mlink->{lc($entry)} = $key;
    }
  }
}


sub make_field_record
{
  my ($text, $chain, $bbono, $record, $dupl_flag) = @_;

  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    my $field = $token->field();
    my $val = $token->value();

    if (! exists $record->{$field})
    {
      $record->{$field} = $val;
    }
    elsif ($dupl_flag && 
        $field ne 'DESTROY' && 
        $record->{$field} ne $val)
    {
      print "$bbono, $text, $field: $record->{$field} vs $val\n";
    }
  }
}


sub check_consistency_pair
{
  my ($text, $bbono, $record, $from, $to) = @_;

  return unless exists $record->{$from};
  return unless exists $record->{$to};

  my $c = $MATRIX{$from}{$to}{lc($record->{$from})};
  if (! defined $c)
  {
    print "$bbono, $text, $to: ",
      "$record->{$from} not in matrix ($from, $to)\n";
  }
  elsif ($c eq $record->{$to})
  {
    return;
  }
  elsif ($from eq 'CLUB' && $to eq 'CITY' && $c =~ /-Pan$/)
  {
    # Special case.
    return;
  }
  else
  {
    print "$bbono, $text, $to: ",
      "$record->{$to} vs $c\n";
  }
}


sub check_consistency
{
  my ($text, $chain, $bbono) = @_;

  return if exists $REPEATS{$bbono};

  my %record;
  make_field_record($text, $chain, $bbono, \%record, 1);

  check_consistency_pair($text, $bbono, \%record,
    'REGION', 'COUNTRY');
  check_consistency_pair($text, $bbono, \%record,
    'CITY', 'COUNTRY');
  check_consistency_pair($text, $bbono, \%record,
    'LOCALITY', 'CITY');
  check_consistency_pair($text, $bbono, \%record,
    'UNIVERSITY', 'CITY');
  check_consistency_pair($text, $bbono, \%record,
    'CLUB', 'CITY');
  check_consistency_pair($text, $bbono, \%record,
    'SPONSOR', 'COUNTRY');
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
        $texts[$i], \$token_no, $main::histo_title, $PREFIX);
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

  my $delta = $chain->last() - $token_no + 1;
  print "DELTA TEAM $delta\n";

}

1;
