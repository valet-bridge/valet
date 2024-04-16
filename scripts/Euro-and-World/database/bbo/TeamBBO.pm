#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamBBO;

our @ISA = qw(Exporter);
our @EXPORT = qw(study_teams unteam print_team_stats);

use lib '.';

use Country;
use Cookbook;
use Token;

use Separators;
use Age;
use Gender;
use Suggestors;


# Where the order is important.  These do not have to be whole words,
# so we can't do a hash lookup.
my %TYPOS_FIRST =
(
  'Chinese ' => ['ch.'],
  'Republic ' => ['rep.'],
  'Netherlands ' => ['neth.'],
  'Serbia~and~Montenegro' => ['serbia&mon.']
);

my %TYPOS_FIRST_HASH;
for my $key (keys %TYPOS_FIRST)
{
  for my $alias (@{$TYPOS_FIRST{$key}})
  {
    $TYPOS_FIRST_HASH{lc($alias)} = $key;
  }
}

my $TYPOS_FIRST_PATTERN = 
  join('|', map { quotemeta } keys %TYPOS_FIRST_HASH);

my $TYPOS_FIRST_REGEX = qr/($TYPOS_FIRST_PATTERN)/i;


# These have to be whole words.
my %TYPOS_SECOND =
(
  'Chinese ' => ['chi', 'chainese'],
  Czech => ['czec'],
  Ireland => ['irelnd', 'irelsnd', 'irlande', 'irelend', 
    'irelena', 'ire'],
  Netherlands => ['net'],
  Northern => ['northertn'],
  Republic => ['rep', 'reublic'],
  Taipei => ['taipae', 'tapei'],
  Zealand => ['zealans', 'zeland'],
);

my %TYPOS_SECOND_HASH;
for my $key (keys %TYPOS_SECOND)
{
  for my $alias (@{$TYPOS_SECOND{$key}})
  {
    $TYPOS_SECOND_HASH{lc($alias)} = $key;
  }
}

my $TYPOS_SECOND_PATTERN = 
  join('|', map { quotemeta } keys %TYPOS_SECOND_HASH);

my $TYPOS_SECOND_REGEX = qr/\b($TYPOS_SECOND_PATTERN)\b/i;


# Whenever these match, they also yield a field of the
# corresponding singleton without further ado.  Only multi-word
# entries in the lists are included, as the single-word ones
# are done later by hash.
my %MULTI_WORD_ALIASES =
(
  COUNTRY =>
  {
    'Bosnia~&~Herzegovina' => ['bosnia & herzegovina',
      'bosnia-herzegovina', 'bosnia&herzegovina', 'bosnia and herz.'],
    'Chinese~Taipei' => ['chinese taipei', 'chinese tai',
      'chinese taipe'],
    'Czech~Republic' => ['czech republic'],
    'Faroe~Islands' => ['faroe islands', 'faroe_islands', 
      'faroe island'],
    'French~Polynesia' => ['french polynesia'],
    'Great~Britain' => ['great britain', 'g.britain'],
    Guyana => ['french guiana', 'french guyana'],
    'Hong~Kong' => ['china hong kong', 'china hongkong', 
      'china honk kong', 'hong kong'],
    Macau => ['china macau'],
    'Netherlands' => ['the netherlands'],
    'Netherlands~Antilles' => ['netherlands antilles'],
    'New~Zealand' => ['new zealand', 'new zeland'],
    'North~Macedonia' => ['north macedonia', 'macedonia'],
    'Republic~of~Ireland' => ['republic of ireland'],
    'San~Marino' => ['san marino'],
    'Serbia~and~Montenegro' => ['serbia and montenegro', 'serbia/mont', 
      'serbia&mon'],
    'Trinidad~and~Tobago' => ['trinidad and tobago', 'trinidad & tobago', 
      'trinidad&tobago'],
  },
);

my %MULTI_WORD_HASH;
for my $category (keys %MULTI_WORD_ALIASES)
{
  for my $key (keys %{$MULTI_WORD_ALIASES{$category}})
  {
    for my $alias (@{$MULTI_WORD_ALIASES{$category}{$key}})
    {
      $MULTI_WORD_HASH{lc($alias)} = $key;
    }
  }
}

my $MULTI_WORD_PATTERN = 
  join('|', map { quotemeta } keys %MULTI_WORD_HASH);

my $MULTI_WORD_REGEX = qr/\b($MULTI_WORD_PATTERN)\b/i;


