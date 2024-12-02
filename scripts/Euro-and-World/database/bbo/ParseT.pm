#!perl

package ParseT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);
use Try::Tiny;

use lib '.';
use lib '..';

use DateCalc;
use LinksT;
use EntryT;

my @MEET_FIELDS = qw(ORGANIZATION SPONSOR COUNTRY REGION CITY LOCALITY 
  ORDINAL ORIGIN ZONE FORM SCORING GENDER AGE);

my %MEET_FIELDS_HASH;
$MEET_FIELDS_HASH{$_} = 1 for @MEET_FIELDS;

my @CHAPTER_FIELDS = qw(YEAR DATE_START DATE_END 
  STAGE MOVEMENT WEEKEND SCORING major minor);
my %CHAPTER_HASH;
$CHAPTER_HASH{$_} = 1 for @CHAPTER_FIELDS;

my @TOURNAMENT_FIELDS = qw(CLUB ORGANIZATION SPONSOR LOCALITY COUNTRY 
  REGION CITY ORIGIN ZONE FORM SCORING MOVEMENT GENDER AGE);

my %TOURNAMENT_FIELDS_HASH;
$TOURNAMENT_FIELDS_HASH{$_} = 1 for @TOURNAMENT_FIELDS;

my %SCORING_HASH = (
  'B' => {'B' => 1, 'BAM' => 1},
  'I' => {'IMP' => 1, 'I' => 1},
  'P' => {'MP' => 1, 'P' => 1}
);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub set_parse_links
{
  my ($self, $meets, $tournaments, $key) = @_;

  for my $meet (sort keys %$meets)
  {
    for my $mfield (@MEET_FIELDS)
    {
      if (exists $meets->{$meet}{$mfield})
      {
        $self->{MEET}{$meet}{$mfield} = $meets->{$meet}{$mfield};
      }
    }

    %{$self->{MEET}{$meet}{EDITIONS}} = %{$meets->{$meet}{EDITIONS}};

    for my $mfield (keys %{$meets->{$meet}})
    {
      next if $mfield eq 'EDITIONS';
      if (! exists $MEET_FIELDS_HASH{$mfield})
      {
        warn "Key $key, meet $meet, field $mfield not used\n";
      }
    }
  }

  for my $tournament (sort keys %$tournaments)
  {
    for my $tfield (@TOURNAMENT_FIELDS)
    {
      if (exists $tournaments->{$tournament}{$tfield})
      {
        $self->{TOURNAMENT}{$tournament}{$tfield} = 
          $tournaments->{$tournament}{$tfield};
      }
    }

    my $t = $tournaments->{$tournament}{EDITIONS};
    for my $edition_str (keys %$t)
    {
      my $edition = $t->{$edition_str};

      if (exists $edition->{MEET})
      {
        $self->{T_MEET}{$tournament}{$edition->{MEET}} = 1;
      }
    }

    %{$self->{TOURNAMENT}{$tournament}{EDITIONS}} = 
      %{$tournaments->{$tournament}{EDITIONS}};

    for my $tfield (keys %{$tournaments->{$tournament}})
    {
      next if $tfield eq 'EDITIONS';
      if (! exists $TOURNAMENT_FIELDS_HASH{$tfield})
      {
        warn "Key $key, tournament $tournament, field $tfield not used\n";
      }
    }
  }
}


sub init_links
{
  my ($self, $division, $debug) = @_;
  my $callback_method = sub { $self->set_parse_links(@_); };

  my %divisions;
  LinksT::init_linksT(\%divisions);

  if ($debug)
  {
    $divisions{$division}->($callback_method);
  }
  else
  {
    while (my ($key, $set_method) = each %divisions)
    {
      $set_method->($callback_method);
    }
  }

  $self->set_lookup_links();
}


