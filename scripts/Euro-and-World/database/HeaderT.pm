#!perl

package HeaderT;

use strict;
use warnings;
use Exporter;
use v5.10;

use Country;
our $country;

use City;
our $city;

use Organizer;
our $organizer;

use Form;
our $form;

use Age;
our $age;

use Gender;
our $gender;

use Restriction;
our $restriction;

my %MONTHS = (
  'January' => '01',
  'February' => '02',
  'March' => '03',
  'April' => '04',
  'May' => '05',
  'June' => '06',
  'July' => '07',
  'August' => '08',
  'September' => '09',
  'October' => '10',
  'November' => '11',
  'December' => '12');


sub new
{
  my $class = shift;

  $country = Country->new() if ! defined $country;
  $city = City->new() if ! defined $city;
  $organizer = Organizer->new() if ! defined $organizer;
  $form = Form->new() if ! defined $form;
  $age = Age->new() if ! defined $age;
  $gender = Gender->new() if ! defined $gender;
  $restriction = Restriction->new() if ! defined $restriction;
  return bless {}, $class;
}


sub check_id
{
  my ($self, $errstr) = @_;
  if (! defined $self->{ID})
  {
    die "$errstr: ID should be present";
  }
  elsif ($self->{ID} !~ /^\d+$/)
  {
    die "$errstr: ID should be numerical";
  }
}


sub check_city
{
  my ($self, $errstr) = @_;
  if (defined $self->{CITY})
  {
    die "$errstr: $self->{CITY} not a city" unless
      $city->valid($self->{CITY});
  }
  else
  {
    die "$errstr: City should be present";
  }
}


sub check_and_recode_country
{
  my ($self, $errstr) = @_;
  if (defined $self->{COUNTRY})
  {
    die "$errstr: $self->{COUNTRY} not a country" unless
      $country->valid($self->{COUNTRY});
    
    $self->{COUNTRY} = $country->code($self->{COUNTRY});
  }
  else
  {
    die "$errstr: Country should be present";
  }
}


sub check_organizer
{
  my ($self, $errstr) = @_;
  if (defined $self->{ORGANIZER})
  {
    die "$errstr: $self->{ORGANIZER} not an organizer" unless
      $organizer->valid($self->{ORGANIZER});
  }
  else
  {
    die "$errstr: Organizer should be present";
  }
}


sub check_year
{
  my ($self, $errstr) = @_;
  if (defined $self->{YEAR})
  {
    die "$errstr: $self->{YEAR} not a year" unless
      $self->{YEAR} =~ /^\d\d\d\d$/ &&
      $self->{YEAR} > 1900 && 
      $self->{YEAR} < 2050;
  }
  else
  {
    die "$errstr: Year should be present";
  }
}


sub check_date_field
{
  my ($self, $field, $errstr) = @_;

  return unless defined $self->{$field};

  my ($y, $m, $d);
  if ($self->{$field} =~ /^(\d\d\d\d)-(\d\d)$/)
  {
    ($y, $m, $d) = ($1, $2, '');
  }
  elsif ($self->{$field} =~ /^(\d\d\d\d)-(\d\d)-(\d\d)$/)
  {
    ($y, $m, $d) = ($1, $2, $3);
  }
  else
  {
    die "$errstr: $field must be of form yyyy-mm-dd";
  }

  if ($y ne $self->{YEAR})
  {
    die "$errstr: $field year must be $self->{YEAR}";
  }

  if ($m < 1 || $m > 12)
  {
    die "$errstr: $m must be a valid month number";
  }

  return if ($d eq '');

  if ($d < 1 || $d > 31)
  {
    die "$errstr: $d must be a valid day number";
  }

  if (($m == 4 || $m == 6 || $m == 9 || $m == 11) && $d == 31)
  {
    die "$errstr: $d must be valid for month $m";
  }

  if ($m == 2 && $d > 29)
  {
    # Forget about leap years...
    die "$errstr: $d must be valid for month $m";
  }
}


sub check_form
{
  my ($self, $errstr) = @_;
  if (defined $self->{FORM})
  {
    die "$errstr: $self->{FORM} not a form" unless
      $form->valid($self->{FORM});
  }
  else
  {
    die "$errstr: Form should be present";
  }
}


