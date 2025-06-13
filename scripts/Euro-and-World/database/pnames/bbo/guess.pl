#!perl
use strict;
use warnings;
use utf8;
use feature 'unicode_strings';
use Encode;
use Encode::HanExtra;
use Encode::Detect::Detector;
use Encode::Guess;


# Encode::Guess->set_suspects(qw/utf8 windows-1254 gb18030 iso-8859-9 windows-1252/);


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

my %LOCAL_SUBS =
(
  BARCANERA => {ZhangZhou => 'Zhou ZHANG'}
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

my @tmp;
split_into_components($fields[$i+1], \@tmp);
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
      $datum =~   s/^[!\-+:;'"@?\(\)\{\}\[\]<>*.,=#%&\/\$]+\s*//;
      $datum =~ s/\s*[!\-+:;'"@?\(\)\{\}*.,=#%&\/\$]+$//;

      next unless length($datum) > 0;
      next if $datum =~ /^[!_\-+:\(\)*.,=%\/\$'"@?#x\s]+$/;

next;
      guess_string_type($handle, $datum, 0);

      # A targeted way to make fixes.
      if (exists $LOCAL_SUBS{$handle})
      {
        for my $tofix (keys %{$LOCAL_SUBS{$handle}})
        {
          $datum =~ s/$tofix/$LOCAL_SUBS{$handle}{$tofix}/;
        }
      }

      if ($datum =~ /^A$/)
      {
        print "HERE\n";
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
      my @values = ($datum);
      my @texts = ($datum);

      split_on_multi($whole, \@TAG_ORDER, 0, \@tags, \@values, \@texts);

      # Split on separators.
      my $sep = qr/[\s+\-\+\.,_:;&@"\/\(\)\|]/;

      my $token_no = 0;
      my $unsolved_flag = 0;
      my $chain = Chain->new();

      # Make the chain.
      for my $i (0 .. $#values)
      {
        if ($tags[$i] ne '0')
        {
          # We had a multi-word hit.
          append_token($chain, 'SINGLETON', $tags[$i], $values[$i],
            $texts[$i], \$token_no, $histo, '');
          next;
        }

        # Split further.
        my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
        my $i = 0;
        foreach my $value (@a)
        {
          if (study_component($whole, \@TAG_ORDER, $value, \$token_no, 
            $chain, $histo))
          {
            next;
          }

          if ($i == 0 && 
             (length($value) >= 3 && $value =~ /^[0-9](\p{Word}+)$/) ||
             (length($value) >= 5 && $value =~ /^[A-Z](\p{Word}+)$/))
          {
            # It happens that there is a leading 0-9 or A-Z.
            my $rest = $1;
            if (study_component($whole, \@TAG_ORDER, $rest, \$token_no, 
              $chain, $histo))
            {
              next;
            }
          }
        
          append_token($chain, 'UNKNOWN', '', $value, $value,
            \$token_no, $histo, '');

          print "SSS value $value\n";
          $unsolved_flag = 1;
        }
      }

      for my $i (0 .. $chain->last())
      {
        consolidate_names($chain->check_out($i));
      }

      if ($chain->last() == 0)
      {
        my $match_field = match_single_word($handle, $chain);
        if ($match_field eq '')
        {
          print "WW9 $datum\n";
          my $value = $values[0];
        }
        else
        {
          $country_seen = 1 if $match_field eq 'COUNTRY';
          $name_seen = 1 if $match_field eq 'NAME';

          $chain->complete('COMPLETE');
          next;
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

        if ($field0 eq 'FIRST' && $field1 eq 'LAST')
        {
          store($handle, 'FIRST', $value0);
          store($handle, 'LAST', $value1);
          $chain->complete('COMPLETE');
          $name_seen = 1;
          next;
        }
        elsif ($field1 eq 'FIRST' && $field0 eq 'LAST')
        {
          store($handle, 'FIRST', $value1);
          store($handle, 'LAST', $value0);
          $chain->complete('COMPLETE');
          $name_seen = 1;
          print "YY2 $datum\n";
          next;
        }
      }

      next if $chain->status() eq 'COMPLETE';

      if ($#values > 3)
      {
        print "ZZ2 $datum\n";
      }

      push @info, "GENERIC $datum";
    }

next;

    for my $inf (@info)
    {
      print "$inf\n";
    }

    for my $key (sort keys %{$players{$handle}})
    {
      print "KEY $key ", join(' ', @{$players{$handle}{$key}}), "\n";
    }
    print "---\n\n";

    $i++;
  }
}

$histo->print();


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


sub split_into_components
{
  my ($text, $list) = @_;
  my @parts = split /([\x01-\x1F])/, $text;

  push @$list, { CHARSET => 0, TEXT => shift @parts };
  
  while (@parts) 
  {
    my $sep = shift @parts;
    my $chunk = shift @parts // '';
    push @$list, { CHARSET => ord($sep), TEXT => $chunk };

    my $ascii = ($chunk =~ tr/\x00-\x7F//);
    my $total = length($chunk);
    my $high = $total - $ascii;
    next if $high == 0;

    
    my $encoding = guess_string_type('', $text, 0);
    my $decoded;
    if ($encoding eq 'FAILED')
    {
      $decoded = $chunk;
    }
    else
    {
      $decoded = decode($encoding, $chunk, Encode::FB_CROAK);
    }


    # my $encoding = Encode::Guess->guess($chunk);
    # my $decoded;

    # if (ref($encoding)) 
    # {
      # my $decoded = $encoding->decode($chunk);

      binmode(STDOUT, ":encoding(UTF-8)");
      printf("CHARSET %2d ENCODING %-15s TEXT %s\n", 
        ord($sep), $encoding, $decoded);
    # } 
    # else 
    # {
      # warn "Could not guess encoding for $chunk: $encoding";
    # }


  }
}



sub guess_string_type
{
  my ($handle, $str, $recursing) = @_;

  my $upper = ($str =~ tr/A-Z//);
  my $lower = ($str =~ tr/a-z//);
  my $digit = ($str =~ tr/0-9//);
  my $ascii = ($str =~ tr/\x00-\x7F//);
  my $total = length($str);
  my $high = $total - $ascii;

  # if ($ascii == 0  && $high > 2)
  {
    # print "NONPRINTING? $str\n";

    my $encoding = Encode::Detect::Detector::detect($str);
    if (defined $encoding) 
    {
      # print "  Detected encoding: $encoding\n";

      # Decode the raw string to Perl's internal Unicode format
      my $decoded;
      eval 
      {
        $decoded = decode($encoding, $str, Encode::FB_CROAK);
      };
      if ($@) 
      {
        if (! $recursing)
        {
          my $str2 = substr($str, 1);
          return guess_string_type($handle, $str2, 1);
        }
        else
        {
          warn "  Handle $handle [$recursing] decode failed with $encoding: $@";
        }
      } 
      else 
      {
        # Set STDOUT to UTF-8 so it prints properly
        binmode(STDOUT, ":encoding(UTF-8)");
  
        # Print decoded Unicode string
        print "$encoding;$decoded\n";
        return $encoding;
        # print "  Decoded string: $decoded\n";
      }
    } 
    else 
    {
      warn "  Encoding could not be detected.\n";
    }
  }
  return 'FAILED';
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


sub consolidate_names
{
  my ($token) = @_;
  my $field = $token->field();

  if ($field eq 'FIRSTFIRST' ||
      $field eq 'FIRSTMID' ||
      $field eq 'FIRSTBBO')
  {
    $token->set_field('FIRST');
  }
  elsif ($field eq 'LASTLAST' ||
      $field eq 'LASTMID' ||
      $field eq 'LASTBBO')
  {
    $token->set_field('LAST');
  }
}


sub study_component
{
  my ($whole, $tag_order, $value, $pos, $chain, $histo) = @_;

  if (singleton_non_tag_matches_basic(
    $value, $pos, $chain, $histo, ''))
  {
    return 1;
  }
  elsif (singleton_tag_matches_basic($whole, $tag_order,
    $pos, $value, 0, $chain, $histo, ''))
  {
    return 1;
  }
  else
  {
    return 0;
  }
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
      $field eq 'CONVENTIONS' ||
      $field eq 'LETTER' ||
      $field eq 'NUMERAL' ||
      $field eq 'YEAR')
  {
    store($handle, $field, $value);
    return $field;
  }
  elsif ($field eq 'FIRST')
  {
    store($handle, 'FIRST', $value);
    return 'NAME';
  }
  elsif ($field eq 'LAST')
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
      return if lc($stored) eq lc($value);
    }
  }

  push @{$players{$handle}{$key}}, $value;
}


