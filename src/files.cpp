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

#include "files.h"
#include "Pairs.h"
#include "Hand.h"
#include "parse.h"
#include "cst.h"

using namespace std;

extern OptionsType options;
extern Pairs pairs;
extern map<string, Hand> handList;


string MakeHandTag(
  const unsigned rno,
  const unsigned bno);


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


#include "misc.h"
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
  vector<string> tokens(32);
  ResultType res;
  string tag;

  while (getline(fname, line))
  {
    lno++;
    if (line[0] == '#' || line.empty())
      continue;

    tokens.clear();
    tokenize(line, tokens, "|");
    size_t tlen = tokens.size();
    if (tlen != 9 && tlen != 10)
    {
      cerr << "File '" << scoresFile << "', line " << lno << 
        ":\nGot " << tlen << " tokens, wanted 9 or 10\n";
      cerr << "(" << line << ")" << endl;
      return false;
    }

    if (! LineToResult(tokens, res, rno, bno))
    {
      cerr << "File '" << scoresFile << "', line " << lno << 
        ": Syntax error\n";
      cerr << "(" << line << ")" << endl;
      return false;
    }

    if (options.roundFirst > 0 && rno < options.roundFirst)
      continue;
    if (options.roundLast > 0 && rno > options.roundLast)
      continue;

    tag = MakeHandTag(rno, bno);
    map<string, Hand>::iterator it = handList.find(tag);
    if (it == handList.end())
      handList[tag].SetBoardNumber(bno);
    handList[tag].AddResult(res);
  }

  fname.close();
  return true;
}