sub check_age
{
  my ($self, $errstr) = @_;
  if (defined $self->{RESTRICTION_AGE})
  {
    die "$errstr: $self->{RESTRICTION_AGE} not an age restriction" unless
      $age->valid($self->{RESTRICTION_AGE});
  }
  else
  {
    die "$errstr: Age restriction should be present";
  }
}


sub check_gender
{
  my ($self, $errstr) = @_;
  if (defined $self->{RESTRICTION_GENDER})
  {
    die "$errstr: $self->{RESTRICTION_GENDER} not a gender restriction" 
      unless $gender->valid($self->{RESTRICTION_GENDER});
  }
  else
  {
    die "$errstr: Gender restriction should be present";
  }
}


sub restrict_gender
{
  my ($self, $unit_gender, $errstr) = @_;
  return $restriction->gender(
    $self->{RESTRICTION_GENDER}, 
    $unit_gender, 
    $errstr);
}


sub restrict_age
{
  my ($self, $unit_age, $errstr) = @_;
  return $restriction->age(
    $self->{RESTRICTION_AGE},
    $unit_age,
    $errstr);
}


sub set_from_buffer
{
  my ($self, $buffer_ref, $errstr) = @_;

  for my $key (keys %$buffer_ref)
  {
    $self->{$key} = $buffer_ref->{$key};
  }

  $self->check_id($errstr);
  $self->check_city($errstr);
  $self->check_and_recode_country($errstr);
  $self->check_organizer($errstr);
  $self->check_year($errstr);
  $self->check_date_field('DATE_START', $errstr);
  $self->check_date_field('DATE_END', $errstr);
  $self->check_form($errstr);
  $self->check_age($errstr);
  $self->check_gender($errstr);
}


sub check_from_details
{
  my ($self, $title, $details, $errstr) = @_;

  if ($title ne $self->{TITLE})
  {
    die "$errstr: Title $title vs $self->{TITLE}";
  }

  my @words = split /[,\-\s]+/, $details;

  # Each detail has a dot that is coded as a three-character symbol.
  # We find the index of that word.

  my $dot_index = $self->get_dot_index(\@words);
  die "$errstr: No dot found in details" if $dot_index == -1;

  if ($title =~ /Online/)
  {
    if ($self->{CITY} ne 'Online')
    {
      die "$errstr: Expected city Online with title $title";
    }
    if ($self->{COUNTRY} ne 'ONL')
    {
      die "$errstr: Expected country Online with title $title";
    }
  }
  else
  {
    $self->check_location(\@words, $dot_index, $errstr);
  }

  my $l = $#words;
  if ($l - $dot_index == 1)
  {
    # Hopefully just a year
    die "$errstr: Year $words[$l] vs $self->{YEAR}" unless
      $words[$l] eq $self->{YEAR};
  }
  elsif ($l - $dot_index == 2)
  {
    # Hopefully June 1995
    die "$errstr: Year $words[$l]vs $self->{YEAR}" unless
      $words[$l] eq $self->{YEAR};

    $self->check_month($words[$l-1], $errstr);
  }
  elsif ($l - $dot_index == 4)
  {
    # Hopefully of the form 2 - 13 July 1987
    die "$errstr: Year $words[$l]vs $self->{YEAR}" unless
      $words[$l] eq $self->{YEAR};

    $self->check_month_range($words[$l-3], $words[$l-2],
      $words[$l-1], $errstr);
  }
  elsif ($l - $dot_index == 5)
  {
    # Hopefully of the form 21 August - 3 September 1987
    $self->{YEAR} = $words[$l];
    die "$errstr: Year $words[$l]vs $self->{YEAR}" unless
      $words[$l] eq $self->{YEAR};

    $self->check_months_range($words[$l-4], $words[$l-3],
      $words[$l-2], $words[$l-1], $errstr);
  }
  else
  {
    die "$errstr: Haven't learned this yet, $details";
  }
}


