/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_PARSE_H
#define VALET_PARSE_H

#include <string>
#include "cst.h"

using namespace std;

template <class ContainerT>

void tokenize(
  const string& str,
  ContainerT& tokens,
  const string& delimiters);

int ParseScoreLine(
  const string& line,
  ResultType& res,
  unsigned& rno,
  unsigned& bno,
  bool skipNameCheck = false);

#endif
