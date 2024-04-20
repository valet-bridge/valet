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

my (%MULTI_WORDS, %MULTI_TYPOS, %MULTI_REGEX, 
  %SINGLE_WORDS, %SINGLE_TYPOS);

my $CITIES_NAME = "../../../../../../bboD/../../cities/cities.txt";
my (%CITIES, %CITIES_LC);


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
      'chinese taipe', 'ch.taipei', 'china taipei', 'chinese  taipei',
      'taipei'],
    'Czech~Republic' => ['czech republic'],
    'Faroe~Islands' => ['faroe islands', 'faroe_islands', 
      'faroe island'],
    'French~Polynesia' => ['french polynesia'],
    'Great~Britain' => ['great britain', 'g.britain'],
    Guyana => ['french guiana', 'french guyana'],
    'Hong~Kong' => ['china hong kong', 'china hongkong', 
      'china honk kong', 'hong kong'],
    'Isle~of~Man' => ['isle of man'],
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

  REGION =>
  {
    'Western~Australia' => ['wa']
  },

  SPONSOR =>
  {
    'Beijing~Hull~Technology' => ['beijing hull tech'],
    'Beijing~Liuhe'=> ['beijing liuhe'],
    'Beijing~Dazhong'=> ['beijing dazhong'],
    'Darles~Santerm' => ['darles santerm'],
    'Dongfeng' => ['dongfeng automobile'],
    'Grant~Thornton' => ['grant thornton', 'grant thonrton',
      'grantt thornton', 'bg thornton'],
    'J.~Pereira~de~Sousa' => ['j. pereira de sousa'],
    'Novi~Kod' => ['novi kod'],
    'Palma~Karya~Mandiri' => ['palma karya mandiri'],
    'Paulo~G.~Pereira' => ['paulo g. pereira', 'p g pereira',
      'p. g. pereira', 'pg pereira', 'p.g.pereira'],
    'Phoenix~TV' => ['phoenix tv'],
    'Unia~Leszno' => ['unia leszno'],
    'Unia~Winkhaus' => ['unia winkhaus', 'winkhaus unia',
      'winkhaus-unia'],
    'Zhongshan~Jiegao' => ['zhong shan jie gao']
  },

  ORGANIZATION =>
  {
    EBU => ['eng bridge union'],
  },

  CAPTAIN =>
  {
    'Bareket' => ['bareket ilan'],
    'David~Birman' => ['birman david', 'david birman', 'birman d.'],
    'Della~Monta' => ['della monta'],
    'Ginossar' => ['eldad ginossar'],
    'Jorge~Cruzeiro' => ['jorge cruzeiro'],
    'Palma~Carlos' => ['palma carlos'],
    'Paul~Van~Goor' => ['paul van goor'],
    'Pontiac~7' => ['pontiac7'],
    'Rui~Santos' => ['rui santos'],
    'Shashi~Gupta' => ['shashi gupta'],
    'Sinan~Abi' => ['sinan abi'],
    'Sinan~Göksu' => ['sinan goksu'],
    'van~Prooijen'=> ['van prooijen', 'van proojen'],
    'Van~Cleeff' => ['van cleeff'],
    'Van~de~Walle~' => ['van de walle'],
    'Van~den~Bos' => ['van den bos', 'van des bos'],
    'Van~den~Cleff' => ['van den cleff'],
    'Van~der~Vlugt' => ['van der vlugt'],
    'Van~Elsuwé' => ['van elsuwé'],
    'Van~Gestel' => ['van gestel'],
    'Van~Helsing' => ['van helsing'],
    'Van~Hoof' => ['van hoof'],
    'Vang~Larsen' => ['vang larsen', 'van larsen', 'vang-larsen'],
    'Van~Riel' => ['van riel'],
    'Van~Zwol' => ['van zwol'],
    'Yao~Ke' => ['yao ke'],
  },

  CLUB =>
  {
    'ABA~Mumbai' => ['aba - mumbai', 'aba-mumbai'],
    'Altay~GSKD' => ['altay gskd', 'altay gsk', 'altay sdgskd', 'altay sk'],
    'Altay~Genclik' => ['altay genclik'],
    'Bamberger~Reiter' => ['bamberger reiter'],
    'Diyarbakýr~Sur~BSK' => ['diyarbakýr sur bsk', 
      'diyarbakir bs', 'diyarbakir bsbs', 'dýyarbakir sur. b.b', 
      'diyarbakir sur sk', 'sur belediye sk',
      'sur belediye', 'd.bakýr sur', 'd.bakir sur'],
    'Drammen~Arbeiderparti' => ['drammen arbeiderparti', 'drammen arb'],
    'Kota~Club' => ['kota club'],
    'Mike~Lawrence~Club' => ['mike lawrence club'],
    'Nancy~Darville' => ['nancy jarville'],
    'Phoenix~Oltenita' => ['phoenix oltenita'],
    'Qingnian~Qiche' => ['qingnian qiche'],
    'Van~Bric~SK' => ['van bric sk']
  },

  UNIVERSITY =>
  {
    'Anadolu~University' => ['unit anadolu'],
    'Bilkent~University' => ['bilkent uni.'],
    'Gunadurma' => ['guna darma'],
    'ITS~IKOMA' => ['its ikoma'],
    'ITÜ~Vakfi' => ['itu vakfi'],
    'Koc~University' => ['koc university bk', 'koc university'],
    'KwaZulu~Natal' => ['kwazulu natal'],
    'University~of~California~at~Berkeley' => ['cal berkeley',
      'cal-berkeley', 'uc berkeley', 'berkeley'],
    'University~of~Chicago' => ['u chicago'],
    'University~of~Gdansk' => ['uni gdansk', 'gdank univ poland',
      'gdansk univ poland'],
    'University~of~Illonois' => ['u of illinois'],
    'University~of~North~Carolina' => ['u n. carolina'],
    'University~of~Warsaw' => ['uni warsaw'],
    'University~of~Wroclaw' => ['uni wroclaw'],
    'Universität~Potsdam' => ['uni potsdam']
  }
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

  REGION => 
  {
    Bali => [],
    Florida => [],
    Kedungwaru => [],
    Lumajang => [],
    Ratchaburi => [],
    Victoria => [],
    'Western Australia' => []
  },

  SPONSOR =>
  {
    COMAL => [],
    CONSUS => [],
    Dongfeng => [],
    Enterprise => [],
    Sagaplast => []
  },

  CAPTAIN =>
  {
    Gartaganis => ['gartaginas'],
    Markowicz => ['markovics', 'markowitz'],
    Milner => ['millner'],
    "O'Rourke" => ['o_rouke'],
    Teltscher => ['teltsher'],
    Wigoder => ['wigodor'],
    Zaleski => ['zalesky'],
    Zimmermann => ['zimmmermann', 'zimmerman', 'zimermann',
      'zimerman', 'zmmermann']
  },

  CLUB =>
  {
    'ABA Mumbai' => ['aba'],
    'Diyarbakýr Sur BSK' => [],
    Sakura => []
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
    $SINGLE_WORD_HASH{lc($key)} = { CATEGORY => $category, KEY => $key };
    for my $alias (@{$SINGLE_WORD_ALIASES{$category}{$key}})
    {
      $SINGLE_WORD_HASH{$alias} = { CATEGORY => $category, KEY => $key };
    }
  }
}

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
# Add Guernsey, United Kingdom, Jersey, Isle of Man, Mali
# DenmarS, Deutsch, Indýa, Sweeden, CBAI, Brasilia

