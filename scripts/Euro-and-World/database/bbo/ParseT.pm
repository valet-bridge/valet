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

my $DEBUG_LINKS = 1;

my @MEET_FIELDS = qw(ORGANIZATION SPONSOR COUNTRY REGION CITY LOCALITY 
  ORDINAL ORIGIN ZONE FORM SCORING GENDER AGE);

my %MEET_FIELDS_HASH;
$MEET_FIELDS_HASH{$_} = 1 for @MEET_FIELDS;

my @MEET_EDITION_FIELDS = qw(YEAR CITY);
my @MEET_EDITION_PREFIXED_FIELDS = qw(ORDINAL DATE_START DATE_END);

my @TOURNAMENT_EDITION_PREFIXED_FIELDS = qw(ORDINAL CITY);
my @TOURNAMENT_CHAPTER_FIELDS = qw(YEAR MOVEMENT STAGE major minor);
my @TOURNAMENT_MEET_FIELDS = qw(MEET);

my @TOURNAMENT_FIELDS = qw(ORGANIZATION SPONSOR LOCALITY COUNTRY 
  REGION CITY ORIGIN ZONE FORM SCORING MOVEMENT GENDER AGE);

my %TOURNAMENT_FIELDS_HASH;
$TOURNAMENT_FIELDS_HASH{$_} = 1 for @TOURNAMENT_FIELDS;

my %COMPATIBILITIES = (
  COUNTRY => ['COUNTRY'],
  CITY => ['TITLE_CITY'],
  FORM => ['TITLE_FORM', 'EVENT_FORM'],
  AGE => ['TITLE_AGE', 'EVENT_AGE'],
  GENDER => ['TITLE_GENDER', 'EVENT_GENDER'],
  MOVEMENT => ['EVENT_MOVEMENT', 'TITLE_MOVEMENT'],
  SCORING => ['SCORING'],
  STAGE => ['EVENT_STAGE', 'TITLE_STAGE', 'TITLE_ROF'],
  SEGMENT => ['HALF'],
  MATCH => ['TITLE_MATCH', 'EVENT_MATCH']
);

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

  $self->check_consistency() if $DEBUG_LINKS;
  exit;
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
      ($text =~ /^Meet Italy Cup/ ||
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


sub get_all_fields
{
  my ($self, $tname, $edition, $chapter, $cumul) = @_;

  my $errstr = "$tname, $edition, $chapter:";

  my $t_header = $self->{TOURNAMENT}{$tname};
  my $t_edition = $t_header->{EDITIONS}{$edition};
  my $t_chapter = $t_edition->{CHAPTERS}{$chapter};

  $self->cumulate_fields($t_header, 
    {}, { EDITIONS => 1 }, $errstr, $cumul);
  $self->cumulate_fields($t_edition, 
    {}, { MEET_TAG => 1, CHAPTERS => 1 }, $errstr, $cumul);
  $self->cumulate_fields($t_chapter, 
    {}, { DATE_START => 1, DATE_END => 1 }, $errstr, $cumul);

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


sub check_consistency
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
        }
        else
        {
          warn "Tname $tournament, $tag: Meet $meet, $mtag not found";
          $mtag = '';
        }
      }

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

        # Look for fields that get set more than once.
        my %cumul = %$chapter;
        for my $e (sort keys %$editions)
        {
          next if $e eq 'CHAPTERS' || $e =~ /^\d+$/;
          if (! exists $cumul{$e})
          {
            $cumul{$e} = $editions->{$e};
          }
          elsif ($cumul{$e} ne $editions->{$e})
          {
            warn "Tname $tournament, $tag: Field $e reset";
          }
          else
          {
            warn "Tname $tournament, $tag: Field $e set twice";
          }
        }

        if ($mtag)
        {
          for my $f (sort keys %{$self->{MEET}{$meet}})
          {
            next if $f eq 'EDITIONS';
            if (! exists $cumul{$f})
            {
              $cumul{$f} = $self->{MEET}{$meet}{$f};
            }
            elsif ($cumul{$f} ne $self->{MEET}{$meet}{$f})
            {
              warn "Tname $tournament, $tag: Field $f reset in Meet";
            }
            else
            {
              warn "Tname $tournament, $tag: Field $f set again in Meet";
            }
          }

          my $med = $self->{MEET}{$meet}{EDITIONS}{$mtag};
          for my $f (sort keys %$med)
          {
            next if $f =~ /^DATE_/;
            if (! exists $cumul{$f})
            {
              $cumul{$f} = $med->{$f};
            }
            elsif ($cumul{$f} ne $med->{$f})
            {
              warn "Tname $tournament, $tag: Field $f reset in Meet chapter";
            }
            elsif ($f ne 'YEAR')
            {
              warn "Tname $tournament, $tag: Field $f set again in Meet chapter";
            }
          }
        }

        my %cumul2;
        # next;
        my $errstr = "$tournament, $tag, $ctag";
        $self->get_all_fields($tournament, $tag, $ctag, \%cumul2);

        for my $k (sort keys %cumul2)
        {
          if (! exists $cumul{$k})
          {
            # warn "$errstr $k only in cumul2";
          }
          elsif ($cumul{$k} ne $cumul2{$k})
          {
            next if ($k eq 'DATE_START' || $k eq 'DATE_END' ||
              $k =~ /^\d\d\d\d/);
            warn "$errstr $k: $cumul{$k} vs $cumul2{$k}";
          }
        }

        for my $k (sort keys %cumul)
        {
          if (! exists $cumul2{$k})
          {
            next if ($k eq 'DATE_START' || $k eq 'DATE_END' ||
              $k =~ /^\d\d\d\d/);
            warn "$errstr $k only in cumul";
          }
        }

      }
    }
  }
}


