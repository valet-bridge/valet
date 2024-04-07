#!perl

package Separators;

use strict;
use warnings;
use Exporter;
use v5.10;

use lib '.';

our @ISA = qw(Exporter);
our @EXPORT = qw(%SEPARATORS);

our %SEPARATORS =
(
  'SPACE' => 0x1,
  'DOT' => 0x2,
  'COLON' => 0x4,
  'SEMICOLON' => 0x8,
  'DASH' => 0x10,
  'UNDERSCORE' => 0x20,
  'PLUS' => 0x40,
  'SLASH' => 0x80,
  'LEFT_PAREN' => 0x100,
  'RIGHT_PAREN' => 0x200,
  'QUOTE' => 0x400,
  'VIRTUAL' => 0x800
);

1;
