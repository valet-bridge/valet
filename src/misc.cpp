/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// The functions in this file are help functions.


#include <iostream>

using namespace std;

#include "Pairs.h"
#include "misc.h"

extern Pairs pairs;


void PrintResult(
  const ResultType& res)
{
  cout << 
    setw(10) << left << "North" << right <<
    res.north << 
    " (" << pairs.GetPlayerName(res.north) << ")\n";

  cout << 
    setw(10) << left << "East" << right <<
    res.east << 
    " (" << pairs.GetPlayerName(res.east) << ")\n";

  cout << 
    setw(10) << left << "South" << right <<
    res.south << 
    " (" << pairs.GetPlayerName(res.south) << ")\n";

  cout << setw(10) << left << "West" << right <<
    res.west << 
    " (" << pairs.GetPlayerName(res.west) << ")\n";

  cout << setw(10) << left << "Contract" << right <<
    res.level << " " <<
    ValetDenoms[res.denom] << " " <<
    ValetMultipliers[res.multiplier] << "\n";

  cout << setw(10) << left << "Declarer" << right <<
    ValetPositions[res.declarer] << "\n";

  cout << setw(10) << left << "Tricks" << right <<
    res.tricks << "\n";

  cout << setw(10) << left << "Lead" << right <<
    ValetDenoms[res.leadDenom] << 
    ValetRanks[res.leadRank] << "\n";
}


void PrintEntry(
  const ValetEntryType& entry)
{
  cout << setw(12) << left << "Pair no." << right << entry.pairNo << "\n";

  cout << setw(12) << left << "Opp no." << right << entry.oppNo << "\n";

  cout << setw(12) << left << "Declaring" << right <<
    entry.declFlag[0] << " " << entry.declFlag[1] << "\n";

  cout << setw(12) << left << "Defending" << right << entry.defFlag << "\n";

  cout << setw(12) << left << "Leading" << right <<
    entry.leadFlag[0] << " " << entry.leadFlag[1] << "\n";

  cout << setw(12) << left << "Bid score" << entry.bidScore << "\n";

  cout << setw(12) << left << "Play score" << right <<
    entry.playScore[0] << " " << entry.playScore[1] << "\n";

  cout << setw(12) << left << "Lead score" << right <<
    entry.leadScore[0] << " " << entry.leadScore[1] << "\n";

  cout << setw(12) << left << "Def score" << right <<
    entry.defScore << "\n";
}

