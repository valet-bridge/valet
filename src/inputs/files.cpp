/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


// The functions in this file read the input files.


#include <iostream>
#include <fstream>
#include <map>

#include "files.h"
#include "parse.h"

#include "../pairs/Players.h"

#include "../hand/Hand.h"

#include "../Result.h"
#include "../valet.h"
#include "../cst.h"

using namespace std;

extern Options options;
extern Players players;
extern map<string, Hand> hands;
extern Error error;


string makeHandTag(
  const string& roundTag,
  const unsigned boardNo);


bool readNameFile(const string& nameFile)
{
  ifstream fname(nameFile.c_str());
  if (! fname.is_open())
  {
    cerr << "Unable to read from file '" << nameFile << "'." << endl;
    return false;
  }

  string line;
  unsigned lno = 0;
  vector<string> tokens;
  while (getline(fname, line))
  {
    lno++;
    if (line[0] == '#' || line.empty())
      continue;

    tokens.clear();
    tokenize(line, tokens, "|");
    if (tokens.size() != 2)
    {
      cerr << "File '" << nameFile << "', line " << lno << 
        ":\nGot " << tokens.size() << " tokens, wanted 2\n";
      cerr << "(" << line << ")" << endl;
      return false;
    }

    players.add(tokens[0], tokens[1]);
  }

  fname.close();
  return true;
}


string makeHandTag(
  const string& roundTag,
  const unsigned boardNo)
{
  return roundTag + "|" + to_string(boardNo);
}


bool readScoresFile(const string& scoresFile)
{
  ifstream fname(scoresFile.c_str());
  if (! fname.is_open())
  {
    cerr << "Unable to read from file '" << scoresFile << "'." << endl;
    return false;
  }

  hands.clear();
  string line;
  unsigned lno = 0, boardNo = 0;
  string roundTag;
  Result result;
  string tag;

  while (getline(fname, line))
  {
    lno++;
    line.erase(remove(line.begin(), line.end(), '\r'), line.end());
    if (line[0] == '#' || 
        line.empty() ||
        line.find("Adj") != string::npos ||
        line.find("adj") != string::npos ||
        line.find("ADJ") != string::npos ||
        line.find("None") != string::npos)
    {
      // Also skip adjusted scores.
      continue;
    }

    if (parseScoreLine(line, result, roundTag, boardNo) != RETURN_NO_FAULT)
    {
      cerr << "File '" << scoresFile << "', line " << lno << 
        ": Syntax error" << endl;
      cerr << error.message.str();
      return false;
    }

    // Turn something like "Men17" into "17" so it can be compared
    // to a numerical range of rounds.
    const string numericalPart = 
      roundTag.substr(roundTag.find_first_of("0123456789"));
    int roundNoInt;
    if (! parseInt(numericalPart, roundNoInt))
    {
      cerr << "Unable to turn " << roundTag << 
        " into numerical round." << endl;
      return false;
    }
    const unsigned roundNo = static_cast<unsigned>(roundNoInt);


    if (options.roundFirst > 0 && roundNo < options.roundFirst)
      continue;
    if (options.roundLast > 0 && roundNo > options.roundLast)
      continue;

    tag = makeHandTag(roundTag, boardNo);
    if (hands.find(tag) == hands.end())
      static_cast<void>(hands[tag].setBoardNumber(boardNo));
    hands[tag].add(result);
  }

  fname.close();
  return true;
}

