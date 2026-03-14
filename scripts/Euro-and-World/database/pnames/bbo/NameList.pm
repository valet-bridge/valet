#!perl

package NameList;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

# These are the tags that we understand.
my %TAGS = (
  NAME_FIRST => 'FIRST',
  NAME_INITIAL => 'INITIAL',
  NAME_LAST => 'LAST',
  NAME_NICK => 'NICK',
  NAME_PARTICLE => 'PARTICLE'
);

sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub align_long_short
{
  # Not a class method.
  my ($long, $short) = @_;

  my $nlong = $#$long;
  my $nshort = $#$short;

  my $lindex = 0;
  my $sindex = 0;

  while (1)
  {
    my $stag = $short->[$sindex];
    while (1)
    {
      my $ltag = $long->[$lindex];
      if ($ltag eq $stag &&
          lc($long->[$lindex+1]) eq lc($short->[$sindex+1]))
      {
        $lindex += 2;
        $sindex += 2;
        return 1 if ($sindex > $nshort);
        return 0 if ($lindex > $nlong);
        last;
      }
      else
      {
        $lindex += 2;
      }

      return 0 if ($lindex > $nlong);
    }
  }
}


sub add_list
{
  my ($self, $list) = @_;

  if (! exists $self->{LIST})
  {
    @{$self->{LIST}} = @$list;
    $self->{LAST} = $#$list;
    return 1;
  }

  if ($#$list > $self->{LAST})
  {
    if (align_long_short($list, $self->{LIST}))
    {
      @{$self->{LIST}} = @$list;
      $self->{LAST} = $#$list;
      return 1;
    }
  }
  elsif (align_long_short($self->{LIST}, $list))
  {
    return 1;
  }
  else
  {
    return 0;
  }
}


sub update_stats
{
  my ($self, $stats) = @_;

  return '' unless exists $self->{LIST};

  for (my $i = 0; $i <= $self->{LAST}; $i += 2)
  {
    $stats->{$self->{LIST}[$i]}++;
  }
}



sub str
{
  my ($self) = @_;

  return '' unless exists $self->{LIST};

  my $s = '';
  for (my $i = 0; $i <= $self->{LAST}; $i += 2)
  {
    $s .= "$self->{LIST}[$i] $self->{LIST}[$i+1]\n";
  }
  return $s;
}


1;
