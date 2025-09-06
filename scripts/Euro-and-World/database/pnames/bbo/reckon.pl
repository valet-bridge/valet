#!perl
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use feature 'unicode_strings';
use Encode;
use Encode::HanExtra;
use Encode::Detect::Detector;
use Encode::Guess;


# Encode::Guess->set_suspects(qw/utf8 windows-1254 gb18030 iso-8859-9 windows-1252/);


use lib '.';
use lib './Email';
use lib './Caps';
use lib './Sparse';
use lib '..';

use Carp::Assert;


my %INT_COUNTS;

my %PUNCTUATION =
(
  '-' => 'DASH',
  '+' => 'PLUS',
  '.' => 'POINT',
  '?' => 'QUESTION',
  '_' => 'UNDERSCORE',
  ',' => 'COMMA',
  ':' => 'COLON',
  ';' => 'SEMICOLON',
  '=' => 'EQUAL',
  '&' => 'AMPERSAND',
  '@' => 'AT_SIGN',
  '#' => 'HASH',
  '*' => 'ASTERISK',
  '%' => 'PERCENT',
  '$' => 'DOLLAR',
  '^' => 'CARET',
  '~' => 'TILDE',
  '"' => 'DOUBLEQUOTE',
  '/' => 'SLASH',
  '\\' => 'BACKSLASH',
  '(' => 'PAREN_LEFT',
  ')' => 'PAREN_RIGHT',
  '<' => 'LESS_THAN',
  '>' => 'GREATER_THAN',
  '|' => 'PIPE',
  '[' => 'SQUARE_LEFT',
  ']' => 'SQUARE_RIGHT',
  '{' => 'CURLY_LEFT',
  '}' => 'CURLY_RIGHT',
);

my @UNIT_TAGS = qw(
  DENOMINATIONS
  LENGTHS
  RANKS
  SHAPES
  STRENGTHS

  BASES
  OPENINGS
  CONSTRUCTIVE
  COMPETITIVE
  BLACKWOOD
  BERGEN
  MISC
  KEYCARD
  STAYMAN
  CARDING
);

my @TAG_ORDER = qw(
  BASES
  OPENINGS
  CONSTRUCTIVE
  COMPETITIVE
  AGAINSTNT
  KEYCARD
  CONVENTIONS
  CARDING
  SYSTEM

  FLUFF
  NOTNAMES

  COUNTRY
  REGION
  CITY
  LOCALITY
  NATIONALITY


  FIRSTFIRST
  FIRSTMID
  FIRSTBBO
  LASTLAST
  LASTMID
  LASTBBO
);

my @FIRST_ORDER = qw(
  FIRSTFIRST
  FIRSTMID
  FIRSTBBO
);

my @LAST_ORDER = qw(
  LASTLAST
  LASTMID
  LASTBBO
);

my @SEMANTIC_TAGS = qw(
  COUNTRY 
  REGION 
  CITY 
  LOCALITY 
  NATIONALITY
  NOTNAMES 
  FIRST 
  LAST
);

my %SYSTEM_TAGS_HASH =
(
  BASES => 1,
  OPENINGS => 1,
  CONSTRUCTIVE => 1,
  COMPETITIVE => 1,
  AGAINSTNT => 1,
  KEYCARD => 1,
  CONVENTIONS => 1,
  CARDING => 1,
);

my @CLUBS_FWD_LIKE = qw(c cl t tr);
my %CLUBS_FWD_LIKE_HASH;
$CLUBS_FWD_LIKE_HASH{$_} = 1 for @CLUBS_FWD_LIKE;

my @DIAMONDS_FWD_LIKE = qw(d di k ka);
my %DIAMONDS_FWD_LIKE_HASH;
$DIAMONDS_FWD_LIKE_HASH{$_} = 1 for @DIAMONDS_FWD_LIKE;

my @NOTRUMP_FWD_LIKE = qw(fa int ntp ntr nts sa sin sn snt);
my %NOTRUMP_FWD_LIKE_HASH;
$NOTRUMP_FWD_LIKE_HASH{$_} = 1 for @NOTRUMP_FWD_LIKE;

my %NOTRUMP_FWD_TWO_LIKE_HASH =
(
  n => { t => 1, trump => 1 },
  no => { trump => 1 },
  s => { t => 1 }
);

