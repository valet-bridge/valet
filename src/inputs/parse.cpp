/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


// The functions in this file help to parse the scores file.

#include <vector>
#include <cassert>

// #include <stdio.h>
#include <string.h>

#include "../pairs/Players.h"

#include "../valet.h"
#include "../scoring.h"
#include "../Result.h"
#include "../cst.h"

#include "pinternal.h"

using namespace std;

extern Players players;
extern Error error;


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


bool parseInt(
  const string& text,
  int& value)
{
  if (text == "")
    return false;

  int i;
  size_t pos;
  try
  {
    i = stoi(text, &pos, 0);
    if (pos != text.size())
      return false;
  }
  catch (...)
  {
    return false;
  }

  value = i;
  return true;
}


bool tokenToUnsigned(
  const string& token,
  const unsigned lowerLimit,
  const unsigned upperLimit,
  const string& err,
  unsigned& res)
{
  int i;
  if (! parseInt(token, i))
  {
    error.flag = true;
    error.message << "Got " << err << ": " << token << " (not a number)\n";
    return false;
  }
  res = static_cast<unsigned>(i);
    
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
  else
    return true;
}


bool charToPlayer(
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


bool tokenToLevel(
  const string& token,
  unsigned& d)
{
  const char c = token[0];
  if (c < '0' || c > '7')
  {
    error.flag = true;
    error.no = RETURN_LEVEL;
    error.message << "Got contract: '" << token.c_str() <<
      "' (can't find a level 1 .. 7)\n";
    return false;
  }
  
  d = static_cast<unsigned>(c - '0');
  return true;
}


bool tokenToDenom(
  const string& token,
  const unsigned index,
  const string& tag,
  unsigned& d)
{
  const char c = token[index];
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
    {
      error.flag = true;
      error.no = RETURN_DENOM;
      error.message << 
        "Got " << tag << 
        ": '" << token.c_str() <<
        "' (can't find a denomination, want NSHDC/nshdc)\n";
      return false;
    }
  }
}


bool lineToNumbers(
  const vector<string>& tokens,
  unsigned& roundNo,
  unsigned& boardNo)
{
  if (! tokenToUnsigned(tokens[0], 1, 0, "round number", roundNo))
  {
    error.no = RETURN_ROUND_NUMBER;
    return false;
  }

  if (! tokenToUnsigned(tokens[1], 1, 0, "board number", boardNo))
  {
    error.no = RETURN_BOARD_NUMBER;
    return false;
  }

  return true;
}


bool checkPlayer(
  const string& token,
  const string& tag,
  const int errNo)
{
  if (! players.exists(token))
  { 
    error.flag = true;
    error.no = errNo;
    error.message << 
      "Got " << tag << 
      " player: '" << token << 
      "' (not in name list)\n";
    return false;
  }
  else
    return true;
}


bool checkContract(const string& token)
{
  size_t cl = token.size();
  if (cl == 0 || cl > 4)
  {
    error.flag = true;
    error.no = RETURN_CONTRACT_FORMAT_TEXT;
    error.message << "Got contract: '" << token.c_str() <<
      "' (bad length)\n";
    return false;
  }

  if (cl == 1 && token != "P" && token != "p")
  {
    error.flag = true;
    error.no = RETURN_CONTRACT_FORMAT_TEXT;
    error.message << "Got contract: '" << token.c_str() <<
      "' (if length 1, must be P or p)\n";
    return false;
  }

  return true;
}


bool tokenToMultiplier(
  const string& token,
  unsigned& multiplier)
{
  if (token.size() == 3)
  {
    if (token[2] != 'X' && token[2] != 'x')
    {
      error.flag = true;
      error.no = RETURN_MULTIPLIER;
      error.message << "Got contract: '" << token.c_str() <<
        "' (expected last letter to be X or x)\n";
      return false;
    }
    multiplier = VALET_DOUBLED;
  }
  else if (token.size() == 4)
  {
    if ((token[2] != 'X' && token[2] != 'x') || 
        (token[3] != 'X' && token[3] != 'x'))
    {
      error.flag = true;
      error.no = RETURN_MULTIPLIER;
      error.message << "Got contract: '" << token.c_str() <<
        "' (expected last letters to be XX or xx)\n";
      return false;
    }
    multiplier = VALET_REDOUBLED;
  }
  else
    multiplier = VALET_UNDOUBLED;

  return true;
}


bool tokenToPlayer(
  const string& token,
  unsigned& player)
{
  if (token.size() != 1 || ! charToPlayer(token[0], player))
  {
    error.flag = true;
    error.no = RETURN_DECLARER;
    error.message << "Got declarer: '" << token.c_str() <<
      "' (expected NESW or nesw)\n";
    return false;
  }
  else
    return true;
}


