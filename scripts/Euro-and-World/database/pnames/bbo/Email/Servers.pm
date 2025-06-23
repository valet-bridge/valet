#!perl

package Email::Servers;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(is_server);

my %SERVERS =
(
  'ac.jp' => { 'neptune.kanazawa-it' => 1},
  'ac.il' => { 
    'mail.biu' => 1,
    'post.tau' => 1, 
    'wisdom.weizmann' => 1 },
  'com.cn' => { 
    'cmc.genertec' => 1,
    'mail.zjczzq' => 1 },
  'com.tw' => { 'ms32.url' => 1 },
  'ethz.ch' => { 'org.chem' => 1 },
  'ne.jp' => { 
    'a6.dion' => 1, 'd1.dion' => 1, 'h2.dion' => 1, 
    'mx1.harmonix' => 1, 
    'mail.hinocatv' => 1, 
    'jcom.home' => 1,
    'aa.isas' => 1, 
    'chive.ocn' => 1, 'crocus.ocn' => 1, 'deluxe.ocn' => 1,
      'royal.ocn' => 1, 'song.ocn' => 1,
    'deluxe.odn' => 1, 'syd.odn' => 1, 'par.odn' => 1,
    'va.rsoenet' => 1 },
  'net.pl' => { 'main.satfilm' => 1 },
  'net.tw' => { 'fbb.3a' => 1 },
  'zj.cn' => { 'mail.hz' => 1, 'mail.tzptt' => 1, 'mail.wzptt' => 1 },
);

sub is_server
{
  my ($domain, $str) = @_;
  if (exists $SERVERS{$domain} &&
      exists $SERVERS{$domain}{$str})
  {
    return 1;
  }
  else
  {
    return '';
  }
}


1;