sub check_dates
{
  my ($text, $tag, $year, $date_start, $date_end) = @_;

  # Years must match.
  # Dates must not be too far apart.

  my $real_year = '';
  my $real_year2 = '';
  if (length $year == 4)
  {
    $real_year = $year;
  }
  elsif ($year =~ /^(\d\d\d\d)[A-F]$/)
  {
    $real_year = $1;
  }
  elsif ($year =~ /^(\d\d)(\d\d)-(\d\d)$/)
  {
    $real_year = $1 . $2;
    $real_year2 = $1 . $3;
  }
  elsif ($year ne '')
  {
    warn "$text: $year is not a year-like format";
  }

  if ($year ne '' && $year ne $real_year)
  {
    warn "$text: $year != $real_year";
  }

  my $d1 = DateCalc->new();
  try
  {
    $d1->set_by_field($date_start);
  }
  catch
  {
    warn "$text: $date_start is not a starting date";
  };

  my $d2 = DateCalc->new();
  try
  {
    $d2->set_by_field($date_end);
  }
  catch
  {
    warn "$text: $date_end is not an ending date";
  };

  my $delta = $d1->days_before($d2);
  if ($delta < 0 || $delta > 15)
  {
    warn "$text: Delta $delta" unless
      ($text =~ /^Meet Indonesian National Games/ ||
       $text =~ /^Meet Italy Cup/ ||
       $text =~ /^Meet Italian Club Championship/ ||
       $text =~ /^Meet Argentinian Trials/);
  }

  if (! defined $date_start)
  {
    warn "$text";
  }

  $date_start =~ /^(\d\d\d\d)/;
  my $y1 = $1;
  $date_end =~ /^(\d\d\d\d)/;
  my $y2 = $1;

  if ($real_year ne '' && $y1 ne $real_year)
  {
    warn "$text: $date_start not same year as $year";
  }

  if ($real_year2 ne '' && $y2 ne $real_year2)
  {
    warn "$text: $date_end not same year as end of $year";
  }
  elsif ($real_year ne '' && $y2 ne $real_year)
  {
    warn "$text: $date_end not same year as $year";
  }
}


sub check_meet_ref
{
  my ($self, $text, $meet, $mtag, $date_start, $date_end) = @_;

  my $date = DateCalc->new();
  $date->set_by_field($date_start);

  my $mdate1 = $self->{MEET}{$meet}{EDITIONS}{$mtag}{DATE_START};
  my $mdate2 = $self->{MEET}{$meet}{EDITIONS}{$mtag}{DATE_END};

  my $dist = $date->distance($mdate1, $mdate2);
  if ($dist != 0)
  {
    warn "$text: $date_start outside of $mdate1 to $mdate2";
  }

  $date->set_by_field($date_end);
  $dist = $date->distance($mdate1, $mdate2);
  if ($dist != 0)
  {
    warn "$text: $date_end outside of $mdate1 to $mdate2";
  }
}


sub cumulate_fields
{
  my ($self, $hash, $dupl_ok, $excludes, $errstr, $cumul) = @_;

  for my $field (sort keys %$hash)
  {
    next if exists $excludes->{$field};
    next if $field =~ /^\d\d\d\d/;

    if (! exists $cumul->{$field})
    {
      $cumul->{$field} = $hash->{$field};
    }
    elsif ($cumul->{$field} ne $hash->{$field})
    {
      warn "$errstr Field $field reset";
    }
    elsif (! exists $dupl_ok->{$field})
    {
      warn "$errstr Field $field set twice";
    }
  }
}


sub check_chapter
{
  my ($chapter, $errstr) = @_;
  for my $field (sort keys %$chapter)
  {
    if (! exists $CHAPTER_HASH{$field})
    {
      warn "$errstr: $field";
    }
  }
}


