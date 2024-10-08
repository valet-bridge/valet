#!perl

package ParseT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib '..';

use DateCalc;
use EntryT;

# use Tournaments::Argentina;
# use Tournaments::Australia;
# use Tournaments::Belgium;
# use Tournaments::Brazil;
# use Tournaments::Canada;
# use Tournaments::Chile;
# use Tournaments::Czech;
# use Tournaments::Denmark;
# use Tournaments::EuroAdult;
# use Tournaments::EuroYouth;
# use Tournaments::Finland;
# use Tournaments::Germany;
# use Tournaments::Greece;
# use Tournaments::Hungary;
# use Tournaments::Iceland;
# use Tournaments::India;
# use Tournaments::Indonesia;
# use Tournaments::Ireland;
# use Tournaments::Israel;
# use Tournaments::Italy;
# use Tournaments::NewZealand;
# use Tournaments::Norway;
# use Tournaments::Poland;
# use Tournaments::Portugal;
# use Tournaments::Romania;
# use Tournaments::Serbia;
# use Tournaments::Spain;
use Tournaments::SouthAmerica;
# use Tournaments::Turkey;
# use Tournaments::Switzerland;
# use Tournaments::USA;


my %DIVISIONS =
(
  # ARGENTINA => \&Tournaments::Argentina::set_links
  # AUSTRALIA => \&Tournaments::Australia::set_links
  # BELGIUM => \&Tournaments::Belgium::set_links
  # BRAZIL => \&Tournaments::Brazil::set_links
  # CANADA => \&Tournaments::Canada::set_links
  # CHILE => \&Tournaments::Chile::set_links
  # CZECH => \&Tournaments::Czech::set_links
  # DENMARK => \&Tournaments::Denmark::set_links
  # EUROADULT => \&Tournaments::EuroAdult::set_links
  # EUROYOUTH => \&Tournaments::EuroYouth::set_links
  # FINLAND => \&Tournaments::Finland::set_links
  # GERMANY => \&Tournaments::Germany::set_links
  # GREECE => \&Tournaments::Greece::set_links
  # HUNGARY => \&Tournaments::Hungary::set_links
  # ICELAND => \&Tournaments::Iceland::set_links
  # INDIA => \&Tournaments::India::set_links
  # INDONESIA => \&Tournaments::Indonesia::set_links
  # IRELAND => \&Tournaments::Ireland::set_links
  # ISRAEL => \&Tournaments::Israel::set_links
  # ITALY => \&Tournaments::Italy::set_links
  # NEWZEALAND => \&Tournaments::NewZealand::set_links
  # NORWAY => \&Tournaments::Norway::set_links
  # POLAND => \&Tournaments::Poland::set_links
  # PORTUGAL => \&Tournaments::Portugal::set_links
  # ROMANIA => \&Tournaments::Romania::set_links
  # SERBIA => \&Tournaments::Serbia::set_links
  # SPAIN => \&Tournaments::Spain::set_links
  SOUTHAMERICA => \&Tournaments::SouthAmerica::set_links
  # TURKEY => \&Tournaments::Turkey::set_links
  # SWITZERLAND => \&Tournaments::Switzerland::set_links
  # USA => \&Tournaments::USA::set_links
);

my @MEET_FIELDS = qw(ORGANIZATION COUNTRY CITY LOCALITY ORDINAL
  ORIGIN ZONE SCORING);

my @MEET_EDITION_FIELDS = qw(YEAR CITY);
my @MEET_EDITION_PREFIXED_FIELDS = qw(ORDINAL DATE_START DATE_END);

my @TOURNAMENT_EDITION_PREFIXED_FIELDS = qw(ORDINAL CITY);
my @TOURNAMENT_CHAPTER_FIELDS = qw(YEAR MOVEMENT STAGE major minor);
my @TOURNAMENT_MEET_FIELDS = qw(MEET);

my @TOURNAMENT_FIELDS = qw(ORGANIZATION COUNTRY CITY ORIGIN ZONE
  FORM SCORING GENDER AGE);

my %COMPATIBILITIES = (
  FORM => ['TITLE_FORM'],
  AGE => ['TITLE_AGE', 'EVENT_AGE'],
  GENDER => ['TITLE_GENDER', 'EVENT_GENDER'],
  MOVEMENT => ['EVENT_MOVEMENT', 'TITLE_MOVEMENT'],
  SCORING => ['SCORING'],
  STAGE => ['EVENT_STAGE', 'TITLE_STAGE', 'TITLE_ROF'],
  SEGMENT => ['HALF']
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

    %{$self->{TOURNAMENT}{$tournament}{EDITIONS}} = 
      %{$tournaments->{$tournament}{EDITIONS}};
  }
}


sub init_links
{
  my ($self) = @_;
  my $callback_method = sub { $self->set_parse_links(@_); };

  while (my ($key, $set_method) = each %DIVISIONS)
  {
    $set_method->($callback_method);
    
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


sub get_edition_and_chapter
{
  my ($self, $meet, $tname, $entry, $debug) = @_;

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
    for my $tname (keys %{$self->{TOURNAMENT}})
    {
      my $t = $self->{TOURNAMENT}{$tname};

      my ($hits, $conflicts) = compatibility($t, $entry);
      next if $conflicts > 0;

      for my $edition_str (keys %{$t->{EDITIONS}})
      {
        my $edition = $t->{EDITIONS}{$edition_str};

        if (exists $edition->{MEET} && $edition->{MEET} eq $meet)
        {
          push @tname_list, $tname;
          last;
        }
      }
    }

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
        }
      }
    }
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
