/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_MISC_H
#define VALET_MISC_H

#include <vector>
#include "cst.h"

using namespace std;

void PrintResult(
  const ResultType& res,
  ostream& oss = std::cout);

void PrintEntry(
  const ValetEntryType& entry,
  ostream& oss = std::cout);

void PrintEntryTableau(
  const vector<ValetEntryType>& entries,
  const string& boardtag,
  ostream& oss = std::cout);
  
#endif

