/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_ARGS_H
#define VALET_ARGS_H

void Usage(
 const char base[]);

void PrintOptions();

void ReadArgs(
  int argc,
  char * argv[]);

#endif

