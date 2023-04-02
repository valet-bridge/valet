/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


// This is the main function, reading in and processing the files.


#include <iostream>
#include <fstream>
#include <list>
#include <cassert>

#include "pairs/Players.h"
#include "pairs/Pairs.h"
#include "hand/Hand.h"
#include "scores/Scores.h"

#include "scores/ScoreInput.h"
#include "scores/Tableau.h"
#include "scores/PairSheets.h"

#include "inputs/args.h"
#include "inputs/files.h"
#include "inputs/parse.h"

#include "scoring.h"

#include "cst.h"

using namespace std;


Options options;
Players players;
Pairs pairs;
map<string, Hand> hands;
Scores scores;
Error error;


int main(int argc, char const * argv[])
{
  error.flag = false;
  readArgs(argc, argv);
  setTables();

  if (! readNameFile(options.directory + "/" + options.nameFile))
    return(0);

  if (! readScoresFile(options.directory + "/" + options.scoresFile))
    return(0);

  fstream ts;
  if (options.tableauFlag)
  {
    ts.open(options.tableauFile, fstream::out);
    if (! ts.is_open())
    {
      cerr << "Can't write to " << options.tableauFile << "\n";
      exit(1);
    }
  }

  fstream ps;
  if (options.pairSheetsFlag)
  {
    ps.open(options.pairSheetsFile, fstream::out);
    if (! ps.is_open())
    {
      cerr << "Can't write to " << options.pairSheetsFile << "\n";
      exit(1);
    }
  }

  // Kludge to get the hand in the right semantic order.
  struct HandEntry
  {
    string str;
    Hand * handPtr;

    bool operator < (const HandEntry& he2) const
    {
      return lessByBoard(str, he2.str);
    };
  };

  list<HandEntry> hlist;
  for (auto& hand: hands)
    hlist.push_back({hand.first, &hand.second});

  hlist.sort();

  PairSheets pairSheets;

  for (auto& hentry: hlist)
  {
    vector<ScoreInput> entries;

    hentry.handPtr->calculateScores(entries);

    for (auto& entry: entries)
    {
      scores.add(entry);
      if (options.pairSheetsFlag)
        pairSheets.add(hentry.str, entry);
    }
    
    if (options.tableauFlag)
    {
      Tableau tableau;
      tableau.add(entries);
      tableau.scale();
      ts << tableau.str(hentry.str);
    }
  }

  if (options.tableauFlag)
    ts.close();

  if (options.pairSheetsFlag)
  {
    pairSheets.sort();
    ps << pairSheets.str();
    ps.close();
  }

  scores.scale();

  if (options.compensateFlag)
    scores.compensate();

  if (options.learnFlag)
  {
    fstream ls;
    ls.open(options.learnFile, fstream::out);
    if (! ls.is_open())
    {
      cerr << "Can't write to " << options.learnFile << "\n";
      exit(1);
    }

    for (auto& hentry: hlist)
      ls << hentry.str << "," << hentry.handPtr->strProfile();

    exit(0);
  }

  scores.sort(static_cast<SortingEnum>(options.sort));
  cout << scores.str();
  cout.flush();
}

