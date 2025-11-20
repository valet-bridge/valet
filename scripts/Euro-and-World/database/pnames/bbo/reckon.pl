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


# This is the one with names etc.
use WholeBBO;
my $whole_names = WholeBBO->new();
$whole_names->init_hashes;

# This is system-oriented.
use WholeBBO2;
my $whole_system = WholeBBO2->new();
$whole_system->init_hashes;

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
  'UNDO' => 'Manual/noundos.txt',
  'FINAL' => 'Manual/final.txt'
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

# OK as last names specifically as First Last (3 units).
my $last3_names = Manual::TargetedWords->new();
$last3_names->read_file('Manual/last3.txt');

# Perhaps sloppier attempt at first names not otherwise found.
my $first1_names = Manual::TargetedWords->new();
$first1_names->read_file('Manual/first1.txt');

use Manual::SubLines;
$sublines = Manual::SubLines->new();
$sublines->read_file('Manual/sub_lines.txt');
# $sublines->consolidate_with('df1');
# $sublines->print();
# exit;


my $file = 'db';
my $data;
read_raw_file($file, \$data);

my @chunks = split /\x00+/, $data;
my @paragraphs;

raw_to_paragraphs(\@chunks, \@paragraphs);

my %chain_stats;
my %handle_counts;
my %cat_hist;

