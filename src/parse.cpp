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
#include "cst.h"

using namespace std;


extern Pairs pairs;


bool TokenToUnsigned(
  const string token,
  unsigned lowerLimit,
  unsigned upperLimit,
  const string err,
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


bool TokenToUnsigned(
  const string token,
  unsigned lowerLimit,
  unsigned upperLimit,
  const string err,
  unsigned& res)
{
  char *pend;
  res = static_cast<unsigned>(strtol(token.c_str(), &pend, 10));
  if ((lowerLimit > 0 && res < lowerLimit) || 
      (upperLimit > 0 && res > upperLimit))
  {
    if (upperLimit > 0)
      cerr << err << "'" << token << "' is not " <<
        lowerLimit << ".." << upperLimit << endl;
    else
      cerr << err << "'" << token << "' is not >= " << lowerLimit << endl;
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
      p = VALET_NORTH;
      return true;
    case 'E':
      p = VALET_EAST;
      return true;
    case 'S':
      p = VALET_SOUTH;
      return true;
    case 'W':
      p = VALET_WEST;
      return true;
    default:
      cerr << "'" << static_cast<unsigned>(c) <<
        "' is not a player (NESW)" << endl;
      return false;
  }
}


bool CharToLevel(
  const char c,
  unsigned& d)
{
  if (c < '0' || c > '9')
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
      cerr << "'" << static_cast<unsigned>(c) <<
        "' is not a denomination (NSHDC)" << endl;
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
    cerr << "'" << static_cast<unsigned>(c) <<
      "' is not a rank" << endl;
    return false;
  }
}


bool LineToResult(
  const vector<string> tokens,
  ResultType& res,
  unsigned& rno,
  unsigned& bno)
{
  if (! TokenToUnsigned(tokens[0], 1, 0, "Round number", rno))
    return false;

  if (! TokenToUnsigned(tokens[1], 1, 0, "Board number", bno))
    return false;

  res.north = tokens[2];
  if (! pairs.TagExists(res.north))
  { 
    cerr << "'" << res.north << " is not a valid player\n";
    return false;
  }
  res.east = tokens[3];
  if (! pairs.TagExists(res.east))
  { 
    cerr << "'" << res.east << " is not a valid player\n";
    return false;
  }
  res.south = tokens[4];
  if (! pairs.TagExists(res.south))
  { 
    cerr << "'" << res.south << " is not a valid player\n";
    return false;
  }
  res.west = tokens[5];
  if (! pairs.TagExists(res.west))
  { 
    cerr << "'" << res.west << " is not a valid player\n";
    return false;
  }

  size_t cl = tokens[6].size();
  if (cl == 0 || cl > 4)
  {
    cerr << "'" << tokens[6].c_str() << " is not a contract" << endl;
    return false;
  }

  if (cl == 1)
  {
    if (tokens[6] != "P")
    {
      cerr << "'" << tokens[6].c_str() << " is not a passed contract" << 
        endl;
      return false;
    }
    res.level = 0;
    return true;
  }

  if (! CharToLevel(tokens[6][0], res.level))
    return false;

  if (! CharToDenom(tokens[6][1], res.denom))
    return false;

  if (cl == 3)
  {
    if (tokens[6][2] != 'X')
    {
      cerr << "'" << tokens[6].c_str() << " is not a doubled contract" << 
        endl;
      return false;
    }
    res.multiplier = VALET_DOUBLED;
  }
  else if (cl == 4)
  {
    if (tokens[6][2] != 'X' || tokens[6][3] != 'X')
    {
      cerr << "'" << tokens[6].c_str() << " is not a redoubled contract" << 
        endl;
      return false;
    }
    res.multiplier = VALET_REDOUBLED;
  }
  else
    res.multiplier = VALET_UNDOUBLED;


  if (tokens[7].size() != 1)
  {
    cerr << "'" << tokens[7].c_str() << " is not a declarer" << endl;
    return false;
  }

  if (! CharToPlayer(tokens[7][0], res.declarer))
    return false;

  if (! TokenToUnsigned(tokens[8], 0, 13, "Tricks", res.tricks))
    return false;

  if (tokens.size() == 9)
  {
    res.leadRank = 0;
    return true;
  }

  if (tokens[9].size() != 2)
  {
    cerr << "'" << tokens[9].c_str() << " is not a lead" << endl;
    return false;
  }

  if (! CharToDenom(tokens[9][0], res.leadDenom))
    return false;

  if (! CharToRank(tokens[9][1], res.leadRank))
    return false;

  return true;
}

