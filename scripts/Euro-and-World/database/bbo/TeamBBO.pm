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
use lib './Team';

use Country;
use Cookbook;
use Token;

use Separators;
use Age;
use Gender;
use Suggestors;

use Team::Fun;
use Team::First;
use Team::Other;
use Team::Sponsor;
use Team::Organization;
use Team::Abbr;
use Team::Country;
use Team::Region;
use Team::Zone;
use Team::Quarter;
use Team::City;
use Team::Club;
use Team::Captain;
use Team::Bot;
use Team::Nationality;
use Team::University;
use Team::Gender;
use Team::Age;
use Team::Color;
use Team::Scoring;
use Team::Form;
use Team::Destroy;

use Team::Matrix;

my @TAG_ORDER = qw(
  TEAM_FUN 
  TEAM_FIRST 
  TEAM_OTHER 
  TEAM_SPONSOR 
  TEAM_ORGANIZATION 
  TEAM_COUNTRY 
  TEAM_REGION 
  TEAM_ZONE 
  TEAM_CLUB 
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
  TEAM_DESTROY
);

my (%MULTI_WORDS, %MULTI_REGEX, %SINGLE_WORDS);
my (%MULTI_HITS);

my $CITIES_NAME = "../../../../../../bboD/../../cities/cities.txt";
my (%CITIES, %CITIES_LC);

# Links between different tags, e.g. club to city.
my %MATRIX;


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

my $country = Country->new();
my $gender = Gender->new();
my $age = Age->new();

my %HIT_STATS;
my %FORM_SCORES;


sub init_hashes
{
  set_hashes_team_fun('TEAM_FUN');
  set_hashes_team_first('TEAM_FIRST');
  set_hashes_team_other('TEAM_OTHER');
  set_hashes_team_region('TEAM_REGION');
  set_hashes_team_zone('TEAM_ZONE');
  set_hashes_team_city('TEAM_CITY');
  set_hashes_team_quarter('TEAM_QUARTER');
  set_hashes_team_sponsor('TEAM_SPONSOR');
  set_hashes_team_university('TEAM_UNIVERSITY');
  set_hashes_team_club('TEAM_CLUB');
  set_hashes_team_organization('TEAM_ORGANIZATION');
  set_hashes_team_abbr('TEAM_ABBR');
  set_hashes_team_captain('TEAM_CAPTAIN');
  set_hashes_team_bot('TEAM_BOT');
  set_hashes_team_country('TEAM_COUNTRY');
  set_hashes_team_nationality('TEAM_NATIONALITY');
  set_hashes_team_gender('TEAM_GENDER');
  set_hashes_team_age('TEAM_AGE');
  set_hashes_team_color('TEAM_COLOR');
  set_hashes_team_scoring('TEAM_SCORING');
  set_hashes_team_form('TEAM_FORM');
  set_hashes_team_destroy('TEAM_DESTROY');

  set_matrix();
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
      $mlink->{$entry} = $key;
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
  # elsif ($country->valid_lc(lc($part)))
  # {
    # $token->set_singleton('TEAM_COUNTRY', $part);
    # $HIT_STATS{TEAM_COUNTRY}++;
    # return;
  # }
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


sub study_team
{
  my ($text, $chain, $bbono) = @_;

  return if $text eq '';
  return if suggest_form($text, \%FORM_SCORES);

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
}


sub unteam
{
  my ($text, $result) = @_;

  my $res = $text;
  my $team1 = $result->{TEAM1};
  my $team2 = $result->{TEAM2};

  $res =~ s/\Q$team1\E// if defined $team1 && length($team1) > 1;
  $res =~ s/\Q$team2\E// if defined $team2 && length($team2) > 1;
  return $res;
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
