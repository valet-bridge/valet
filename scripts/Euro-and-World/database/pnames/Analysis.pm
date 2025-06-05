#!perl

package Analysis;

use strict;
use warnings;
use v5.10;

use utf8;
use Encode qw(decode encode);

use lib '.';

use FirstMid;
use LastMid;
use Manip;

use constant
{
  INITIAL => 0,
  ALLCAPS => 1,
  CAPITALIZED => 2,
  PARTICLE => 3,
  GENERAL => 4
};

my %EXCEPTIONS =
(
  'Chien-I' => CAPITALIZED,
  "DALL'AGLIO" => ALLCAPS,
  "DELL'ARMI" => ALLCAPS,
  'El-Salam' => CAPITALIZED,
  "GUINVARC'H" => ALLCAPS,
  'Jérôme' => CAPITALIZED,
  'Jan-e-Alam' => CAPITALIZED,
  JoAnna => CAPITALIZED,
  'I-Hung' => CAPITALIZED,
  'I-Ming' => CAPITALIZED,
  LaLa => CAPITALIZED,
  "LA'O" => ALLCAPS,
  'María' => CAPITALIZED,
  'Mai-Brit' => CAPITALIZED,
  "O'KEEFFE-BROWN" => ALLCAPS,
  "O'REILLY-POL" => ALLCAPS,
  'Pei-En' => CAPITALIZED,
  'Pik-Kin' => CAPITALIZED,
  "Ra'ad" => CAPITALIZED,
  'Sze-Ching' => CAPITALIZED,
  'Sze-Wing' => CAPITALIZED,
  'TJON-A-TSOI' => ALLCAPS,
  'Ul-Ain' => CAPITALIZED,
  'Zia-Ul' => CAPITALIZED,
  'ZUR-CAMPANILE' => ALLCAPS
);

# Ugh
my $JEROME = decode('iso-8859-1', 'Jérôme');

