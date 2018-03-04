/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// The functions in this file help to parse the scores file.


#include <string>
#include <vector>
#include <stdio.h>
#include <stdlib.h>

#include "Pairs.h"
#include "parse.h"
#include "valet.h"

using namespace std;


extern Pairs pairs;
extern ErrorType error;


bool TokenToUnsigned(
  const string token,
  unsigned lowerLimit,
  unsigned upperLimit,
  const string& err,
  unsigned& res);

bool CharToPlayer(
  const char c,
  unsigned& p);

bool CharToLevel(
  const char c,
  unsigned& d);

bool CharToDenom(
  const char c,
  unsigned& d);

bool CharToRank(
  const char c,
  unsigned& r);

bool LineToResult(
  const vector<string>& tokens,
  ResultType& res,
  unsigned& rno,
  unsigned& bno,
  bool skipNameCheck);

// tokenize splits a string into tokens separated by delimiter.
// http://stackoverflow.com/questions/236129/split-a-string-in-c

template <class ContainerT>

void tokenize(
  const string& str, 
  ContainerT& tokens,
  const string& delimiters)
{
  string::size_type pos, lastPos = 0;

  typedef ContainerT Base;
  typedef typename Base::value_type ValueType;
  typedef typename ValueType::size_type SizeType;

  while (true)
  {
    pos = str.find_first_of(delimiters, lastPos);
    if (pos == std::string::npos)
    {
      pos = str.length();
      tokens.push_back(ValueType(str.data()+lastPos, 
        static_cast<SizeType>(pos - lastPos)));
      break;
    }
    else
    {
      tokens.push_back(ValueType(str.data()+lastPos,
        static_cast<SizeType>(pos - lastPos)));
    }
    lastPos = pos + 1;
   }
}


bool TokenToUnsigned(
  const string token,
  unsigned lowerLimit,
  unsigned upperLimit,
  const string& err,
  unsigned& res)
{
  char *pend;
  res = static_cast<unsigned>(strtol(token.c_str(), &pend, 10));
  if ((lowerLimit > 0 && res < lowerLimit) || 
      (upperLimit > 0 && res > upperLimit))
  {
    if (upperLimit > 0)
      error.message << "Got " << err << ": " << token <<
       " (not " << lowerLimit << " .. " << upperLimit << ")\n";
    else
      error.message << "Got " << err << ": " << token <<
       " (not >= " << lowerLimit << ")\n";

    error.flag = true;
    return false;
  }
  else if (*pend != '\0')
  {
    error.flag = true;
    error.message << "Got " << err << ": " << token << " (not a number)\n";
    return false;
  }
  else
    return true;
}


bool CharToPlayer(
  const char c,
  unsigned& p)
{
  switch(c)
  {
    case 'N':
    case 'n':
      p = VALET_NORTH;
      return true;
    case 'E':
    case 'e':
      p = VALET_EAST;
      return true;
    case 'S':
    case 's':
      p = VALET_SOUTH;
      return true;
    case 'W':
    case 'w':
      p = VALET_WEST;
      return true;
    default:
      error.flag = true;
      return false;
  }
}


bool CharToLevel(
  const char c,
  unsigned& d)
{
  if (c < '0' || c > '7')
    return false;
  
  d = static_cast<unsigned>(c - '0');
  return true;
}


bool CharToDenom(
  const char c,
  unsigned& d)
{
  switch(c)
  {
    case 'N':
    case 'n':
      d = VALET_NOTRUMP;
      return true;
    case 'S':
    case 's':
      d = VALET_SPADES;
      return true;
    case 'H':
    case 'h':
      d = VALET_HEARTS;
      return true;
    case 'D':
    case 'd':
      d = VALET_DIAMONDS;
      return true;
    case 'C':
    case 'c':
      d = VALET_CLUBS;
      return true;
    default:
      error.flag = true;
      return false;
  }
}


bool CharToRank(
  const char c,
  unsigned& r)
{
  if (c >= '2' && c <= '9')
  {
    r = static_cast<unsigned>(c - '0');
    return true;
  }
  else if (c == 'T' || c == 't')
  {
    r = 10;
    return true;
  }
  else if (c == 'J' || c == 'j')
  {
    r = 11;
    return true;
  }
  else if (c == 'Q' || c == 'q')
  {
    r = 12;
    return true;
  }
  else if (c == 'K' || c == 'k')
  {
    r = 13;
    return true;
  }
  else if (c == 'A' || c == 'a')
  {
    r = 14;
    return true;
  }
  else
  {
    error.flag = true;
    return false;
  }
}


