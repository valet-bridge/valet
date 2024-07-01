#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TitleBBO;

our @ISA = qw(Exporter);
our @EXPORT = qw(init_hashes set_overall_hashes 
  study_title pre_process_title post_process_title print_title_stats   
  all_used);

use lib '.';
use lib './Event';
# use lib './Components';

use Token;
use Separators;

use Event::Cookbook;

my @NEW_TAG_ORDER = qw(
  TNAME
  DESTROY
  TWORD
  MEET
  CLUB

  ORGANIZATION 
  ZONE 
  SPONSOR 
  COUNTRY 
  NATIONALITY
  REGION 
  CITY 
  QUARTER 
  UNIVERSITY 
  FORM 
  CAPTAIN 
  GENDER
  AGE
  SCORING
  PERSON
  ITERATOR
  STAGE
  TIME
  PARTICLE
  AMBIGUOUS
);

my (%MULTI_HITS);
my %HIT_STATS;

my $PREFIX = 'TITLE_';


sub make_field_record
{
  my ($text, $chain, $bbono, $record, $dupl_flag) = @_;

  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    my $field = $token->field();
    my $val = $token->value();

    if (! exists $record->{$field})
    {
      $record->{$field} = $val;
    }
    elsif ($dupl_flag && 
        $field ne 'TITLE_DESTROY' && 
        $record->{$field} ne $val)
    {
      print "$bbono, $text, $field: $record->{$field} vs $val\n";
    }
  }
}


sub make_complete_field_record
{
  my ($text, $chain, $bbono, $record) = @_;

  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    my $field = $token->field();
    my $val = $token->value();

    push @{$record->{$field}}, $val;
  }
}


sub is_small_ordinal
{
  my $part = pop;
  if
     ($part =~ /^(\d+)th$/i ||
      $part =~ /^(\d+)rth$/i ||
      $part =~ /^(\d+)st$/i ||
      $part =~ /^(\d+)rst$/i ||
      $part =~ /^(\d+)rd$/i ||
      $part =~ /^(\d+)er$/i ||
      $part =~ /^(\d+)e$/i ||
      $part =~ /^(\d+)eme$/i ||
      $part =~ /^(\d+)°$/i ||
      $part =~ /^(\d+)º$/i ||
      $part =~ /^(\d+)ª$/i ||
      $part =~ /^(\d+)nd$/i)
  {
    return $1;
  }
  elsif (lc($part) eq 'first')
  {
    return 1;
  }
  elsif (lc($part) eq 'second')
  {
    return 2;
  }
  else
  {
    return 0;
  }
}


sub fix_small_ordinal
{
  my ($part, $token) = @_;
  if (my $ord = is_small_ordinal($part))
  {
    # We don't check whether the ending matches the number.
    if ($ord >= 0 && $ord < 100)
    {
      $ord =~ s/^0+//; # Remove leading zeroes
      # $token->set_singleton('TITLE_ORDINAL', $ord);
      $token->set_ordinal_counter($ord);
      return 1;
    }
    else
    {
      die "Large ordinal? $part";
    }
  }
  else
  {
    return 0;
  }
}


sub split_on_trailing_digits
{
  my ($list_ref) = @_;

  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];
    next unless $part =~ /^(.*[a-z])(\d+)$/i;

    my ($letters, $digits) = ($1, $2);
    next if $letters eq 'U' || $letters eq 'D';
    next if $digits > 50;

    splice(@$list_ref, $i, 0, ('') x 2);
    $list_ref->[$i] = $letters;
    $list_ref->[$i+1] = '|';
    $list_ref->[$i+2] = $digits;
  }
}


