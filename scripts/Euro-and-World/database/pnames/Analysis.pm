#!perl

package Analysis;

use strict;
use warnings;
use v5.10;

use lib '.';

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
  "GUINVARC'H" => ALLCAPS,
  'Jérôme' => CAPITALIZED,
  'Jan-e-Alam' => CAPITALIZED,
  JoAnna => CAPITALIZED,
  'I-Hung' => CAPITALIZED,
  'I-Ming' => CAPITALIZED,
  LaLa => CAPITALIZED,
  'María' => CAPITALIZED,
  "O'KEEFFE-BROWN" => ALLCAPS,
  "O'REILLY-POL" => ALLCAPS,
  "Ra'ad" => CAPITALIZED
);

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
    Conny => {Catharine => 1},
    Dave => {David => 1},
    Det => {Bernadette => 1},
    Dick => {Richard => 1, 'Richard J.' => 1},
    Giampao => {Giampaolo => 1},
    Giancarlo => {'Giovanni Carlo' => 1},
    Hein => {Henricus => 1},
    Henk => {Hendrik => 1},
    Hovik => {Hovhannes => 1},
    'Jean-Jacque' => {'Jean-Jacques' => 1},
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
    Denis => {Darko => 1},
    Dimmie => {Irene => 1},
    Joice => {'Julietta Grace' => 1},
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
    Brian => {'Ho Yin' => 1},
    Catherine => {Runmei => 1},
    Chris => {'Tze Him' => 1},
    Clair => {Shiuan => 1},
    'Costa-Foru' => {Constantin => 1},
    Derek => {'Wei Peu' => 1},
    Gloria => {'Ching-Shan' => 1},
    Jack => {Jie => 1},
    Jerry => {'Li Min' => 1},
    Jimmy => {'Saleem Ud' => 1, Zhuo => 1},
    John => {'Hao Zhen' => 1},
    Kevin => {Yuxiang => 1},
    Max => {Ziyu => 1},
    Nicky => {Kulbir => 1},
    Oak => {Wattanai => 1},
    Timothy => {Kaiti => 1},
  },
  
  VARIANT =>
  {
    Alexandre => {Alexandru => 1},
    Danielle => {Daniele => 1},
    Isabella => {Isabelle => 1},
    Jacob => {Yaacov => 1},
    Jeniffer => {Jennifer => 1},
    Jingsheng => {Jinsheng => 1},
    Kamales => {Kamles => 1},
    Mansur => {Mansoor => 1},
    Marco => {Marcos => 1},
    Michael => {Mikhail => 1},
    Michele => {Michelle => 1},
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
    Wojciech => {Wojtek => 1},
    Woyciech => {Wojtek => 1},
  }
);

