/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// The functions in this file read the input files.


#include <iostream>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <string>
#include <map>
#include <functional>
#include <algorithm>

#include "files.h"
#include "Pairs.h"
#include "Hand.h"
#include "parse.h"
#include "valet.h"

using namespace std;

extern OptionsType options;
extern Pairs pairs;
extern map<string, Hand> handList;
extern ErrorType error;


string MakeHandTag(
  const unsigned rno,
  const unsigned bno);


bool ReadNameFile(
  const string nameFile)
{
  ifstream fname(nameFile.c_str());
  if (! fname.is_open())
  {
    cerr << "Unable to read from file '" << nameFile << "'." << endl;
    return false;
  }

  string line;
  unsigned lno = 0;
  vector<string> tokens(32);
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

    pairs.AddPlayer(tokens[0], tokens[1]);
  }

  fname.close();
  return true;
}


string MakeHandTag(
  const unsigned rno,
  const unsigned bno)
{
  ostringstream oss;
  oss << rno << "|" << bno;
  return oss.str();
}


bool ReadScoresFile(
  const string scoresFile)
{
  ifstream fname(scoresFile.c_str());
  if (! fname.is_open())
  {
    cerr << "Unable to read from file '" << scoresFile << "'." << endl;
    return false;
  }

  handList.clear();
  string line;
  unsigned lno = 0, rno, bno = 0;
  ResultType res;
  string tag;

  while (getline(fname, line))
  {
    lno++;
    if (line[0] == '#' || line.empty())
      continue;

    // Trim line end
    line.erase(find_if(line.rbegin(), line.rend(),
      not1(ptr_fun<int, int>(isspace))).base(), line.end());

    int r;
    if ((r = ParseScoreLine(line, res, rno, bno)) != RETURN_NO_FAULT)
    {
      if (r == RETURN_TOKEN_NUMBER)
      {
        cerr << "File '" << scoresFile << "', line " << lno << 
          ":\nGot wrong number of tokens, wanted 9 or 10\n";
        cerr << "(" << line << ")\n";
        cerr << error.message.str();
        return false;
      }
      else
      {
        cerr << "File '" << scoresFile << "', line " << lno << 
          ": Syntax error" << endl;
        cerr << "(" << line << ")" << endl;
        cerr << error.message.str() << endl;
        return false;
      }
    }

    if (options.roundFirst > 0 && rno < options.roundFirst)
      continue;
    if (options.roundLast > 0 && rno > options.roundLast)
      continue;

    tag = MakeHandTag(rno, bno);
    map<string, Hand>::iterator it = handList.find(tag);
    if (it == handList.end())
      static_cast<void>(handList[tag].SetBoardNumber(bno));
    handList[tag].AddResult(res);
  }

  fname.close();
  return true;
}

