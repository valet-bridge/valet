#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamBBO;

our @ISA = qw(Exporter);
our @EXPORT = qw(read_cities study_teams unteam print_team_stats
  set_overall_hashes init_hashes   all_used);

use lib '.';
use lib '..';
use lib './Team';
use lib './Event';
use lib './Tags';

use Country;
use Token;
use Util;

use Event::Cookbook;

use Separators;
use Age;
use Gender;

use Team::Suggestors;

use Tags::Fun;
use Tags::First;
use Tags::Other;
use Tags::Sponsor;
use Tags::Organization;
use Tags::Abbr;
use Tags::Country;
use Tags::Region;
use Tags::Zone;
use Tags::Quarter;
use Tags::City;
use Tags::Club;
use Tags::Captain;
use Tags::Bot;
use Tags::Nationality;
use Tags::University;
use Tags::Gender;
use Tags::Age;
use Tags::Color;
use Tags::Scoring;
use Tags::Form;

use Tags::Tword;
use Tags::Meet;

use Tags::Destroy;

use Team::Matrix;
use Team::Repeats;

my @TAG_ORDER = qw(
  TEAM_FUN 
  TEAM_FIRST 
  TEAM_SPONSOR 
  TEAM_ORGANIZATION 
  TEAM_COUNTRY 
  TEAM_REGION 
  TEAM_ZONE 
  TEAM_CLUB 
  TEAM_OTHER 
  TEAM_QUARTER 
  TEAM_CITY 
  TEAM_ABBR 
  TEAM_CAPTAIN
  TEAM_BOT
  TEAM_NATIONALITY
  TEAM_UNIVERSITY 
  TEAM_GENDER
  TEAM_AGE
  TEAM_COLOR
  TEAM_SCORING
  TEAM_FORM
  TEAM_TWORD
  TEAM_MEET
  TEAM_TIME
  TEAM_DESTROY
);

my (%MULTI_WORDS, %MULTI_REGEX, %SINGLE_WORDS);
my (%MULTI_HITS);

my $CITIES_NAME = "../../../../../../bboD/../../cities/cities.txt";
my (%CITIES, %CITIES_LC);

# Links between different tags, e.g. club to city.
my %MATRIX;

# BBOVG numbers for which repeated, but different fields are OK.
my %REPEATS;


sub read_cities
{
  my () = @_;
  open my $fh, '<', $CITIES_NAME or die "Cannot read file $CITIES_NAME $!";
  my $line;
  while ($line = <$fh>)
  {
    my @a = split '\|', $line;
    die "City format: $line, $#a" unless $#a == 1;
    $CITIES{$a[0]} = $a[1];
    $CITIES_LC{lc($a[0])} = $a[1];
  }
  close $fh;
}

my %HIT_STATS;
my %FORM_SCORES;