sub get_header_fields
{
  my ($self, $tname, $edition, $cumul) = @_;

  my $errstr = "$tname, $edition:";

  my $t_header = $self->{TOURNAMENT}{$tname};
  my $t_edition = $t_header->{EDITIONS}{$edition};

  $t_header->{TOURNAMENT_NAME} = $tname;

  $self->cumulate_fields($t_header, 
    {}, { EDITIONS => 1 }, $errstr, $cumul);
  $self->cumulate_fields($t_edition, 
    {}, { MEET_TAG => 1, CHAPTERS => 1 }, $errstr, $cumul);

  return unless exists $t_edition->{MEET};

  my $meet = $t_edition->{MEET};
  my $meet_tag = $t_edition->{MEET_TAG} // $edition;
  my $m_header = $self->{MEET}{$meet};
  my $m_edition = $m_header->{EDITIONS}{$meet_tag};

  $self->cumulate_fields($m_header, 
    {}, { EDITIONS => 1 }, $errstr, $cumul);
  $self->cumulate_fields($m_edition, 
    { YEAR => 1 }, {}, $errstr, $cumul);
}


sub get_all_fields
{
  my ($self, $tname, $edition, $chapter, $cumul, $ch_data) = @_;

  my $errstr = "$tname, $edition, $chapter:";

  my $t_header = $self->{TOURNAMENT}{$tname};
  my $t_edition = $t_header->{EDITIONS}{$edition};

  # Make a copy so we can't accidentally overwrite the original.
  %$ch_data = %{$t_edition->{CHAPTERS}{$chapter}};

  check_chapter($ch_data, $errstr);

  $self->cumulate_fields($t_header, 
    {}, { EDITIONS => 1 }, $errstr, $cumul);
  $self->cumulate_fields($t_edition, 
    {}, { MEET_TAG => 1, CHAPTERS => 1 }, $errstr, $cumul);

  return unless exists $t_edition->{MEET};

  my $meet = $t_edition->{MEET};
  my $meet_tag = $t_edition->{MEET_TAG} // $edition;
  my $m_header = $self->{MEET}{$meet};
  my $m_edition = $m_header->{EDITIONS}{$meet_tag};

  $self->cumulate_fields($m_header, 
    {}, { EDITIONS => 1 }, $errstr, $cumul);
  $self->cumulate_fields($m_edition, 
    { YEAR => 1 }, {}, $errstr, $cumul);
}


sub set_lookup_links
{
  my ($self) = @_;

  for my $meet (sort keys %{$self->{MEET}})
  {
    my $editions = $self->{MEET}{$meet}{EDITIONS};
    for my $tag (sort keys %$editions)
    {
      my $edition = $editions->{$tag};
      my $year = $edition->{YEAR} // '';
      check_dates("Meet $meet, $tag", $tag, $year,
        $edition->{DATE_START}, $edition->{DATE_END});
    }
  }

  for my $tournament (sort keys %{$self->{TOURNAMENT}})
  {
    my $editions = $self->{TOURNAMENT}{$tournament}{EDITIONS};
    for my $tag (sort keys %$editions)
    {
      my $edition = $editions->{$tag};

      my $meet = '';
      my $mtag = '';
      my $mchapter;
      if (exists $edition->{MEET})
      {
        $meet = $edition->{MEET};
        $mtag = $edition->{MEET_TAG} // $tag;
        if (exists $self->{MEET}{$meet}{EDITIONS}{$mtag})
        {
          $mchapter = $self->{MEET}{$meet}{EDITIONS}{$mtag};

          push @{$self->{M_LINKS}{$meet}{$mtag}},
            { TNAME => $tournament, EDITION => $tag };
        }
        else
        {
          warn "Tname $tournament, $tag: Meet $meet, $mtag not found";
          $mtag = '';
        }
      }

      $self->get_header_fields($tournament, $tag,
        \%{$self->{T_HEADERS}{$tournament}{$tag}});

      for my $ctag (sort keys %{$edition->{CHAPTERS}})
      {
        my $chapter = $edition->{CHAPTERS}{$ctag};
        my $year = $chapter->{YEAR} // '';
        check_dates("Tname $tournament, $tag, $ctag", $tag, $year,
          $chapter->{DATE_START}, $chapter->{DATE_END});

        if ($mtag)
        {
          $self->check_meet_ref("Tname $tournament, $tag", 
            $edition->{MEET}, $mtag,
            $chapter->{DATE_START}, $chapter->{DATE_END});
        }

        check_chapter($edition->{CHAPTERS}{$chapter}, 
          "$tournament, $tag, $ctag");
      }
    }
  }
}