sub lookup_among_fields
{
  my ($entry, $key) = @_;
  return '' unless defined $COMPATIBILITIES{$key};
  for my $ckey (@{$COMPATIBILITIES{$key}})
  {
    my $value = $entry->field($ckey);
    return $value unless $value eq '';
  }
  return '';
}


sub compatibility
{
  # Not a class method.
  my ($header, $entry) = @_;

  my $hits = 0;
  my $conflicts = 0;

  for my $key (keys %$header)
  {
    next if $key =~ /[a-z]/; # Skip internal information
    my $value = lookup_among_fields($entry, $key);
    next if $value eq '';

    if ($value eq $header->{$key})
    {
      $hits++;
    }
    elsif ($key eq 'STAGE' && 
      $header->{$key} =~ /^Rof(\d+)$/ &&
      $1 eq $value)
    {
      # Kludge because header may say STAGE and entry may
      # say TITLE_ROF 16.  Should probably be prevented.
      $hits++;
    }
    elsif ($key eq 'SCORING' && 
        exists $SCORING_HASH{$value}{$header->{$key}})
    {
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

sub get_edition_and_chapter
{
  my ($self, $meet, $tname, $entry, $debug) = @_;

  if ($meet ne '' && ! exists $self->{MEET}{$meet})
  {
    warn $entry->bbono() . " meet $meet not in structured list";
  }

  my @tname_list;
  if (exists $self->{TOURNAMENT}{$tname})
  {
    # Use tname if given.
    push @tname_list, $tname;
  }
  elsif ($meet ne '')
  {
    # Look for tournaments with the right meet in at least
    # one edition.
    $t0 = time();
    for my $tname (keys %{$self->{TOURNAMENT}})
    {
      my $t = $self->{TOURNAMENT}{$tname};

      next unless exists $self->{T_MEET}{$tname}{$meet};

      $t1 = time();
      my ($hits, $conflicts) = compatibility($t, $entry);
      $times[2] += time() - $t1;
      next if $conflicts > 0;

      $t1 = time();
      for my $edition_str (keys %{$t->{EDITIONS}})
      {
        my $edition = $t->{EDITIONS}{$edition_str};

        if (exists $edition->{MEET} && $edition->{MEET} eq $meet)
        {
          push @tname_list, $tname;
          last;
        }
      }
      $times[3] += time() - $t1;
    }
    $times[0] += time() - $t0;

    if ($#tname_list == -1 && exists $self->{MEET}{$meet})
    {
      warn $entry->bbono() . " not found: meet $meet, " . 
        $entry->field('DATE_ADDED');
    }
  }
  return ($tname, '', '') unless $#tname_list >= 0;

  my $target = DateCalc->new();
  $target->set_by_field($entry->field('DATE_ADDED'));

  my $lowest_dist = 9999;
  my $lowest_hits = 0;
  my ($lowest_tname, $lowest_edition, $lowest_chapter, $lowest_opens);
  my $equal_collision = 0;
  my $collision_str = '';

  for my $tname (@tname_list)
  {
    my $t = $self->{TOURNAMENT}{$tname};
    my ($t_hits, $t_conflicts) = compatibility($t, $entry);
    next if $t_conflicts > 0;

    for my $edition_str (keys %{$t->{EDITIONS}})
    {
      my $edition = $t->{EDITIONS}{$edition_str};
      my ($e_hits, $e_conflicts) = compatibility($edition, $entry);
      next if $e_conflicts > 0;

      my ($m_hits, $m_conflicts) = (0, 0);
      my $t_meet;
      if (exists $edition->{MEET} && $meet ne '')
      {
        next unless ($edition->{MEET} eq $meet);
        $t_meet = $self->{MEET}{$meet};
        my ($m_hits, $m_conflicts) = compatibility($t_meet, $entry);
        next unless $m_conflicts == 0;
      }

      $t0 = time();
      for my $chapter_str (keys %{$edition->{CHAPTERS}})
      {
        my $chapter = $edition->{CHAPTERS}{$chapter_str};
        next unless ref($chapter) eq 'HASH';

        my ($c_hits, $c_conflicts) = compatibility($chapter, $entry);
        next unless $c_conflicts == 0;

        my $hits = $t_hits + $m_hits + $e_hits + $c_hits;

        my $opens = 
          (exists $t->{GENDER} && $t->{GENDER} eq 'Open' ? 1 : 0) +
          (exists $t->{AGE} && $t->{AGE} eq 'Open' ? 1 : 0);

        my $dist = $target->distance(
          $chapter->{DATE_START},
          $chapter->{DATE_END});

        if ($debug)
        {
          print "$tname, $edition_str, $chapter_str: ";
          print "Hits $hits, Open $opens, Dist $dist\n";
        }

        if (($dist < $lowest_dist) ||
            ($dist == $lowest_dist && $hits > $lowest_hits) ||
            ($dist == $lowest_dist && $hits == $lowest_hits &&
             $opens > $lowest_opens))
        {
          print "        SWITCHING: dist now $dist\n" if $debug;
          $lowest_dist = $dist;
          $lowest_tname = $tname;
          $lowest_edition = $edition_str;
          $lowest_chapter = $chapter_str;
          $lowest_hits = $hits;
          $lowest_opens = $opens;
          $equal_collision = 0;
        }
        elsif ($dist == 0 && 
            $hits == $lowest_hits && 
            $opens == $lowest_opens)
        {
          $equal_collision = 1;
          $collision_str = $entry->bbono() . 
            " double zero, ($tname, $edition_str, $chapter_str) vs (" .
            ($lowest_tname eq $tname ? '=' : $lowest_tname) . ", " .
            ($lowest_edition eq $edition_str ? '=' : $lowest_edition) . 
            ", " .
            ($lowest_chapter eq $chapter_str ? '=' : $lowest_chapter) . 
            ")";
        }
      }
      $times[1] += time() - $t0;
    }
  }

  if ($equal_collision)
  {
    warn $collision_str;
  }

  if ($lowest_dist == 0)
  {
    # 'Within one week' would be 7.
    return ($lowest_tname, $lowest_edition, $lowest_chapter);
  }
  else
  {
    warn $entry->bbono() . " not found (dist $lowest_dist): " .
      "$tname, " . $entry->field('DATE_ADDED');
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


sub transfer_field
{
  # Not a class method.
  my ($fields, $field, $value) = @_;

  return unless defined $value;

  if (exists $fields->{$field} && $fields->{$field} ne $value)
  {
    die "Trying to reset from $fields->{$field} to $value";
  }

  $fields->{$field} = $value;
}


sub set_header_entry
{
  my ($self, $tname, $edition_str, $chapter_str) = @_;

  my $entry = EntryT->new();
  my %fields;

  my $chapter_entry = EntryT->new();
  my %chapter_fields;

  # In principle we can override meeting-level data with other data,
  # but I'd like to keep it sparse.

  my $tournament = $self->{TOURNAMENT}{$tname};
  my $t_edition = $tournament->{EDITIONS}{$edition_str};
  my $t_chapter = $t_edition->{CHAPTERS}{$chapter_str};

  transfer_field(\%fields, 'TOURNAMENT_NAME', $tname);

  if (exists $t_edition->{MEET})
  {
    # TODO Edition string not required to be the same?
    my $meet_str = $t_edition->{MEET};
    my $meet = $self->{MEET}{$meet_str};
    my $m_edition = $meet->{EDITIONS}{$edition_str};

    for my $mfield (@MEET_FIELDS)
    {
      transfer_field(\%fields, $mfield, $meet->{$mfield});
    }

    for my $mfield (@MEET_EDITION_FIELDS)
    {
      transfer_field(\%fields, $mfield, $m_edition->{$mfield});
    }

    for my $mfield (@MEET_EDITION_PREFIXED_FIELDS)
    {
      transfer_field(\%fields, 'MEET_' . $mfield, $meet->{$mfield});
    }
  }

  for my $tfield (@TOURNAMENT_FIELDS)
  {
    if (exists $tournament->{$tfield})
    {
      transfer_field(\%fields, $tfield, $tournament->{$tfield});
    }
  }

  for my $tfield (@TOURNAMENT_EDITION_PREFIXED_FIELDS)
  {
    if (exists $t_edition->{$tfield})
    {
      transfer_field(\%fields, 'TOURNAMENT_' . $tfield, 
        $t_edition->{$tfield});
    }
  }

  $entry->set(\%fields);

  for my $tfield (@TOURNAMENT_CHAPTER_FIELDS)
  {
    if (exists $t_chapter->{$tfield})
    {
      transfer_field(\%chapter_fields, $tfield, $t_chapter->{$tfield});
    }
  }

  for my $mfield (@TOURNAMENT_MEET_FIELDS)
  {
    if (exists $t_edition->{$mfield})
    {
      transfer_field(\%chapter_fields, $mfield, $t_edition->{$mfield});
    }
  }

  for my $dfield (qw(DATE_START DATE_END))
  {
    if (exists $t_chapter->{$dfield} &&
        exists $fields{MEET_DATE_START} &&
        exists $fields{MEET_DATE_END})
    {
      my $datecalc = DateCalc->new();
      $datecalc->set_by_field($t_chapter->{$dfield});
      if (! date_calc->inside($fields{MEET_DATE_START},
        $fields{MEET_DATE_END}))
      {
        die "$t_chapter->{$dfield} is not inside " .
          $fields{MEET_DATE_START} . " to " .
          $fields{MEET_DATE_END};
      }
    }
  }

  transfer_field(\%chapter_fields, 'DATE_START', $t_chapter->{DATE_START});
  transfer_field(\%chapter_fields, 'DATE_END', $t_chapter->{DATE_END});
  transfer_field(\%chapter_fields, 'WEEKEND', $t_chapter->{WEEKEND});
  transfer_field(\%chapter_fields, 'MOVEMENT', $t_chapter->{MOVEMENT});

  $chapter_entry->set(\%chapter_fields);

  return ($entry, $chapter_entry);
}


sub is_tournament
{
  my ($self, $tname) = @_;
  return exists $self->{TOURNAMENT}{$tname};
}


1;
