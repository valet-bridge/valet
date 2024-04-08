#!perl

package Separators;

use strict;
use warnings;
use Exporter;
use v5.10;

use lib '.';
use Token;

our @ISA = qw(Exporter);
our @EXPORT = qw(%SEPARATORS set_token);

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


sub set_token
{
  my ($part, $token) = @_;

  if ($part =~ /^\s+$/)
  {
    $token->set_separator('SPACE');
    return 1;
  }
  elsif ($part eq '.')
  {
    $token->set_separator('DOT');
    return 1;
  }
  elsif ($part eq ':')
  {
    $token->set_separator('COLON');
    return 1;
  }
  elsif ($part eq ';')
  {
    $token->set_separator('SEMICOLON');
    return 1;
  }
  elsif ($part eq '-')
  {
    $token->set_separator('DASH');
    return 1;
  }
  elsif ($part eq '_')
  {
    $token->set_separator('UNDERSCORE');
    return 1;
  }
  elsif ($part eq '+')
  {
    $token->set_separator('PLUS');
    return 1;
  }
  elsif ($part eq '/')
  {
    $token->set_separator('SLASH');
    return 1;
  }
  elsif ($part eq '(')
  {
    $token->set_separator('LEFT_PAREN');
    return 1;
  }
  elsif ($part eq ')')
  {
    $token->set_separator('RIGHT_PAREN');
    return 1;
  }
  elsif ($part eq '"')
  {
    $token->set_separator('QUOTE');
    return 1;
  }
  elsif ($part eq '|')
  {
    # Artificial separator made when unmashing.
    $token->set_separator('VIRTUAL');
    return 1;
  }
  else
  {
    return 0;
  }
}

1;