my @NOTRUMP_BWD_LIKE = qw(fa int n ntp ntr nts sa sans senza sn snt);
my %NOTRUMP_BWD_LIKE_HASH;
$NOTRUMP_BWD_LIKE_HASH{$_} = 1 for @NOTRUMP_BWD_LIKE;

my %NOTRUMP_BWD_TWO_LIKE_HASH =
(
  atout => { sans => 1},
  t => { n => 1, s => 1},
  trump => { no => 1 },
  trumps => { no => 1 }
);

# The next four are used to find "5-card majors".
my @CARDS_LIKE = qw(çrd ca car ccrd c cort cr crs cs cts
  k karr kkrt ko korst kr);
my %CARDS_LIKE_HASH;
$CARDS_LIKE_HASH{$_} = 1 for @CARDS_LIKE;

my @MAJOR_LIKE = qw(hs m ma mai may mg mgr mig mm moj mr ms
  sh m's naijor naj nb mobile nobl noble);
my %MAJOR_LIKE_HASH;
$MAJOR_LIKE_HASH{$_} = 1 for @MAJOR_LIKE;

my @CARDS_MAJOR_LIKE = qw(km crm crdsm);
my %CARDS_MAJOR_LIKE;
$CARDS_MAJOR_LIKE{$_} = 1 for @CARDS_MAJOR_LIKE;

my @ORDINAL_LIKE = qw(a in en);
my %ORDINAL_LIKE_HASH;
$ORDINAL_LIKE_HASH{$_} = 1 for @ORDINAL_LIKE;


my @POINTS_LIKE = qw(p ph ps ptsnt pys);
my %POINTS_LIKE_HASH;
$POINTS_LIKE_HASH{$_} = 1 for @POINTS_LIKE;

my %SEMANTIC_HASH;
$SEMANTIC_HASH{$_} = 1 for @SEMANTIC_TAGS;

# Permissive of some order changes.
# Other tags include DELETE and FLUFF.

my @POST_MAIL_ORDER = qw(
  OPEN
  PRIVATE
  SYSTEM

  LEVEL

  USER_TITLE
  USER_ONE
  USER_TWO

  USER_INITIALS
  USER_FIRST
  USER_INITIALS
  USER_PARTICLES
  USER_LAST

  USER_NUMERICAL
  USER_UNPARSEABLE
  EMAIL_CITY
  EMAIL_REGION
  EMAIL_COUNTRY
  EMAIL_UNIVERSITY
  EMAIL

  LEVEL

  CITY
  COUNTRY

  SYSTEM
  MAGIC
  CODE
);

# TODO Do something about Both.
# Probaby split into BothFirstish and BothLastish and BothUnclear.

# This is the one with name etc.
use WholeBBO;
my $whole = WholeBBO->new();
$whole->init_hashes;

# This is system-oriented.
use WholeBBO2;
my $whole2 = WholeBBO2->new();
$whole2->init_hashes;

use Units;
use Sparse::KeyResp;

# use CapSplit;
use Chain;
use Token;
use Util;
use Butil;
use LookFor;

use Inspect;

use Email::Email;

use Histo;
my $histo = Histo->new();

use UnitStats;
my $unit_stats = UnitStats->new();

###
### TODO We still have to look for COUNTRY etc.
###
###
### This is how to use a scan for the || format:

  # my %NAMES =
  # (
    # AAlankBondo => [ CATEGORY => 'NAME_FIRST', VALUE => 'Alan', CATEGORY => 'NAME_INITIALS', VALUE => 'K.', CATEGORY => 'NAME_LAST', VALUE => 'Bondo' ],
    # ...
  # );

    # if (exists $NAMES{$text})
    # {
      # @$splits = @{$NAMES{$text}};
      # return 1;
    # }


      # if (Caps::CapSplit::split_on_caps($whole, $unit_tags, $part, 
        # \@splits, $identifier))
      # {
        # print $identifier;

        # for (my $i = 0; $i <= $#splits; $i += 4)
        # {
          # assert($splits[$i] eq 'CATEGORY', "Not a category");
          # assert($splits[$i+2] eq 'VALUE', "Not a value");

          # $units->push($splits[$i+1], $part, $splits[$i+3], 
            # $pos, $chain_stats);
        # }
      # }

my @HANDLE_SKIPS = qw(
  123 270357
);

my %HANDLE_SKIPS_HASH;
$HANDLE_SKIPS_HASH{$_} = 1 for @HANDLE_SKIPS;

use Manual::TargetedLines;

$fluffed_lines = Manual::TargetedLines->new();
$fluffed_lines->read_file('Manual/fluffed_lines.txt');

$known_names = Manual::TargetedLines->new();
$known_names->read_file('Manual/known_names.txt');

$late_mails = Manual::TargetedLines->new();
$late_mails->read_file('Manual/late_mails.txt');

use Manual::TargetedWords;

# Some words can be either first, last names or neither.
$both_last = Manual::TargetedWords->new();
$both_last->read_file('Manual/both_last.txt');

$both_neither = Manual::TargetedWords->new();
$both_neither->read_file('Manual/both_neither.txt');

# OK as last names specifically as First Last (3 units).
my $last3_names = Manual::TargetedWords->new();
$last3_names->read_file('Manual/last3.txt');


use Manual::SubLines;
$sublines = Manual::SubLines->new();
$sublines->read_file('Manual/sub_lines.txt');
# $sublines->consolidate_with('edit5');
# $sublines->print();
# exit;

# TODO Name//Place


my $file = 'db';
my $data;
read_raw_file($file, \$data);

my @chunks = split /\x00+/, $data;
my @paragraphs;

raw_to_paragraphs(\@chunks, \@paragraphs);

my %chain_stats;
my %handle_counts;

for my $paragraph (@paragraphs)
{
# if ($paragraph->{HANDLE} eq 'CAPERONE')
# {
  # print "HERE\n";
# }
  $handle_counts{$paragraph->{HANDLE}}++;
  Inspect::inspect_paragraph($whole, $paragraph, \%handle_counts);

  # print_paragraph($paragraph);

  # This caught many things, but is more of a linter.
  # check_tag_order($paragraph);

  my $lno = -1;
  for my $entry (@{$paragraph->{LINES}})
  {
    $lno++;

    # Heavily curated.
    next unless $entry->{CATEGORY} eq 'OPEN';

    my $chain = Chain->new();
    my @chains;
    push @chains, $chain;



    if (study_line($whole, $whole2, \@UNIT_TAGS, $entry, \@chains, 
      $paragraph->{HANDLE}, $handle_counts{$paragraph->{HANDLE}}, $lno, 
      $histo, $unit_stats, \%chain_stats))
    {
      next;
    }
  }

  # Make chains for each unstructured field (OPEN, SYSTEM),
  # make histograms, guess what the chains are.
  # structure_paragraph($whole, $paragraph);
  
  # Look at sub-chains where important system stuff has been found.
  # sub_system_chains($whole, $paragraph,
    # $handle_counts{$paragraph->{HANDLE}}, \%chain_stats);
}

$unit_stats->print();

printf("Lines %10d\n", $chain_stats{DATA});
printf("Parts %10d\n\n", $chain_stats{PARTS});

print "Categories\n\n";
my $ssum = 0;
for my $cat (sort keys %{$chain_stats{CATEGORIES}})
{
  printf("%-20s%8d\n", $cat, $chain_stats{CATEGORIES}{$cat});
  $ssum += $chain_stats{CATEGORIES}{$cat};
}
printf("\n%20s%8d\n", "Sum", $ssum);

print "\nWords\n\n";
$ssum = 0;
for my $word (sort keys %{$chain_stats{WORDS}})
{
  printf("%-20s%8d\n", $word, $chain_stats{WORDS}{$word});
  $ssum += $chain_stats{WORDS}{$word};
}
printf("\n%20s%8d\n", "Sum", $ssum);

print "High words\n\n";
$ssum = 0;
for my $word (sort keys %{$chain_stats{HIGH_WORDS}})
{
  printf("%-20s%8d\n", $word, $chain_stats{HIGH_WORDS}{$word});
  $ssum += $chain_stats{HIGH_WORDS}{$word};
}
printf("\n%20s%8d\n", "Sum", $ssum);

print "\nIntegers\n\n";
for my $k (sort {$a <=> $b} keys %INT_COUNTS)
{
  printf("%-16s%8d\n", $k, $INT_COUNTS{$k});
}

exit;

print "Chains ", $chain_stats{CHAINS}, "\n\n";
my $sum = 0;
my $sumprod = 0;
for my $i (0 .. $#{$chain_stats{LENGTHS}})
{
  my $c = $chain_stats{LENGTHS}[$i] // 0;
  printf("%2s %6d\n", $i, $c);
  $sum += $c;
  $sumprod += $c * $i;
}
printf("\nAverage %6.2f\n", $sumprod / $sum);

print "\nSubchains ", $chain_stats{SUBS}, "\n\n";
$sum = 0;
$sumprod = 0;
for my $i (0 .. $#{$chain_stats{SUBLENGTHS}})
{
  my $c = $chain_stats{SUBLENGTHS}[$i] // 0;
  printf("%2s %6d\n", $i, $c);
  $sum += $c;
  $sumprod += $c * $i;
}
printf("\nAverage %6.2f\n", $sumprod / $sum);

exit;

my $countries = 0;
my (@phist, @hhist);
my %uniques;
for my $paragraph (@paragraphs)
{
  $phist[$#{$paragraph->{LINES}}]++;
  $uniques{$paragraph->{HANDLE}}++;

  # if ($#{$paragraph->{LINES}} == 1)
  # {
    # print_paragraph($paragraph);
  # }

  for my $entry (@{$paragraph->{LINES}})
  {
    if ($entry->{CATEGORY} eq 'COUNTRY')
    {
      $countries++;
      last;
    }
  }

  # my $num_open = 0;
  # for my $entry (@{$paragraph->{LINES}})
  # {
    # if ($entry->{CATEGORY} eq 'OPEN')
    # {
      # $num_open++;
    # }
  # }


  # if ($num_open > 1)
  # {
    # print_paragraph($paragraph);
  # }
}

exit;


sub read_raw_file
{
  my ($file, $data) = @_;

  open(my $fh, "<:raw", $file) or die "Cannot open $file$!";
  local $/;
  $$data = <$fh>;
  close $fh;
}


sub raw_to_paragraphs
{
  my ($chunks, $paragraphs) = @_;

  my $pno = 0;
  for my $cno (0 .. $#chunks)
  {
    if ($chunks[$cno] =~ /^P([A-Z0-9 _]+)$/)
    {
      my $handle = $1;
      if ($handle =~ /^ZZZZ_\d+$/)
      {
        # Skipping anonymous handle.
        $cno++;
        next;
      }

      next if exists $HANDLE_SKIPS_HASH{$handle};

      $paragraphs[$pno]{HANDLE} = $handle;

      for my $line (split /[\x00-\x1F]+/, $chunks[$cno+1])
      {
        next if $line =~ /^\s+$/;

        $line =~ s/^\s+//;
        $line =~ s/\s+$//;
        $line =~ s/\s{2,}/ /g;
        $line =~ s/^[!\-+:;'"@?\(\)\{\}\[\]<>*.,=#%&\/\$]+\s*//;
        $line  =~ s/\s*[!\-+:;'"@?\(\)\{\}*.,=#%&\/\$]+$//;

        next if length($line) == 0;
        next if $line =~ /^[!_\-+:\(\)*.,=%\/\$'"@?#x\s]+$/;

        push @{$paragraphs[$pno]{LINES}},
          { CATEGORY => 'OPEN', TEXT => $line };
      }
      $pno++;
    }
  }
}


sub make_chain
{
  my ($whole, $datum, $chain) = @_;

  my @tags = (0);
  my @values = ($datum);
  my @texts = ($datum);

  split_on_multi($whole, \@TAG_ORDER, 0, \@tags, \@values, \@texts);

  # Split on separators.
  my $sep = qr/[\s+\-\+\.,_:;&@"\/\(\)\|]/;

  my $token_no = 0;
  # my $unsolved_flag = 0;

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

      # print "SSS value $value\n";
      # $unsolved_flag = 1;
    }
  }

  for my $i (0 .. $chain->last())
  {
    consolidate_names($chain->check_out($i));
  }
}


sub get_token_tag
{
  my ($token) = @_;

  if ($token->category() eq 'UNKNOWN')
  {
    return 'UNKNOWN';
  }
  else
  {
    return $token->field();
  }
}


sub make_chain_profile
{
  my ($chain, $profile) = @_;

  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    $profile->{get_token_tag($token)}++;
  }
}


sub print_chain_info
{
  my ($chain) = @_;

  my $semantics = '';
  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    my $tag = get_token_tag($token);
    print "$tag ";
    $semantics .= "SEMANTIC " . $token->value() . "\n" 
      if is_semantic($tag);
  }
  print "\n$semantics\n\n";
}


sub is_semantic
{
  my ($tag) = @_;
  return exists $SEMANTIC_HASH{$tag};
}


sub classify_chain_profile
{
  my ($chain, $profile, $datum) = @_;

  my $count = 1 + $chain->last();

  my $system_indicators = 0;
  for my $key (qw(BASES OPENINGS KEYCARD CONVENTIONS CARDING SYSTEM FLUFF))
  {
    $system_indicators += $profile->{$key} // 0;
  }

  my $semantic_indicators = 0;
  for my $key (qw(COUNTRY REGION CITY LOCALITY NATIONALITY
    NOTNAMES FIRST LAST))
  {
    $semantic_indicators += $profile->{$key} // 0;
  }

  if ($count > 4)
  {
    if ($semantic_indicators)
    {
       print "($system_indicators, $semantic_indicators): $datum\n";
       print_chain_info($chain);
    }
  }
}


sub print_sub_chains
{
  my ($chain, $profile, $datum, 
    $handle, $hcount, $lno, $chain_stats) = @_;

  my $count = 1 + $chain->last();
  $chain_stats->{LENGTHS}[$count]++;

  my $system_indicators = 0;
  for my $key (qw(BASES OPENINGS CONSTRUCTIVE COMPETITIVE
    AGAINSTNT KEYCARD CONVENTIONS CARDING))
  {
    $system_indicators += $profile->{$key} // 0;
  }

  return if $system_indicators == 0;
  return if $system_indicators == $count;

  print "($system_indicators of $count, $lno): $datum\n";

  # Build up the texts on which to split.
  my $pos = 0;
  my $last_hit = -1;
  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    my $tag = get_token_tag($token);

    next unless ($tag eq 'BASES' || $tag eq 'OPENINGS' ||
        $tag eq 'KEYCARD' || $tag eq 'CONVENTIONS' ||
        $tag eq 'CARDING' || $tag eq 'CONSTRUCTIVE' ||
        $tag eq 'COMPETITIVE' || $tag eq 'AGAINSTNT');
    
    my $substr = $token->text();
    my $index = index($datum, $substr, $pos);

    die "Substring '$substr' not found in expected order" if $index == -1;

    my $piece = substr($datum, $pos, $index - $pos);
    my $sub_len = $i - $last_hit;
    $last_hit = $i;
    $chain_stats->{SUBS}++;
    $chain_stats->{SUBLENGTHS}[$sub_len]++;

    if ($piece)
    {
      $piece =~ s/^[- ,:;.()&\/]+//;
      $piece =~  s/[- ,:;.()&\/]+$//;
      if ($piece)
      {

        # if ($sub_len >= 10)
        # {
          print "Y ($handle, $hcount, $lno): $datum\n";
          print "X '$piece',\n";
        # }
      }
    }

    $pos = $index + length($substr);
  }
  print "\n";
}


sub structure_paragraph
{
  my ($whole, $paragraph) = @_;

  for my $entry (@{$paragraph->{LINES}})
  {
    if ($entry->{CATEGORY} eq 'LIST')
    {
      my $len = $#{$entry->{LIST}};

      for (my $i = 0; $i <= $len; $i += 2)
      {
        if ($entry->{LIST}[$i] eq 'OPEN' ||
            $entry->{LIST}[$i] eq 'SYSTEM')
        {
          my $chain = Chain->new();
          make_chain($whole, $entry->{LIST}[$i+1], $chain);

          my %profile;
          make_chain_profile($chain, \%profile);

          classify_chain_profile($chain, \%profile, $entry->{LIST}[$i+1]);
        }
      }
    }
    elsif ($entry->{CATEGORY} eq 'OPEN' ||
        $entry->{CATEGORY} eq 'SYSTEM')
    {
      my $chain = Chain->new();
      my $datum = $entry->{VALUE} // $entry->{TEXT};
      make_chain($whole, $datum, $chain);

      my %profile;
      make_chain_profile($chain, \%profile);

      classify_chain_profile($chain, \%profile, $datum);
    }
  }

}


sub sub_system_chains
{
  my ($whole, $paragraph, $handle_count, $chain_stats) = @_;

  my $lno = -1;
  for my $entry (@{$paragraph->{LINES}})
  {
    $lno++;

    # if (exists $FLUFFED_LINES{$paragraph->{HANDLE}}{$handle_count}{$lno})
    # {
      # $entry->{CATEGORY} = 'FLUFF';
      # $entry->{VALUE} = $entry->{TEXT};
      # next;
    # }

    if ($entry->{CATEGORY} eq 'LIST')
    {
      my $len = $#{$entry->{LIST}};

      for (my $i = 0; $i <= $len; $i += 2)
      {
        if ($entry->{LIST}[$i] eq 'OPEN' ||
            $entry->{LIST}[$i] eq 'SYSTEM')
        {
          my $chain = Chain->new();
          make_chain($whole, $entry->{LIST}[$i+1], $chain);
          $chain_stats->{CHAINS}++;

          my %profile;
          make_chain_profile($chain, \%profile);

          print_sub_chains($chain, \%profile, $entry->{LIST}[$i+1],
            $paragraph->{HANDLE}, $handle_count, $lno, $chain_stats);
        }
      }
    }
    elsif ($entry->{CATEGORY} eq 'OPEN' ||
        $entry->{CATEGORY} eq 'SYSTEM')
    {
      my $chain = Chain->new();
      my $datum = $entry->{VALUE} // $entry->{TEXT};
      make_chain($whole, $datum, $chain);
      $chain_stats->{CHAINS}++;

      my %profile;
      make_chain_profile($chain, \%profile);

      print_sub_chains($chain, \%profile, $datum, 
        $paragraph->{HANDLE}, $handle_count, $lno, $chain_stats);
    }
  }
}


sub lines_to_list
{
  my ($entry, $list) = @_;

  if ($entry->{CATEGORY} eq 'LIST')
  {
    my $len = $#{$entry->{LIST}};
    for (my $i = 0; $i <= $len; $i += 2)
    {
      if ($entry->{LIST}[$i] eq 'OPEN' || 
          $entry->{LIST}[$i] eq 'SYSTEM')
      {
        push @$list, $entry->{LIST}[$i+1];
      }
    }
  }
  elsif ($entry->{CATEGORY} eq 'OPEN' || $entry->{CATEGORY} eq 'SYSTEM')
  {
    my $datum = $entry->{VALUE} // $entry->{TEXT};
    push @$list, $datum;
  }
}


sub list_to_units
{
  my ($whole, $unit_tags, $list, $units, 
    $text, $handle, $hcount, $lno, $histo, $chain_stats) = @_;

  for my $datum (@$list)
  {
    $chain_stats->{DATA}++;

    if ($datum =~ /#fake@/)
    {
      $units->push('FLUFF', $datum, $datum, 0, $chain_stats);
      return;
    }

    my $sep = qr/(\d+|[\s\-\+\.\?_,:;=&@#*%\$^~"\/\\()<>|\[\]\{\}])/;
    my @parts = grep { $_ ne '' } split /$sep/, $datum;

    my $pos = -1;
    my @splits;
    for my $part (@parts)
    {
      $pos++;
      $chain_stats->{PARTS}++;

      if (exists $PUNCTUATION{$part})
      {
        $units->push('PUNCTUATION', $part, $PUNCTUATION{$part},
          $pos, $chain_stats);
        next;
      }
      elsif ($part eq ' ')
      {
        $units->push('PUNCTUATION', $part, 'SPACE', $pos, $chain_stats);
        next;
      }
      elsif ($part =~ /^\d+$/)
      {
        $units->push_integer($part, $pos, $chain_stats);
        next;
      }
      else
      {
        my ($category, $value);
        categorize($whole, $unit_tags, $part, \$category, \$value);

        $units->push($category, $part, $value, $pos, $chain_stats);
      }
    }
  }
}


sub look_for_openings
{
  my ($units, $chain_stats) = @_;

  LookFor::look_for_opening($units, 'notrump', 'NT', 1, 3,
    \%NOTRUMP_FWD_LIKE_HASH, $chain_stats);

  # LookFor::look_for_opening($units, 'clubs', 'C', 1, 2,
    # \%CLUBS_FWD_LIKE_HASH, $chain_stats);

  LookFor::look_for_opening($units, 'diamonds', 'D', 1, 2,
    \%DIAMONDS_FWD_LIKE_HASH, $chain_stats);
}

sub study_word
{
  my ($whole_names, $word, $histo) = @_;

  my $token_no = 0;
  my $chain = Chain->new();
  my $first_flag = 0;
  my $last_flag = 0;

  if (singleton_tag_matches_basic($whole_names, \@FIRST_ORDER,
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    $first_flag = 1;
  }

  if (singleton_tag_matches_basic($whole_names, \@LAST_ORDER,
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    $last_flag = 1;
  }

  if ($first_flag && ! $last_flag)
  {
    return 'NAME_FIRST';
  }
  elsif (! $first_flag && $last_flag)
  {
    return 'NAME_LAST';
  }
  elsif ($first_flag && $last_flag)
  {
    if ($both_neither->lookup($word))
    {
      # Fall through.
      return '';
    }
    elsif ($both_last->lookup($word))
    {
      return 'NAME_LAST';
    }
    else
    {
      return 'NAME_FIRST';
    }
  }
  elsif ($word =~ /^[A-Za-z]$/)
  {
    return 'NAME_INITIAL';
  }
  else
  {
    return '';
  }
}


sub study_line
{
  my ($whole_names, $whole_system, $unit_tags, $entry, $chains, 
    $handle, $hcount, $lno, $histo, $unit_stats, $chain_stats) = @_;

  my @list;
  lines_to_list($entry, \@list);
  return if $#list == -1; # COUNTRY, etc.

  if ($#list == 0 && $list[0] !~ / /)
  {
    # Could be a single name.
    my $cat = study_word($whole_names, $list[0], $histo);
    if ($cat && $cat ne 'NAME_INITIAL')
    {
      $entry->{CATEGORY} = $cat;
      return;
    }
  }

my $identifier = "YYY $handle, $hcount, $lno\n" .
  $entry->{TEXT} . "\n" .
  $entry->{TEXT} . "\n\n";

if ($handle eq 'RJP1')
{
  # print "HERE\n";
}

  my @battery;
  $battery[0] = Units->new();
  list_to_units($whole_system, $unit_tags, \@list, $battery[0],
    $entry->{TEXT}, $handle, $hcount, $lno, $histo, $chain_stats);

  my $units = $battery[0];
  if ($units->last() == 2 &&
    $units->value(1) eq 'SPACE')
  {
    # Simple screen for names.
    my $cat0 = study_word($whole_names, $units->value(0), $histo);
    my $cat2 = study_word($whole_names, $units->value(2), $histo);

    if ($cat2 eq '' && $last3_names->lookup($units->value(2)))
    {
      $cat2 = 'NAME_LAST';
    }

    if ($cat0 eq 'NAME_FIRST' && $cat2 eq 'NAME_LAST')
    {
      # TODO Probably keep the identification somewhere?
      $entry->{CATEGORY} = 'NAMELIKE';
      return;
    }
    elsif ($cat0 eq 'NAME_FIRST' && $cat2 eq 'NAME_INITIAL')
    {
      # TODO Probably keep the identification somewhere?
      $entry->{CATEGORY} = 'NAMELIKE';
      return;
    }
    elsif ($cat0 eq '' && $cat2 eq 'NAME_LAST')
    {
      # print "XCAND ", lc($units->value(2)), "\n";
      # print $identifier;
    }
    else
    {
      # print $identifier;
      # my $s = (($cat0 eq '' ? 'NONE' : $cat0) . " " .
            # ($cat2 eq '' ? 'NONE' : $cat2) . "\n");
      # print $s;
      # print $identifier;
    }

    # The other way round (a) identifies only a small number, and
    # (b) needs to be curated.
    # print $identifier;
  }
  if ($units->last() == 4)
  {
    print $identifier;
  }

  look_for_openings($battery[0], $chain_stats);

  # look_for_bigrams($battery[0], $chain_stats);

  look_for_jac_mic($battery[0], 'Michaels', 'Cuebid', 'Michaels Cuebid',
    $chain_stats, $identifier);

  # my @streaks0;
  # $battery[0]->get_number_streaks(\@streaks0);
  # Sparse::KeyResp::look_for_responses($battery[0], \@streaks0,
    # \%INT_COUNTS, $chain_stats);

  my @streaks;
  $battery[0]->get_number_streaks(\@streaks);

  look_for_ranges($battery[0], \@streaks, $chain_stats, $identifier);

  look_for_notrump($battery[0], $chain_stats, $identifier);

  split_on_specifics(\@battery, $chain_stats, $identifier);

  if ($#battery >= 1)
  {
    # Assume it's a system line -- great assumption.
    # I've edited some with two units (so length 1).
    return;
  }

  my $longest = 0;
  for my $units (@battery)
  {
    my $l = $units->last()+1;
    $longest = $l if $l > $longest;
  }

  # Heavily curated.
  if ($entry->{CATEGORY} ne 'OPEN')
  {
    return;
  }

  if ($battery[0]->status() eq 'COMPLETE')
  {
    return;
  }

  if ($longest == 2 || $longest == 4 || $longest >= 6)
  {
    return;
  }


  if ($longest == 3)
  {
    # print $identifier;
  }

  # if ($#battery == 0 && $battery[0]->last() == 0)
  # {
    # print $identifier;
  # }

  for my $u (@battery)
  {
    $unit_stats->add($u, $identifier);
  }
  $unit_stats->add_unit_count(1 + $#battery);


return;

  # my @streaks;
  # $units->get_number_streaks(\@streaks);

  # The return value is the streak number, after which other
  # streak contents will no longer be valid.
  # Sparse::KeyResp::look_for_responses($units, \@streaks,
    # \%INT_COUNTS, $chain_stats);
}


sub locate_tag_number
{
  my ($start, $tag) = @_;

  for my $i ($$start .. $#POST_MAIL_ORDER)
  {
    if ($tag eq $POST_MAIL_ORDER[$i])
    {
      $$start = $i;
      return 1;
    }
  }
  return 0;

}


sub check_tag_order
{
  my ($paragraph) = @_;

  my $post_index = 0;

  for my $entry (@{$paragraph->{LINES}})
  {
    my $tag = $entry->{CATEGORY};
    next if $tag eq 'FLUFF'; # Always permitted
    next if $tag eq 'PRIVATE' || 
      $tag eq 'COUNTRY' ||
      $tag eq 'LEVEL'; # Manually checked
    if ($tag eq 'LIST')
    {
      for (my $i = 0; $i <= $#{$entry->{LIST}}; $i += 2)
      {
        my $list_tag = $entry->{LIST}[$i];
        next if $list_tag eq 'DELETE'; # Always permitted
        if (! locate_tag_number(\$post_index, $list_tag))
        {
          print_paragraph($paragraph);
          print "Did not find tag " .  $entry->{LIST}[$i] . " in order\n";
          print "---\n\n";
          return;
        }
      }
    }
    else
    {
      if (! locate_tag_number(\$post_index, $tag))
      {
        print_paragraph($paragraph);
        print "Did not find tag $tag in order\n";
        print "---\n\n";
        return;
      }
    }
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


sub print_paragraph
{
  my ($paragraph) = @_;

  print $paragraph->{HANDLE}, "\n";
  for my $entry (@{$paragraph->{LINES}})
  {
    if ($entry->{CATEGORY} eq 'LIST')
    {
      my $len = $#{$entry->{LIST}};

      for (my $i = 0; $i <= $len; $i += 2)
      {
        printf("%-12s %-12s %s\n", 
          $entry->{LIST}[$i],
          $entry->{LIST}[$i+1],
          $entry->{TEXT});
      }
    }
    else
    {
      printf("%-12s %-12s %s\n", 
        $entry->{CATEGORY},
        $entry->{VALUE} // '',
        $entry->{TEXT});
    }
  }
  print "\n";
}