sub get_dot_index
{
  my ($self, $words_ref) = @_;

  my $found = 0;
  for my $i (0 .. $#$words_ref)
  {
    next unless length($words_ref->[$i]) == 3;
    next unless ord(substr($words_ref->[$i], 0, 1)) == 226;
    next unless ord(substr($words_ref->[$i], 1, 1)) == 128;
    next unless ord(substr($words_ref->[$i], 2, 1)) == 162;
    return $i;
  }
  return -1;
}


sub month_day
{
  my ($self, $text, $res_ref) = @_;
  return 0 unless $text =~ /^(\d+)$/;
  $$res_ref = $1;
  $$res_ref = '0' . $$res_ref if (length $$res_ref == 1);
  return 1;
}


sub check_location
{
  my ($self, $words_ref, $dot_index, $errstr) = @_;

  die "$errstr: Don't know how to deal with this location" unless
    $dot_index >= 2;

  # Look for something like Miami Beach, U.S.A.
  my $city_guess = join ' ', @{$words_ref}[0 .. $dot_index-2];
  my $country_guess = $words_ref->[$dot_index-1];

  if ($country->valid($country_guess))
  {
    die "$errstr: $city_guess is not a city" unless
      $city->valid($city_guess);
  }
  else
  {
    die "$errstr: $city_guess not a country" if $dot_index == 2;

    # Maybe it's of the form 'Great Britain' or 'Czech Republic'.
    $city_guess = join ' ', @{$words_ref}[0 .. $dot_index-3];
    my $country_guess2 = join ' ', 
      @{$words_ref}[$dot_index-2 .. $dot_index-1];

    if ($country->valid($country_guess2))
    {
      die "$errstr: $city_guess is not a city" unless
        $city->valid($city_guess);
    }
    else
    {
      die "$errstr: Neither $country_guess nor $country_guess2 a country";
    }
  }
}


sub check_finished_dates
{
  my ($self, $date_start, $date_end, $errstr) = @_;

  die "$errstr: Date start $date_start vs $self->{DATE_START}" unless
     $date_start eq $self->{DATE_START};

  die "$errstr: Date end $date_end vs $self->{DATE_END}" unless
     $date_end eq $self->{DATE_END};
}


sub check_month
{
  my ($self, $month, $errstr) = @_;

  die "$errstr: $month not a month" unless defined $MONTHS{$month};

  my $date_start = $self->{YEAR} . '-' .  $MONTHS{$month};
  my $date_end = $date_start;

  $self->check_finished_dates($date_start, $date_end, $errstr);

}


sub check_month_range
{
  my ($self, $day1, $day2, $month, $errstr) = @_;

  die "$errstr: $month not a month" unless defined $MONTHS{$month};

  my $start;
  die "$errstr: $day1 not a day" unless 
    $self->month_day($day1, \$start);

  my $end;
  die "$errstr: $day2 not a day" unless 
    $self->month_day($day2, \$end);

  my $date_start = $self->{YEAR} . '-' .  $MONTHS{$month} . '-' . $start;
  my $date_end = $self->{YEAR} . '-' .  $MONTHS{$month} . '-' . $end;

  $self->check_finished_dates($date_start, $date_end, $errstr);
}


sub check_months_range
{
  my ($self, $day1, $month1, $day2, $month2, $errstr) = @_;
  
  die "$errstr: $month1 not a month" unless defined $MONTHS{$month1};
  die "$errstr: $month2 not a month" unless defined $MONTHS{$month2};

  my $start;
  die "$errstr: $day1 not a day" unless 
    $self->month_day($day1, \$start);

  my $end;
  die "$errstr: $day2 not a day" unless 
    $self->month_day($day2, \$end);

  my $date_start = $self->{YEAR} . '-' .  $MONTHS{$month1} . '-' . $start;
  my $date_end = $self->{YEAR} . '-' .  $MONTHS{$month2} . '-' . $end;

  $self->check_finished_dates($date_start, $date_end, $errstr);
}


sub is_teams
{
  my ($self) = @_;

  if (defined $self->{FORM})
  {
    return ($self->{FORM} =~ /Teams/ ? 1 : 0);
  }
  else
  {
    die "No form";
  }
}


sub restriction_compatible
{
  my ($self, $unit_restriction) = @_;

  # The tournament may permit multiple sub-tournaments.
  # The unit restriction is the restriction on a team or a pair.
  
  return $restriction->check(
    $self->{RESTRICTION_AGE}, 
    $self->{RESTRICTION_GENDER},
    $unit_restriction);
}


sub str
{
  my ($self) = @_;

  for my $field (qw(TITLE ID CITY COUNTRY ORGANIZER
    DATE_START DATE_END YEAR FORM RESTRICTION_AGE RESTRICTION_GENDER))
  {
    next unless defined $self->{$field};
    print "$field $self->{$field}\n";
  }
}


1;
