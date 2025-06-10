#!perl
use strict;
use warnings;
use utf8;
use feature 'unicode_strings';

use lib '.';
use lib '..';

my @TAG_ORDER = qw(
  CONVENTIONS
  SYSTEM

  COUNTRY
  REGION
  CITY
  LOCALITY
  NATIONALITY

  FLUFF
  NOTNAMES

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
            # The first two are a simpler version of singleton_non_matches.
            if ($value =~ /^\d+$/)
            {
              append_token($chain, 'COUNTER', 'NUMERAL',
                $value, $value, \$token_no, $histo, '');
              next;
            }
            elsif ($value =~ /^[A-za-z]$/)
            {
              append_token($chain, 'COUNTER', 'LETTER',
                $value, $value, \$token_no, $histo, '');
              next;
            }

            # This is a simpler version of singleton_matches.
            my $found = 0;
            my $fix;
            for my $core_tag (@TAG_ORDER)
            {
              $fix = $whole->get_single($core_tag, lc($value));
              next unless defined $fix->{CATEGORY};
              my $tag = $fix->{CATEGORY};
              $found = $core_tag;
              last;
            }

            if ($found)
            {
              append_token($chain, 'SINGLETON', $found, $fix->{VALUE},
                lc($value), \$token_no, $histo, '');
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
        my $match_field = match_single_word($handle, $chain);
        if ($match_field eq '')
        {
          print "WW9 $datum\n";
          my $value = $values[0];

          # TODO Should be somehow above and not in this if().
          if (length($value) >= 3 && $value =~ /^[0-9](\p{Word}+)$/) 
          {
            my $rest = $1;
            my $found = 0;
            my $fix;
            for my $core_tag (@TAG_ORDER)
            {
              $fix = $whole->get_single($core_tag, lc($rest));
              next unless defined $fix->{CATEGORY};
              $found = $core_tag;
              last;
            }

            if ($found)
            {
              # TODO Modify the token.
            }
          }
          elsif (length($value) >= 5 && $value =~ /^[A-Z](\p{Word}+)$/) 
          {
            my $rest = $1;
            my $found = 0;
            my $fix;
            for my $core_tag (@TAG_ORDER)
            {
              $fix = $whole->get_single($core_tag, lc($rest));
              next unless defined $fix->{CATEGORY};
              $found = $core_tag;
              last;
            }

            if ($found)
            {
              # TODO Modify the token.
              print "WWW $value ($found)\n";
            }
          }
        }

        if ($match_field eq 'COUNTRY')
        {
          $country_seen = 1;
        }
        elsif ($match_field eq 'NAME')
        {
          $name_seen = 1;
        }
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


sub match_single_word
{
  # Return something useful if we matched.
  my ($handle, $chain) = @_;

  my $token = $chain->check_out(0);
  my $field = $token->field();
  my $value = $token->value();

  if ($field eq 'COUNTRY' ||
      $field eq 'REGION' ||
      $field eq 'CITY' ||
      $field eq 'LOCALITY' ||
      $field eq 'FLUFF' ||
      $field eq 'SYSTEM' ||
      $field eq 'CONVENTIONS')
  {
    store($handle, $field, $value);
    return $field;
  }
  elsif ($field eq 'FIRSTFIRST' ||
      $field eq 'FIRSTMID' ||
      $field eq 'FIRSTBBO')
  {
    store($handle, 'FIRST', $value);
    return 'NAME';
  }
  elsif ($field eq 'LASTLAST' ||
      $field eq 'LASTMID' ||
      $field eq 'LASTBBO')
  {
    store($handle, 'LAST', $value);
    return 'NAME';
  }

  return '';
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