# This is used to verify that middle names are like first names.
my @FIRST_NAMES =
qw(
  Aaron Abbas Abdel Abdullah Abel Adrian Ahmad Ahmed Ake Alain 
  Albert Alberto Alejandra Alejandro Alex Alexander Alexandra Alexandre
  Alexandru Alfredo Ali Anders Andre Andrea Andreas Andreea 
  Andrei Andres Andrias Andrzej Angel Angela Angelica Angelo Angelova
  Anker Anil Anita Ann Anne Annette Anthonius Anthony Anton Antonia 
  Antonio Ara Are Ariel Aril Arild Arne Arthur Arturo Arve Asbjorn
  Aulia Aulid
  Bambang Barbosa Barki Battista Beate Beatrice Belle Benedict 
  Beniamino Berkay Bertram Birgitte Bjoerk Bjoernar Bjorn Bogdan 
  Borgar Borissova Brian Brita Britt Bruna Bruno
  Carla Carlo Carlos Carmen Carol Carolina Cato Cecilia Celia 
  Celina Cesare Chandra Charles Charlie Charllene Charlotte Christer 
  Christian Christina Christine Christopher Claude Claudiu Christa 
  Cosmo Craig Cristian Cristina
  Daniel Daniela Dario David Delfina Diana Didier Dirk Dolores 
  Domenico Dumitru
  Edmund Edoardo Eduardo Edward Egil Eidur Einar Eirik Eivind Elena 
  Elia Eline Elisa Elise Elizabeth Elvin Elvira Emil Emilie Emmanuel 
  Endre Enrica Enrique Erdem Erik Eriks Erling Esther Eugenia Eugenio
  Fay Federico Felicia Felipe Fernando Filippo Florencia Fold Frances 
  Francesco Francis Francisco Francois Francoise Fraser Frederic 
  Frederik Fredrik Frode
  Gabriel Gabriela Gabryjela Gail Gautur Georg Georges Gerard 
  Gheorghe Gigello Giovanni Giulio Gisella Gisli Giuseppe Gracio 
  Grazia Graziela Gudlaug Gundega Gunnar Gustaaf
  Haakon Hallvard Harald Hasan Hassan Haugen Helen Helena Helene 
  Helge Helvijs Hendrik Henrik Henry Hersir Holmar Hove Hugo Hussain
  Ian Idland Ignacio Ilari Inge Inger Ingvald Ioulios Irene Irvin 
  Isabel Ivan Ivar Ivonne
  Jack Jacob Jacques Jakob Jakup James Jan Jane Janneth Javier 
  Jason Jean Jeffry Jeremiah Jerry Joan Joana Joao Joaquin Joergen 
  Johan Johan Johannes John Jona Jonny Jorge Jorgen Jose Joseph 
  Judith Juan Juhan
  Kaare Kare Karim Karin Karl Kate Kay Kayzen Keith Kenyon Kjellaug 
  Konstantinos Kristen Kristian Kristine Kristjan Kubilay Kumar
  Laurentiu Lee Lena Lene Leon Leonardo Leslie Lija Lilian Lily 
  Lionel Lisa Lise Lou Louis Louisa Louise Luca Lucette Lucia Lucian 
  Luigi Luis Luisa Luiza Lygre Lynn
  Maciej Mae Magnus Mahmood Manuel Marcelo Marc Marcelin Marek 
  Margaret Margarita Margrethe Mari Maria Marian Marie Marina Mario 
  Marit Mark Marius Marques Martin Massimo Matias Mauricio Merete 
  Meta Mette Micael Michael Michel Miguel Mihaela Mihai Mihail 
  Mihaylova Mikael Mirabelle Miranda Mirta Mohamed Monica Mora Morten 
  Mustafa
  Nicholas Nicoletta Nicolle Nika Niklas Noeline Noelle
  Odile Octavian Odin Olai Olafs Olav Ole Olha Olivier Olof Omar 
  Omer Orn Osman Osnes Otto Ove Ovidiu Owen
  Pablo Pall Paola Paoli Patrick Paul Paula Pauli Paulo Pawel 
  Pedro Peter Petronia Petter Philip Philippe Pia Pierre Pino 
  Prakash Priscilla
  Rachel Rafael Ragnar Raiko Ramon Raphaela Ricardo Richard 
  Ricquier Riswan Rita Roar Robert Roberto Rodolfo Roger Ronald 
  Ronaldo Rosa Rosanna Rosaria Roxana Roy Runar Ruth Ryan
  Sabine Saeed Said Sartje Sebastian Sergio Sergiu Shankar Sigurd 
  Silvio Simon Simona Singh Siri Sivert Soerlie Sofia Sofie Sophia 
  Sophie Stephen Steven Stewart Sue Susana Swaray Sydney
  Teresa Terje Theo Theodore Thomas Thora Titus Toar Tomas Tor Tore 
  Torgeir 
  Tove Trine Triumf Tua Tybring
  Uffe Ugur Ulrik Ursin
  Vala Valentin Valerie Veronica Victor Victoria Virgil Virginia 
  Vittorio
  Walter Werner Wilhemina Willem William Willy Wojciech
  Xavier
  Yves Yvonne
);