my %SPECIALS =
(
  # The first part is the short/nickname/rename/variant.
  SHORT =>
  {
    Alya => {Alevtina => 1},
    Andy => {Andrew => 1, 'Andrew C.' => 1},
    Becky => {Rebecca => 1},
    Bobby => {Robert => 1},
    Chander => {Chandkaran => 1},
    Chris => {Krzysztof => 1},
    Conny => {Catharine => 1},
    Dave => {David => 1},
    Denny => {'Deny Jacob' => 1},
    Desi => {'Desislava Borissova' => 1},
    Det => {Bernadette => 1},
    Dick => {Richard => 1, 'Richard J.' => 1},
    Giampao => {Giampaolo => 1},
    Giancarlo => {'Giovanni Carlo' => 1},
    Hein => {Henricus => 1},
    Henk => {Hendrik => 1},
    Hovik => {Hovhannes => 1},
    'Jean-Jacque' => {'Jean-Jacques' => 1},
    Jenny => {'Jennifer Christina' => 1},
    Jerem => {Jeremi => 1},
    Jim => {James => 1, 'James E.' => 1},
    Katie => {Catherine => 1},
    Kit => {Christopher => 1},
    Lina => {Eleni => 1},
    Liz => {Elizabeth => 1},
    Loes => {'Marie Louise' => 1},
    Maggie => {Margaret => 1},
    Mandy => {Adamantia => 1},
    Manos => {Emmanuel => 1},
    Mansur => {'Mansoor Ghulam' => 1},
    Matt => {Matthew => 1},
    Mauri => {Maurizio => 1},
    Natasha => {Nataliya => 1},
    Nick => {Nicklas => 1, Niklas => 1},
    Pero => {Petar => 1},
    Phil => {Philip => 1},
    Sandro => {Alexandre => 1},
    Sascha => {Alexander => 1},
    Sasha => {Alexander => 1},
    Teddy => {Theodor => 1},
    Tony => {Anthony => 1, Anton => 1},
    Wil => {Willem => 1},
    Wim => {Willem => 1},
    Yossi => {Josef => 1, Yosef => 1},
    Zandy => {Alexander => 1}
  },

  NICKNAME =>
  {
    Ans => {'Anna Maria Wilhelmina' => 1},
    Akis => {Zafiris => 1},
    Charles => {'Ka Ning' => 1},
    Denis => {Darko => 1},
    Dimmie => {Irene => 1},
    Gautam => {'Subhash Chander' => 1},
    Himmy => {'Pak Him' => 1},
    Joice => {'Julita Grace' => 1},
    Kojak => {'William J.' => 1},
    Mavi => {'Maria Vittoria' => 1},
    Memo => {Giampietro => 1},
    Mino => {Jacomo => 1},
    Moti => {Mordechay => 1},
    Nina => {Planinka => 1},
    Nitsa => {Antonia => 1},
    Pinuccia => {Giuseppina => 1},
    Sheelu => {Saela => 1},
    Titta => {'Giovanni Battista' => 1}
  },

  RENAME =>
  {
    Aaron => {'Shiu Cheong' => 1},
    Adam => {'Tsz Nam' => 1},
    Andy => {'Pei-En' => 1},
    Abby => {'Wai-Lap' => 1},
    Ben => {'Chun Pong' => 1},
    Bob => {Xinyu => 1},
    Brian => {'Ho Yin' => 1},
    Calvin => {'Ching Fung' => 1},
    Catherine => {Runmei => 1},
    Charmain => {'Hor Yung' => 1},
    Chris => {'Tze Him' => 1},
    Christopher => {'Hong Sing' => 1},
    Clair => {Shiuan => 1},
    'Costa-Foru' => {Constantin => 1},
    Cynthia => {'Hung Ching' => 1},
    Davied => {'Xiao' => 1},
    Dennis => {'Yu Kwong' => 1},
    Derek => {'Wei Peu' => 1},
    Desmond => {'Feng Gui' => 1},
    Dora => {'Lo Lai Yee' => 1},
    Gary => {'Po Tang' => 1},
    Gloria => {'Ching-Shan' => 1},
    Harry => {'Tsz Fung' => 1},
    Henry => {'Hon Shing' => 1, 'Wai-Kit' => 1},
    Jack => {Jie => 1},
    Jerry => {'Li Min' => 1},
    Jimmy => {'Saleem Ud' => 1, Zhuo => 1},
    John => {'Hao Zhen' => 1},
    Joyce => {'Sau Yin' => 1},
    Kelvin => {Yisheng => 1},
    Kevin => {Yuxiang => 1},
    Marvin => {'Yong Chieng' => 1},
    Max => {Ziyu => 1},
    Nancy => {'Wai Fong' => 1},
    'Nancy Marie' => {'Pek See' => 1},
    Nicky => {Kulbir => 1},
    Oak => {Wattanai => 1},
    Pearlie => {'Pui Yi' => 1},
    'Pedro Leonel' => {Ioklon => 1},
    Romulus => {'Yuan Xing' => 1},
    Ronald => {'Cheuk Him' => 1},
    Ruby => {'Ka Yee' => 1},
    Simon => {'Chi Kwong' => 1},
    Timothy => {'Jian Zhong' => 1, Kaiti => 1},
    Tony => {'Pik-Kin' => 1},
    Vincent => {'Hoi Yuen' => 1},
    Vonny => {'Siti Chaerani' => 1},
    Wendy => {Guangli => 1},
    William => {'Shiu-Kwong' => 1},
  },
  
  VARIANT =>
  {
    Alexandre => {Alexandru => 1},
    Chengyi => {'Cheng Yi' => 1},
    Danielle => {Daniele => 1},
    Isabella => {Isabelle => 1},
    Jacob => {Yaacov => 1},
    Jeniffer => {Jennifer => 1},
    Jerome => {$JEROME => 1},
    Jiaxiang => {'Jia Xiang' => 1},
    Jingsheng => {Jinsheng => 1},
    Kamales => {Kamles => 1},
    Marco => {Marcos => 1},
    Michael => {Mikhail => 1},
    Michele => {Michelle => 1},
    Monya => {Monia => 1},
    Myriam => {Miryam => 1},
    Nabeel => {Nabil => 1},
    Norman => {Normann => 1},
    Paolo => {Paulo => 1},
    Rigmore => {Rigmor => 1},
    Simin => {Simun => 1},
    Sophie => {Safeya => 1},
    Stephan => {Stefan => 1},
    Teodoras => {Teodoros => 1},
    Zbyszek => {Zbigniew => 1},
    Zdenek => {Zdenko => 1},
    Zijian => {'Zi Jian' => 1},
    Wojciech => {Wojtek => 1},
    Woyciech => {Wojtek => 1},
  },

  LAST_VARIANT =>
  {
    AGRAWAL => {AGARWAL => 1},
    JAERUP => {JARUP => 1},
    KHIUPPUNEN => {KHYUPPENEN => 1},
    ROSENBLUM => {ROZENBLYUM => 1},
    THOMA => {TOMA => 1},
  }
);

