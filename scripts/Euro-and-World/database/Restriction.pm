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

1;
