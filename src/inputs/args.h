/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_ARGS_H
#define VALET_ARGS_H

void usage(const char base[]);

void printOptions();

void readArgs(
  const int argc,
  char const * argv[]);

#endif

