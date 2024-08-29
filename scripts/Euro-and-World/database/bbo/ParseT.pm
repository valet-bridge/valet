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
use Tournaments::Germany;


my %DIVISIONS =
(
  GERMANY => \&Tournaments::Germany::set_links
);

my @MEET_FIELDS = qw(ORGANIZATION COUNTRY CITY ORIGIN ZONE);

my @TOURNAMENT_FIELDS = qw(ORGANIZATION COUNTRY CITY ORIGIN ZONEo
  FORM SCORING GENDER AGE);


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


sub get_edition
{
  my ($self, $tname, $date_added) = @_;
  return '' unless exists $self->{TOURNAMENT}{$tname};
  my $t = $self->{TOURNAMENT}{$tname};

  my $target = DateCalc->new();
  $target->set_by_field($date_added);

  my $lowest_dist = 9999;
  my $lowest_edition;
  for my $edition (keys %{$t->{EDITIONS}})
  {
    my $dist = $target->distance($edition,
      $t->{EDITIONS}{$edition}{DATE_START},
      $t->{EDITIONS}{$edition}{DATE_END});
    
    if ($dist < $lowest_dist)
    {
      $lowest_dist = $dist;
      $lowest_edition = $edition;
    }
  }

  if ($lowest_dist <= 7)
  {
    # Within one week
    return $lowest_edition;
  }
  else
  {
    return '';
  }
}


1;
