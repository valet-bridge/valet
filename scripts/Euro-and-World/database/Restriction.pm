#!perl

package Restriction;

use strict;
use warnings;
use Exporter;
use v5.10;

my %RESTRICTIONS = (
  "Girls series" => 
    { age => "U26", gender => "Women", stage => "General" },
  "Juniors series" => 
    { age =>, "U26", gender => "Open", stage => "General" },
  "Juniors Swiss series" => 
    { age =>, "U26", gender => "Open", stage => "General" },
  "Juniors B-A-M series" => 
    { age =>, "U26", gender => "Open", stage => "General" },
  "U28 series" => 
    { age =>, "U28", gender => "Open", stage => "General" },
  "Youngsters series" => 
    { age =>, "U21", gender => "Open", stage => "General" },
  "U31 series" => 
    { age =>, "U31", gender => "Open", stage => "General" },

  "Kids series" => 
    { age => "U16", gender => "Open", stage => "General" },

  "All series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Open series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Transnational Open series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Bermuda Bowl series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Rosenblum Cup series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Rosenblum series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Rand Cup series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Transnational Teams series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Open Olympiad series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Olympiad series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Transnational Teams (BB) series" => 
    { age =>"Open", gender => "Open", stage => "General" },

  "Senior Bowl series" => 
    { age => "Seniors", gender => "Open", stage => "General" },
  "Seniors series" => 
    { age => "Seniors", gender => "Open", stage => "General" },
  "d'Orsi Bowl series" => 
    { age => "Seniors", gender => "Open", stage => "General" },

  "Venice Cup series"  => 
    { age => "Open", gender => "Women", stage => "General" },
  "McConnell Cup series"  => 
    { age => "Open", gender => "Women", stage => "General" },
  "McConnell series"  => 
    { age => "Open", gender => "Women", stage => "General" },
  "Women series" => 
    { age => "Open", gender => "Women", stage => "General" },

  "Wuhan Cup series" => 
    { age => "Open", gender => "Mixed", stage => "General" },
  "Mixed series" => 
    { age => "Open", gender => "Mixed", stage => "General" },
  "Mixed series Qualifying" => 
    { age => "Open", gender => "Mixed", stage => "Qualifying" },
  "Mixed series Consolation" => 
    { age => "Open", gender => "Mixed", stage => "Consolation" },
  "Mixed Teams series" => 
    { age => "Open", gender => "Mixed", stage => "General" },
  "Transnational Mixed series" => 
    { age => "Open", gender => "Mixed", stage => "General" },
  "Transnational Mixed Teams series" => 
    { age => "Open", gender => "Mixed", stage => "General" }
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
    if ($specific_gender eq 'Women' || $specific_gender eq 'None')
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
    if ($specific_age eq 'Seniors' ||
        $specific_age eq 'None')
    {
      return 'Seniors';
    }
    else
    {
      die "$errstr: Unit age $specific_age incompatible with Seniors";
    }
  }
  elsif ($tourn_age eq $specific_age ||
    $specific_age eq 'None')
  {
    return $tourn_age;
  }
  else
  {
    die "$errstr: Unit age $specific_age incompatible with $tourn_age";
  }
}


sub stage
{
  my ($self, $tourn_stage, $unit_restriction, $errstr) = @_;

  if (! defined $tourn_stage || $tourn_stage eq 'Multiple')
  {
    if (defined $unit_restriction)
    {
      return $unit_restriction;
    }
    else
    {
      return 'General';
    }
  }
  elsif (defined $unit_restriction)
  {
    die "$errstr: Unit stage $unit_restriction vs $tourn_stage";
  }
  else
  {
    return $tourn_stage;
  }
}


1;