my %SINGLE_WORD_ALIASES =
(
  COUNTRY =>
  {
    Argentina => ['argenting', 'argentýna'],
    Australia => ['austrlia', 'oz'],
    Austria => ['austra'],
    Brazil => ['brasil'],
    Canada => ['kanada'],
    'Czech Republic' => ['czr'],
    Colombia => ['columbia'],
    Croatia => ['croatie'],
    Denmark => ['danmark', 'danemark', 'denmarrk'],
    Estonia => ['estonie'],
    Finland => ['finnland'],
    Germany => ['deutschland'],
    Hungary => ['hungar'],
    Ireland => ['roireland'],
    Italy => ['italia'],
    Israel => ['isreal', 'israil', 'isarel', 'israël'],
    Latvia => ['lavtia', 'latvija'],
    Luxembourg => ['luxemburg'],
    Madagascar => ['madagaskar'],
    Monaco => ['nonaco'],
    Netherlands => ['nederlands', 'netherland', 'nrtherlands', 
      'netherlans', 'netherlnd', 'neth', 'nl'],
    'New Zealand' => ['nwzealand'],
    'North Macedonia' => ['macedonia'],
    'Northern Ireland' => ['nireland'],
    Norway => ['norge', 'norges', 'norwegen'],
    Palestine => ['palastine'],
    Philippines => ['philipppines'],
    Poland => ['polen'],
    Reunion => ['réunion'],
    'Sri Lanka' => ['srilanka'],
    Switzerland => ['suitzerland', 'switserland'],
    Tunisia => ['tunisie']
  },

  NATIONALITY =>
  {
    Australia => ['australian'],
    Bulgaria => ['bulgarian', 'blugarian'],
    Croatia => ['croatian'],
    'Czech Republic' => ['czech'],
    Estonia => ['estonian'],
    France => ['french'],
    Germany => ['german'],
    Greece => ['greek'],
    Hungary => ['hungar'],
    India => ['indian'],
    Indonesia => ['indonesian'],
    Israel => ['israeli'],
    Netherlands => ['dutch'],
    Norway => ['norwegian'],
    Poland => ['polish'],
    Sweden => ['swedish'],
    Tunisia => ['tunisie']
  }
);

my %SINGLE_WORD_HASH;
for my $category (keys %SINGLE_WORD_ALIASES)
{
  for my $key (keys %{$SINGLE_WORD_ALIASES{$category}})
  {
    for my $alias (@{$SINGLE_WORD_ALIASES{$category}{$key}})
    {
      $SINGLE_WORD_HASH{$alias} = { CATEGORY => $category, KEY => $key };
    }
  }
}


# TODO 
# Eng Bridge Union -> EBU
# Add Guernsey, United Kingdom, Jersey, Isle of Man
# Mali
# Check
# DenmarS, Deutsch, Indýa, Sweeden, CBAI, Brasilia

my @VALID_CAPTAINS = qw(
  Bertens Bessis
  Cole Compton Cope Courtney
  Drijver Dyke
  Eggeling Elinescu
  Fantoni Fleisher Fredin Freed
  Garvey Gartaganis Gaviard Gawrys
  Gillis Ginossar Gitelman 
  Goldberg Goldman Goldstein Gordon Gosney Gotard
  Greenberg Gromov Gromova Grue
  Gumby Gupta
  Hauge
  Hackett Hamman Hampson Hans Hansen Harper Harris Harrison
  Helness
  Hillman Hinden Hirst
  Hoffman Horwitz
  Hughes Hung
  Irens Iversen
  Jacobs Jagniewski Jain Jansma Janssen Jassem
  Kamil Kamras Kaplan Kasle Katz
  Klinger Koistinen
  Kranyak Kriegel
  Lall Lambardi Larsen
  Lee Levi Levin Levine Levy Lewis Lhuissier
  Liggins Lilley
  Lynch
  Mahaffey Markey Markowicz Marquardsen
  McIntoch McKellar McManus
  Meckstroth Mesbur Meltzer
  Mills Milne Milner Mittelman
  Mooney Moran Morath
  Morbey Morgan Morris Morrison Morse Moss Mossop Mott Mouiel
  Nader Nagy
  Neill Newell Nickell Nielsen Nilsland Nilsson
  Nunes Nunn Nystrom
  Oliveira
  O'Rourke
  Onstein Onstott
  Palmer Passell
  Penfold Pereira
  Piekarek
  Platt
  Pollack
  Quantin
  Rao
  Rigal Rimstedt
  Robinson Rogoff Rombaut Rosen Rosenthal Rubin
  Saelensminde Sandqvist
  Schaltz Schermer Schneider Schwartz
  Shugart Sime Simson Sinclair Smith Sorkin Soulet
  Spangenberg Spector
  Stamatov Stansby Stephenson Stern Sternberg Stevens 
  Stoichkov Street Strul Sundelin
  Sylvan
  Teixeira Teltscher
  Thomsen Thomson
  Upmark
  Venkatesh Ventin
  Vinciguerra Vitas Volcker
  Weingold Weinstein
  Welland Werdelin Westheimer Westra
  Whibley
  Wigoder Wildavsky Wilkinson Willenken Williams Witte
  Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey
  Wrang
  Zagorin Zaleski Zia Zimmermann
);

