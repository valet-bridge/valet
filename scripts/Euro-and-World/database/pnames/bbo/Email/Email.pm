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
use Email::Edits;
use Email::Multiples;
use Email::Privates;
use Email::Domains;
use Email::Servers;
use Email::Users;
use Email::Unparseable;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(looks_like);


sub looks_like
{
  # There could be multiple pieces of information on a line.
  # We attempt to return all of them.  The caller must then process
  # @$matches.

  my ($orig_text, $matches) = @_;

  # Emails have '@'.
  my @a = split '@', $orig_text;
  return unless $#a == 1;

  # Emails don't have too many dots.
  my $dots = ($orig_text =~ tr/\.//);
  return unless $dots >= 1 && $dots <= 4;

  # Clean up some spaces.
  $orig_text =~ s/^\s+//;
  $orig_text =~ s/\s+$//;
  my $text = $orig_text;
  $text =~ s/\s//g;

  if (exists $DELETIONS_HASH->{$text})
  {
    push @$matches, 'DELETE', $orig_text;
    return;
  }
  elsif (exists $PRIVATES_HASH->{$text})
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
    # Fall through.
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
  elsif (exists $EDITS_HASH->{$text})
  {
    # Fall through.
    $text = $EDITS_HASH->{$text};
  }

  my $spaces = ($orig_text =~ tr/ //);
  if ($spaces > 3)
  {
    push @$matches, 'SYSTEM', $text;
    return;
  }

  if ($text =~ /[\x80-\xFF]/)
  {
    special_kludge($text, $matches);
    return;
  }

  my $regex = Email::Domains::regex();
  if ( $text !~ $regex)
  {
    # Doesn't happen.
    return;
  }

  my ($front, $sep, $domain) = ($1, $2, $3);
  if ($sep eq '@')
  {
    parse_user($front, $matches);

    my $country = Email::Domains::country($domain);
    push @$matches, 'EMAIL_COUNTRY', $country if $country;
    push @$matches, 'EMAIL', $text;
    return;
  }

  if ($sep ne '.')
  {
    # Doesn't happen.
    return;
  }

  if ($front !~ /^([a-z0-9._-]+)@/)
  {
    # Doesn't happen.
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
      # Doesn't happen.
      return;
    }
  }
  else
  {
    $server = $1;
  }

  parse_user($user, $matches);
  push @$matches, 'EMAIL', $text;
  return;
}


sub special_kludge
{
  my ($text, $matches) = @_;

  # There are only six cases with high special characters left.
  if ($text =~ /1nt/)
  {
    push @$matches, 'SYSTEM', '2/1 1NT 15-17 Transfers';
  }
  elsif ($text =~ /\.pl$/)
  {
    push @$matches, 'EMAIL_COUNTRY', 'Poland';
  }
  else
  {
    push @$matches, 'DELETE', $text;
  }
}


sub parse_user
{
  my ($user, $matches) = @_;

  if ($user =~ /^[\d_.-]+$/)
  {
    push @$matches, 'USER_NUMERICAL', $user;
    return;
  }

  $user =~ s/^[\d_.-]+//;
  $user =~ s/[\d_.-]+$//;

  if ($user =~ /^[a-z]+$/)
  {
    # A single string, potentially followed by numbers.
    push @$matches, 'USER_ONE', $user;
    return;
  }

  if ($user !~ /^[a-z0-9._-]+$/)
  {
    # Doesn't happen.
    return;
  }

  if (exists $UNPARSEABLE_HASH->{$user})
  {
    push @$matches, 'USER_UNPARSEABLE', $user;
    return;
  }

  my @a = split /\.+/, $user;
  my @b = split /_+/, $user;
  my @c = split /-+/, $user;

  if ($#a == 0 && $#b == 0 && $#c == 0)
  {
    # Checked manually.
    push @$matches, 'USER_UNPARSEABLE', $user;
  }
  elsif (exists $USERS_HASH->{$user})
  {
    my @list = Email::Users::lookup($user);
    push @$matches, map { @$_ } @list;
  }
  elsif ($#a == 1 && $#b == 0 && $#c == 0)
  {
    match_two($matches, $user, $a[0], $a[1], '');
  }
  elsif ($#a == 0 && $#b == 1 && $#c == 0)
  {
    match_two($matches, $user, $b[0], $b[1], '');
  }
  elsif ($#a == 0 && $#b == 0 && $#c == 1)
  {
    match_two($matches, $user, $c[0], $c[1], '');
  }
  elsif ($#a == 2 && $#b == 0 && $#c == 0)
  {
    match_three($matches, $user, $a[0], $a[1], $a[2], 'MAILODD1');
  }
  elsif ($#a == 0 && $#b == 2 && $#c == 0)
  {
    match_three($matches, $user, $b[0], $b[1], $b[2], 'MAILODD2');
  }
  elsif ($#a == 0 && $#b == 0 && $#c == 2)
  {
    match_three($matches, $user, $c[0], $c[1], $c[2], 'MAILODD3');
  }
  elsif ($#a == 1 && $#b == 0 && $#c == 1)
  {
    if (length($a[0]) > length($c[0]))
    {
      # Of the form 'Jean-Pierre Chery'.
      match_two($matches, $user, $a[0], $a[1], '');
    }
    else
    {
      # Doesn't happen.
    }
  }
  else
  {
    # Doesn't happen.
  }
}

sub match_two
{
  my ($matches, $user, $e0, $e1, $debug) = @_;

  my $l0 = length($e0);
  my $l1 = length($e1);

  if ($e0 eq 'dr')
  {
    push @$matches, 'USER_TITLE', 'Dr.';
    push @$matches, 'USER_LAST', $e1;
    print "$debug A: $user\n" if $debug;
  }
  else
  {
    push @$matches, 'USER_ONE', $e0;
    push @$matches, 'USER_TWO', $e1;
  }
}


sub match_three
{
  my ($matches, $user, $e0, $e1, $e2, $debug) = @_;

  if ($user =~ /[0-9]/)
  {
    push @$matches, 'USER_UNPARSEABLE', $user;
    return;
  }

  my $l0 = length($e0);
  my $l1 = length($e1);
  my $l2 = length($e2);

  if ($l0 == 1 && $l1 == 1 && $l2 > 1)
  {
    my $initials = uc("$e0. $e1.");
    push @$matches, 'USER_INITIALS', $initials;
    push @$matches, 'USER_LAST', $e2;
  }
  elsif ($l0 > 1 && $l1 == 1 && $l2 > 1)
  {
    if ($e0 eq 'dr')
    {
      push @$matches, 'USER_TITLE', 'Dr.';
      push @$matches, 'USER_INITIALS', uc("$e1.");
      push @$matches, 'USER_LAST', $e2;
    }
    else
    {
      push @$matches, 'USER_FIRST', $e0;
      push @$matches, 'USER_INITIALS', uc("$e1.");
      push @$matches, 'USER_LAST', $e2;
    }
  }
}

1;