my %TITLES =
(
  TITLE_GENERAL =>
  {
    Baron => {Baron => 1},
    'Brigadier General' => {'Brig-Gen.' => 1},
    'Captain' => {Capt => 1, 'Capt.' => 1},
    Count => {Count => 1},
    'Dr.' => {Dr => 1, 'Dr.' => 1},
    Lady => {Lady => 1, LADY => 1},
    Major => {'Maj.' => 1},
    Marquess => {Marquess => 1},
    Princess => {Prinzessin => 1},

  },

  TITLE_SPECIFIC =>
  {
    Baron => 1,
    Count => 1
  }
);

my %TITLES_HASH;
for my $k1 (keys %{$TITLES{TITLE_GENERAL}})
{
  $TITLES_HASH{$_} = $k1 for keys %{$TITLES{TITLE_GENERAL}{$k1}};
}

# The first one is used to verify that middle names are like first names.
# This last one used to verify that middle names are like last names.

my %FIRST_NAMES_HASH;
$FIRST_NAMES_HASH{$_} = 1 for @FIRST_MID_NAMES;

my %LAST_NAMES_HASH;
$LAST_NAMES_HASH{$_} = 1 for @LAST_MID_NAMES;


my %PARTICLES =
(
  ABD => 1,
  ABU => 1,
  AL => 1,
  BEN => 1,
  DA => 1,
  DALLA => 1,
  DALLE => 1,
  DEGLI => 1,
  DELLA => 1,
  DELLE => 1,
  DE => 1,
  DEL => 1,
  DEN => 1,
  DER => 1,
  DI => 1,
  DO => 1,
  DOS => 1,
  DU => 1,
  E => 1,
  ECH => 1,
  EL => 1,
  IBN => 1,
  LA => 1,
  LAS => 1,
  LE => 1,
  LO => 1,
  LOS => 1,
  MAC => 1,
  SAINT => 1,
  SANTA => 1,
  ST => 1,
  TEN => 1,
  TER => 1,
  VAN => 1,
  "'T" => 1,
  VON => 1,
  Y => 1,
  ZU => 1,
  ZUR => 1
);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub remove_various
{
  my ($self, $words) = @_;

  my $i = 0;
  while ($i < @$words)
  {
    my $w = $words->[$i];
    if ($w =~ /^Jr\.*$/)
    {
      $self->{JUNIOR} = 1;
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^Sr\.*$/)
    {
      $self->{SENIOR} = 1;
      splice @$words, $i, 1;
      next;
    }

    if (exists $TITLES_HASH{$w})
    {
      my $title = $TITLES_HASH{$w};
      if (! exists $TITLES{TITLE_SPECIFIC}{$title} || $i == 0)
      {
        $self->{TITLE} = $title;
        splice @$words, $i, 1;
        next;
      }
    }

    if ($w eq 'II' || $w eq 'III')
    {
      if ($i != 1 || $words->[0] ne 'Yasuaki')
      {
        # Kludge.
        $self->{DYNAST} = $w;
        splice @$words, $i, 1;
        next;
      }
    }
    if ($w =~ /^\((\d)\)$/)
    {
      $self->{COUNTER} = $1;
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^[A-Z]\.$/)
    {
      $i++;
      next;
    }
    if ($w =~ /^[A-Z]$/)
    {
      # Add point to a single letter.
      if ($w ne 'E' && $w ne 'Y')
      {
        # Manually edited so these initials always have dots.
        $words->[$i] .= '.';
        $i++;
        next;
      }
    }

    # First name(s) in brackets.
    if ($w =~ /^\(([A-Z].+[a-z])\)$/)
    {
      my $inner = $1;
      for my $key (qw(SHORT NICKNAME RENAME VARIANT))
      {
        # Check that the first names are what they should be.
        if (exists $SPECIALS{$key}{$inner})
        {
          my $firsts = join(' ', @{$words}[0 .. $i-1]);
          if (exists $SPECIALS{$key}{$inner}{$firsts})
          {
            $self->{$key} = $inner;
            splice @$words, $i, 1;
            next;
          }
        }
      }
    }

    if ($w =~ /\./ && $w !~ / / && $w !~ /[a-z]/)
    {
      # Probably a list of initials.  Space them out properly and
      # include consistent dots.
      my @e = split /\./, $w;
      my $elen = $#e;
      die "Empty list: $w" unless $elen > 0;

      for my $j (0 .. $elen)
      {
        my $ee = $e[$j];
        die "Expected initial: $ee" unless length($ee) == 1;
        $e[$j] .= '.';
      }

      splice @$words, $i, 1, @e;
      $i += $elen + 1;
      next;
    }


    $i++;
  }
}


