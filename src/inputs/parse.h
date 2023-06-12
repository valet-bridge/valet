/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_PARSE_H
#define VALET_PARSE_H

#include <string>

using namespace std;

class Result;
struct PlayerTags;

template <class ContainerT>


void tokenize(
  const string& str,
  ContainerT& tokens,
  const string& delimiters);

bool parseInt(
  const string& str,
  int& result);

int parseScoreLine(
  const string& line,
  Result& result,
  string& roundTag,
  unsigned& boardNo,
  const bool skipNameCheck = false);

int parseScoreLine(
  const string& line,
  PlayerTags& ptt);

bool lessByBoard(
  const string& str1,
  const string& str2);

#endif