sub title_specific_hashes
{
  my ($whole, $part, $token, $chain) = @_;

  for my $tag (@NEW_TAG_ORDER)
  {
    my $fix = $whole->get_single($tag, lc($part));
    if (defined $fix->{CATEGORY})
    {
      my $cat = $PREFIX . $fix->{CATEGORY};

      # my $w = $fix->{VALUE};
      # $MULTI_HITS{$tag}{lc($part)}++;
      # $MULTI_HITS{$tag}{lc($w)}++;

      $token->set_singleton($cat, $fix->{VALUE});
      # $HIT_STATS{$fix->{CATEGORY}}++;
      $HIT_STATS{$cat}++;

      if ($cat eq 'TITLE_GENDER' && $fix->{VALUE} eq 'Open')
      {
        # Special case: Add an extra token.
        my $token2 = Token->new();
        $token2->copy_origin_from($token);
        $token2->set_singleton($PREFIX . 'AGE', 'Open');
        $chain->append($token2);
        $HIT_STATS{$PREFIX . 'AGE'}++;
      }
      elsif ($cat eq 'TITLE_AGE' && $fix->{VALUE} eq 'Girls')
      {
        # Special case: Add an extra token.
        my $token2 = Token->new();
        $token2->copy_origin_from($token);
        $token2->set_singleton($PREFIX . 'GENDER', 'Women');
        $chain->append($token2);
        $HIT_STATS{$PREFIX . 'GENDER'}++;
      }

      return 1;
    }
  }
  return 0;
}


sub study_part
{
  my ($whole, $part, $i, $chain, $unknown_part_flag) = @_;

  my $token = Token->new();
  $token->set_origin($i, $part);
  $chain->append($token);

  $HIT_STATS{TOTAL}++;

  if (set_token($part, $token))
  {
    $token->set_singleton('SEPARATOR', $part);
    $HIT_STATS{SEPARATOR}++;
    return;
  }
  elsif ($part =~ /^\d+$/)
  {
    if ($part >= 1900 && $part < 2100)
    {
      $token->set_singleton('TITLE_YEAR', $part);
      $HIT_STATS{TITLE_YEAR}++;
    }
    else
    {
      $token->set_numeral_counter($part);
      # $token->set_singleton('TITLE_INTEGER', $part);
      $HIT_STATS{TITLE_INTEGER}++;
    }
    return;
  }
  elsif ($part =~ /^[A-HJa-h]$/)
  {
    $token->set_letter_counter($part);
    # $token->set_singleton('TITLE_LETTER', $part);
    $HIT_STATS{TITLE_LETTER}++;
    return;
  }
  elsif (fix_small_ordinal($part, $token))
  {
    $HIT_STATS{TITLE_ORDINAL}++;
    return;
  }

  # The general solution.
  return if title_specific_hashes($whole, $part, $token, $chain);

  # Some use of other hashes.
  my $fix_event = $FIX_HASH{lc($part)};

  if (defined $fix_event->{CATEGORY})
  {
    my $category = $fix_event->{CATEGORY};
    if ($category eq 'NUMERAL')
    {
      $token->set_numeral_counter($fix_event->{VALUE});
      # $token->set_singleton('TITLE_NUMERAL', $fix_event->{VALUE});
      $HIT_STATS{TITLE_NUMERAL}++;
      return;
    }
    elsif ($category eq 'ROMAN')
    {
      $token->set_roman_counter($fix_event->{VALUE});
      # $token->set_singleton('TITLE_ROMAN', $fix_event->{VALUE});
      $HIT_STATS{TITLE_ROMAN}++;
      return;
    }
  }

  $token->set_unknown_full($part);
  $HIT_STATS{UNMATCHED}++;
  print "QQQ ", $part, "\n";
  $$unknown_part_flag = 1;
}