sub get_capitalization
{
  # Not a class method
  my ($text) = @_;

  return INITIAL if $text =~ /^[A-Z]\.{0,1}$/;
  return ALLCAPS if $text =~ /^[\p{Lu}']+$/;
  return CAPITALIZED if $text =~ /^[A-Z][\p{Ll}]+$/;
  return ALLCAPS if $text =~ /^[DOL]'[A-Z]+$/; # D'ANIELLO
  return ALLCAPS if $text =~ /^Ma{0,1}c[A-Z]+$/; # MacMAHON, McDONALD

  if (exists $EXCEPTIONS{$text})
  {
    return $EXCEPTIONS{$text};
  }

  if ($text =~ /^([A-Za-z]{2,})-([A-Za-z]{2,})$/)
  {
    # Something like Marie-Claire or ABU-GHAZALEH
    my ($a, $b) = ($1, $2);
    my $c1 = get_capitalization($a);
    my $c2 = get_capitalization($b);
    return $c1 if $c1 == $c2;
  }

  return GENERAL;
}


sub get_particle
{
  # Not a class method
  my ($text) = @_;

  return PARTICLE if exists $PARTICLES{$text};

  return GENERAL;
}


sub add
{
  my ($self, $key, $text, $country) = @_;

  # reprint(\@FIRST_MID_NAMES, 'FIRST_NAMES');
  # reprint(\@LAST_MID_NAMES, 'LAST_NAMES');
  # die;

  if ($text =~ /TSOI$/)
  {
    # print "HERE\n";
  }

  my @words = $text =~ /\([^)]+\)|\S+/g;

  $self->remove_various(\@words);

  my @caps;
  for my $v (@words)
  {
    push @caps, get_capitalization($v);
  }

  if ($#caps == 0 && $caps[0] == ALLCAPS)
  {
    $self->{FIRST_MISSING} = 1;
    $self->add_last($key, $words[0]);
    return;
  }

  if ($#caps == 1)
  {
    if ($caps[0] == CAPITALIZED && $caps[1] == ALLCAPS)
    {
      $self->add_first($key, $words[0]);
      $self->add_last($key, $words[1]);
      return;
    }
    elsif ($caps[0] == ALLCAPS && $caps[1] == CAPITALIZED)
    {
      $self->add_first($key, $words[1]);
      $self->add_last($key, $words[0]);
      return;
    }
    elsif ($caps[0] == INITIAL && $caps[1] == ALLCAPS)
    {
      $self->add_first_initial($key, $words[0]);
      $self->add_last($key, $words[1]);
      return;
    }
    elsif ($caps[0] == ALLCAPS && $caps[1] == INITIAL)
    {
      $self->add_first_initial($key, $words[1]);
      $self->add_last($key, $words[0]);
      return;
    }
    elsif ($words[0] eq '-')
    {
      $self->{FIRST_MISSING} = 1;
      $self->add_last($key, $words[1]);
      return;
    }
    elsif ($words[1] eq '-')
    {
      $self->{FIRST_MISSING} = 1;
      $self->add_last($key, $words[0]);
      return;
    }
  }

  if ($#caps > 1)
  {
    # Look for last names containing particles.
    my @particles;
    for my $v (@words)
    {
      push @particles, get_particle($v);
    }

    return if $self->add_with_first_initials(
      $key, \@words, \@caps, \@particles);
    return if $self->add_with_middle_initials(
      $key, \@words, \@caps, \@particles);
    return if $self->add_with_split($key, \@words, \@caps, \@particles);
  }

  print "$text XXX\n";
}


sub add_first
{
  my ($self, $key, $text) = @_;

  if (! exists $self->{FIRST_FULL})
  {
    # Assume it's a full-form name, even if we know that it could
    # be a variant.
    $self->{FIRST_FULL} = $text;
    return;
  }

  for my $key (qw(FIRST_FULL VARIANT NICKNAME RENAME SHORT))
  {
    return if exists $self->{$key} && $self->{$key} eq $text;
  }

  for my $tag (qw(VARIANT NICKNAME RENAME SHORT))
  {
    if (exists $SPECIALS{$tag}{$text})
    {
      if (exists $self->{FIRST_FULL})
      {
        if (exists $SPECIALS{$tag}{$text}{$self->{FIRST_FULL}})
        {
          die "$tag: $self->{$tag} vs $text" if exists $self->{$tag};

          # It's a special form of FIRST_FULL.
          $self->{$tag} = $text;
          return;
        }
      }
      elsif (exists $self->{$tag})
      {
        die "$tag $self->{$tag} vs $text" if ($self->{$tag} ne $text);
      
        # We already have the special form.
        return;
      }
      else
      {
        # It's a new special form.
        # $self->{$tag} = $text;
        # return;
      }
    }
    elsif (exists $self->{FIRST_FULL} &&
      exists $SPECIALS{$tag}{$self->{FIRST_FULL}} &&
      exists $SPECIALS{$tag}{$self->{FIRST_FULL}}{$text})
    {
      # We got the special form first, but we stored it in FIRST__FULL,
      # and now we got the full first name.
      $self->{$tag} = $self->{FIRST_FULL};
      $self->{FIRST_FULL} = $text;
      return;
    }
    elsif (exists $self->{$tag} &&
      exists $SPECIALS{$tag}{$self->{$tag}}{$text})
    {
      # We got the special form directly into the right place.
      $self->{FIRST_FULL} = $text;
      return;
    }
  }

  # Can use $key
  print "$text: Haven't learned multiple first names yet.\n";
}


sub add_first_initial
{
  my ($self, $key, $text) = @_;

  # This is a stand-alone initial (or initials).
  if (exists $self->{FIRST_INITIAL})
  {
    die "Already have an initial when adding $text";
  }

  if (exists $self->{FIRST_FULL} &&
      exists $self->{VARIANT} &&
      exists $self->{NICKNAME} &&
      exists $self->{RENAME} &&
      exists $self->{SHORT})
  {
    die "Already have a first name when adding initial $text";
  }

  $self->{FIRST_INITIAL} = $text;
}


sub add_middle_initial
{
  my ($self, $key, $text) = @_;

  # This is a middle initial (or initials).
  if (exists $self->{MIDDLE_INITIAL})
  {
    die "Already have a middle initial when adding $text";
  }

  $self->{MIDDLE_INITIAL} = $text;
}


sub add_last
{
  my ($self, $key, $text) = @_;

  if (! exists $self->{LAST_FULL} &&
      ! exists $self->{LAST_VARIANT} &&
      ! exists $self->{LAST_EARLIER1} &&
      ! exists $self->{LAST_EARLIER2})
  {
    # Assume it's a full-form name.
    $self->{LAST_FULL} = $text;
    return;
  }

  for my $key (qw(LAST_FULL LAST_VARIANT LAST_EARLIER1 LAST_EARLIER2))
  {
    return if exists $self->{$key} && $self->{$key} eq $text;
  }

  if ($key eq 'NAME_DEPRECATED')
  {
    if (exists $SPECIALS{LAST_VARIANT} &&
        exists $SPECIALS{LAST_VARIANT}{$text} &&
        exists $self->{LAST_FULL} &&
        exists $SPECIALS{LAST_VARIANT}{$text}{$self->{LAST_FULL}})
    {
      $self->{LAST_VARIANT} = $text;
      return;
    }

    if (! exists $self->{LAST_EARLIER1})
    {
      $self->{LAST_EARLIER1} = $text;
      return;
    }

    if (! exists $self->{LAST_EARLIER2})
    {
      $self->{LAST_EARLIER2} = $text;
      return;
    }
  }


  print "$text: Haven't learned multiple last names yet.\n";
}


sub add_with_first_initials
{
  my ($self, $key, $words, $caps) = @_;

  if ($words->[0] eq '-')
  {
    $self->{FIRST_MISSING} = 1;
    my $last = join(' ', @{$words}[1 .. $#$words]);
    $self->add_last($key, $last);
    return 1;
  }

  # Start with an initial
  return 0 unless $caps->[0] eq INITIAL;

  my $len = $#$words;
  my $p_first = 99;
  for my $i (0 .. $len)
  {
    if ($caps->[$i] ne INITIAL && $caps->[$i] ne CAPITALIZED)
    {
      $p_first = $i;
      last;
    }
  }

  return 0 unless $p_first <= $len;

  for my $i ($p_first .. $len)
  {
    if ($caps->[$i] ne ALLCAPS)
    {
      return 0;
    }
  }

  my $first = join(' ', @{$words}[0 .. $p_first-1]);
  $self->add_first($key, $first);

  my $last = join(' ', @{$words}[$p_first .. $len]);
  $self->add_last($key, $last);

  return 1;
}


sub add_with_middle_initials
{
  my ($self, $key, $words, $caps) = @_;

  my $len = $#$words;
  my $p_first = 99;
  for my $i (0 .. $len)
  {
    if ($caps->[$i] eq INITIAL)
    {
      $p_first = $i;
      last;
    }
  }

  my $p_last = -1;
  for my $i (reverse 0 .. $len)
  {
    if ($caps->[$i] eq INITIAL)
    {
      $p_last = $i;
      last;
    }
  }

  return 0 unless $p_first <= $p_last;
  return 0 unless $p_first >= 0 && $p_last < $len;

  for my $i (0 .. $p_first-1)
  {
    return 0 unless $caps->[$i] eq CAPITALIZED;
  }

  for my $i ($p_last+1 .. $len)
  {
    return 0 unless $caps->[$i] eq ALLCAPS;
  }

  my $first = '';
  if ($p_first > 0)
  {
    my $first = join(' ', @{$words}[0 .. $p_first-1]);
    $self->add_first($key, $first);
  }

  my $initials = join(' ', @{$words}[$p_first .. $p_last]);
  my $last = join(' ', @{$words}[$p_last+1 .. $len]);
  $self->add_middle_initial($key, $initials);
  $self->add_last($key, $last);

  return 1;
}


sub add_with_split
{
  # There should be a first name in front and a last name at the end.
  # Can we split somewhere along the way such that particles and
  # known last names go in the last name, and the rest in the first
  # name?

  my ($self, $key, $words, $caps, $particles) = @_;

  my $len = $#$words;
  return unless $len > 1;

  my $p_last = 99;
  for my $i (0 .. $len)
  {
    if ($caps->[$i] ne CAPITALIZED && $caps->[$i] ne INITIAL)
    {
      $p_last = $i;
      last;
    }
  }

  my $p_first = -1;
  for my $i (reverse 0 .. $len)
  {
    if ($caps->[$i] ne ALLCAPS && $particles->[$i] ne PARTICLE)
    {
      $p_first = $i;
      last;
    }
  }

  return 0 unless $p_first + 1 == $p_last;

  for my $i (1 .. $p_first)
  {
    my $w = $words->[$i];
if (! exists $FIRST_NAMES_HASH{$words->[$i]} &&
   (! exists $EXCEPTIONS{$w} || $EXCEPTIONS{$w} != CAPITALIZED) &&
   $caps->[$i] != INITIAL)
{
  print "MISSF $w\n";
}
    return 0 unless 
      (exists $FIRST_NAMES_HASH{$w} ||
      (exists $EXCEPTIONS{$w} && $EXCEPTIONS{$w} == CAPITALIZED) ||
      $caps->[$i] == INITIAL);
  }

  for my $i ($p_last .. $len-1)
  {
    my $w = $words->[$i];
if (! exists $LAST_NAMES_HASH{$words->[$i]} &&
   (! exists $EXCEPTIONS{$w} || $EXCEPTIONS{$w} != ALLCAPS) &&
   $particles->[$i] != PARTICLE)
{
  print "MISSL $words->[$i]\n";
}
    return 0 unless 
      exists $LAST_NAMES_HASH{$words->[$i]} || 
      (exists $EXCEPTIONS{$w} && $EXCEPTIONS{$w} == ALLCAPS) ||
      $particles->[$i] == PARTICLE;
  }

  my $first = join(' ', @{$words}[0 .. $p_first]);
  $self->add_first($key, $first);

  my $last = join(' ', @{$words}[$p_last .. $len]);
  $self->add_last($key, $last);

  return 1;
}


sub complete
{
  my ($self) = @_;

  for my $key (qw(FIRST_FULL FIRST_INITIAL MIDDLE_INITIAL LAST_FULL))
  {
    if (exists $self->{$key})
    {
      @{$self->{LISTS}{$key}} = split ' ', $self->{$key};
    }
  }

  my (@accumf, %seenf);
  for my $key (qw(SHORT NICKNAME RENAME VARIANT)) 
  {
    if (exists $self->{$key}) 
    {
      my @words = split ' ', $self->{$key};
      push @accumf, @words;
    }
  }

  # Remove duplicates
  @{$self->{LISTS}{FIRST_OTHER}} = do { grep { !$seenf{$_}++ } @accumf; };

  my (@accuml, %seenl);
  for my $key (qw(LAST_VARIANT LAST_EARLIER1 LAST_EARLIER2)) 
  {
    if (exists $self->{$key}) 
    {
      my @words = split ' ', $self->{$key};
      push @accuml, @words;
    }
  }

  # Remove duplicates
  @{$self->{LISTS}{LAST_OTHER}} = do { grep { !$seenl{$_}++ } @accuml; };


  # Check for consistency.
  my $c = 0;
  $c++ if exists $self->{FIRST_FULL};
  $c++ if exists $self->{FIRST_INITIAL};
  $c++ if exists $self->{FIRST_MISSING};
  die "First names compromised" unless $c == 1;

  $c = 0;
  for (qw(SHORT NICKNAME RENAME VARIANT))
  {
    $c++ if exists $self->{$_};
  }
  die "Too many first versions" unless $c <= 1;

  die "No full last name" unless exists $self->{LAST_FULL};

  $self->{COMPLETE} = 1;
}


sub str_line
{
  my ($self) = @_;

  $self->complete() unless exists $self->{COMPLETE};

  my $s = '';
  $s .= $self->{TITLE} . ' ' if exists $self->{TITLE};

  $s .= $self->{FIRST_FULL} if exists $self->{FIRST_FULL};

  if (exists $self->{FIRST_INITIAL})
  {
    $s .= ' ' unless $s eq '';
    $s .= $self->{FIRST_INITIAL};
  }
  if (exists $self->{FIRST_MISSING})
  {
    $s .= ' ' unless $s eq '';
    $s .= '-';
  };

  $s .= ' ' . $self->{MIDDLE_INITIAL} if exists $self->{MIDDLE_INITIAL};

  my $c = 0;
  for (qw(SHORT NICKNAME RENAME VARIANT))
  {
    $c++ if exists $self->{$_};
  }
  if ($c == 1)
  {
    for my $key (qw(SHORT NICKNAME RENAME VARIANT))
    {
      $s .= ' (' . $self->{$key} . ')' if exists $self->{$key};
    }
  }

  $s .= ' ' . $self->{LAST_FULL} if exists $self->{LAST_FULL};

  $c = 0;
  for (qw(LAST_VARIANT LAST_EARLIER1 LAST_EARLIER2))
  {
    $c++ if exists $self->{$_};
  }
  if ($c >= 1)
  {
    for my $key (qw(LAST_VARIANT LAST_EARLIER1 LAST_EARLIER2))
    {
      $s .= ' (' . $self->{$key} . ')' if exists $self->{$key};
    }
  }

  $s .= ' Jr.' if exists $self->{JUNIOR};
  $s .= ' Sr.' if exists $self->{SENIOR};
  $s .= ' ' . $self->{DYNAST} if exists $self->{DYNAST};
  $s .= ' (' . $self->{COUNTER} . ')' if exists $self->{COUNTER};

  return $s;
}


sub str_verbose
{
  my ($self) = @_;

  $self->complete() unless exists $self->{COMPLETE};

  my $s = '';
  for my $key (qw(TITLE FIRST_FULL FIRST_INITIAL FIRST_MISSING
    MIDDLE_INITIAL SHORT NICKNAME RENAME VARIANT
    LAST_FULL LAST_VARIANT LAST_EARLIER1 LAST_EARLIER2
    JUNIOR SENIOR DYNAST COUNTER))
  {
    $s .= "$key $self->{$key}\n" if exists $self->{$key};
  }

  $s .= "\n";


  for my $key (qw(FIRST_FULL FIRST_INITIAL FIRST_OTHER
    MIDDLE_INITIAL LAST_FULL LAST_OTHER))
  {
    if (exists $self->{LISTS}{$key} &&
      $#{$self->{LISTS}{$key}} >= 0)
    {
      $s .= "LIST $key " . (join ' ', @{$self->{LISTS}{$key}}) . "\n";
    }
  }

  # return encode("iso-8859-1", "$s\n", Encode::FB_CROAK);
  return "$s\n";
}


1;
