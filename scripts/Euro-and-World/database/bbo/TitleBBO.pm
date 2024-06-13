#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TitleBBO;

our @ISA = qw(Exporter);
our @EXPORT = qw(init_hashes set_overall_hashes 
  study_title print_title_stats   all_used);

use lib '.';
use lib './Team';
use lib './Event';
use lib './Title';

use Token;
use Separators;

use Event::Cookbook;

use Team::Organization;
use Team::Zone;
use Team::Country;
use Team::Nationality;
use Team::Region;
use Team::City;
use Team::Quarter;
use Team::University;
use Team::Form;
use Team::Sponsor;
use Team::Gender;
use Team::Age;
use Team::Captain;

use Title::Meet;
use Title::Person;
use Title::Tname;
use Title::Tword;
use Title::Club;
use Title::Stage;
use Title::Time;
use Title::Destroy;

my @TAG_ORDER = qw(
  TITLE_DESTROY
  TITLE_TNAME
  TITLE_TWORD
  TITLE_MEET
  TITLE_CLUB

  TITLE_ORGANIZATION 
  TITLE_ZONE 
  TITLE_COUNTRY 
  TITLE_NATIONALITY
  TITLE_REGION 
  TITLE_CITY 
  TITLE_QUARTER 
  TITLE_UNIVERSITY 
  TITLE_FORM 
  TITLE_SPONSOR 
  TITLE_CAPTAIN 
  TITLE_GENDER
  TITLE_AGE
  TITLE_SCORING
  TITLE_PERSON
  TITLE_STAGE
  TITLE_TIME
);

my (%MULTI_WORDS, %MULTI_REGEX, %SINGLE_WORDS);
my (%MULTI_HITS);

my %HIT_STATS;


sub init_hashes
{
  my $method = \&TitleBBO::set_overall_hashes;

  Team::Organization::set_hashes($method, 'TITLE_ORGANIZATION');
  Team::Zone::set_hashes($method, 'TITLE_ZONE');
  Team::Country::set_hashes($method, 'TITLE_COUNTRY');
  Team::Nationality::set_hashes($method, 'TITLE_NATIONALITY');
  Team::Region::set_hashes($method, 'TITLE_REGION');
  Team::City::set_hashes($method, 'TITLE_CITY');
  Team::Quarter::set_hashes($method, 'TITLE_QUARTER');
  Team::University::set_hashes($method, 'TITLE_UNIVERSITY');
  Team::Form::set_hashes($method, 'TITLE_FORM');
  Team::Sponsor::set_hashes($method, 'TITLE_SPONSOR');

  Title::Person::set_hashes($method, 'TITLE_PERSON');

  Team::Captain::set_hashes($method, 'TITLE_CAPTAIN');
  Team::Gender::set_hashes($method, 'TITLE_GENDER');
  Team::Age::set_hashes($method, 'TITLE_AGE');
  Team::Scoring::set_hashes($method, 'TITLE_SCORING');

  Title::Meet::set_hashes($method, 'TITLE_MEET');
  Title::Tname::set_hashes($method, 'TITLE_TNAME');
  Title::Tword::set_hashes($method, 'TITLE_TWORD');
  Title::Club::set_hashes($method, 'TITLE_CLUB');
  Title::Stage::set_hashes($method, 'TITLE_STAGE');
  Title::Time::set_hashes($method, 'TITLE_TIME');
  Title::Destroy::set_hashes($method, 'TITLE_DESTROY');
}




sub set_overall_hashes
{
  my ($multi_words, $multi_typos, $single_words, $single_typos, $key) = @_;

  # The words themselves.
  for my $multi (@$multi_words)
  {
    my $tilded = $multi =~ s/ /\~/gr;
    $MULTI_WORDS{$key}{lc($multi)} = $multi;
    $SINGLE_WORDS{$key}{lc($multi)} = 
      { CATEGORY => $key, VALUE => $multi };
  }

  # Any typos.
  for my $multi (keys %$multi_typos)
  {
    my $tilded = $multi =~ s/ /\~/gr;
    for my $typo (@{$multi_typos->{$multi}})
    {
      $MULTI_WORDS{$key}{lc($typo)} = $multi;
      $SINGLE_WORDS{$key}{lc($multi)} = 
        { CATEGORY => $key, VALUE => $multi };
    }
  }

  if (keys %{$MULTI_WORDS{$key}})
  {
    my $multi_pattern_direct = join('|', map { quotemeta }
      sort { length($b) <=> length($a) } keys %{$MULTI_WORDS{$key}});

    $MULTI_REGEX{$key} = qr/(?<!\p{L})($multi_pattern_direct)(?=\P{L}|\z)/i;
  }
  else
  {
    $MULTI_REGEX{$key} = '';
  }

  # Similarly for the single words.
  for my $single (@$single_words)
  {
    $SINGLE_WORDS{$key}{lc($single)} = 
      { CATEGORY => $key, VALUE => $single };
  }

  for my $single (keys %$single_typos)
  {
    for my $typo (@{$single_typos->{$single}})
    {
      $SINGLE_WORDS{$key}{lc($typo)} = 
        { CATEGORY => $key, VALUE => $single };
    }
  }
}


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
      $part =~ /^(\d+)eme$/i ||
      $part =~ /^(\d+)°$/i ||
      $part =~ /^(\d+)º$/i ||
      $part =~ /^(\d+)ª$/i ||
      $part =~ /^(\d+)nd$/i)
  {
    return $1;
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
      $token->set_singleton('TITLE_ORDINAL', $ord);
      # $token->set_ordinal_counter($ord);
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
  my ($part, $token, $chain) = @_;

  for my $tag (@TAG_ORDER)
  {
    my $fix = $SINGLE_WORDS{$tag}{lc($part)};
    if (defined $fix->{CATEGORY})
    {
      # my $w = $fix->{VALUE};
      # $MULTI_HITS{$tag}{lc($part)}++;
      # $MULTI_HITS{$tag}{lc($w)}++;

      $token->set_singleton($fix->{CATEGORY}, $fix->{VALUE});
      $HIT_STATS{$fix->{CATEGORY}}++;

      if ($fix->{CATEGORY} eq 'TITLE_GENDER' &&
          $fix->{VALUE} eq 'Open')
      {
        # Special case: Add an extra token.
        my $token2 = Token->new();
        $token2->copy_origin_from($token);
        $token2->set_singleton('TITLE_AGE', 'Open');
        $chain->append($token2);
        $HIT_STATS{'TITLE_AGE'}++;
      }
      elsif ($fix->{CATEGORY} eq 'TITLE_AGE' &&
          $fix->{VALUE} eq 'Girls')
      {
        # Special case: Add an extra token.
        my $token2 = Token->new();
        $token2->copy_origin_from($token);
        $token2->set_singleton('TITLE_GENDER', 'Women');
        $chain->append($token2);
        $HIT_STATS{'TITLE_GENDER'}++;
      }

      return 1;
    }
  }
  return 0;
}


