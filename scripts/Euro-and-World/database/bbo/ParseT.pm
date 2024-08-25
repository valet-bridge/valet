#!perl

package ParseT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib '..';

use Tournaments::Germany;


my %DIVISIONS =
(
  GERMANY => \&Tournaments::Germany::set_links
);

my @MEET_FIELDS = qw(ORGANIZATION COUNTRY CITY ORIGIN ZONE);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub set_parse_links
{
  my ($self, $dictionary, $key) = @_;

  for my $meet (sort keys %$dictionary)
  {
    for my $mfield (@MEET_FIELDS)
    {
      if (exists $dictionary->{$meet}{$mfield})
      {
        $self->{MEET}{$mfield} = $dictionary->{$meet}{$mfield};
      }
    }

    for my $tname (sort keys %{$dictionary->{$meet}})
    {
      # Was a meeting field?
      next if exists $self->{MEET}{$tname};
      %{$self->{TOURNAMENT}{$tname}} = %{$dictionary->{$meet}{$tname}};
    }
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



sub is_tname
{
  my ($self, $tname) = @_;

  return exists $self->{TOURNAMENT}{$tname};
}


1;
