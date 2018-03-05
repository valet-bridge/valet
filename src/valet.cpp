/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// This is the main function, reading in and processing the files.


#include <iostream>
#include <fstream>

#include "cst.h"
#include "args.h"
#include "files.h"
#include "scoring.h"
#include "misc.h"
#include "Pairs.h"
#include "Hand.h"
#include "Scores.h"

using namespace std;


OptionsType options;
typedef map<string, Hand>::iterator it_type;
map<string, Hand> handList;
Pairs pairs;
Scores scores;
ErrorType error;


int main(int argc, char * argv[])
{
  error.flag = false;
  ReadArgs(argc, argv);
  SetTables();

  if (! ReadNameFile(options.directory + "/" + options.nameFile))
    return(0);

  if (! ReadScoresFile(options.directory + "/" + options.scoresFile))
    return(0);

  fstream tableauStream;
  if (options.tableauFlag)
  {
    tableauStream.open(options.tableauFile, fstream::out);
    if (! tableauStream.is_open())
    {
      cerr << "Can't write to " << options.tableauFile << "\n";
      exit(1);
    }
  }

  unsigned numEntries = 16;
  vector<ValetEntryType> entries(numEntries);
  for (it_type it = handList.begin(); it != handList.end(); it++)
  {
    unsigned num = it->second.GetNumEntries();
    if (num > numEntries)
    {
      entries.resize(num);
      numEntries = num;
    }

    entries = it->second.CalculateScores();
    for (unsigned i = 0; i < entries.size(); i++)
      scores.AddEntry(entries[i]);
    
    if (options.tableauFlag)
      PrintTableauText(entries, it->first, tableauStream);
  }


  if (options.compensateFlag)
    scores.Compensate();

  if (options.tableauFlag)
    tableauStream.close();

  scores.Normalize();
  scores.Sort(options.sort);
  scores.Print();
  cout.flush();
}

