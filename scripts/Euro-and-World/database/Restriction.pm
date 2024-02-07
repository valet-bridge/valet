#!perl

package Restriction;

use strict;
use warnings;
use Exporter;
use v5.10;

my %RESTRICTIONS = (
  "Girls series" => { age => "U26", gender => "Women" },
  "Juniors series" => { age =>, "U26", gender => "Open" },
  "Juniors Swiss series" => { age =>, "U26", gender => "Open" },
  "Juniors B-A-M series" => { age =>, "U26", gender => "Open" },

  "U28 series" => { age =>, "U28", gender => "Open" },

  "Youngsters series" => { age =>, "U21", gender => "Open" },
  "U31 series" => { age =>, "U31", gender => "Open" },

  "Kids series" => { age => "U16", gender => "Open" },

  "All series" => { age => "Open", gender => "Open" },
  "Open series" => { age => "Open", gender => "Open" },
  "Transnational Open series" => { age => "Open", gender => "Open" },
  "Bermuda Bowl series" => { age => "Open", gender => "Open" },
  "Rosenblum Cup series" => { age => "Open", gender => "Open" },
  "Rosenblum series" => { age => "Open", gender => "Open" },
  "Rand Cup series" => { age => "Open", gender => "Open" },
  "Transnational Teams series" => { age => "Open", gender => "Open" },
  "Open Olympiad series" => { age => "Open", gender => "Open" },
  "Olympiad series" => { age => "Open", gender => "Open" },
  "Transnational Teams (BB) series" => { age =>"Open", gender => "Open" },

  "Senior Bowl series" => { age => "Seniors", gender => "Open" },
  "Seniors series" => { age => "Seniors", gender => "Open" },
  "d'Orsi Bowl series" => { age => "Seniors", gender => "Open" },

  "Venice Cup series"  => { age => "Open", gender => "Women" },
  "McConnell Cup series"  => { age => "Open", gender => "Women" },
  "McConnell series"  => { age => "Open", gender => "Women" },
  "Women series" => { age => "Open", gender => "Women" },

  "Wuhan Cup series" => { age => "Open", gender => "Mixed" },
  "Mixed series" => { age => "Open", gender => "Mixed" },
  "Mixed Teams series" => { age => "Open", gender => "Mixed" },
  "Transnational Mixed series" => { age => "Open", gender => "Mixed" },
  "Transnational Mixed Teams series" => { age => "Open", gender => "Mixed" }
);


sub new
{
  return bless {}, shift;
}


sub check
{
  my ($self, $age, $gender, $restriction) = @_;
  return 0 unless exists $RESTRICTIONS{$restriction};

  return 1 if $age eq 'Multiple' && $gender eq 'Multiple';

  return 0 unless $age eq $RESTRICTIONS{$restriction}{age};
  return 0 unless $gender eq $RESTRICTIONS{$restriction}{gender};
  return 1;
}


sub gender
{
  my ($self, $tourn_gender, $unit_restriction, $errstr) = @_;

  my $specific_gender;
  if (defined $RESTRICTIONS{$unit_restriction})
  {
    $specific_gender = $RESTRICTIONS{$unit_restriction}{gender};
  }
  else
  {
    $specific_gender = $unit_restriction;
  }

  if ($tourn_gender eq 'Women')
  {
    if ($specific_gender eq 'Women')
    {
      return 'Women';
    }
    else
    {
      die "$errstr: Unit restriction $unit_restriction " .
        "incompatible with $tourn_gender";
    }
  }
  else
  {
    return $specific_gender;
  }
}


sub age
{
  my ($self, $tourn_age, $unit_restriction, $errstr) = @_;

  my $specific_age;
  if (defined $RESTRICTIONS{$unit_restriction})
  {
    $specific_age = $RESTRICTIONS{$unit_restriction}{age};
  }
  else
  {
    $specific_age = $unit_restriction;
  }

  if ($tourn_age eq 'Open' || $tourn_age eq 'Multiple')
  {
    return $specific_age;
  }
  elsif ($tourn_age eq 'Seniors')
  {
    if ($specific_age eq 'Seniors')
    {
      return $specific_age;
    }
    else
    {
      die "$errstr: Unit age $specific_age incompatible with Seniors";
    }
  }
  elsif ($tourn_age eq $specific_age)
  {
    return $specific_age;
  }
  else
  {
    die "$errstr: Unit age $specific_age incompatible with $tourn_age";
  }
}


1;