sub split_on_some_numbers
{
  my ($text) = @_;

  if ($text =~ /1[\/_](\d)\s+final/i)
  {
    my $n = $1;
    warn "Haven't learned this yet: $text" unless $n == 2 || $n == 4;
    $text =~ s/1\/4 finale*/quarterfinal/;
    $text =~ s/1\/2 finale*/semifinal/;
  }

  # Years.
  $text =~ s/'(9\d)/19$1/g;
  $text =~ s/'(0\d)/20$1/g;
  $text =~ s/'(1\d)/20$1/g;

  # Nameless teams.
  $text =~ s/#\d+\s+vs*\s+#*\d+//;
  $text =~ s/tm\s+\d+\s+vs\s+tm\s+\d+//i;
  $text =~ s/team\s+\d+\s+vs\s+team\s+\d+//i;
  $text =~ s/- \d+ v \d+//i;

  $text =~ s/^(\d+)th([a-z])/$1th $2/i;
  $text =~ s/^([01]\d)([A-SU-Z])/20$1 $2/; # Kludge, avoid th
  $text =~ s/\b([1-9])([A-D])\b/$1 $2/gi;
  $text =~ s/\b(\d)of(\d)\b/$1 of $2/g;
  
  if ($text =~ /(\d+)[_&](\d+)/ && $1 <= $2 && $1 < 1990)
  {
    $text =~ s/(\d+)_(\d+)/$1 of $2/;
    $text =~ s/(\d+)&(\d+)/$1 to $2/;
  }

  # Doesn't really belong here.
  $text =~ s/pokal([a-z])/pokal $1/i;
  $text =~ s/-th\b/th/g;
  $text =~ s/(\d) th\b/$1th/g;
  $text =~ s/2 nd\b/2nd/g;
  $text =~ s/\bUSA[12]/USA/g;
  $text =~ s/\bUSA 2\b/USA/g;
  $text =~ s/II-nd/2nd/g;
  $text =~ s/\b(\d\d) _$/Rof$1/g;
  $text =~ s/\bF([12])\b/Final $1/g;

# my $t = $text;
# print "XERE $t | $text\n" unless $t eq $text;

  return $text;
}


sub split_on_capitals
{
  my ($text) = @_;

  my @words = split(/\s+/, $text);
  my @result;

  foreach my $word (@words) 
  {
    if ($word =~ /^[a-zA-Z]+$/ && $word !~ /[A-Z](?:[a-z]{0,1}[A-Z]|\z)/)
    {
      $word =~ s/(?<=[a-z])(?=[A-Z])/ /g;
    }

    # Do not split if the word contains a sub-word of length < 3
    push @result, $word;
  }

  return join(" ", @result);
}


