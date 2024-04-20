#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamBBO;

our @ISA = qw(Exporter);
our @EXPORT = qw(read_cities study_teams unteam print_team_stats
  set_overall_hashes init_hashes);

use lib '.';

use Country;
use Cookbook;
use Token;

use Separators;
use Age;
use Gender;
use Suggestors;

use TeamFun;
use TeamCity;
use TeamSponsor;
use TeamUniversity;
use TeamClub;
use TeamOrganization;
use TeamCaptain;
use TeamCountry;
use TeamNationality;
use TeamRegion;

my (%MULTI_WORDS, %MULTI_REGEX, %SINGLE_WORDS);

my $CITIES_NAME = "../../../../../../bboD/../../cities/cities.txt";
my (%CITIES, %CITIES_LC);


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


# TODO 
# Add Guernsey, United Kingdom, Jersey, Mali
# DenmarS, Deutsch, Indýa, Sweeden, CBAI, Brasilia

my $country = Country->new();
my $gender = Gender->new();
my $age = Age->new();

my %HIT_STATS;
my %FORM_SCORES;


sub init_hashes
{
  set_hashes_team_fun('TEAM_FUN');
  set_hashes_team_city('TEAM_CITY');
  set_hashes_team_sponsor('TEAM_SPONSOR');
  set_hashes_team_university('TEAM_UNIVERSITY');
  set_hashes_team_club('TEAM_CLUB');
  set_hashes_team_organization('TEAM_ORGANIZATION');
  set_hashes_team_captain('TEAM_CAPTAIN');
  set_hashes_team_country('TEAM_COUNTRY');
  set_hashes_team_nationality('TEAM_NATIONALITY');
  set_hashes_team_region('TEAM_REGION');
}


sub set_overall_hashes
{
  my ($multi_words, $multi_typos, $single_words, $single_typos, $key) = @_;

  # The words themselves.
  for my $multi (@$multi_words)
  {
    my $tilded = $multi =~ s/ /\~/gr;
    $MULTI_WORDS{$key}{lc($multi)} = $tilded;
    $SINGLE_WORDS{$key}{lc($multi)} = 
      { CATEGORY => $key, VALUE => $multi };
  }

  # Any typos.
  for my $multi (keys %$multi_typos)
  {
    my $tilded = $multi =~ s/ /\~/gr;
    for my $typo (@{$multi_typos->{$multi}})
    {
      $MULTI_WORDS{$key}{lc($typo)} = $tilded;
      $SINGLE_WORDS{$key}{lc($multi)} = 
        { CATEGORY => $key, VALUE => $multi };
    }
  }

  my $multi_pattern = join('|', map { quotemeta }
    keys %{$MULTI_WORDS{$key}});

  $MULTI_REGEX{$key} = qr/\b($multi_pattern)\b/i;


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


sub clean_team
{
  my $team = pop;
  $team =~ s/\s*\(\d+\)\s*$//; # (69)
  $team =~ s/^\s+|\s+$//g; # Leading and trailing space

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


sub split_on_trailing_digits
{
  my ($list_ref) = @_;

  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];
    next unless $part =~ /^([a-z]+)(\d+)$/i;

    my ($letters, $digits) = ($1, $2);
    next if $letters eq 'U' || $letters eq 'D';

    splice(@$list_ref, $i, 0, ('') x 2);
    $list_ref->[$i] = $letters;
    $list_ref->[$i+1] = '|';
    $list_ref->[$i+2] = $digits;
  }
}

my $tmp_global;

sub study_part
{
  my ($part, $i, $chain) = @_;

  my $token = Token->new();
  $token->set_origin($i, $part);
  $chain->append($token);

  $HIT_STATS{TOTAL}++;

  # Turn the artificial separator back into a space.
  $part =~ s/~/ /g;

  # Try the new hash set-up.
  for my $tag (qw(TEAM_FUN TEAM_CITY TEAM_COUNTRY TEAM_NATIONALITY
    TEAM_REGION TEAM_SPONSOR TEAM_UNIVERSITY TEAM_CLUB TEAM_ORGANIZATION 
    TEAM_CAPTAIN))
  {
    my $fix = $SINGLE_WORDS{$tag}{lc($part)};
    if (defined $fix->{CATEGORY})
    {
      $token->set_singleton($fix->{CATEGORY}, $fix->{VALUE});
      $HIT_STATS{$fix->{CATEGORY}}++;
      return;
    }
  }

  my $fix_event = $FIX_HASH{lc($part)};

  if (defined $fix_event->{CATEGORY})
  {
    my $category = $fix_event->{CATEGORY};
    if ($category eq 'AGE' || $category eq 'CITY' ||
        $category eq 'COUNTRY' || $category eq 'FORM' || 
        $category eq 'GENDER' || $category eq 'MONTH' || 
        $category eq 'NUMERAL' || $category eq 'ROMAN' ||
        $category eq 'SCORING' || $category eq 'SPONSOR' ||
        $category eq 'TOURNAMENT')
    {
      $token->set_singleton($category, $fix_event->{VALUE});
      $HIT_STATS{$category}++;
      return;
    }

    # TODO Can print "ZZZ UNKNOWN $part\n";
  }

  if (set_token($part, $token))
  {
    $token->set_singleton('SEPARATOR', $part);
    $HIT_STATS{SEPARATOR}++;
  }
  elsif ($country->valid_lc(lc($part)))
  {
    $token->set_singleton('COUNTRY', $part);
    $HIT_STATS{COUNTRY}++;
  }
  elsif ($part =~ /^19\d\d$/ || $part =~ /^20\d\d$/)
  {
    $token->set_singleton('YEAR', $part);
    $HIT_STATS{YEAR}++;
  }
  elsif ($part =~ /^\d+$/ && $part >= 0 && $part < 100)
  {
    $token->set_numeral_counter($part);
    $HIT_STATS{INTEGER}++;
  }

  elsif ($part =~ /^open$/i)
  {
    $HIT_STATS{OPEN}++;
  }
  else
  {
    $token->set_unknown($part);
    $HIT_STATS{UNMATCHED}++;
    print $part, "\n";
    $tmp_global = 1;
  }
}


sub study_team
{
  my ($text, $chain) = @_;

  if (suggest_form($text, \%FORM_SCORES))
  {
    return;
  }

  for my $tag (qw(TEAM_FUN TEAM_CITY TEAM_COUNTRY TEAM_NATIONALITY
    TEAM_REGION TEAM_SPONSOR TEAM_UNIVERSITY TEAM_CLUB 
    TEAM_ORGANIZATION TEAM_CAPTAIN))
  {
    $text =~ s/$MULTI_REGEX{$tag}/$MULTI_WORDS{$tag}{lc($1)}/ge;
  }

  # Split on separators.
  my @parts = grep {$_ ne ''} split /([.\-\+_:;"\/\(\)]|\s+)/, $text;

  split_on_trailing_digits(\@parts);

  my $one_tmp = 0;
  for my $i (0 .. $#parts)
  {
    $tmp_global = 0;
    study_part($parts[$i], $i, $chain);
    if ($tmp_global)
    {
      # print "TTT $text\n";
      $one_tmp = 1;
    }
  }
  print "UUU $text\n" if ($one_tmp && $#parts > 0);
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
  my ($text, $result, $chain1, $chain2) = @_;

  return unless defined $text;

  # TODO Put this to clean_team, and don't remove it yet
  $text =~ s/\- npc//g;
  $text =~ s/\(npc\)//g;

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

  study_team($result->{TEAM1}, $chain1);
  study_team($result->{TEAM2}, $chain2);
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

1;
