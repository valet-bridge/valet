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
  "Juniors series Semifinal A" => 
    { age =>, "U26", gender => "Open", stage => "Semifinal A" },
  "Juniors series Semifinal B" => 
    { age =>, "U26", gender => "Open", stage => "Semifinal B" },
  "Juniors series Qualification A" => 
    { age =>, "U26", gender => "Open", stage => "Qualifying A" },
  "Juniors series Qualification B" => 
    { age =>, "U26", gender => "Open", stage => "Qualifying B" },
  "Juniors series Consolation" => 
    { age =>, "U26", gender => "Open", stage => "Consolation" },
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
  "Kids series Qualifier" => 
    { age => "U16", gender => "Open", stage => "Qualifying" },

  "All series" => 
    { age => "Open", gender => "Open", stage => "General" },

  "Open series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Open series Final B" => 
    { age => "Open", gender => "Open", stage => "Final B" },
  "Open series Final C" => 
    { age => "Open", gender => "Open", stage => "Final C" },
  "Open series Semifinal" => 
    { age => "Open", gender => "Open", stage => "Semifinal" },
  "Open series Semifinal A" => 
    { age => "Open", gender => "Open", stage => "Semifinal A" },
  "Open series Semifinal B" => 
    { age => "Open", gender => "Open", stage => "Semifinal B" },
  "Open series Qualifying" => 
    { age => "Open", gender => "Open", stage => "Qualifying" },
  "Open series Consolation" => 
    { age => "Open", gender => "Open", stage => "Consolation" },
  "Open series Consolation A" => 
    { age => "Open", gender => "Open", stage => "Consolation A" },
  "Open series Consolation B" => 
    { age => "Open", gender => "Open", stage => "Consolation B" },
  "Open series Qualifier" => 
    { age => "Open", gender => "Open", stage => "Qualifying" },

  "Transnational Open series" => 
    { age => "Open", gender => "Open", stage => "BB" },
  "Bermuda Bowl series" => 
    { age => "Open", gender => "Open", stage => "BB" },
  "Rosenblum Cup series" => 
    { age => "Open", gender => "Open", stage => "Rosenblum" },
  "Rosenblum series" => 
    { age => "Open", gender => "Open", stage => "Rosenblum" },
  "Rand Cup series" => 
    { age => "Open", gender => "Open", stage => "Rand" },
  "Transnational Teams series" => 
    { age => "Open", gender => "Open", stage => "TNT" },
  "Open Olympiad series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Olympiad series" => 
    { age => "Open", gender => "Open", stage => "General" },
  "Transnational Teams (BB) series" => 
    { age =>"Open", gender => "Open", stage => "TNT" },

  "Senior Bowl series" => 
    { age => "Seniors", gender => "Open", stage => "General" },
  "Seniors series" => 
    { age => "Seniors", gender => "Open", stage => "General" },
  "Seniors series Semifinal" => 
    { age => "Seniors", gender => "Open", stage => "Semifinal" },
  "Seniors series Semifinal A" => 
    { age => "Seniors", gender => "Open", stage => "Semifinal A" },
  "Seniors series Semifinal B" => 
    { age => "Seniors", gender => "Open", stage => "Semifinal B" },
  "Seniors series Qualifier" => 
    { age => "Seniors", gender => "Open", stage => "Qualifying" },
  "Seniors series Qualifying" => 
    { age => "Seniors", gender => "Open", stage => "Qualifying" },
  "Seniors series Consolation" => 
    { age => "Seniors", gender => "Open", stage => "Consolation" },
  "d'Orsi Bowl series" => 
    { age => "Seniors", gender => "Open", stage => "General" },

  "Venice Cup series"  => 
    { age => "Open", gender => "Women", stage => "VC" },
  "McConnell Cup series"  => 
    { age => "Open", gender => "Women", stage => "McConnell" },
  "McConnell series"  => 
    { age => "Open", gender => "Women", stage => "McConnell" },
  "Women series" => 
    { age => "Open", gender => "Women", stage => "General" },
  "Women series Semifinal" => 
    { age => "Open", gender => "Women", stage => "Semifinal" },
  "Women series Semifinal A" => 
    { age => "Open", gender => "Women", stage => "Semifinal A" },
  "Women series Semifinal B" => 
    { age => "Open", gender => "Women", stage => "Semifinal B" },
  "Women series Qualifier" => 
    { age => "Open", gender => "Women", stage => "Qualifying" },
  "Women series Qualifying" => 
    { age => "Open", gender => "Women", stage => "Qualifying" },
  "Women series Consolation" => 
    { age => "Open", gender => "Women", stage => "Consolation" },
  "Women series Consolation B" => 
    { age => "Open", gender => "Women", stage => "Consolation B" },

  "Wuhan Cup series" => 
    { age => "Open", gender => "Mixed", stage => "WC" },
  "Mixed series" => 
    { age => "Open", gender => "Mixed", stage => "General" },
  "Mixed series Final A" => 
    { age => "Open", gender => "Mixed", stage => "Final A" },
  "Mixed series Final B" => 
    { age => "Open", gender => "Mixed", stage => "Final B" },
  "Mixed series Final C" => 
    { age => "Open", gender => "Mixed", stage => "Final C" },
  "Mixed series Semifinal A" => 
    { age => "Open", gender => "Mixed", stage => "Semifinal A" },
  "Mixed series Semifinal B" => 
    { age => "Open", gender => "Mixed", stage => "Semifinal B" },
  "Mixed series Qualifying" => 
    { age => "Open", gender => "Mixed", stage => "Qualifying" },
  "Mixed series Consolation" => 
    { age => "Open", gender => "Mixed", stage => "Consolation" },
  "Mixed Teams series" => 
    { age => "Open", gender => "Mixed", stage => "General" },
  "Transnational Mixed series" => 
    { age => "Open", gender => "Mixed", stage => "TNT" },
  "Transnational Mixed Teams series" => 
    { age => "Open", gender => "Mixed", stage => "TNT" }
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

  my $specific_stage;
  if (defined $RESTRICTIONS{$unit_restriction})
  {
    $specific_stage = $RESTRICTIONS{$unit_restriction}{stage};
  }
  else
  {
    $specific_stage = $unit_restriction;
  }

  if (! defined $tourn_stage || $tourn_stage eq 'Multiple')
  {
    return $specific_stage;
  }
  elsif ($specific_stage ne $tourn_stage)
  {
    die "$errstr: Unit stage $specific_stage vs $tourn_stage";
  }
  else
  {
    return $tourn_stage;
  }
}


1;