my @VALID_CAPTAINS = qw(
  Altay Ames Anderson Appleton
  Baki Bello Bellosta Bertens Bessis Bo
  Carmichael Campos Charlotte Cole Compton Cope Courtney
  Deva Drijver Dyke
  Eggeling Elinescu
  Fantoni Ferrara Fleisher Fredin Freed
  Garvey Gartaganis Gary Gaviard Gawrys
  Gillis Ginossar Gitelman 
  Goldberg Goldman Goldstein Gordon Gosney Gotard
  Greenberg Gromov Gromova Grue
  Gumby Gupta
  Hauge
  Hackett Hamman Hampson Hampton Hans Hansen Harper Harris Harrison
  Helness
  Hillman Hinden Hirst
  Hoffman Horwitz
  Hughes Hung
  Irens Iversen
  Jacobs Jagniewski Jain Jansma Janssen Jassem
  Kamil Kamras Kaplan Kasle Katz
  Kent Klinger Koistinen Kosti
  Kranyak Kriegel
  Lall Lambardi Larsen
  Lee Levi Levin Levine Levy Lewis Lhuissier
  Liggins Lilley
  Lund Lynch
  Mahaffey Markey Markowicz Martin Marquardsen
  McIntoch McKellar McManus
  Meckstroth Mendoza Mesbur Meltzer
  Mills Milne Milner Mittelman Miura
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
  Rao Ravenna
  Richardson Rigal Rimstedt
  Robinson Robles Rogoff Rombaut Rosen Rosetta Rosenthal Rubin Rubio
  Sadek Saelensminde Sandqvist Santos
  Schaltz Schermer Schneider Schwartz
  Shugart Sime Simson Sinclair Smith Sorkin Soulet
  Spangenberg Spector
  Stamatov Stansby Stephenson Stern Sternberg Stevens 
  Stoichkov Street Strul Sundelin
  Sylvan
  Tamburrini Tarsus Taylor Teixeira Teltscher
  Thomsen Thomson
  Una Upmark
  Venkatesh Ventin
  Viana Vinciguerra Vitas Volcker
  Weingold Weinstein
  Welland Werdelin Westheimer Westra
  Whibley
  Wigoder Wildavsky Wilkinson Willenken Williams Witte
  Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey
  Wrang
  Zagorin Zaleski Zia Zimmermann
);

