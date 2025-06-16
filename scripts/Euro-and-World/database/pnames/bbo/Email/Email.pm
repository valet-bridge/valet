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

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(looks_like);

my @PRIVATES = (
  '@no.spam',
  'ask.me@tellyou',
  'bruce.springsteen@no',
  'dont.use@com',
  'i.am@not',
  'your.request@will.be.considered',
  'ask me@o2.pl',
  'ask me@hotmail.com',
  'baboun@pourmes amis.com',
  'be cool@bbo.com',
  'be happy@fun.com',
  'be nice @ crazy . com',
  'chameleon @,hotmail.com',
  'kau tanya lah@ku.com',
  'no @no.com',
  'non ricordo@quale.it',
  'private.kol@hotmail.com',
  'private@Private.com',
  'private@gmail..com',
  'private@gmail.com',
  'private@hotmail.com',
  'private@no.spam',
  'private@private.com',
  'wong ilang@yahoo.co',
);

my %PRIVATES_HASH;
$PRIVATES_HASH{$_} = 1 for @PRIVATES;

my @DOMAINS = qw(
  ae af ag ai am an ar as at au bd be bg bh biz bl bm bn bo br by 
  ca cat cc ch cl cn co com cr cz cy de dk edu ee eg es eu fi fm fo fr 
  ge gov gr hk hr hu id ie il info is it in jo jp kg kr ku kz
  la lb lc li lk ls lt lu lv ma mc me mk mu mx mz 
  na name net ni nl no nu nz org pe pf ph pk pl pt py ro rs ru 
  sa se sg si sk sm st su th tn tr tt tv tw ua uk us uy vu world yu za
);

my %DOMAINS_HASH;
$DOMAINS_HASH{$_} = 1 for @DOMAINS;


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
  elsif (exists $PRIVATES_HASH{$text})
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

  if ($text =~ /\s/)
  {
    $text =~ s/\s//g;
    return;
  }
  elsif ($text =~ /\.([a-z]+)$/ && exists $DOMAINS_HASH{$1})
  {
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


