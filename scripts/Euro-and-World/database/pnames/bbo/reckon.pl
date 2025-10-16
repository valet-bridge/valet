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

use Chain;
use Token;
use Util;
use Butil;
use LookFor;

use Inspect;

use Email::Email;

use Histo;
my $histo = Histo->new();

# TODO Still need this?

my @HANDLE_SKIPS = qw(
  123 270357
);

my %HANDLE_SKIPS_HASH;
$HANDLE_SKIPS_HASH{$_} = 1 for @HANDLE_SKIPS;

use Manual::TargetedLines;

my %PRE_INSPECTED_LINES =
(
  'BEHAVIOR' => 'Manual/behaviors.txt',
  'PICKY' => 'Manual/nomultiples.txt',
  'FLUFF' => 'Manual/fluffed_lines.txt',
  'MAIL' => 'Manual/late_mails.txt', # Special case
  'NAMELIKE' => 'Manual/known_names.txt',
  'PRIVATE' => 'Manual/privates.txt',
  'PROFILE' => 'Manual/noprofiles.txt',
  'SYSTEM' => 'Manual/system_lines.txt',
  'UNDO' => 'Manual/noundos.txt'
);

# Just in order of frequency.
my @PRE_INSPECTED_ORDER = qw(
  NAMELIKE
  SYSTEM
  FLUFF
  PRIVATE
  PROFILE
  MAIL
  UNDO
  PICKY
  BEHAVIOR
);

Inspect::init_pre_inspected(\%PRE_INSPECTED_LINES);

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
# $sublines->consolidate_with('lev');
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
if ($paragraph->{HANDLE} eq 'LIBRAX')
{
  # print "HERE\n";
}
  $handle_counts{$paragraph->{HANDLE}}++;
  Inspect::inspect_paragraph($whole, $whole2, 
    $last3_names, $paragraph, \@PRE_INSPECTED_ORDER, 
    \%handle_counts, $histo, \%chain_stats);

  # print_paragraph($paragraph);

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
      $histo, \%chain_stats))
    {
      next;
    }
  }
}

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


sub lines_to_list_OLD
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


sub list_to_units_OLD
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


sub study_line
{
  my ($whole_names, $whole_system, $unit_tags, $entry, $chains, 
    $handle, $hcount, $lno, $histo, $chain_stats) = @_;

  my @list;
  lines_to_list_OLD($entry, \@list);
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
  list_to_units_OLD($whole_system, $unit_tags, \@list, $battery[0],
    $entry->{TEXT}, $handle, $hcount, $lno, $histo, $chain_stats);

  my $units = $battery[0];
  if ($units->last() == 2 &&
    $units->value(1) eq 'SPACE')
  {
    # TODO Use Inspect.pm::study_name
    #
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

  # if ($units->last() == 0)
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

  if ($entry->{CATEGORY} eq 'OPEN')
  {
    # Only because this is so heavily curated.
    $entry->{CATEGORY} = 'SYSTEM';
    # print $identifier;
    return;
  }

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

  if ($units->last() >= 2)
  {
    # With all the curation, this is a system line.
    return;
  }

  die;
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
  # This caught many things, but is more of a linter.

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
