#!perl

package Geography;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '../../bbo';
use lib '../../bbo/Connections';

use Whole;
use Connections::Matrix;

my $whole = Whole->new();
Connections::Matrix::set_matrix($whole);


# These are the tags that we understand.
my %TAGS = (
  CITY  => 'CITY',
  COUNTRY  => 'COUNTRY',
  EMAIL_CITY => 'CITY',
  EMAIL_COUNTRY => 'COUNTRY',
  EMAIL_REGION => 'REGION',
  EMAIL_UNIVERSITY => 'UNIVERSITY',
  LOCALITY => 'LOCALITY',
  REGION => 'REGION'
);

my %COUNTRY_SPECIALIZE =
(
  England => { 
    'Great Britain' => 'England',
    'United Kingdom' => 'England' },
  'Great Britain' => { 
    England => 'England',
    Scotland => 'Scotland',
    'United Kingdom' => 'Great Britain',
    Wales => 'Wales' },
  'Northern Ireland' => { 
    'Great Britain' => 'Northern Ireland',
    'United Kingdom' => 'Northern Ireland' },
  Scotland => { 
    'Great Britain' => 'Scotland',
    'United Kingdom' => 'Scotland' },
  'United Kingdom' => { 
    England => 'England',
    'Great Britain' => 'Great Britain',
    'Northern Ireland' => 'Northern Ireland' ,
    Scotland => 'Scotland',
    Wales => 'Wales' },
  Wales => { 
    'Great Britain' => 'Wales',
    'United Kingdom' => 'Wales' }
);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub add_tag
{
  my ($self, $tag, $value) = @_;

  if (! exists $self->{$tag})
  {
    $self->{$tag} = $value;
    return 1;
  }

  if ($self->{$tag} eq $value)
  {
    return 1;
  }

  if ($tag eq 'COUNTRY' &&
      exists $COUNTRY_SPECIALIZE{$value} &&
      exists $COUNTRY_SPECIALIZE{$value}{$self->{$tag}})
  {
    $self->{$tag} = $COUNTRY_SPECIALIZE{$value}{$self->{$tag}};
    return 1;
  }

  warn "Geography::add_tag: Have $self->{$tag}, got $value";
  return 0;
}


sub add
{
  my ($self, $tag, $value) = @_;

  return 0 unless exists $TAGS{$tag};
  my $my_tag = $TAGS{$tag};

  if ($my_tag eq 'COUNTRY')
  {
    return $self->add_tag($my_tag, $value);
  }

  if ($my_tag eq 'REGION')
  {
    return 0 unless $self->add_tag($my_tag, $value);

    my $country = $whole->get_matrix_element('REGION', 'COUNTRY', 
      lc($value));
    return $self->add_tag('COUNTRY', $country);
  }

  if ($my_tag eq 'CITY')
  {
    return 0 unless $self->add_tag($my_tag, $value);

    my $country = $whole->get_matrix_element('CITY', 'COUNTRY', 
      lc($value));
    return $self->add_tag('COUNTRY', $country);
  }

  if ($my_tag eq 'LOCALITY')
  {
    return 0 unless $self->add_tag($my_tag, $value);

    my $city = $whole->get_matrix_element('LOCALITY', 'CITY', 
      lc($value));
    return 0 unless $self->add_tag('CITY', $city);

    my $country = $whole->get_matrix_element('CITY', 'COUNTRY', 
      lc($city));
    return $self->add_tag('COUNTRY', $country);
  }

  if ($my_tag eq 'UNIVERSITY')
  {
    return 0 unless $self->add_tag($my_tag, $value);

    my $city = $whole->get_matrix_element('UNIVERSITY', 'CITY', 
      lc($value));
    return 0 unless $self->add_tag('CITY', $city);

    my $country = $whole->get_matrix_element('CITY', 'COUNTRY', 
      lc($city));
    return $self->add_tag('COUNTRY', $country);
  }

  warn "Geography::add_tag: Unknown tag $my_tag";
  return 0;
}


sub set_hash
{
  my ($self, $hash) = @_;

  for my $tag (qw(COUNTRY REGION CITY LOCALITY UNIVERSITY))
  {
    push @{$hash->{$tag}}, $self->{$tag} if exists $self->{$tag};
  }
}


sub str
{
  my ($self) = @_;

  my $s = '';
  for my $tag (qw(COUNTRY REGION CITY LOCALITY UNIVERSITY))
  {
    $s .= "$tag $self->{$tag}\n" if exists $self->{$tag};
  }
  return $s;
}


1;
