#!perl
use strict;
use warnings;

use lib '..';
use lib '../..';

use FirstFirst;
use FirstMid;
use FirstBBO;

use LastMid;
use LastLast;
use LastBBO;

use Country;
my $country = Country->new();

my @DOMAINS = qw(
  ag ar at au be bg br ca ch cl cn co com cz de dk edu ee es eu fi fm fr 
  gr hk hr hu id ie il is it in jp lu lv mx net nl no nz org 
  pl pt ro ru se sg sk tr tw uk us za
);

my %DOMAINS_HASH;
$DOMAINS_HASH{$_} = 1 for @DOMAINS;

my @SKIP_WORDS = qw(
  ask Ask
  null
  other Other
  privado privat private prive privato Privat Private PRIVATE
  request
  speak
);

my %SKIP_HASH;
$SKIP_HASH{$_} = 1 for @SKIP_WORDS;

my @SYSTEM_WORDS = qw(
  1nt 2d 2nt 15-17 15-18 16-18 16-19 19-20 20-21 20-22 21-23
  0314 1430 5542
  5cm 5crd 5major
  aces accept acol against akol alert asking attitude
  beginner better bicolor blackwood blw
  capaletti capp card carding cards checkback clubs cue cuebid
  dbl diamonds discard drury
  enc encourage encouraging exclusion expert
  faible fnt forcing free fsf fuerte
  gadgets gambling gerber game gf
  hand hcp hearts high
  inverted
  jac jacoby
  keycard
  landy lead leb lebensohl low
  major majors master minimum minor muiderberg multi multicolor
  negative nmf
  ogust opening overcall overcalls
  partner play player points prec precision preempt pts puppet
  raise raises relay resp response reverse revdrury rkc rkcb 
  rusinow sayc short small smolen spades splinter standard standart 
  stayman 
  std strng strong strongest suit suits supp support
  transf transfer transfers transfert trèfle trefles trf trnsf 
  trsf twos
  udca undo undos upside
  weak waiting
  xfer
);

# BIL is not really a convention, but is normally not a real last name.
my @CONVENTIONS = qw(
  bergen
  bil
  blackwood
  cappelletti
  drury
  english
  jacobi jacoby
  gerber ghestem goren
  landy lightner
  michaels
  ogust
  smolen stayman
);

my %CONVENTIONS_HASH;
$CONVENTIONS_HASH{$_} = $_ for @CONVENTIONS;

my $SYSTEMRE = qr/\b(?:@{[ join '|', @SYSTEM_WORDS ]})\b/i;


my (%FIRST, %FIRST_LC);
$FIRST{$_} = 1 for @FIRST_FIRST_NAMES;
$FIRST{$_} = 1 for @FIRST_MID_NAMES;
$FIRST{$_} = 1 for @FIRST_BBO;
$FIRST_LC{lc($_)} = $_ for @FIRST_FIRST_NAMES;
$FIRST_LC{lc($_)} = $_ for @FIRST_MID_NAMES;
$FIRST_LC{lc($_)} = $_ for @FIRST_BBO;

my (%LAST, %LAST_LC);
$LAST{$_} = 1 for @LAST_MID_NAMES;
$LAST{$_} = 1 for @LAST_LAST_NAMES;
$LAST_LC{lc($_)} = $_ for @LAST_MID_NAMES;
$LAST_LC{lc($_)} = $_ for @LAST_LAST_NAMES;
$LAST_LC{lc($_)} = $_ for @LAST_BBO;

# my %FIRST_MANUAL;
# get_file(\%FIRST_MANUAL, 'h');
# for my $k (keys %FIRST_MANUAL)
# {
  # if (! exists $FIRST_LC{$k} && ! exists $LAST_LC{$k})
  # {
    # print "$k\n";
  # }
# }
# exit;


my $file = 'db';
my $data;


open(my $fh, "<:raw", $file) or die "Cannot open $file$!";
local $/;
$data = <$fh>;
close $fh ;

my @fields = split /\x00+/, $data;