bool tokenToRank(
  const string& token,
  unsigned& r)
{
  const char c = token[1];
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
    error.no = RETURN_LEAD_RANK;
    error.message << "Got lead: '" << token.c_str() <<
      "' (can't find a rank, want AKQJT, akqjt or 2 .. 9)\n";
    return false;
  }
}


bool lineToResult(
  const vector<string>& tokens,
  Result& result,
  unsigned& roundNo,
  unsigned& boardNo,
  bool skipNameCheck)
{
  if (! lineToNumbers(tokens, roundNo, boardNo))
    return false;

  if (! skipNameCheck && 
      ! checkPlayer(tokens[2], "North", RETURN_PLAYER_NORTH))
    return false;

  if (! skipNameCheck && 
      ! checkPlayer(tokens[3], "East", RETURN_PLAYER_EAST))
    return false;

  if (! skipNameCheck && 
      ! checkPlayer(tokens[4], "South", RETURN_PLAYER_SOUTH))
    return false;

  if (! skipNameCheck && 
      ! checkPlayer(tokens[5], "West", RETURN_PLAYER_WEST))
    return false;

  result.setPlayers(tokens[2], tokens[3], tokens[4], tokens[5]);

  if (! checkContract(tokens[6]))
    return false;

  if (tokens[6].size() == 1)
  {
    result.setPassedOut();
    return true;
  }


  unsigned level, denom, multiplier, declarer, tricks;
  if (! tokenToLevel(tokens[6], level))
    return false;

  if (! tokenToDenom(tokens[6], 1, "contract", denom))
    return false;

  if (! tokenToMultiplier(tokens[6], multiplier))
    return false;

  if (! tokenToPlayer(tokens[7], declarer))
    return false;

  if (! tokenToUnsigned(tokens[8], 0, 13, "tricks", tricks))
  {
    error.flag = true;
    error.no = RETURN_TRICKS;
    return false;
  }

  unsigned vulNS, vulEW;
  getVul(boardNo, vulNS, vulEW);
  const unsigned vul = (declarer == VALET_NORTH || declarer == VALET_SOUTH ?
    vulNS : vulEW);

  result.setGeneralResult(level, denom, multiplier, declarer, tricks, vul);


  if (tokens.size() == 9)
  {
    result.setNoLead();
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

  unsigned leadDenom, leadRank;
  if (! tokenToDenom(tokens[9], 0, "denomination", leadDenom))
    return false;

  if (! tokenToRank(tokens[9], leadRank))
    return false;

  result.setLead(leadDenom, leadRank);

  return true;
}


int parseScoreLine(
  const string& line,
  Result& result,
  unsigned& roundNo,
  unsigned& boardNo,
  const bool skipNameCheck)
{
  vector<string> tokens;
  tokenize(line, tokens, "|");
  const size_t tlen = tokens.size();

  if (tlen != 9 && tlen != 10)
  {
    error.flag = true;
    error.no = RETURN_TOKEN_NUMBER;
    error.message << "Got token number: " << tlen <<
      " (expected 9 or 10)\n";
    error.message << "Parsed line: '" << line << "'\n";
    return error.no;
  }

  if (lineToResult(tokens, result, roundNo, boardNo, skipNameCheck))
    return RETURN_NO_FAULT;
  else
  {
    error.message << "Parsed line: '" << line << "'\n";
    return error.no;
  }
}


int parseScoreLine(
  const string& line,
  PlayerTags& playerTags)
{
  vector<string> tokens;
  tokenize(line, tokens, "|");
  const size_t tlen = tokens.size();

  // Short form as we have already called the other parseScoreLine.
  assert(tlen == 9 || tlen == 10);

  strncpy(playerTags.north, tokens[2].c_str(), VALET_INPUT_MAX_LENGTH);
  strncpy(playerTags.east,  tokens[3].c_str(), VALET_INPUT_MAX_LENGTH);
  strncpy(playerTags.south, tokens[4].c_str(), VALET_INPUT_MAX_LENGTH);
  strncpy(playerTags.west,  tokens[5].c_str(), VALET_INPUT_MAX_LENGTH);

  return RETURN_NO_FAULT;
}


bool lessByBoard(
  const string& str1,
  const string& str2)
{
  // This is a kludge: We may have str1 "1|1" and str2 "1|10".
  // We want str1 to be less than str2.

  vector<string> tokens1, tokens2;
  tokenize(str1, tokens1, "|");
  tokenize(str2, tokens2, "|");
  assert(tokens1.size() == 2);
  assert(tokens2.size() == 2);

  int r1, r2, b1, b2;
  parseInt(tokens1[0], r1);
  parseInt(tokens1[1], b1);
  parseInt(tokens2[0], r2);
  parseInt(tokens2[1], b2);

  if (r1 < r2)
    return true;
  else if (r1 > r2)
    return false;
  else if (b1 < b2)
    return true;
  else
    return false;
}
