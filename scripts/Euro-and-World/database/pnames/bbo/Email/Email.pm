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
use Email::Servers;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(looks_like);


sub looks_like
{
  # There could be multiple pieces of information on a line.
  # We attempt to return all of them.  The caller must then process
  # @$matches.

  my ($orig_text, $matches) = @_;

  my @a = split '@', $orig_text;
  return '' unless $#a == 1;

  my $dots = ($orig_text =~ tr/\.//);
  return '' unless $dots >= 1 && $dots <= 4;

  $orig_text =~ s/^\s+//;
  $orig_text =~ s/\s+$//;
  my $text = $orig_text;
  $text =~ s/\s//g;

  return if exists $DELETIONS_HASH->{$text};

  if ($text =~ /\@juno.com/i)
  {
    print "HERE\n";
  }

  if (exists $PRIVATES_HASH->{$text})
  {
    push @$matches, 'PRIVATE', 'Private';
    return;
  }

  if ($text =~ s/\s*private$// ||
      $text =~ s/^pri(.+)vate$/$1/ ||
      $text =~ s/^p(.+)rivate$/$1/ ||
      $text =~ s/^(.+)rivate$/$1/ ||
      $text =~ s/^private*(.+)$/$1/)
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

  my $spaces = ($orig_text =~ tr/ //);
  if ($spaces > 3)
  {
    push @$matches, 'SYSTEM', $text;
    return;
  }

  if ($text =~ /[\x80-\xFF]/)
  {
    print "CHARSET $orig_text\n";
    return;
  }

  my $regex = Email::Domains::regex();
  if ( $text !~ $regex)
  {
    # No hits.
    print "MAILMISS $text\n";
    return;
  }

  my ($front, $sep, $domain) = ($1, $2, $3);
  if ($sep eq '@')
  {
    # Ignore return value for now.
    parse_user($front, $matches);

    my $country = Email::Domains::country($domain);
    push @$matches, 'EMAIL_COUNTRY', $country if $country;
    push @$matches, 'EMAIL', $text;
    return;
  }

  if ($sep ne '.')
  {
    # Clean.
    print "MAILODD9 $text\n";
    return;
  }

  if ($front !~ /^([a-z0-9._-]+)@/)
  {
    # Clean.
    print "MAILODD8 $orig_text, $front\n";
    return;
  }
  my $user = $1;

  my $server;
  if ($front !~ /@([a-z0-9_-]+)$/)
  {
    my $remainder = $front;
    $remainder =~ s/^.*@(.*)/$1/;
    $server = $1;
    if (! Email::Servers::is_server($domain, $remainder))
    {
      # Otherwise fall through.
      print "MAILODD7 $text, $remainder\n";
      return;
    }
  }
  else
  {
    $server = $1;
  }

  # if ($front !~ /^([a-z0-9._-]+)@([a-z0-9_-]+)$/)
  # {
    # if ($front !~ /@.*\./)
    # {
      # print "MAILODD8 $orig_text, $front\n";
      # return;
    # }
    # else
    # {
      # my $remainder = $front;
      # $remainder =~ s/^.*@(.*)/$1/;
      # print "MAILODD7 $text, $remainder\n";
      # return;
    # }
  # }

  # print "MAILINFO $server ($domain)\n";

  # Ignore return value for now.
  parse_user($user, $matches);
  return;
}


sub parse_user
{
  my ($user, $matches) = @_;

  if ($user =~ /^\d+$/)
  {
    push @$matches, 'USER_NUMERICAL', $1;
    return 1;
  }

  $user =~ s/^[\d_.-]+//;
  $user =~ s/[\d_.-]+$//;

  if ($user =~ /^[a-z]+$/)
  {
    # A single string, potentially followed by numbers.
    push @$matches, 'USER_LETTERS', $user;
    return 1;
  }

  if ($user !~ /^[a-z0-9._-]+$/)
  {
    print "MAILODD4 $user\n";
    return 0;
  }

  my @a = split /\./, $user;
  my @b = split '_', $user;
  my @c = split '-', $user;

  if ($#a == 0 && $#b == 0 && $#c == 0)
  {
    # Checked manually.
    push @$matches, 'USER_UNPARSEABLE', $user;
    return 1;
  }
  elsif ($#a == 1 && $#b == 0 && $#c == 0)
  {
    push @$matches, 'USER_FIRST', $a[0];
    push @$matches, 'USER_SECOND', $a[1];
    return 1;
  }
  elsif ($#a == 0 && $#b == 1 && $#c == 0)
  {
    push @$matches, 'USER_FIRST', $b[0];
    push @$matches, 'USER_SECOND', $b[1];
    return 1;
  }
  elsif ($#a == 0 && $#b == 0 && $#c == 1)
  {
    push @$matches, 'USER_FIRST', $c[0];
    push @$matches, 'USER_SECOND', $c[1];
    return 1;
  }
  else
  {
    print "MAILODD2 $user\n";
    return 0;
  }
}


1;