# This is used to verify that middle names are like first names.
my @LAST_NAMES =
qw(
  AASAND ABOU AGUADO ALBERTI ALTMANN AMMENDOLIA ARGAYNE ARMIJO 
  ASPLUND ATTARD
  BACCHI BAJOS BALLERINO BALLI BANG BAPTISTA BARCOS BARRERA BASELGA
  BATALLA BATZIA BEIRAO BELLERIO BELLUSSI BELLOCQ BELRHITI BENDER 
  BENSBY BETTENCOURT BETTI BILDE BJOERBEKK BO BONADIES BORDALLO 
  BORSARELLI BOSCARO BRENDERFORD BRENNA BRITO BRORHOLT BRUN BRYDE 
  BUELENS BULLARD BUUS
  CANALI CANDUCCI CANESSA CAPBERN CAPELLI CAPION CASALE CASTELLO 
  CASTRO CATASTINI CATTANEO CESARI CESATI CHACON CHAMORRO CHAVES 
  CHINDEMI CILLEBORG CIVIDIN COLOMBO COLONNA CORREA CORSICO 
  COSIGNANI COSSU COSTA CREDAZZI CRISAFULLI CROCI CUBILLO CUERVO
  DALEMARK DAM DELLADIO DELPIANO DENEGRI DIAZ DIEZ DIMITROV DRINOVEC
  DWYER DYBVIK
  ECK EDWARDS ERTBJERG
  FABBRI FANTONI FARINA FERLAZZO FERNANDES FERNANDEZ FINCHELTUB 
  FOLLIERO FRANCES
  HALD HANSEN HARALDSDOTTIR HARLAND HAYMAN HERRERA HJORTH HOEL HOLM
  HOLTZ HVIDBERG 
  GANDINI GARCIA GARRIGOU GARRONE GERMANETTI GIACCHINI GLAZER 
  GOETZ GOMES GOMEZ GONCALVES GONZALES GRASHOLT GRAYSON GULDBRAND
  HELDAL HINZ HOLM HUC
  JEITZ JIMENEZ JONES JUCHIMOWICZ JUHL JUL JUST JUUL
  KEITH KERLERO KIRKEGAARD KOFOED KORRE KRAFT KRAGH KROGH KRUSE
  LANZOTTI LAUGE LEMAITRE LIAQUAT LINDAAS LINTRUP LOENBERG LOPES 
  LOPEZ LORENTE LOSCHI LUND LUZ LYNGE
  MARANI MARTINEZ MARSH MATHE MAURY MAZZADI MICALI MOELLER MOLLER 
  MONTEIRO MORCK MOREIRA MUSCAT
  NIELSEN NIKOLOV NOERHAVE NYHEIM
  OLIVEIRA
  PABIS PALANCA PARASIAN PELAEZ PEREZ POLIMENI PONCE PORTANTI PRATO
  QUERAN
  RAMIREZ RANDLE RASK RASMUSSEN RAULUND REY REYES RICCI ROCABERG
  ROSEN ROUANET ROZPIDE RUZ
  SANCHEZ SANTOS SCHMIDT SCHNETZER SEGURA SELLAN SEQUI SERCY 
  SERRANO SGOLOMBIS SHLESINGER SILVA SILVERMAN SKOGLY SMADILO 
  SPINOLA STAMATOV STAUGAARD STEEN STEIGER STEWART STRANDE
  THEISS THRANE THUNBO TOCCO TORKELSEN TORNBERG TURLETTI TVEDEN
  VAGN VAISBICH VALENZUELA VEEL VERDI VERMEHREN VIGORELLI VILBORG 
  VINBERG VIVARELLI
  WANG WEISS WHEATLEY WICKBE WINGAARD
  ZAIDENBERG ZAMMIT ZEDDA
);

my %FIRST_NAMES_HASH;
$FIRST_NAMES_HASH{$_} = 1 for @FIRST_NAMES;

my %LAST_NAMES_HASH;
$LAST_NAMES_HASH{$_} = 1 for @LAST_NAMES;


