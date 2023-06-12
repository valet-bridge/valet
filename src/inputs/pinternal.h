/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_PINTERNAL_H
#define VALET_PINTERNAL_H

#include <string>

using namespace std;

class Result;


bool tokenToUnsigned(
  const string& token,
  const unsigned lowerLimit,
  const unsigned upperLimit,
  const string& err,
  unsigned& res);

bool charToPlayer(
  const char c,
  unsigned& p);

bool tokenToLevel(
  const string& token,
  unsigned& d);

bool charToDenom(
  const string& token,
  const unsigned index,
  const string& tag,
  unsigned& d);

bool lineToNumbers(
  const vector<string>& tokens,
  string& roundTag,
  unsigned& boardNo);

bool checkPlayer(
  const string& token,
  const string& tag,
  const int errNo);

bool checkContract(const string& token);

bool tokenToMultiplier(
  const string& token,
  unsigned& multiplier);

bool tokenToPlayer(
  const string& token,
  unsigned& player);

bool tokenToRank(
  const string& token,
  unsigned& r);

bool lineToResult(
  const vector<string>& tokens,
  Result& res,
  string& roundTag,
  unsigned& boardNo,
  bool skipNameCheck);

#endif
