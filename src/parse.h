/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_PARSE_H
#define VALET_PARSE_H

#include "cst.h"

bool LineToResult(
  const std::vector<std::string> tokens,
  ResultType& res,
  unsigned& rno,
  unsigned& bno);

#endif