bool LineToResult(
  const vector<string>& tokens,
  ResultType& res,
  unsigned& rno,
  unsigned& bno,
  bool skipNameCheck)
{
  if (! TokenToUnsigned(tokens[0], 1, 0, "round number", rno))
  {
    error.no = RETURN_ROUND_NUMBER;
    return false;
  }

  if (! TokenToUnsigned(tokens[1], 1, 0, "board number", bno))
  {
    error.no = RETURN_BOARD_NUMBER;
    return false;
  }

  res.north = tokens[2];
  if (! skipNameCheck && ! pairs.TagExists(res.north))
  { 
    error.flag = true;
    error.no = RETURN_PLAYER_NORTH;
    error.message << "Got North player: '" << res.north << 
      "' (not in name list)\n";
    return false;
  }
  res.east = tokens[3];
  if (! skipNameCheck && ! pairs.TagExists(res.east))
  { 
    error.flag = true;
    error.no = RETURN_PLAYER_EAST;
    error.message << "Got East player: '" << res.east <<
      "' (not in name list)\n";
    return false;
  }
  res.south = tokens[4];
  if (! skipNameCheck && ! pairs.TagExists(res.south))
  { 
    error.flag = true;
    error.no = RETURN_PLAYER_SOUTH;
    error.message << "Got South player: '" << res.south << 
      "' (not in name list)\n";
    return false;
  }
  res.west = tokens[5];
  if (! skipNameCheck && ! pairs.TagExists(res.west))
  { 
    error.flag = true;
    error.no = RETURN_PLAYER_WEST;
    error.message << "Got West player: '" << res.west <<
      "' (not in name list)\n";
    return false;
  }

  size_t cl = tokens[6].size();
  if (cl == 0 || cl > 4)
  {
    error.flag = true;
    error.no = RETURN_CONTRACT_FORMAT_TEXT;
    error.message << "Got contract: '" << tokens[6].c_str() <<
      "' (bad length)\n";
    return false;
  }

  if (cl == 1)
  {
    if (tokens[6] != "P" && tokens[6] != "p")
    {
      error.flag = true;
      error.no = RETURN_CONTRACT_FORMAT_TEXT;
      error.message << "Got contract: '" << tokens[6].c_str() <<
        "' (if length 1, must be P or p)\n";
      return false;
    }
    res.level = 0;
    return true;
  }

  if (! CharToLevel(tokens[6][0], res.level))
  {
    error.flag = true;
    error.no = RETURN_LEVEL;
    error.message << "Got contract: '" << tokens[6].c_str() <<
      "' (can't find a level 1 .. 7)\n";
    return false;
  }

  if (! CharToDenom(tokens[6][1], res.denom))
  {
    error.flag = true;
    error.no = RETURN_DENOM;
    error.message << "Got contract: '" << tokens[6].c_str() <<
      "' (can't find a denomination, want NSHDC/nshdc)\n";
    return false;
  }

  if (cl == 3)
  {
    if (tokens[6][2] != 'X' && tokens[6][2] != 'x')
    {
      error.flag = true;
      error.no = RETURN_MULTIPLIER;
      error.message << "Got contract: '" << tokens[6].c_str() <<
        "' (expected last letter to be X or x)\n";
      return false;
    }
    res.multiplier = VALET_DOUBLED;
  }
  else if (cl == 4)
  {
    if ((tokens[6][2] != 'X' && tokens[6][2] != 'x')|| 
        (tokens[6][3] != 'X' && tokens[6][3] != 'x'))
    {
      error.flag = true;
      error.no = RETURN_MULTIPLIER;
      error.message << "Got contract: '" << tokens[6].c_str() <<
        "' (expected last letters to be XX or xx)\n";
      return false;
    }
    res.multiplier = VALET_REDOUBLED;
  }
  else
    res.multiplier = VALET_UNDOUBLED;


  if (tokens[7].size() != 1 || ! CharToPlayer(tokens[7][0], res.declarer))
  {
    error.flag = true;
    error.no = RETURN_DECLARER;
    error.message << "Got declarer: '" << tokens[7].c_str() <<
      "' (expected NESW or nesw)\n";
    return false;
  }

  if (! TokenToUnsigned(tokens[8], 0, 13, "tricks", res.tricks))
  {
    error.flag = true;
    error.no = RETURN_TRICKS;
    return false;
  }

  if (tokens.size() == 9)
  {
    res.leadRank = 0;
    return true;
  }

  if (tokens[9].size() != 2)
  {
    error.flag = true;
    error.no = RETURN_LEAD_TEXT;
    error.message << "Got lead: '" << tokens[9].c_str() <<
      "' (expected two characters)\n";
    return false;
  }

  if (! CharToDenom(tokens[9][0], res.leadDenom))
  {
    error.flag = true;
    error.no = RETURN_LEAD_DENOM;
    error.message << "Got lead: '" << tokens[9].c_str() <<
      "' (can't find a denomination, want NSHDC/nshdc)\n";
    return false;
  }

  if (! CharToRank(tokens[9][1], res.leadRank))
  {
    error.flag = true;
    error.no = RETURN_LEAD_RANK;
    error.message << "Got lead: '" << tokens[9].c_str() <<
      "' (can't find a rank, want AKQJT, akqjt or 2 .. 9)\n";
    return false;
  }

  return true;
}


int ParseScoreLine(
  const string& line,
  ResultType& res,
  unsigned &rno,
  unsigned &bno,
  bool skipNameCheck)
{
  vector<string> tokens(32);
  tokens.clear();

  tokenize(line, tokens, "|");
  size_t tlen = tokens.size();
  if (tlen != 9 && tlen != 10)
  {
    error.flag = true;
    error.no = RETURN_TOKEN_NUMBER;
    error.message << "Got token number: " << tlen <<
      " (expected 9 or 10)\n";
    error.message << "Parsed line: '" << line << "'\n";
    return error.no;
  }

  if (LineToResult(tokens, res, rno, bno, skipNameCheck))
    return RETURN_NO_FAULT;
  else
  {
    error.message << "Parsed line: '" << line << "'\n";
    return error.no;
  }
}