sub init_hashes
{
  my $method = \&TeamBBO::set_overall_hashes;

  Tags::Fun::set_hashes($method, 'TEAM_FUN');
  Tags::First::set_hashes($method, 'TEAM_FIRST');
  Tags::Other::set_hashes($method, 'TEAM_OTHER');
  Tags::Region::set_hashes($method, 'TEAM_REGION');
  Tags::Zone::set_hashes($method, 'TEAM_ZONE');
  Tags::City::set_hashes($method, 'TEAM_CITY');
  Tags::Quarter::set_hashes($method, 'TEAM_QUARTER');
  Tags::Sponsor::set_hashes($method, 'TEAM_SPONSOR');
  Tags::University::set_hashes($method, 'TEAM_UNIVERSITY');
  Tags::Club::set_hashes($method, 'TEAM_CLUB');
  Tags::Organization::set_hashes($method, 'TEAM_ORGANIZATION');
  Tags::Abbr::set_hashes($method, 'TEAM_ABBR');
  Tags::Captain::set_hashes($method, 'TEAM_CAPTAIN');
  Tags::Bot::set_hashes($method, 'TEAM_BOT');
  Tags::Country::set_hashes($method, 'TEAM_COUNTRY');
  Tags::Nationality::set_hashes($method, 'TEAM_NATIONALITY');
  Tags::Gender::set_hashes($method, 'TEAM_GENDER');
  Tags::Age::set_hashes($method, 'TEAM_AGE');
  Tags::Color::set_hashes($method, 'TEAM_COLOR');
  Tags::Scoring::set_hashes($method, 'TEAM_SCORING');
  Tags::Form::set_hashes($method, 'TEAM_FORM');
  Tags::Tword::set_hashes($method, 'TEAM_TWORD');
  Tags::Meet::set_hashes($method, 'TEAM_MEET');
  Tags::Time::set_hashes($method, 'TEAM_TIME');

  # TODO Goal is mainly to have one of these.
  Tags::Destroy::set_hashes($method, 'TEAM_DESTROY');

  set_matrix();
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


sub set_overall_hashes
{
  my ($multi_words, $multi_typos, $single_words, $single_typos, $key) = @_;

  # The words themselves.
  for my $multi (@$multi_words)
  {
    my $tilded = $multi =~ s/ /\~/gr;
    $MULTI_WORDS{$key}{lc($multi)} = $multi;
    $SINGLE_WORDS{$key}{lc($multi)} = 
      { CATEGORY => $key, VALUE => $multi };
  }

  # Any typos.
  for my $multi (keys %$multi_typos)
  {
    my $tilded = $multi =~ s/ /\~/gr;
    for my $typo (@{$multi_typos->{$multi}})
    {
      $MULTI_WORDS{$key}{lc($typo)} = $multi;
      $SINGLE_WORDS{$key}{lc($multi)} = 
        { CATEGORY => $key, VALUE => $multi };
    }
  }

  if (keys %{$MULTI_WORDS{$key}})
  {
    my $multi_pattern_direct = join('|', map { quotemeta }
      sort { length($b) <=> length($a) } keys %{$MULTI_WORDS{$key}});

    $MULTI_REGEX{$key} = qr/(?<!\p{L})($multi_pattern_direct)(?=\P{L}|\z)/i;
  }
  else
  {
    $MULTI_REGEX{$key} = '';
  }

  # Similarly for the single words.
  for my $single (@$single_words)
  {
    $SINGLE_WORDS{$key}{lc($single)} = 
      { CATEGORY => $key, VALUE => $single };
  }

  for my $single (keys %$single_typos)
  {
    for my $typo (@{$single_typos->{$single}})
    {
      $SINGLE_WORDS{$key}{lc($typo)} = 
        { CATEGORY => $key, VALUE => $single };
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
        $field ne 'TEAM_DESTROY' && 
        $record->{$field} ne $val)
    {
      print "$bbono, $text, $field: $record->{$field} vs $val\n";
    }
  }
}


sub make_complete_field_record
{
  my ($text, $chain, $bbono, $record) = @_;

  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    my $field = $token->field();
    my $val = $token->value();

    push @{$record->{$field}}, $val;
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
  elsif ($from eq 'TEAM_CLUB' && $to eq 'TEAM_CITY' && $c =~ /-Pan$/)
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
    'TEAM_REGION', 'TEAM_COUNTRY');
  check_consistency_pair($text, $bbono, \%record,
    'TEAM_CITY', 'TEAM_COUNTRY');
  check_consistency_pair($text, $bbono, \%record,
    'TEAM_QUARTER', 'TEAM_CITY');
  check_consistency_pair($text, $bbono, \%record,
    'TEAM_UNIVERSITY', 'TEAM_CITY');
  check_consistency_pair($text, $bbono, \%record,
    'TEAM_CLUB', 'TEAM_CITY');
  check_consistency_pair($text, $bbono, \%record,
    'TEAM_SPONSOR', 'TEAM_COUNTRY');
}


sub fix_some_parentheses
{
  my ($team_ref) = @_;

  return unless $$team_ref =~ /\((.*)\)/;
  my $t = $1;

  my $fix = $SINGLE_WORDS{TEAM_AGE}{lc($t)};
  if (defined $fix->{CATEGORY})
  {
    $$team_ref =~ s/\($t\)/($fix->{VALUE})/;
    return;
  }

  $fix = $SINGLE_WORDS{TEAM_GENDER}{lc($t)};
  if (defined $fix->{CATEGORY})
  {
    $$team_ref =~ s/\($t\)/($fix->{VALUE})/;
    return;
  }

  if ($t eq 'O')
  {
    $$team_ref = 'Open';
  }
  elsif ($t eq 'W')
  {
    $$team_ref = 'Women';
  }
  elsif ($t eq 'S')
  {
    $$team_ref = 'Seniors';
  }
  elsif ($t eq 'L')
  {
    $$team_ref = 'Ladies';
  }
  elsif ($t eq 'J')
  {
    $$team_ref = 'Juniors';
  }
}