sub study_part
{
  my ($part, $i, $chain, $unknown_part_flag) = @_;

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
      # $token->set_numeral_counter($part);
      $token->set_singleton('TITLE_INTEGER', $part);
      $HIT_STATS{TITLE_INTEGER}++;
    }
    return;
  }
  elsif ($part =~ /^[A-D]$/)
  {
    # $token->set_letter_counter($part);
    $token->set_singleton('TITLE_LETTER', $part);
    $HIT_STATS{TITLE_LETTER}++;
    return;
  }
  elsif (fix_small_ordinal($part, $token))
  {
    $HIT_STATS{TITLE_ORDINAL}++;
    return;
  }

  # The general solution.
  return if title_specific_hashes($part, $token, $chain);

  # Some use of other hashes.
  my $fix_event = $FIX_HASH{lc($part)};

  if (defined $fix_event->{CATEGORY})
  {
    my $category = $fix_event->{CATEGORY};
    if ($category eq 'NUMERAL' || $category eq 'ROMAN')
    {
      $token->set_singleton('TITLE_' . $category, $fix_event->{VALUE});
      $HIT_STATS{'TITLE_' . $category}++;
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

  $text =~ s/(20\d\d)/ $1 /g;
  $text =~ s/'(9\d)/19$1/g;
  $text =~ s/'(0\d)/20$1/g;

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
  my ($text, $parts, $tags) = @_;

  @$parts = ($text);
  @$tags = (0);

  for my $tag (@TAG_ORDER)
  {
    next if $MULTI_REGEX{$tag} eq '';
    for my $i (reverse 0 .. $#$parts)
    {
      next if $tags->[$i] ne '0';
      my @a = grep { $_ ne '' } split /$MULTI_REGEX{$tag}/, $parts->[$i];

      if ($#a == 0)
      {
        # Optimize for this frequent special case.
        if (exists $MULTI_WORDS{$tag}{lc($a[0])})
        {
          $parts->[$i] = $MULTI_WORDS{$tag}{lc($a[0])};
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
          if (exists $MULTI_WORDS{$tag}{lc($parts->[$j])})
          {
            $parts->[$j] = $MULTI_WORDS{$tag}{lc($parts->[$j])};
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
  my ($part, $chain, $token_no, $unsolved_flag) = @_;

  # Split on trailing digits.
  my $unknown_part_flag = 0;
  if ($part =~ /^(.*[a-z])(\d+)$/i &&
      $1 ne 'U' && $1 ne 'D')
  {
    my ($letters, $digits) = ($1, $2);

    study_part($letters, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;

    study_part($digits, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;
  }
  else
  {
    study_part($part, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;
  }

  $$unsolved_flag = 1 if $unknown_part_flag;
}


sub study_title
{
  my ($text, $chain, $unknowns, $bbono) = @_;

  return if $text eq '';

  my $ntext = split_on_some_numbers($text);

  my $stext = split_on_capitals($ntext);

  my @parts = ();
  my @tags = (0);
  split_on_multi($stext, \@parts, \@tags);

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
        study_component($part, $chain, \$token_no, \$unsolved_flag);
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
  print "Multis:\n\n";
  for my $key (@TAG_ORDER)
  {
    for my $entry (sort keys %{$MULTI_WORDS{$key}})
    {
      if (! defined $MULTI_HITS{$key}{$entry})
      {
        print "$key: $entry\n";
      }
    }
  }

  print "\nSingles\n\n";
  for my $key (@TAG_ORDER)
  {
    for my $entry (sort keys %{$SINGLE_WORDS{$key}})
    {
      if (! defined $MULTI_HITS{$key}{$entry})
      {
        print "$key: $entry\n";
      }
    }
  }

}

1;