for my $paragraph (@paragraphs)
{
# if ($paragraph->{HANDLE} eq 'STOXI11')
if ($paragraph->{HANDLE} =~ /AUGUSTINHA/)
{
  # print "HERE\n";
}
  $handle_counts{$paragraph->{HANDLE}}++;
  Inspect::inspect_paragraph($whole_names, $whole_system, 
    $first1_names, $last3_names,
    $paragraph, \@PRE_INSPECTED_ORDER, 
    \%handle_counts, $histo, \%chain_stats);

  # print_paragraph($paragraph);

  my $lno = -1;
  for my $entry (@{$paragraph->{LINES}})
  {
    $lno++;

    my $handle = $paragraph->{HANDLE};
    my $hcount = $handle_counts{$paragraph->{HANDLE}};

    my $identifier = "YYY $handle, $hcount, $lno\n" .
      $entry->{TEXT} . "\n" .
      $entry->{TEXT} . "\n\n";

    if ($identifier =~ /0REINE57, 1/)
    {
      # print "HERE\n";
    }


    # Heavily curated.
    if ($entry->{CATEGORY} ne 'OPEN')
    {
      # This happens a lot: From 2.1 mio down to 60k cases.
      register_categories($entry, $identifier, \%cat_hist);
      next;
    }

    my $chain = Chain->new();
    my @chains;
    push @chains, $chain;

    my @list;
    lines_to_list($entry, \@list);

    # my $handle = $paragraph->{HANDLE};
    # my $hcount = $handle_counts{$paragraph->{HANDLE}};

    # my $identifier = "YYY $handle, $hcount, $lno\n" .
      # $entry->{TEXT} . "\n" .
      # $entry->{TEXT} . "\n\n";

    my @battery;
    $battery[0] = Units->new();
    list_to_units_no_punctuation($whole_names,
      \@list, $battery[0], $histo, \%chain_stats);

    # If we were still debugging and looking for system lines,
    # this would be the place to continue.
    # list_to_units($whole_system, \@UNIT_TAGS, \@list, $battery[0],
      # $entry->{TEXT}, $histo, \%chain_stats);

    # if ($entry->{TEXT} =~ /Plunkett/)
    # {
      # print "HERE\n";
    # }

    my @name_list;
    if (! Inspect::study_name($battery[0], $whole_names, 
      $first1_names, $last3_names,
      1, \@name_list, $identifier, $histo) ||
      $#name_list < 0)
    {
      # warn "$identifier: Should be a name, $#name_list";
      print "$identifier: Should be a name, $#name_list\n";
      print_list(\@name_list, $identifier);
      next;
    }

    $entry->{CATEGORY} = 'LIST';
    @{$entry->{LIST}} = @name_list;
    register_categories($entry, $identifier, \%cat_hist);
  }
}

print "\n\n";

my $sum = 0;
for my $k (qw(NAMELIKE NAME_BOTH UNKNOWN))
{
  printf("%-16s%10d\n", $k, $cat_hist{$k});
  $sum += $cat_hist{$k};
}
print '-' x 26, "\n";
printf("%-16s%10d\n\n", '', $sum);
exit;

print "\n";
$sum = 0;
for my $k (sort keys %cat_hist)
{
  printf("%-16s%10d\n", $k, $cat_hist{$k});
  $sum += $cat_hist{$k};
}
print '-' x 26, "\n";
printf("%-16s%10d\n\n", '', $sum);
exit;

printf("Lines %10d\n", $chain_stats{DATA});
printf("Parts %10d\n\n", $chain_stats{PARTS});

print_chain_stats_entry(\%chain_stats, 'Categories', 'CATEGORIES');
print_chain_stats_entry(\%chain_stats, 'Words', 'WORDS');
print_chain_stats_entry(\%chain_stats, 'High words', 'HIGH_WORDS');

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

      $paragraphs[$pno]{HANDLE} = $handle;

      for my $line (split /[\x00-\x1F]+/, $chunks[$cno+1])
      {
        next if $line =~ /^\s+$/;

        $line =~ s/^\s+//;
        $line =~ s/\s+$//;
        $line =~ s/\s{2,}/ /g;
        $line =~ s/^[!\-+:;'"@?\(\)\{\}\[\]<>*.,=#%&\/\$]+\s*//;
        $line =~ s/\s*[!\-+:;'"@?\(\)\{\}*.,=#%&\/\$]+$//;

        next if length($line) == 0;
        next if $line =~ /^[!_\-+:\(\)*.,=%\/\$'"@?#x\s]+$/;

        push @{$paragraphs[$pno]{LINES}},
          { CATEGORY => 'OPEN', TEXT => $line };
      }
      $pno++;
    }
  }
}
 

sub register_categories
{
  my ($entry, $identifier, $hist) = @_;

  my $flag = 0;

  if ($entry->{CATEGORY} eq 'LIST')
  {
    for (my $i = 0; $i <= $#{$entry->{LIST}}; $i += 2)
    {
      $hist->{$entry->{LIST}[$i]}++;
      # if ($entry->{LIST}[$i] =~ /^USER_UNPARSEABLE/)
      # {
        # print $identifier;
      # }
      if ($entry->{LIST}[$i] eq 'NAMELIKE' ||
          $entry->{LIST}[$i] eq 'NAME_BOTH' ||
          $entry->{LIST}[$i] eq 'UNKNOWN')
      {
        $flag = 1;
      }
    }
  }
  else
  {
    $hist->{$entry->{CATEGORY}}++;
    # if ($entry->{CATEGORY} =~ /^INT_/)
    # {
      # print $identifier;
    # }
    if ($entry->{CATEGORY} eq 'NAMELIKE' ||
        $entry->{CATEGORY} eq 'NAME_BOTH' ||
        $entry->{CATEGORY} eq 'UNKNOWN')
    {
      $flag = 1;
    }
  }

  if ($flag && 0)
  {
    # print $identifier;

    my $cstr;
    if ($entry->{CATEGORY} eq 'LIST')
    {
      my @cats;
      for (my $i = 0; $i <= $#{$entry->{LIST}}; $i += 2)
      {
        push @cats, $entry->{LIST}[$i];
      }
      $cstr = join ' - ', @cats;

    }
    else
    {
      $cstr = $entry->{CATEGORY};
    }

    # if ($cstr =~ / / && $cstr =~ /UNKNOWN/)
    # if ($cstr =~ /UNKNOWN/)
    # {
      print $identifier;
      print $cstr, "\n\n---\n\n";
    # }
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

   # Invocation from above:
   # study_line($whole_names, $whole_system, \@UNIT_TAGS, 
     # $entry, \@chains, $paragraph->{HANDLE}, 
     # $handle_counts{$paragraph->{HANDLE}}, $lno, 
     # $histo, \%chain_stats);

  my @list;
  lines_to_list($entry, \@list);
  return if $#list == -1; # COUNTRY, etc.

  my $identifier = "YYY $handle, $hcount, $lno\n" .
    $entry->{TEXT} . "\n" .
    $entry->{TEXT} . "\n\n";

  my @battery;
  $battery[0] = Units->new();
  list_to_units($whole_system, $unit_tags, \@list, $battery[0],
    $entry->{TEXT}, $histo, $chain_stats);

  my $units = $battery[0];

  print $identifier;

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

  # Don't get to here anymore.
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


sub print_chain_stats_entry
{
  my ($chain_stats, $name, $field) = @_;

  print "$name\n\n";
  my $sum = 0;
  for my $cat (sort keys %{$chain_stats->{$field}})
  {
    printf("%-20s%8d\n", $cat, $chain_stats->{$field}{$cat});
    $sum += $chain_stats->{$field}{$cat};
  }
  printf("\n%20s%8d\n", "Sum", $sum);
}