sub compatibility
{
  # Not a class method.
  my ($header, $entry, $form_fixable, $scoring_fixable) = @_;

  my $hits = 0;
  my $conflicts = 0;

  for my $key (keys %$entry)
  {
    next unless exists $header->{$key};
    my $header_value = $header->{$key};
    my $entry_value = $entry->{$key};

    if ($entry_value eq $header_value)
    {
      $hits++;
    }
    elsif ($key eq 'SCORING' && 
        (exists $SCORING_HASH{$entry_value}{$header_value} ||
        $scoring_fixable))
    {
      $hits++;
    }
    elsif ($key eq 'FORM' && $form_fixable)
    {
      $entry->{$key} = $header_value;
      $hits++;
    }
    else
    {
      $conflicts++;
    }
  }
  return ($hits, $conflicts);
}


my (@times, $t0, $t1);

sub get_tname_list
{
  my ($self, $meet, $tname, $entry, $tname_list, $debug) = @_;

  # It's useful to screen by the year of the entry.
  my $entry_year = $entry->chapter_field('YEAR');
  if ($entry_year eq '')
  {
    $entry->chapter_field('DATE_ADDED') =~ /^(\d\d\d\d)/;
    $entry_year = $1;
  }

  if (exists $self->{TOURNAMENT}{$tname})
  {
    for my $edition (keys %{$self->{TOURNAMENT}{$tname}{EDITIONS}})
    {
      if ($edition =~ /^(\d\d\d\d)[A-Z]{0,1}$/)
      {
        next unless $1 eq $entry_year;
      }
      push @$tname_list, { TNAME => $tname, EDITION => $edition };
    }
  }
  elsif ($meet ne '' && exists $self->{MEET}{$meet})
  {
    my $m = $self->{M_LINKS}{$meet};
    for my $edition (keys %$m)
    {
      if ($edition =~ /^(\d\d\d\d)[A-Z]{0,1}$/)
      {
        next unless $1 eq $entry_year;
      }
      push @$tname_list, @{$m->{$edition}};
    }
  }
  else
  {
    warn $entry->bbono() . " meet $meet, tname $tname not found"
      unless $debug;
  }
}


sub str_or_equal
{
  my ($primary, $match) = @_;
  return ($primary eq $match ? '=' : $primary);
}


sub update_chapter_match
{
  my ($self, $header, $target, $t_hits, 
    $tname, $edition_str, $chapter_str, 
    $form_fixable, $scoring_fixable,
    $best, $entry, $debug) = @_;

  my $edition = $self->{TOURNAMENT}{$tname}{EDITIONS}{$edition_str};
  my $chapter = $edition->{CHAPTERS}{$chapter_str};
  return unless ref($chapter) eq 'HASH';

  my ($c_hits, $c_conflicts) = compatibility(
    $chapter, $entry->{CHAPTER}, $form_fixable, $scoring_fixable);
  return unless $c_conflicts == 0;

  my $hits = $t_hits + $c_hits;

  my $opens = 
    (exists $header->{GENDER} && $header->{GENDER} eq 'Open' ? 1 : 0) +
    (exists $header->{AGE} && $header->{AGE} eq 'Open' ? 1 : 0);

  my $dist = $target->distance(
    $chapter->{DATE_START},
    $chapter->{DATE_END});

  if ($debug)
  {
    print "$tname, $edition_str, $chapter_str: " .
      "Hits $hits, Open $opens, Dist $dist\n";
  }

  if (($dist < $best->{LOWEST_DIST}) ||
      ($dist == $best->{LOWEST_DIST} && $hits > $best->{LOWEST_HITS}) ||
      ($dist == $best->{LOWEST_DIST} && $hits == $best->{LOWEST_HITS} &&
       $opens > $best->{LOWEST_OPENS}))
  {
    print "        SWITCHING: dist now $dist\n" if $debug;
    $best->{LOWEST_DIST} = $dist;
    $best->{LOWEST_TNAME} = $tname;
    $best->{LOWEST_EDITION} = $edition_str;
    $best->{LOWEST_CHAPTER} = $chapter_str;
    $best->{LOWEST_HITS} = $hits;
    $best->{LOWEST_OPENS} = $opens;
    $best->{EQUAL_COLLISION} = 0;
  }
  elsif ($dist == 0 && 
      $hits == $best->{LOWEST_HITS} && 
      $opens == $best->{LOWEST_OPENS})
  {
    $best->{EQUAL_COLLISION} = 1;
    $best->{COLLISION_STR} = $entry->bbono() . 
      " double ZERO, ($tname, $edition_str, $chapter_str) vs (" .
      str_or_equal($best->{LOWEST_TNAME}, $tname) . ", " .
      str_or_equal($best->{LOWEST_EDITION}, $edition_str) . ", " .
      str_or_equal($best->{LOWEST_CHAPTER}, $chapter_str) . ")";
  }
}


