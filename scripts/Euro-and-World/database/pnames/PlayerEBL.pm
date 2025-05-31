#!perl

package PlayerEBL;

use strict;
use warnings;
use v5.10;
use open ':std', ':encoding(iso-8859-1)';

use lib '.';
use lib '..';

use Country;
my $country = Country->new();

use Analysis;

my @FIELDS = qw(
  NAME NAME_PREFERRED NAME_DEPRECATED
  BIRTH_EXACT
  DEATH_EXACT
  COUNTRY COUNTRY_DEPRECATED
  EBL 
  WBF WBF_DEPRECATED
  GENDER 
  TOURNAMENT);

my %FIELDS_HASH;
$FIELDS_HASH{$_} = 1 for @FIELDS;


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub set_by_chunk
{
  my ($self, $chunk, $fname, $lno) = @_;

  for my $key (keys %$chunk)
  {
    die "$fname line $lno: Unexpected field $key\n" unless
      exists $FIELDS_HASH{$key};
  }

  for my $key (qw(EBL))
  {
    $self->set_integer($chunk, $key, $fname, $lno);
  }

  for my $key (qw(EBL WBF WBF_DEPRECATED 
    NAME NAME_DEPRECATED NAME_PREFERRED))
  {
    $self->set_arbitrary($chunk, $key);
  }

  for my $key (qw(COUNTRY COUNTRY_DEPRECATED))
  {
    $self->set_country($chunk, $key, $fname, $lno);
  }

  for my $key (qw(BIRTH_EXACT DEATH_EXACT))
  {
    $self->set_date($chunk, $key, $fname, $lno);
  }

  $self->set_gender($chunk, $fname, $lno);

  $self->set_tournaments($chunk, $fname, $lno);

  $self->{ANALYSIS} = Analysis->new();
  for my $key (qw(NAME NAME_DEPRECATED NAME_PREFERRED))
  {
    for my $v (@{$self->{$key}})
    {
      $self->{ANALYSIS}->add($key, $v, $self->{COUNTRY}[0]);
    }
  }
}


sub set_integer
{
  my ($self, $chunk, $key, $fname, $lno) = @_;

  return unless exists $chunk->{$key};
  for my $value (@{$chunk->{$key}})
  {
    if ($value !~ /^\d+$/)
    {
      die "$fname line $lno: $value is not an integer ($key)";
    }
  }

  $self->set_arbitrary($chunk, $key);
}


sub set_arbitrary
{
  my ($self, $chunk, $key) = @_;
  return unless exists $chunk->{$key};
  @{$self->{$key}} = @{$chunk->{$key}};
}


sub set_country
{
  my ($self, $chunk, $key, $fname, $lno) = @_;
  return unless exists $chunk->{$key};

  for my $value (@{$chunk->{$key}})
  {
    if (! $country->valid($value))
    {
      warn "$fname line $lno: $value is not a country";
    }
  }

  $self->set_arbitrary($chunk, $key);
}

sub set_date
{
  my ($self, $chunk, $key, $fname, $lno) = @_;
  return unless exists $chunk->{$key};

  # TODO Perhaps we will also need actual dates.

  for my $value (@{$chunk->{$key}})
  {
    if ($value !~ /^\d+$/)
    {
      die "$fname line $lno: $value is not an integer ($key)";
    }
    if ($value < 1900 || $value > 2100)
    {
      die "$fname line $lno: $value is not a year ($key)";
    }
  }

  $self->set_arbitrary($chunk, $key);
}


sub set_gender
{
  my ($self, $chunk, $fname, $lno) = @_;
  return unless exists $chunk->{GENDER};

  if ($#{$chunk->{GENDER}} != 0)
  {
    die "$fname line $lno: expected exactly one gender";
  }

  my $value = $chunk->{GENDER}[0];
  if ($value ne 'M' && $value ne 'F' && $value ne '?')
  {
    die "$fname line $lno: expected gender M, F or ?";
  }

  $self->set_arbitrary($chunk, 'GENDER');
}


sub set_tournaments
{
  my ($self, $chunk, $fname, $lno) = @_;
  return unless exists $chunk->{TOURNAMENT};

  for my $value (@{$chunk->{TOURNAMENT}})
  {
    if ($value !~ /^(\d+)\|(\d+)\|(.+)$/)
    {
      die "$fname line $lno: Bad TOURNAMENT line $value";
    }
    
    # WBF tournament number, year, tag (partner, team name, ...)
    push @{$self->{TOURNAMENT}}, [$1, $2, $3];
  }
}


sub str
{
  my ($self) = @_;

  my $s = '';
  for my $key (@FIELDS)
  {
    next unless exists $self->{$key};
    if ($key eq 'TOURNAMENT')
    {
      for my $i (0 .. $#{$self->{$key}})
      {
        $s .= $key . ' ' . join('|', @{$self->{$key}[$i]}) . "\n";
      }
    }
    else
    {
      for my $version (@{$self->{$key}})
      {
        $s .= "$key $version\n";
      }
    }
  }
  return $s;
}


1;