my %CAPTAIN_FIX_ALIASES =
(
  Gartaganis => ['gartaginas'],
  Markowicz => ['markovics', 'markowitz'],
  Milner => ['millner'],
  "O'Rourke" => ['o_rouke'],
  Teltscher => ['teltsher'],
  Wigoder => ['wigodor'],
  Zaleski => ['zalesky'],
  Zimmermann => ['zimmmermann', 'zimmerman', 'zimermann',
    'zimerman', 'zmmermann']
);


my %CAPTAIN_FIX_HASH;
for my $key (keys %CAPTAIN_FIX_ALIASES)
{
  for my $fix (@{$CAPTAIN_FIX_ALIASES{$key}})
  {
    $CAPTAIN_FIX_HASH{$fix} = $key;
  }
}

for my $captain (@VALID_CAPTAINS)
{
  $CAPTAIN_FIX_HASH{lc($captain)} = $captain;
}


my $country = Country->new();
my $gender = Gender->new();
my $age = Age->new();

my %HIT_STATS;
my %FORM_SCORES;



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


sub study_part
{
  my ($part, $i, $chain) = @_;

  my $token = Token->new();
  $token->set_origin($i, $part);
  $chain->append($token);

  $HIT_STATS{TOTAL}++;

  # Turn the artificial separator back into a space.
  $part =~ s/~/ /g;

  my $fix = $SINGLE_WORD_HASH{lc($part)};

  if (defined $fix->{CATEGORY})
  {
    $token->set_singleton($fix->{CATEGORY}, $fix->{VALUE});
    $HIT_STATS{SINGLE_WORD}++;
  }
  elsif ($country->valid_lc(lc($part)))
  {
    $HIT_STATS{COUNTRY_CLASS}++;
  }
  elsif (defined $CAPTAIN_FIX_HASH{lc($part)})
  {
    $HIT_STATS{CAPTAIN}++;
  }
  elsif (set_token($part, $token))
  {
    $HIT_STATS{SEPARATOR}++;
  }
  elsif ($part =~ /^19\d\d$/ || $part =~ /^20\d\d$/)
  {
    $HIT_STATS{YEAR}++;
  }
  elsif ($part =~ /^\d+$/ && $part >= 0 && $part < 100)
  {
    $HIT_STATS{INTEGER}++;
  }
  elsif ($part =~ /^open$/i)
  {
    $HIT_STATS{OPEN}++;
  }
  elsif ($age->valid_lc($part))
  {
    $HIT_STATS{AGE}++;
  }
  elsif ($gender->valid_lc($part))
  {
    $HIT_STATS{GENDER}++;
  }
  else
  {
    $HIT_STATS{UNMATCHED}++;
    print $part, "\n";
  }
}


sub study_team
{
  my ($text, $chain) = @_;

  if (suggest_form($text, \%FORM_SCORES))
  {
    return;
  }

  # Ignore word boundaries.
  $text =~ s/$TYPOS_FIRST_REGEX/$TYPOS_FIRST_HASH{lc($1)}/ge;

  # Consider word boundaries.
  $text =~ s/$TYPOS_SECOND_REGEX/$TYPOS_SECOND_HASH{lc($1)}/ge;

  # Match multi-word patterns, using ~ as an artificial separator.
  $text =~ s/$MULTI_WORD_REGEX/$MULTI_WORD_HASH{lc($1)}/ge;

  # Split on separators.
  my @parts = grep {$_ ne ''} split /([.\-\+_:;"\/\(\)]|\s+)/, $text;

  split_on_trailing_digits(\@parts);

  for my $i (0 .. $#parts)
  {
    study_part($parts[$i], $i, $chain);
  }
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