my %players;
for my $i (0 .. $#fields)
{
  if ($fields[$i] =~ /^P([A-Z0-9 _]+)$/)
  {
    my $handle = $1;
    if ($handle =~ /^ZZZZ_\d+$/)
    {
      # Skipping anonymous handle.
      $i++;
      next;
    }

    my @data = split /[\x00-\x1F]+/, $fields[$i+1];
    my @info;
    my $country_seen = 0;
    my $magic_seen = 0;
    my $name_seen = 0;

    print "HANDLE $handle (", 1+ $#data, ")\n";
    for my $i (0 .. $#data)
    {
      my $datum = $data[$i];
      $datum =~ s/^\s+//;
      $datum =~ s/\s+$//;
      $datum =~ s/^[!\-+:;'"@?\(\)*.,=#%&\/\$]+\s*//;
      $datum =~ s/\s*[!\-+:;'"@?\)*.,=#%&\/\$]+$//;

      next unless length($datum) > 0;
      next if exists $SKIP_HASH{$datum};
      next if $datum =~ /^[!_\-+:\(\)*.,=%\/\$'"@?#x\s]+$/;

      if ($datum =~ /Wolanski/)
      {
        # print "HERE\n";
      }

      if ($country->valid_lc($datum))
      {
        store($handle, 'COUNTRY', $datum);
        $country_seen = 1;
        next;
      }
      elsif ($datum =~ /^(\d+)$/ && $1 >= 100 && $1 < 200)
      {
        store($handle, 'MAGIC', $datum);
        $magic_seen = 1;
        next;
      }

      my $datum_lc = lc($datum);
      if ($datum !~ /\s/ && exists $FIRST_LC{$datum_lc})
      {
        store($handle, 'FIRST', $FIRST_LC{$datum_lc});
        $name_seen = 1;
        next;
      }
      elsif ($datum !~ /\s/ && exists $LAST_LC{$datum_lc} &&
        ! exists $CONVENTIONS_HASH{$datum_lc})
      {
        store($handle, 'LAST', $LAST_LC{$datum_lc});
        $name_seen = 1;
        next;
      }

      if ($datum =~ /^[0-9]n/ && $magic_seen)
      {
        # Skip -- some kind of code.
        next;
      }
      elsif ($datum =~ /^\dy/)
      {
        # Skip -- some kind of code.
        next;
      }

      if (! $country_seen)
      {
        next if looks_like_email($handle, $datum);
      }
      elsif (! $magic_seen)
      {
        store($handle, 'SYSTEM', $datum);
        next;
      }

      if ($datum =~ $SYSTEMRE) 
      {
        store($handle, 'SYSTEM', $datum);
        next;
      }

      # Some simple first-last combinations.
      my @words = split /\s+/, $datum_lc;
      if ($#words == 1)
      {
        if (exists $FIRST_LC{$words[0]} &&
            ! exists $LAST_LC{$words[0]} &&
            exists $LAST_LC{$words[1]} &&
            ! exists $FIRST_LC{$words[1]} &&
            ! exists $CONVENTIONS_HASH{$words[1]})
        {
          store($handle, 'FIRST', $FIRST_LC{$words[0]});
          store($handle, 'LAST', $LAST_LC{$words[1]});
          $name_seen = 1;
          next;
        }
        elsif (!exists $FIRST_LC{$words[0]} &&
            exists $LAST_LC{$words[0]} &&
            ! exists $LAST_LC{$words[1]} &&
            exists $FIRST_LC{$words[1]} &&
            ! exists $CONVENTIONS_HASH{$words[0]})
        {
          print "WXW $datum\n";
          # next;
        }
      }

      if ($name_seen)
      {
        print "YYY $datum\n";
      }

      push @info, "GENERIC $datum";
    }

    for my $inf (@info)
    {
      print "$inf\n";
    }

    for my $key (keys %{$players{$handle}})
    {
      print "KEY $key ", join(' ', @{$players{$handle}{$key}}), "\n";
    }
    print "---\n\n";

    $i++;
  }
}


sub get_file
{
  my ($first, $fname) = @_;

  open my $fh, '<', $fname or die "Can't read $fname: $!";
  while (my $line = <$fh>)
  {
    chomp $line;
    $line =~ s///g;
    next if $line =~ /^\s*$/;
  
    if ($line =~ /\s+/)
    {
      warn "SPACE $line";
      next;
    }
  
    $first->{lc($line)} = 1;
  }
  close $fh;
}


sub looks_like_email
{
  my ($handle, $datum) = @_;

  return 0 if $datum =~ /\s/;

  my @a = split '@', $datum;
  return 0 unless $#a == 1;

  my @b = split '\.', $a[1];
  return 0 unless $#b >= 1 && $#b <= 3;

  my $domain = $b[$#b];
  if (exists $DOMAINS_HASH{lc($domain)})
  {
    store($handle, 'EMAIL', $datum);
    return 1;
  }

  print "ALIAS $datum\n";
  print "DOMMISS $domain\n";
  return 0;
}


sub store
{
  my ($handle, $key, $value) = @_;

  if (exists $players{$handle}{$key})
  {
    for my $stored (@{$players{$handle}{$key}})
    {
      return if $stored eq $value;
    }
  }

  push @{$players{$handle}{$key}}, $value;
}


