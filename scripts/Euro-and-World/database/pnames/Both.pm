#!perl

# A few names that appear to be either first or last names in the
# EBL file.

package Both;

use strict;
use warnings;
use v5.10;
use Exporter 'import';

our @EXPORT = qw(@BOTH_FIRST @BOTH_LAST);

use utf8;

our @BOTH_FIRST =
qw(
  Almeida 
  Chin 
  Dong 
  Florin Frances Fung 
  Helal 
  In 
  Jul 
  Kai Kee Keith Kumar 
  Lam Li Luca 
  Noel 
  Paoli Pauli Paz Pham 
  Richard Robert 
  Simon Stewart Sydney 
  Tan 
  Ud 
  Wei 
);

our @BOTH_LAST =
qw(
  ALMEIDA 
  CHIN 
  DONG 
  FLORIN FRANCES FUNG 
  HELAL 
  IN 
  JUL 
  KAI KEE KEITH KUMAR 
  LAM LI LUCA 
  NOEL 
  PAOLI PAULI PAZ PHAM 
  RICHARD ROBERT 
  SIMON STEWART SYDNEY 
  TAN 
  UD 
  WEI 
);


1;