sub get_edition_and_chapter
{
  my ($self, $meet, $tname, $entry, $debug, $division_flag) = @_;

  my @tname_list;
  $self->get_tname_list($meet, $tname, $entry, \@tname_list, 
    $division_flag);
  return ($tname, '', '') unless $#tname_list >= 0;

  my $target = DateCalc->new();
  $target->set_by_field($entry->{CHAPTER}{DATE_ADDED});

  my %best;
  $best{LOWEST_DIST} = 9999;
  $best{LOWEST_HITS} = 0;
  $best{EQUAL_COLLISION} = 0;
  $best{COLLISION_STR} = '';

  for my $tname_entry (@tname_list)
  {
    my $tname_cand = $tname_entry->{TNAME};
    my $edition_cand = $tname_entry->{EDITION};

    my $t = $self->{T_HEADERS}{$tname_cand}{$edition_cand};
    my $form_fixable = FScorr::form_fixable($tname_cand, $entry->bbono());
    my $scoring_fixable = 
      FScorr::scoring_fixable($tname_cand, $entry->bbono());

    my ($t_hits, $t_conflicts) = compatibility(
      $t, $entry->{HEADER}, $form_fixable, $scoring_fixable);
    next if $t_conflicts > 0;

    $t0 = time();
    my $edition = 
      $self->{TOURNAMENT}{$tname_cand}{EDITIONS}{$edition_cand};
    for my $chapter_str (keys %{$edition->{CHAPTERS}})
    {
      $self->update_chapter_match($t, $target, $t_hits,
        $tname_cand, $edition_cand, $chapter_str, 
        $form_fixable, $scoring_fixable,
        \%best, $entry, $debug);
    }
    $times[0] += time() - $t0;
  }

  if ($best{EQUAL_COLLISION})
  {
    warn $best{COLLISION_STR};
  }

  if ($best{LOWEST_DIST} == 0)
  {
    # 'Within one week' would be 7.
    return ($best{LOWEST_TNAME}, 
        $best{LOWEST_EDITION}, 
        $best{LOWEST_CHAPTER});
  }
  else
  {
    warn $entry->bbono() . 
      " not found (DIST $best{LOWEST_DIST}): " .
      "$tname, " . $entry->{CHAPTER}{DATE_ADDED};
    return ($tname, '', '');
  }
}


sub print_times
{
  for my $i (0 .. $#times)
  {
    printf "  Time $i: %.3f seconds\n", $times[$i];
  }
}


sub get_header_entry
{
  my ($self, $tname, $edition, $chapter) = @_;

  return ($self->{T_HEADERS}{$tname}{$edition},
    $self->{TOURNAMENT}{$tname}{EDITIONS}{$edition}{CHAPTERS}{$chapter}); 
}


sub is_tournament
{
  my ($self, $tname) = @_;
  return exists $self->{TOURNAMENT}{$tname};
}


1;
