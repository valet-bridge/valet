/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_DSUPPORT_H
#define VALET_DSUPPORT_H

#define TEST_ENTRIES 22

int getMode(
  int argc,
  char * argv[]);

void usage(char * argv[]);

void setTagInputs(
  PlayerTags& players, 
  InputResult& input, 
  const unsigned resultNo);

void setNumberInputs(
  PlayerNumbers& players, 
  InputResult& input, 
  const unsigned resultNo);

#endif