my %PARTICLES =
(
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
  DU => 1,
  EL => 1,
  LA => 1,
  LE => 1,
  LO => 1,
  TEN => 1,
  TER => 1,
  VAN => 1,
  VON => 1,
  ZU => 1
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
    if ($w =~ /^Dr\.*$/)
    {
      $self->{TITLE} = 'Dr.';
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^Capt\.*$/)
    {
      $self->{TITLE} = 'Captain';
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^Maj\.*$/)
    {
      $self->{TITLE} = 'Major';
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^\((\d)\)$/)
    {
      $self->{COUNTER} = $1;
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^[A-Z]\.$/)
    {
      # A single initial with a point.
      $i++;
      next;
    }
    if ($w =~ /^[A-Z]$/)
    {
      # Add point to a single letter.
      $words->[$i] .= '.';
      $i++;
      next;
    }
    if ($w =~ /^\(([A-Z][a-z]+)\)$/)
    {
      my $inner = $1;
      if (exists $SPECIALS{SHORT}{$inner})
      {
        $self->{SHORT} = $inner;
        splice @$words, $i, 1;
        next;
      }
      if (exists $SPECIALS{NICKNAME}{$inner})
      {
        $self->{NICKNAME} = $inner;
        splice @$words, $i, 1;
        next;
      }
      if (exists $SPECIALS{RENAME}{$inner})
      {
        $self->{RENAME} = $inner;
        splice @$words, $i, 1;
        next;
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

  # TODO Doesn't do titles yet:
  # Count
  # Graf
  # Baron (not Chi-Cheung Baron NG, Asia)
  # Prinzessin, Prince, Prinz (Prince not in African countries)
  # Capt., Maj.
  # Md is Mohammed
}


sub get_capitalization
{
  # Not a class method
  my ($text) = @_;

  return INITIAL if $text =~ /^[A-Z]\.{0,1}$/;
  return ALLCAPS if $text =~ /^[A-Z]+$/;
  return CAPITALIZED if $text =~ /^[A-Z][a-z]+$/;
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

  return PARTICLE if exists $PARTICLES{uc($text)};

  return GENERAL;
}


sub add
{
  my ($self, $key, $text, $country) = @_;

  my @words = split /\s+/, $text;

  $self->remove_various(\@words);

  my @caps;
  for my $v (@words)
  {
    push @caps, get_capitalization($v);
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
    elsif ($words[0] eq '-' || $words[1] eq '-')
    {
      print "$text WWW\n";
      return;
    }
    else
    {
      print "$text ZZZ\n";
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

    return if $self->add_with_particle($key, \@words, \@caps, \@particles);
  }

  if ($#caps == 2 && $caps[0] == CAPITALIZED && $caps[2] == ALLCAPS)
  {
    if (exists $FIRST_NAMES_HASH{$words[1]})
    {
      $self->add_first($key, "$words[0] $words[1]");
      $self->add_last($key, $words[2]);
      return;
    }
    if (exists $LAST_NAMES_HASH{$words[1]})
    {
      $self->add_first($key, $words[0]);
      $self->add_last($key, "$words[1] $words[2]");
      return;
    }
    if ($caps[1] == INITIAL)
    {
      $self->add_first($key, $words[0]);
      $self->add_first_initial($key, $words[1]);
      $self->add_last($key, $words[2]);
      return;
    }
  }
    

  print "$text XXX\n";
}


sub add_first
{
  my ($self, $key, $text) = @_;

  if (! exists $self->{FIRST_FULL} &&
      ! exists $self->{VARIANT} &&
      ! exists $self->{NICKNAME} &&
      ! exists $self->{RENAME} &&
      ! exists $self->{SHORT})
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
        $self->{$tag} = $text;
        return;
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


  print "$text: Haven't learned multiple last names yet.\n";
}


sub add_with_particle
{
  my ($self, $key, $words, $caps, $particles) = @_;

  my $len = $#$words;
  my $p_first = 99;
  for my $i (0 .. $len)
  {
    if ($particles->[$i] eq PARTICLE)
    {
      $p_first = $i;
      last;
    }
  }

  my $p_last = -1;
  for my $i (reverse 0 .. $len)
  {
    if ($particles->[$i] eq PARTICLE)
    {
      $p_last = $i;
      last;
    }
  }

  return 0 unless $p_first <= $p_last;
  return 0 unless $p_first > 0 && $p_last < $len;

  for my $i (0 .. $p_first-1)
  {
    return 0 unless $caps->[$i] eq CAPITALIZED;
  }

  for my $i ($p_last+1 .. $len)
  {
    return 0 unless $caps->[$i] eq ALLCAPS;
  }

  my $first = join(' ', @{$words}[0 .. $p_first-1]);
  my $last = join(' ', @{$words}[$p_first .. $len]);

  $self->add_first($key, $first);
  $self->add_last($key, $last);
  return 1;
}


sub str_full
{
  my ($self) = @_;

  my $s = '';
  # TODO
  return $s;
}


1;