sub clean_team
{
  my $team = pop;
  $team =~ s/\(\d+\)\s*$//; # (69)
  $team =~ s/^\s+|\s+$//g; # Leading and trailing space

  # Fix some parentheses with age and gender.
  fix_some_parentheses(\$team);

  my $fix = $FIX_HASH{lc($team)};
  if (defined $fix && $fix->{CATEGORY} eq 'COUNTRY')
  {
    return $fix->{VALUE};
  }
  elsif ($team =~ /^\s*$/)
  {
    return '';
  }
  else
  {
    return $team;
  }
}


sub eliminate_districts
{
  my ($team_ref) = @_;

  if ($$team_ref =~ s/district \d+//i)
  {
    return ($$team_ref =~ /^\s*$/ ? 1 : 0);
  }
  elsif ($$team_ref =~ s/\(D\d+\)//)
  {
    return ($$team_ref =~ /^\s*$/ ? 1 : 0);
  }
  elsif ($$team_ref =~ s/\bD\d+\b//)
  {
    return ($$team_ref =~ /^\s*$/ ? 1 : 0);
  }
  else
  {
    return 0;
  }
}


sub split_on_trailing_digits
{
  my ($list_ref) = @_;

  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];
    next unless $part =~ /^(.*[a-z])(\d+)$/i;

    my ($letters, $digits) = ($1, $2);
    next if $letters eq 'U' || $letters eq 'D';
    next if $digits > 50;

    splice(@$list_ref, $i, 0, ('') x 2);
    $list_ref->[$i] = $letters;
    $list_ref->[$i+1] = '|';
    $list_ref->[$i+2] = $digits;
  }
}


sub team_specific_hashes
{
  my ($part, $token, $chain) = @_;

  for my $tag (@TAG_ORDER)
  {
    my $fix = $SINGLE_WORDS{$tag}{lc($part)};
    if (defined $fix->{CATEGORY})
    {
      # my $w = $fix->{VALUE};
      # $MULTI_HITS{$tag}{lc($part)}++;
      # $MULTI_HITS{$tag}{lc($w)}++;

      $token->set_singleton($fix->{CATEGORY}, $fix->{VALUE});
      $HIT_STATS{$fix->{CATEGORY}}++;

      if ($fix->{CATEGORY} eq 'TEAM_GENDER' &&
          $fix->{VALUE} eq 'Open')
      {
        # Special case: Add an extra token.
        my $token2 = Token->new();
        $token2->copy_origin_from($token);
        $token2->set_singleton('TEAM_AGE', 'Open');
        $chain->append($token2);
        $HIT_STATS{'TEAM_AGE'}++;
      }
      elsif ($fix->{CATEGORY} eq 'TEAM_AGE' &&
          $fix->{VALUE} eq 'Girls')
      {
        # Special case: Add an extra token.
        my $token2 = Token->new();
        $token2->copy_origin_from($token);
        $token2->set_singleton('TEAM_GENDER', 'Women');
        $chain->append($token2);
        $HIT_STATS{'TEAM_GENDER'}++;
      }

      return 1;
    }
  }
  return 0;
}


sub study_part
{
  my ($part, $i, $chain, $unknown_part_flag) = @_;

  my $token = Token->new();
  $token->set_origin($i, $part);
  $chain->append($token);

  $HIT_STATS{TOTAL}++;

  if (set_token($part, $token))
  {
    $token->set_singleton('SEPARATOR', $part);
    $HIT_STATS{SEPARATOR}++;
    return;
  }
  elsif ($part =~ /^\d+$/)
  {
    if ($part >= 1900 && $part < 2100)
    {
      $token->set_singleton('TEAM_YEAR', $part);
      $HIT_STATS{TEAM_YEAR}++;
    }
    else
    {
      $token->set_numeral_counter($part);
      $HIT_STATS{TEAM_INTEGER}++;
    }
    return;
  }
  elsif ($part =~ /^[A-D]$/)
  {
    $token->set_letter_counter($part);
    $HIT_STATS{TEAM_LETTER}++;
    return;
  }

  # The general solution.
  return if team_specific_hashes($part, $token, $chain);

  # Some use of other hashes.
  my $fix_event = $FIX_HASH{lc($part)};

  if (defined $fix_event->{CATEGORY})
  {
    my $category = $fix_event->{CATEGORY};
    if ($category eq 'NUMERAL' || $category eq 'ROMAN')
    {
      $token->set_singleton('TEAM_' . $category, $fix_event->{VALUE});
      $HIT_STATS{'TEAM_' . $category}++;
      return;
    }
  }

  $token->set_unknown($part);
  $HIT_STATS{UNMATCHED}++;
  print $part, "\n";
  $$unknown_part_flag = 1;
}


sub split_on_multi
{
  my ($text, $parts, $tags) = @_;

  @$parts = ($text);
  @$tags = (0);

  for my $tag (@TAG_ORDER)
  {
    next if $MULTI_REGEX{$tag} eq '';
    for my $i (reverse 0 .. $#$parts)
    {
      next if $tags->[$i] ne '0';
      my @a = grep { $_ ne '' } split /$MULTI_REGEX{$tag}/, $parts->[$i];

      if ($#a == 0)
      {
        # Optimize for this frequent special case.
        if (exists $MULTI_WORDS{$tag}{lc($a[0])})
        {
          $parts->[$i] = $MULTI_WORDS{$tag}{lc($a[0])};
          $tags->[$i] = $tag;
          # my $w = $MULTI_WORDS{$tag}{lc($a[0])};
          # $MULTI_HITS{$tag}{lc($a[0])}++;
          # $MULTI_HITS{$tag}{lc($w)}++;
        }
      }
      else
      {
        splice(@$parts, $i, 1, @a);
        splice(@$tags, $i, 1, (0) x ($#a+1));

        for my $j ($i .. $i + $#a)
        {
          if (exists $MULTI_WORDS{$tag}{lc($parts->[$j])})
          {
            $parts->[$j] = $MULTI_WORDS{$tag}{lc($parts->[$j])};
            $tags->[$j] = $tag;
            # my $w = $MULTI_WORDS{$tag}{lc($parts->[$j])};
            # $MULTI_HITS{$tag}{lc($parts->[$j])}++;
            # $MULTI_HITS{$tag}{lc($w)}++;
          }
        }
      }
    }
  }
}

sub study_component
{
  my ($part, $chain, $token_no, $unsolved_flag) = @_;

  # Split on trailing digits.
  my $unknown_part_flag = 0;
  if ($part =~ /^(.*[a-z])(\d+)$/i &&
      $1 ne 'U' && $1 ne 'D')
  {
    my ($letters, $digits) = ($1, $2);

    study_part($letters, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;

    study_part($digits, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;
  }
  else
  {
    study_part($part, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;
  }

  $$unsolved_flag = 1 if $unknown_part_flag;
}


sub fix_heuristics
{
  my ($text, $chain, $bbono) = @_;

  my %record;
  make_complete_field_record($text, $chain, $bbono, \%record);

  # Destroy Bridge Club if there is also Sporting Club.
  if (exists $record{TEAM_ABBR} && $#{$record{TEAM_ABBR}} == 1)
  {
    for my $i (0 .. $chain->last())
    {
      my $token = $chain->check_out($i);
      if ($token->field() eq 'TEAM_ABBR' &&
          $token->value() eq 'Bridge Club')
      {
        $token->set_singleton('TEAM_DESTROY', 'Bridge Club');
      }
    }
  }

  # Turn Orange White into Netherlands White.
  if (exists $record{TEAM_COLOR} && $#{$record{TEAM_COLOR}} == 1)
  {
    my $token = $chain->check_out(0);
    if (lc($token->value()) eq 'orange')
    {
      $token->set_singleton('TEAM_COUNTRY', 'Netherlands');
    }
  }

  # Destroy two numerals.
  if (exists $record{NUMERAL} && $#{$record{NUMERAL}} == 1)
  {
    for my $i (0 .. $chain->last())
    {
      my $token = $chain->check_out($i);
      if ($token->field() eq 'NUMERAL')
      {
        $token->set_singleton('TEAM_DESTROY', $token->value());
      }
    }
  }
}


sub study_team
{
  my ($text, $chain, $bbono) = @_;

  return if $text eq '';
  if (my $s = suggest_form($text, \%FORM_SCORES))
  {
    my $token = Token->new();
    $token->set_origin(0, $text);
    $token->set_singleton('TEAM_FORM', $s);
    $chain->append($token);
    $HIT_STATS{TEAM_FORM}++;
    return;
  }

  return if eliminate_districts(\$text);

  my @parts = ($text);
  my @tags = (0);
  split_on_multi($text, \@parts, \@tags);

  # Split on separators.
  my $sep = qr/[\s+\-\+\._;&"\/\(\)\|]/;

  my $token_no = 0;
  my $unsolved_flag = 0;

  for my $i (0 .. $#parts)
  {
    if ($tags[$i] ne '0')
    {
      # We had a multi-word hit.
      my $token = Token->new();
      $token->set_origin($i, $parts[$i]);
      $token->set_singleton($tags[$i], $parts[$i]);
      $chain->append($token);
      $token_no++;
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $parts[$i]);
      foreach my $part (@a)
      {
        study_component($part, $chain, \$token_no, \$unsolved_flag);
      }
    }
  }

  print "UUU $bbono: $text\n" if ($unsolved_flag && $chain->last() > 0);
  print "\n" if $unsolved_flag;

  fix_heuristics($text, $chain, $bbono);
}


sub print_team_stats
{
  for my $key (sort keys %HIT_STATS)
  {
    printf("%-20s %6d\n", $key, $HIT_STATS{$key});
  }

  print "\n";

  for my $key (sort keys %FORM_SCORES)
  {
    printf("%-20s %6d\n", $key, $FORM_SCORES{$key});
  }
}


sub study_teams
{
  my ($text, $result, $chain1, $chain2, $bbono) = @_;

  return unless defined $text;

  if ($text =~ /(.*) vs\. (.*)/)
  {
    my ($team1, $team2) = ($1, $2);
    $result->{TEAM1} = clean_team($team1);
    $result->{TEAM2} = clean_team($team2);
  }
  elsif ($text =~ /^\s*$/ || $text =~ /^\s*vs\.\s*$/)
  {
    $result->{TEAM1} = '';
    $result->{TEAM2} = '';
    return;
  }
  else
  {
    die "Can't parse team line $text\n";
  }

  study_team($result->{TEAM1}, $chain1, $bbono);
  study_team($result->{TEAM2}, $chain2, $bbono);

  check_consistency($result->{TEAM1}, $chain1, $bbono);
  check_consistency($result->{TEAM2}, $chain2, $bbono);

  # Kludge for event matches.
  $result->{TEAM1} =~ s/\s*- npc$//;
  $result->{TEAM2} =~ s/\s*- npc$//;
}


sub is_captain
{
  # Not used.  Maybe for other data sources again.
  my ($text) = @_;

  my $lt = lc($text);
  my $fix = $SINGLE_WORDS{TEAM_CAPTAIN}{$lt};
  return 1 if defined $fix->{CATEGORY};

  if ($lt =~ /$MULTI_REGEX{TEAM_CAPTAIN}/)
  {
    return 1;
  }

  return 0;
}


sub all_used
{
  print "Multis:\n\n";
  for my $key (@TAG_ORDER)
  {
    for my $entry (sort keys %{$MULTI_WORDS{$key}})
    {
      if (! defined $MULTI_HITS{$key}{$entry})
      {
        print "$key: $entry\n";
      }
    }
  }

  print "\nSingles\n\n";
  for my $key (@TAG_ORDER)
  {
    for my $entry (sort keys %{$SINGLE_WORDS{$key}})
    {
      if (! defined $MULTI_HITS{$key}{$entry})
      {
        print "$key: $entry\n";
      }
    }
  }

}

1;
