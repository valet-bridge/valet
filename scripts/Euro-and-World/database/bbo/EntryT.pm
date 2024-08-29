#!perl

package EntryT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub read
{
  my ($self, $fh) = @_;

  %$self = ();

  my $line;
  return 0 unless defined($line = <$fh>);

  die "Not a BBONO: $line" unless $line =~ /^BBONO\s+(\d+)$/;
  $self->{BBONO} = $1;

  do
  {
    $line = <$fh>;
    chomp $line;
  }
  while ($line ne '');

  while (1)
  {
    $line = <$fh>;
    chomp $line;
    return 1 if $line eq '';

    if ($line !~ /^([A-Z0-9_]+)\s(.*)$/)
    {
      die "$self->{BBONO}: Malformed line $line";
    }

    my ($tag, $value) = ($1, $2);
    push @{$self->{$tag}}, $value;
  }

  return 1;
}


sub field
{
  my ($self, $field) = @_;

  if (exists $self->{$field})
  {
    # TODO For now.  What is there is more than one?
    return $self->{$field}[0];
  }
  else
  {
    return '';
  }
}


sub bbono
{
  my ($self) = @_;
  return $self->{BBONO};
}


sub str_fields
{
  my ($self, $key) = @_;

  my $s = '';
  for my $v (@{$self->{$key}})
  {
    $s .= "$key $v\n";
  }
  return $s;
}


sub str
{
  my ($self) = @_;

  my $s = "BBONO $self->{BBONO}\n";

  for my $order (qw(TITLE_ TEAM1_ TEAM2_ EVENT_ DATE_))
  {
    for my $key (sort keys %$self)
    {
      if ($key =~ /^$order/)
      {
        $s .= $self->str_fields($key);
      }
    }
  }

  if (exists $self->{BOARDS})
  {
    $s .= $self->str_fields('BOARDS');
  }

  if (exists $self->{SCORING})
  {
    $s .= $self->str_fields('SCORING');
  }

  return "$s\n";
}


1;
