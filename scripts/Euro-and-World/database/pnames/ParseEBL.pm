#!perl

package ParseEBL;

use strict;
use warnings;
use v5.10;
use open ':std', ':encoding(iso-8859-1)';

use lib '.';

use PlayerEBL;

my @FIELDS = qw(
  EBL 
  WBF WBF_DEPRECATED
  NAME NAME_DEPRECATED NAME_PREFERRED
  COUNTRY COUNTRY_DEPRECATED
  BIRTH_EXACT
  DEATH_EXACT
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


sub read
{
  my ($self, $fname) = @_;

  open my $fh, '<', $fname or die "Cannot read file: $!";
  my %chunk = ();
  my $lno = 0;
  while (my $line = <$fh>)
  {
    chomp $line;
    $line =~ s///g;
    $lno++;
    if ($line eq '')
    {
      $self->transfer_chunk(\%chunk, $fname, $lno);
      %chunk = ();
    }
    elsif ($line =~ /^([A-Z_]+)\s+(.*)$/)
    {
      my ($field, $value) = ($1, $2);
      push @{$chunk{$field}}, $value;
    }
    elsif ($line =~ /^DELETED$/)
    {
      # TODO Remember so we can print it?
      %chunk = ();
      $line = <$fh>;
      die "$fname line $lno: Expected empty line" unless $line =~ /^\s*$/;
    }
    else
    {
      die "$fname line $lno: $line\n";
    }
  }
  close $fh;

  if (%chunk)
  {
    die "$fname does not end with an empty line";
  }
}


sub transfer_chunk
{
  my ($self, $chunk, $fname, $lno) = @_;

  if (exists $chunk->{EBL_PREFERRED})
  {
    $self->alias_chunk($chunk, $fname, $lno);
    return;
  }

  for my $key (qw(EBL NAME COUNTRY))
  {
    die "$fname line $lno: No $key\n" unless exists $chunk->{$key};
  }

  if ($#{$chunk->{EBL}} != 0)
  {
    die "$fname line $lno: Expected exactly one EBL\n";
  }

  my $ebl = $chunk->{EBL}[0];
  if (exists $self->{EBL}{$ebl})
  {
    die "$fname line $lno: EBL $ebl already seen\n";
  }

  # The master storage from which the file can be reconstructed is EBL.
  # There is also NAME (for each spelling), and then the same two
  # but by country.

  $self->{EBL}{$ebl} = PlayerEBL->new();
  $self->{EBL}{$ebl}->set_by_chunk($chunk, $fname, $lno);

  for my $key (qw(NAME NAME_PREFERRED NAME_DEPRECATED))
  {
    for my $version (@{$chunk->{$key}})
    {
      if (exists $self->{NAME}{$version})
      {
        die "$fname line $lno: Name $version already seen ($key)\n";
      }
      # Shallow copy.
      $self->{NAME}{$version} = $self->{EBL}{$ebl};
    }
  }

  for my $country (@{$chunk->{COUNTRY}})
  {
    if (exists $self->{COUNTRY_EBL}{$country}{$ebl})
    {
      die "$fname line $lno: EBL $ebl already seen ($country, $ebl)\n";
    }

    $self->{COUNTRY_EBL}{$country}{$ebl} = $self->{EBL}{$ebl};

    for my $key (qw(NAME NAME_PREFERRED NAME_DEPRECATED))
    {
      for my $version (@{$chunk->{$key}})
      {
        if (exists $self->{COUNTRY_NAME}{$country}{$version})
        {
          die "$fname line $lno: Name $version already seen ($key)\n";
        }

        $self->{COUNTRY_NAME}{$country}{$version} = $self->{EBL}{$ebl};
      }
    }
  }
}


sub alias_chunk
{
  my ($self, $chunk, $fname, $lno) = @_;

  die "$fname line $lno: Alias must have EBL\n" unless
    exists $chunk->{EBL};

  for my $key (keys %$chunk)
  {
    if ($key ne 'EBL' && $key ne 'EBL_PREFERRED')
    {
      die "$fname line $lno: Unexpected key $key\n";
    }
  }

  $self->{ALIAS}{$chunk->{EBL_PREFERRED}[0]} = $chunk->{EBL}[0];
}


sub str
{
  my ($self) = @_;

  my $s = '';
  for my $ebl (sort { $a <=> $b } keys %{$self->{EBL}})
  {
    $s .= $self->{EBL}{$ebl}->str() . "\n";
  }

  for my $ebl_pref (sort { $a <=> $b } keys %{$self->{ALIAS}})
  {
    $s .= "EBL " . $self->{ALIAS}{$ebl_pref} . "\n";
    $s .= "EBL_PREFERRED " . $ebl_pref . "\n\n";
  }

  return $s;
}


1;
