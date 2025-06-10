#!perl
use strict;
use warnings;

use lib '.';
use lib '..';

my @TAG_ORDER = qw(
  COUNTRY
  REGION
  CITY
  LOCALITY
  NATIONALITY
  FLUFF
  NOTNAMES
  SYSTEM
  CONVENTIONS
  FIRSTFIRST
  FIRSTMID
  FIRSTBBO
  LASTLAST
  LASTMID
  LASTBBO
);

# TODO Do something about Both.
# Probaby split into BothFirstish and BothLastish and BothUnclear.

use WholeBBO;
my $whole = WholeBBO->new();
$whole->init_hashes;

use Chain;
use Token;
use Util;

use Histo;
my $histo = Histo->new();

my @DOMAINS = qw(
  ag ar at au be bg br ca ch cl cn co com cz de dk edu ee es eu fi fm fr 
  gr hk hr hu id ie il is it in jp lu lv mx net nl no nz org 
  pl pt ro ru se sg sk tr tw uk us za
);

my %DOMAINS_HASH;
$DOMAINS_HASH{$_} = 1 for @DOMAINS;

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
      $datum =~ s/\s+/ /g;
      $datum =~ s/^[!\-+:;'"@?\(\)*.,=#%&\/\$]+\s*//;
      $datum =~ s/\s*[!\-+:;'"@?\)*.,=#%&\/\$]+$//;

      next unless length($datum) > 0;
      next if $datum =~ /^[!_\-+:\(\)*.,=%\/\$'"@?#x\s]+$/;

      if ($datum =~ /Wolanski/)
      {
        # print "HERE\n";
      }

      if ($datum =~ /^(\d+)$/ && $1 >= 100 && $1 < 200)
      {
        store($handle, 'MAGIC', $datum);
        $magic_seen = 1;
        next;
      }

      if (($datum =~ /^[0-9]n/ && $magic_seen) || $datum =~ /^\dy/)
      {
        # Skip -- some kind of code.
        next;
      }

      if (! $country_seen)
      {
        next if looks_like_email($handle, $datum);
      }

      if ($country_seen && ! $magic_seen)
      {
        store($handle, 'SYSTEM', $datum);
        next;
      }

      # From here on we have to analyze more carefully.
      # This is modeled on Title::Study.
      my @tags = (0);
      my @values = ();
      my @texts = ();

if ($datum eq 'Afghanistan')
{
  print "HERE\n";
}
      split_on_dates($datum, \@tags, \@values, \@texts, 0);
      split_on_multi($whole, \@TAG_ORDER, 0, \@tags, \@values, \@texts);

      # Split on separators.
      my $sep = qr/[\s+\-\+\._:;&@"\/\(\)\|]/;

      my $token_no = 0;
      my $unsolved_flag = 0;
      my $chain = Chain->new();

      for my $i (0 .. $#values)
      {
        if ($tags[$i] ne '0')
        {
          # We had a multi-word hit.
          append_token($chain, 'SINGLETON', $tags[$i], $values[$i],
            $texts[$i], \$token_no, $histo, '');
          
          print "TTT $values[$i]}\n";
        }
        else
        {
          my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
          foreach my $value (@a)
          {
            # if ($value eq 'Ankara')
            # {
              # print "HERE\n";
            # }

            if (singleton_non_tag_matches($value, \$token_no,
              $chain, $histo, ''))
            {
              # print "UUU $value\n";
              next;
            }

            if (singleton_tag_matches($whole, \@TAG_ORDER,
              \$token_no, $value, 0, $chain, $histo, ''))
            {
              # print "VVV $value\n";
              next;
            }

            append_token($chain, 'UNKNOWN', '', $value, $value,
              \$token_no, $histo, '');

            print "SSS value $value\n";
            $unsolved_flag = 1;
          }
        }
      }

      if ($chain->last() == 0)
      {
        my $token = $chain->check_out(0);
        my $field = $token->field();
        my $value = $token->value();
        if ($field eq 'COUNTRY')
        {
          store($handle, 'COUNTRY', $value);
          $country_seen = 1;
          next;
        }
        elsif ($field eq 'REGION')
        {
          store($handle, 'REGION', $value);
          print "XX7 $datum\n";
          next;
        }
        elsif ($field eq 'CITY')
        {
          store($handle, 'CITY', $value);
          print "XX8 $datum\n";
          next;
        }
        elsif ($field eq 'LOCALITY')
        {
          store($handle, 'LOCALITY', $value);
          print "XX9 $datum\n";
          next;
        }
        elsif ($field eq 'FLUFF')
        {
          store($handle, 'FLUFF', $value);
          next;
        }
        elsif ($field eq 'SYSTEM')
        {
          store($handle, 'SYSTEM', $value);
          next;
        }
        elsif ($field eq 'CONVENTIONS')
        {
          store($handle, 'CONVENTIONS', $value);
          next;
        }
        elsif ($field eq 'FIRSTFIRST' ||
            $field eq 'FIRSTMID' ||
            $field eq 'FIRSTBBO')
        {
          store($handle, 'FIRST', $value);
          $name_seen = 1;
          next;
        }
        elsif ($field eq 'LASTLAST' ||
            $field eq 'LASTMID' ||
            $field eq 'LASTBBO')
        {
          store($handle, 'LAST', $value);
          $name_seen = 1;
          next;
        }

        print "WW9 $datum\n";
      }
      elsif ($chain->last() == 1)
      {
        my $token0 = $chain->check_out(0);
        my $field0 = $token0->field();
        my $value0 = $token0->value();

        my $token1 = $chain->check_out(1);
        my $field1 = $token1->field();
        my $value1 = $token1->value();

        if (($field0 eq 'FIRSTFIRST' ||
            $field0 eq 'FIRSTMID' ||
            $field0 eq 'FIRSTBBO') &&
            ($field1 eq 'LASTLAST' ||
            $field1 eq 'LASTMID' ||
            $field1 eq 'LASTBBO'))
        {
          store($handle, 'FIRST', $value0);
          store($handle, 'LAST', $value1);
          $name_seen = 1;
          print "YY1 $datum\n";
          next;
        }
        elsif (($field1 eq 'FIRSTFIRST' ||
            $field1 eq 'FIRSTMID' ||
            $field1 eq 'FIRSTBBO') &&
            ($field0 eq 'LASTLAST' ||
            $field0 eq 'LASTMID' ||
            $field0 eq 'LASTBBO'))
        {
          store($handle, 'FIRST', $value1);
          store($handle, 'LAST', $value0);
          $name_seen = 1;
          print "YY2 $datum\n";
          next;
        }
      }

      if ($name_seen)
      {
        print "ZZ1 $datum\n";
      }

      if ($#values > 3)
      {
        print "ZZ2 $datum\n";
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


