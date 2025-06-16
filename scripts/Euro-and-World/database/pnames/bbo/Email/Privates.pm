#!perl

package Email::Privates;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($PRIVATES_HASH);

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

our $PRIVATES_HASH = { map { $_ => 1 } @PRIVATES };

1;