sub split_on_multi
{
  my ($whole, $text, $parts, $tags) = @_;

  @$parts = split / - /, $text;
  @$tags = (0) x (1 + $#$parts);

  for my $i (reverse 0 .. $#$parts)
  {
    my @date_parts = 
      grep { $_ ne '' } split /(\d\d\d\d[-_]\d\d[-_]\d\d)/, $parts->[$i];

    if ($#date_parts > 0)
    {
      splice(@$parts, $i+1, 0, (0) x $#date_parts);
      splice(@$tags, $i+1, 0, (0) x $#date_parts);

      for my $j (0 .. $#date_parts)
      {
        if ($date_parts[$j] =~ /^\d\d\d\d[-_]\d\d[-_]\d\d$/)
        {
          $parts->[$i+$j] = $date_parts[$j];
          $tags->[$i+$j] = 'TITLE_DATE';
          $HIT_STATS{TITLE_DATE}++;
        }
        else
        {
          # Couldn't do this sooner, as it would destroy the date.
          my $t = $date_parts[$j];

          $t =~ s/20(\d\d)[\/\-_](\d\d)/20$1-20$2/;
          $t =~ s/(\d)\/(\d)/$1 of $2/g;
          $t =~ s/\b(\d)-(\d)/$1 to $2/g;
          $t =~ s/\b(0\d)\b/20$1/g;
          $t =~ s/(20\d\d)/ $1 /g;

          $parts->[$i+$j] = $t;
          $tags->[$i+$j] = 0;
        }
      }
    }
    else
    {
      my $t = $parts->[$i];

      $t =~ s/20(\d\d)[\/\-_](\d\d)\b/20$1-20$2/;
      $t =~ s/(\d)\/(\d)/$1 of $2/g;
      $t =~ s/\b(\d)-(\d)/$1 to $2/g;
      $t =~ s/\b(0\d)\b/20$1/g;
      $t =~ s/(20\d\d)/ $1 /g;

      $parts->[$i] = $t;
      $tags->[$i] = 0;
    }

    if ($i > 0)
    {
      # Make sure that elements on different sides of the ' - ' end up
      # in different chains.
      splice(@$parts, $i, 0, '');
      splice(@$tags, $i, 0, 'TITLE_DESTROY');
    }
  }

  for my $core_tag (@NEW_TAG_ORDER)
  {
    my $tag = $PREFIX . $core_tag;
    my $mregex = $whole->get_multi_regex($core_tag);

    next if $mregex eq '';
    for my $i (reverse 0 .. $#$parts)
    {
      next if $tags->[$i] ne '0';
      my @a = grep { $_ ne '' } split /$mregex/, $parts->[$i];

      if ($#a == 0)
      {
        # Optimize for this frequent special case.
        my $mp = $whole->get_multi($core_tag, lc($a[0]));
        if (defined $mp)
        {
          $parts->[$i] = $mp;
          $tags->[$i] = $tag;

          # my $w = $MULTI_WORDS{$tag}{lc($a[0])};
          # $MULTI_HITS{$tag}{lc($a[0])}++;
          # $MULTI_HITS{$tag}{lc($w)}++;
        }
      }
      else
      {
        splice(@$parts, $i, 1, @a);
        splice(@$tags, $i, 1, (0) x ($#a+1));

        for my $j ($i .. $i + $#a)
        {
          my $mp = $whole->get_multi($core_tag, lc($parts->[$j]));
          if (defined $mp)
          {
            $parts->[$j] = $mp;
            $tags->[$j] = $tag;

            # my $w = $MULTI_WORDS{$tag}{lc($parts->[$j])};
            # $MULTI_HITS{$tag}{lc($parts->[$j])}++;
            # $MULTI_HITS{$tag}{lc($w)}++;
          }
        }
      }
    }
  }
}

sub study_component
{
  my ($whole, $part, $chain, $token_no, $unsolved_flag) = @_;

  # Split on trailing digits.
  my $unknown_part_flag = 0;
  if ($part =~ /^(.*[a-z])(\d+)$/i &&
      $1 ne 'U' && $1 ne 'D')
  {
    my ($letters, $digits) = ($1, $2);

    study_part($whole, $letters, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;

    study_part($whole, $digits, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;
  }
  else
  {
    study_part($whole, $part, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;
  }

  $$unsolved_flag = 1 if $unknown_part_flag;
}


sub study_title
{
  my ($whole, $text, $chain, $unknowns, $bbono) = @_;

  return if $text eq '';

  my $ntext = split_on_some_numbers($text);

  my $stext = split_on_capitals($ntext);

  my @parts = ();
  my @tags = (0);
  split_on_multi($whole, $stext, \@parts, \@tags);

  # Split on separators.
  my $sep = qr/[\s+\-\+\._:;&@"\/\(\)\|]/;

  my $token_no = 0;
  my $unsolved_flag = 0;

  for my $i (0 .. $#parts)
  {
    if ($tags[$i] ne '0')
    {
      # We had a multi-word hit.
      my $token = Token->new();
      $token->set_origin($i, $parts[$i]);
      $token->set_singleton($tags[$i], $parts[$i]);
      $chain->append($token);
      $token_no++;
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $parts[$i]);
      foreach my $part (@a)
      {
        study_component($whole, $part, $chain, \$token_no, \$unsolved_flag);
      }
    }
  }

  print "TTT $bbono: $text\n" if ($unsolved_flag && $chain->last() > 0);
  print "\n" if $unsolved_flag;
}


sub print_title_stats
{
  for my $key (sort keys %HIT_STATS)
  {
    printf("%-20s %6d\n", $key, $HIT_STATS{$key});
  }

  print "\n";
}


sub all_used
{
  my ($whole) = @_;

  print "Multis:\n\n";
  for my $key (@NEW_TAG_ORDER)
  {
    for my $entry ($whole->sorted_mwords())
    {
      if (! defined $MULTI_HITS{$key}{$entry})
      {
        print "$key: $entry\n";
      }
    }
  }

  print "\nSingles\n\n";
  for my $key (@NEW_TAG_ORDER)
  {
    for my $entry ($whole->sorted_swords())
    {
      if (! defined $MULTI_HITS{$key}{$entry})
      {
        print "$key: $entry\n";
      }
    }
  }
}


my %VS_VALID =
(
  TITLE_COUNTRY => 1,
  TITLE_CITY => 1,
  TITLE_GENDER => 1,
  TITLE_AGE => 1,
  TITLE_CAPTAIN => 1
);

my %VS_DESTROY =
(
  TITLE_DESTROY => 1
);

sub get_vs_extent
{
  my ($chain, $center, $hash, $first, $last) = @_;

  # If the chain does not go all the way to the front, split.
  $$first = $center;
  for my $j (reverse 0 .. $center-1)
  {
    my $token0 = $chain->check_out($j);
    my $cat = $token0->category();
    my $field = $token0->field();
    if ($cat eq 'SINGLETON' && exists $hash->{$field})
    {
      $$first = $j;
    }
    else
    {
      last;
    }
  }

  # If the chain does not go all the way to the back, split.
  $$last = $center;
  for my $j ($center+1 .. $chain->last())
  {
    my $token1 = $chain->check_out($j);
    my $cat = $token1->category();
    my $field = $token1->field();
    if ($cat eq 'SINGLETON' && exists $hash->{$field})
    {
      $$last = $j;
    }
    else
    {
      last;
    }
  }
}


sub process_vs_extent
{
  my ($chains, $chain, $cno, $first, $last, $completion) = @_;

  if ($first > 0)
  {
    my $chain1 = Chain->new();
    $chain->copy_from($first, $chain1);
    $chain->delete($first, $chain->last());
    splice(@$chains, $cno+1, 0, $chain1);

    $chain = $chain1;
    $cno++;
  }

  if ($last < $chain->last())
  {
    my $chain2 = Chain->new();
    $chain->copy_from($last+1, $chain2);
    $chain->delete($last+1, $chain->last());
    splice(@$chains, $cno+1, 0, $chain2);
  }

  $chain->complete_if_last_is($chain->last(), $completion);
}


sub pre_process_vs
{
  my ($chains) = @_;

  my $chain = $chains->[0];
  return unless $chain->last() >= 2;
  my $cno = 0;

  my $token = $chain->check_out(0);
  if ($token->category() eq 'SINGLETON' &&
      $token->field() eq 'TITLE_PARTICLE' &&
      $token->value() eq 'vs')
  {
    # A leading VS happens a few times.
    my $chain2 = Chain->new();
    $chain->copy_from(1, $chain2);
    $chain->truncate_directly_before(1);
    $chain->complete_if_last_is(0, 'DESTROY');
    splice(@$chains, 1, 0, $chain2);

    $cno = 1;
    $chain = $chain2;
    return unless $chain->last() >= 2;
  }

  for my $i (1 .. -1 + $chain->last())
  {
    my $token = $chain->check_out($i);
    next unless $token->category() eq 'SINGLETON' &&
      $token->field() eq 'TITLE_PARTICLE' &&
      $token->value() eq 'vs';

    my ($first, $last);
    get_vs_extent($chain, $i, \%VS_VALID, \$first, \$last);

    if ($first < $i && $last > $i)
    {
      process_vs_extent($chains, $chain, $cno, $first, $last, 'COMPLETE');
      last;
    }

    get_vs_extent($chain, $i, \%VS_DESTROY, \$first, \$last);

    if ($first < $i && $last > $i)
    {
      process_vs_extent($chains, $chain, $cno, $first, $last, 'KILLED');
      last;
    }
  }
}


sub pre_process_title
{
  my ($chains) = @_;

  # At this point there is a single chain.
  # It's easier to solve for the team vs team chain here.

  pre_process_vs($chains);

}


sub ordinalize
{
  my ($value) = @_;

  my $last = substr($value, -1);

  if ($last == 1)
  {
    return $value . 'st';
  }
  elsif ($last == 2)
  {
    return $value . 'nd';
  }
  elsif ($last == 3)
  {
    return $value . 'rd';
  }
  else
  {
    return $value . 'th';
  }
}


sub post_process_first_numeral
{
  my ($chains) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    return if $chain->status() eq 'COMPLETE';
    return if $chain->last() > 0;

    my $token = $chain->check_out(0);
    return unless $token->category() eq 'COUNTER';
    return unless $token->field() eq 'NUMERAL';

    # So now we have the first open chain, and it consists
    # of one COUNTER which we turn into an ORDINAL and complete.

    my $value = ordinalize($token->value());
    $token->set_ordinal_counter($value);
    $chain->complete_if_last_is(0, 'COMPLETE');

    return;
  }
}


my %LAST_NUM_DESTROY =
(
  TITLE_CAPTAIN => 1,
  TITLE_CITY => 1,
  TITLE_COUNTRY => 1,
  TITLE_DESTROY => 1,
  TITLE_FORM => 1,
  TITLE_TNAME => 1,
  TITLE_TWORD => 1,
  TITLE_YEAR => 1
);


sub post_process_last_numeral
{
  my ($chains) = @_;

  return unless $#$chains >= 1;
  my $chain1 = $chains->[-1];
  return unless $chain1->status() eq 'OPEN';
  return unless $chain1->last() == 0;

  my $token1 = $chain1->check_out(0);
  return unless $token1->category() eq 'COUNTER' &&
    $token1->field() eq 'NUMERAL';

  my $chain0 = $chains->[-2];
  my $token0 = $chain0->check_out($chain0->last());

  if (exists $LAST_NUM_DESTROY{$token0->field()})
  {
    $chain1->complete_if_last_is(0, 'DESTROY');
  }
}


my %NUM_VALID =
(
  TITLE_AGE => 1,
  TITLE_GENDER => 1,
  TITLE_FORM => 1,
  TITLE_STAGE => 1,
  TITLE_TNAME => 1,
  TITLE_TWORD => 1,
  TITLE_DESTROY => 1
);

sub post_process_last_iterator
{
  my ($chains) = @_;

  # Check whether a lone iterator is preceded by certain tokens,
  # in which case it is destroyed.
  return unless $#$chains >= 1;
  my $chain1 = $chains->[-1];
  return unless $chain1->status() eq 'OPEN';
  return unless $chain1->last() == 0;

  my $token1 = $chain1->check_out(0);
  return unless $token1->category() eq 'SINGLETON' &&
    $token1->field() eq 'TITLE_ITERATOR';

  my $chain0 = $chains->[-2];
  my $token0 = $chain0->check_out($chain0->last());
  my $cat = $token0->category();
  my $field = $token0->field();

  if ($cat eq 'SINGLETON' && exists $NUM_VALID{$field})
  {
    $chain1->complete_if_last_is(0, 'DESTROY');
  }
  elsif ($chain0->last() == 0 && $cat eq 'COUNTER')
  {
    $chain0->append($token1);
    $chain0->complete_if_last_is(1, 'COMPLETE');
    splice(@$chains, $#$chains, 1);
  }
}


sub post_process_stand_alone_singles
{
  my ($chains) = @_;

  for my $chain (@$chains)
  {
    next unless $chain->status() eq 'OPEN' && $chain->last() == 0;
    my $token = $chain->check_out(0);
    my $cat = $token->category();
    my $field = $token->field();

    if ($cat eq 'COUNTER' && 
        ($field eq 'LETTER' || $field eq 'N_OF_N' || $field eq 'ROMAN'))
    {
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($cat eq 'SINGLETON' &&
        ($field eq 'TITLE_TIME'))
    {
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($cat eq 'SINGLETON' &&
        ($field eq 'TITLE_AMBIGUOUS'))
    {
      $chain->complete_if_last_is(0, 'DESTROY');
    }
    elsif ($cat eq 'SINGLETON' &&
        ($field eq 'TITLE_ITERATOR' &&
        $token->value() eq 'Match'))
    {
      $token->set_singleton('TITLE_FORM', 'Teams');
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
  }
}


my %SANDWICH_LEFT_ORDINAL =
(
  TITLE_COUNTRY => 1,
  TITLE_CLUB => 1,
  LETTER => 1
);

my %SANDWICH_RIGHT_ORDINAL =
(
  TITLE_TNAME => 1,
  TITLE_TWORD => 1,
  TITLE_REGION => 1
);

sub post_process_sandwiched_singles
{
  my ($chains) = @_;

  return unless $#$chains >= 2;
  for my $cno (1 .. $#$chains-1)
  {
    my $chain1 = $chains->[$cno];
    next unless $chain1->status() eq 'OPEN';
    next unless $chain1->last() == 0;
    my $token1 = $chain1->check_out(0);
    return unless $token1->category() eq 'COUNTER' &&
      $token1->field() eq 'NUMERAL';

    my $chain0 = $chains->[$cno-1];
    my $token0 = $chain0->check_out($chain0->last());

    my $chain2 = $chains->[$cno+1];
    my $token2 = $chain2->check_out(0);

    if (exists $SANDWICH_LEFT_ORDINAL{$token0->field()} &&
        exists $SANDWICH_RIGHT_ORDINAL{$token2->field()})
    {
      my $value = ordinalize($token1->value());
      $token1->set_ordinal_counter($value);
      $chain1->complete_if_last_is(0, 'COMPLETE');
    }
    else
    {
      $chain1->complete_if_last_is(0, 'DESTROY');
    }
  }
}


sub post_process_split_two
{
  my ($chains, $chain) = @_;

  my $chain2 = Chain->new();
  $chain->copy_from(1, $chain2);
  $chain->truncate_directly_before(1);
  $chain->complete_if_last_is(0, 'COMPLETE');
  $chain2->complete_if_last_is(0, 'COMPLETE');
  splice(@$chains, 1 + $#$chains, 0, $chain2);
}


sub post_process_stand_alone_doubles
{
  my ($chains) = @_;

  # Check for a last chain with two numerals, of which the latter is
  # 1 or 2 and the former is larger.
  my $chain = $chains->[-1];
  return unless $chain->status() eq 'OPEN' && $chain->last() == 1;

  my $token0 = $chain->check_out(0);
  my $token1 = $chain->check_out(1);

  if ($token0->category() eq 'COUNTER' && $token0->field() eq 'NUMERAL')
  {
    if ($token1->category() eq 'COUNTER' && $token1->field() eq 'NUMERAL')
    {
      if ($token0->value() > $token1->value() && $token1->value() < 3)
      {
        post_process_split_two($chains, $chain);
        return;
      }
    }
    print "YYY ", $token0->field(), ", ", $token1->field(), "\n";
  }
  elsif ($token0->field() eq 'TITLE_STAGE' || 
      $token0->field() eq 'TITLE_TIME')
  {
    post_process_split_two($chains, $chain);
    return;
  }
  else
  {
    # A bit radical.
    $chain->complete_if_last_is(1, 'DESTROY');
  }
}


sub post_process_title
{
  my ($chains) = @_;

  post_process_first_numeral($chains);
  post_process_last_iterator($chains);
  post_process_last_numeral($chains);
  post_process_stand_alone_singles($chains);
  post_process_sandwiched_singles($chains);
  post_process_stand_alone_doubles($chains);

}

1;
