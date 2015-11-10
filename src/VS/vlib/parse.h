/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_PARSE_H
#define VALET_PARSE_H

#include <string>
#include "cst.h"

template <class ContainerT>

void tokenize(
  const std::string& str,
  ContainerT& tokens,
  const std::string& delimiters);

int ParseScoreLine(
  const std::string line,
  ResultType& res,
  unsigned& rno,
  unsigned& bno,
  bool skipNameCheck = false);

#endif
