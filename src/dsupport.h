/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_DSUPPORT_H
#define VALET_DSUPPORT_H

#define TEST_ENTRIES 22

int GetMode(
  int argc,
  char * argv[]);

void Usage(
  char * argv[]);

void SetTagInputs(
  PlayersTagType& players, 
  InputResultType& input, 
  const unsigned i);

void SetNumberInputs(
  PlayersNumberType& players, 
  InputResultType& input, 
  const unsigned i);

void PrintPassedResultByTag(
  PositionsTagType& players,
  OutputResultType& output);

void PrintPassedResultByNumber(
  PositionsNumberType& players,
  OutputResultType& output);

void PrintPlayedResultByTag(
  PositionsTagType& players,
  OutputResultType& output);

void PrintPlayedResultByNumber(
  PositionsNumberType& players,
  OutputResultType& output);

#endif