my %CAPTAIN_FIX_HASH;
for my $captain (@VALID_CAPTAINS)
{
  $CAPTAIN_FIX_HASH{lc($captain)} = $captain;
}


my $country = Country->new();
my $gender = Gender->new();
my $age = Age->new();

my %HIT_STATS;
my %FORM_SCORES;


sub init_hashes
{
  set_hashes_team_fun('TEAM_FUN');
  set_hashes_team_city('TEAM_CITY');
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
  for my $tag (qw(TEAM_FUN TEAM_CITY))
  {
    my $fix = $SINGLE_WORDS{$tag}{lc($part)};
    if (defined $fix->{CATEGORY})
    {
      $token->set_singleton($fix->{CATEGORY}, $fix->{VALUE});
      $HIT_STATS{$fix->{CATEGORY}}++;
      return;
    }
  }


  my $fix = $SINGLE_WORD_HASH{lc($part)};

  if (defined $fix->{CATEGORY})
  {
    $token->set_singleton($fix->{CATEGORY}, $fix->{VALUE});
    $HIT_STATS{$fix->{CATEGORY}}++;
    return;
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
      $token->set_singleton($category, $fix->{VALUE});
      $HIT_STATS{$category}++;
      return;
    }

    # TODO Can print "ZZZ UNKNOWN $part\n";
  }

  if (set_token($part, $token))
  {
    $token->set_singleton('SEPARATOR', $fix->{VALUE});
    $HIT_STATS{SEPARATOR}++;
  }
  elsif ($country->valid_lc(lc($part)))
  {
    $token->set_singleton('COUNTRY', $fix->{VALUE});
    $HIT_STATS{COUNTRY}++;
  }
  elsif (defined $CAPTAIN_FIX_HASH{lc($part)})
  {
    $token->set_singleton('CAPTAIN', $fix->{VALUE});
    $HIT_STATS{CAPTAIN}++;
  }
  # elsif (exists $CITIES_LC{lc($part)})
  # {
    # print "ZZZ $part\n";
    # $tmp_global = 1;
  # }
  elsif ($part =~ /^19\d\d$/ || $part =~ /^20\d\d$/)
  {
    $token->set_singleton('YEAR', $fix->{VALUE});
    $HIT_STATS{YEAR}++;
  }
  elsif ($part =~ /^\d+$/ && $part >= 0 && $part < 100)
  {
    $token->set_numeral_counter($fix->{VALUE});
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

  # Ignore word boundaries.
  $text =~ s/$TYPOS_FIRST_REGEX/$TYPOS_FIRST_HASH{lc($1)}/ge;

  # Consider word boundaries.
  $text =~ s/$TYPOS_SECOND_REGEX/$TYPOS_SECOND_HASH{lc($1)}/ge;

  # Match multi-word patterns, using ~ as an artificial separator.
  # $text =~ s/$MULTI_WORD_REGEX/$MULTI_WORD_HASH{lc($1)}/ge;

  for my $tag (qw(TEAM_FUN TEAM_CITY))
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
