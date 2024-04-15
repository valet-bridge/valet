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

# Only if it is a complete team entry.
my @TEAMS_SUGGESTORS = (
  'team 1', 'team 2',
  'team1', 'team2',
  'team a', 'team b',
  'home', 'away', 'visiting',
  'table 1', 'table 2',
  'table8hom', 'table8vis',
  'table9hom', 'table9vis',
  't11-home', 't11-visit', 't12-home', 't12-visit'
);

# Only if it is a complete team entry.
my @PAIRS_SUGGESTORS = (
  'pairs', 'pair 1', 'pair 2', 'pair1', 'pair2', 'pair event',
  'pair a', 'pair b', 'no teams', 'not teams',
  'pair ns', 'pair ew', 'pairs a', 'pairs b',
  'pairs 1', 'pairs 2', 'pair tournament', 'pairs tournament',
  'a_pair1', 'a_pair2', 'b_pair1', 'b_pair2',
  'c_pair1', 'c_pair2', 'd_pair1', 'd_pair2',
  'f_pair1', 'f_pair2', 'g_pair1', 'g_pair2',
  'h_pair1', 'h_pair2'
);

# Only if it is a complete team entry.
my @INDIVIDUAL_SUGGESTORS = (
  'individual'
);

# Only if it is a complete team entry.
my @NEUTRAL_SUGGESTORS = (
  'tournament', 'event',
  'a', 'b', 'x', 'y',
  'ns', 'ew', 'n-s', 'e-w', 'eo', 'north - south', 'east - west',
  1, 2
);



# Where the order is important.  These do not have to be whole words.
my %TYPOS_FIRST =
(
  'Chinese ' => ['ch.'],
  'Republic ' => ['rep.'],
  'Netherlands ' => ['neth.'],
);

# These have to be whole words.
my %TYPOS_SECOND =
(
  'Chinese ' => ['chi', 'chainese'],
  Czech => ['czec'],
  Ireland => ['irelnd', 'irelsnd', 'ire'],
  Netherlands => ['net'],
  Northern => ['northertn'],
  Republic => ['rep', 'reublic'],
  Taipei => ['taipae', 'tapei'],
  Zealand => ['zealans', 'zeland'],
);

# Whenever these match, they also yield a field of the
# corresponding singleton without further ado.
my %MULTI_WORD_ALIASES =
(
  COUNTRY =>
  {
    'Bosnia & Herzegovina' => ['bosnia-herzegovina',
      'bosnia&herzegovina', 'bosnia and herz.'],
    'Chinese Taipei' => ['chinese tai'],
    'Czech Republic' => ['czr'],
    'Faroe Islands' => ['faroe_islands', 'faroe island'],
    'French Polynesia' => [],
    'Great Britain' => ['g.britain'],
    Guyana => ['french guiana', 'french guyana'],
    'Hong Kong' => ['china hong kong', 'china hongkong', 
      'china honk kong'],
    Macau => ['china macau'],
    'Netherlands' => ['the netherlands', 'nl'],
    'Netherlands Antilles' => [],
    'New Zealand' => ['nwzealand'],
    'North Macedonia' => ['macedonia'],
    'Republic of Ireland' => [],
    'San Marino' => [],
    'Serbia and Montenegro' => ['serbia/mont', 'serbia&mon.'],
    'Trinidad and Tobago' => ['trinidad & tobago', 'trinidad&tobago'],
  },
);


# TODO 
# Eng Bridge Union -> EBU
# Split on \ *
# Add Guernsey, United Kingdom, Jersey, Isle of Man
# Mali
# Check
# DenmarS, Deutsch, Indýa, Sweeden, CBAI, Brasilia

my %COUNTRY_FIX_ALIASES =
(
  COUNTRY =>
  {
    Argentina => ['argenting', 'argentýna'],
    Australia => ['austrlia', 'australian', 'oz'],
    Austria => ['austra'],
    Brazil => ['brasil'],
    Canada => ['kanada'],
    Colombia => ['columbia'],
    Denmark => ['danmark', 'danemark', 'denmarrk'],
    Estonia => ['estonian', 'estonie'],
    Finland => ['finnland'],
    France => ['french'],
    Germany => ['deutschland', 'german'],
    Greece => ['greek'],
    Hungary => ['hungar', 'hungarian'],
    India => ['indian'],
    Indonesia => ['indonesian'],
    Italy => ['italia'],
    Israel => ['isreal', 'israeli', 'israil'],
    Latvia => ['lavtia', 'latvija'],
    Luxembourg => ['luxemburg'],
    Madagascar => ['madagaskar'],
    Netherlands => ['nederlands', 'netherland', 'nrtherlands', 
      'netherlans', 'netherlnd', 'neth', 'dutch'],
    Norway => ['norge', 'norges', 'norwegen', 'norwegian'],
    Palestine => ['palastine'],
    Philippines => ['philipppines'],
    Poland => ['polish', 'polen'],
    Sweden => ['swedish'],
    Switzerland => ['suitzerland', 'switserland'],
    Tunisia => ['tunisie', 'tunisian']
  }
);

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

my %COUNTRY_FIX_HASH;
for my $category (keys %COUNTRY_FIX_ALIASES)
{
  for my $value (keys %{$COUNTRY_FIX_ALIASES{$category}})
  {
    for my $fix (@{$COUNTRY_FIX_ALIASES{$category}{$value}})
    {
      $COUNTRY_FIX_HASH{$fix} = { CATEGORY => $category, VALUE => $value };
    }
  }
}

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

my $total = 0;
my $found = 0;



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


sub study_team
{
  my ($text, $chain) = @_;

  # Split on separators.
  my @parts = grep {$_ ne ''} split /([.\-\+_:;"\/\(\)]|\s+)/, $text;

  my $token = Token->new();

  for my $part (@parts)
  {
    $total++;
    if ($country->valid_lc($part))
    {
      $found++;
    }
    elsif (defined $COUNTRY_FIX_HASH{lc($part)})
    {
      $found++;
    }
    elsif (defined $CAPTAIN_FIX_HASH{lc($part)})
    {
      $found++;
    }
    elsif (set_token($part, $token))
    {
      $found++;
    }
    elsif ($part =~ /^19\d\d$/ || $part =~ /^20\d\d$/)
    {
      $found++;
    }
    elsif ($part =~ /^\d+$/ && $part >= 0 && $part < 100)
    {
      $found++;
    }
    elsif ($part =~ /^open$/i)
    {
      $found++;
    }
    elsif ($age->valid_lc($part))
    {
      $found++;
    }
    elsif ($gender->valid_lc($part))
    {
      $found++;
    }
    else
    {
      print $part, "\n";
    }
  }
}

sub print_team_stats
{
  printf("Total team words: %6d\n", $total);
  printf("Total team found: %6d\n", $found);
  printf("Total team open : %6d\n", $total -$found);
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
