#!perl

package Email::Email;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';

use Email::Deletions;
use Email::Countries;
use Email::Multiples;
use Email::Privates;
use Email::Domains;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(looks_like);


sub looks_like
{
  # There could be multiple pieces of information on a line.
  # We attempt to return all of them.  The caller must then process
  # @$matches.

  my ($text, $matches) = @_;

  my @a = split '@', $text;
  return '' unless $#a == 1;

  my $dots = ($text =~ tr/\.//);
  return '' unless $dots >= 1 && $dots <= 4;

  $text =~ s/^\s+//;
  $text =~ s/\s+$//;

  return if exists $DELETIONS_HASH->{$text};

if ($text =~ /vandyk/)
{
  print "HERE\n";
}

  if ($text =~ s/\s*private$//)
  {
    push @$matches, 'PRIVATE', 'Private';
  }
  elsif ($text =~ s/^pri(.+)vate$/$1/)
  {
    push @$matches, 'PRIVATE', 'Private';
  }
  elsif ($text =~ s/^p(.+)rivate$/$1/)
  {
    push @$matches, 'PRIVATE', 'Private';
  }
  elsif ($text =~ s/^(.+)rivate$/$1/)
  {
    push @$matches, 'PRIVATE', 'Private';
  }
  elsif (exists $PRIVATES_HASH->{$text})
  {
    push @$matches, 'PRIVATE', 'Private';
    return;
  }
  elsif ($text =~ s/^private*(.+)$/$1/)
  {
    push @$matches, 'PRIVATE', 'Private';
  }

  if (exists $COUNTRIES_HASH->{$text})
  {
    push @$matches, 'COUNTRY', $COUNTRIES_HASH->{$text};
    return;
  }
  elsif (exists $MULTIPLES_HASH->{$text})
  {
    push @$matches, @{$MULTIPLES_HASH->{$text}};
    return;
  }

  my $spaces = ($text =~ tr/ //);
  if ($spaces > 3)
  {
    push @$matches, 'SYSTEM', $text;
    return;
  }

  if ($text =~ /[\x80-\xFF]/)
  {
    print "CHARSET $text\n";
    return;
  }

  $text =~ s/\s//g;

  my $regex = Email::Domains::regex();
  if ( $text =~ $regex)
  {
    my ($front, $back) = ($1, $2);
    print "EMAILX $text\n";
    return;
  }
  else
  {
    # Effectively there is only the guy who entered a regex left here.
    print "MAILMISS $text\n";
    return;
  }
}

1;


