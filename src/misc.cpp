/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// The functions in this file are help functions.


#include <iostream>
#include <fstream>

using namespace std;

#include "Pairs.h"
#include "misc.h"

extern Pairs pairs;


void PrintResult(
  const ResultType& res,
  ostream& oss)
{
  oss << 
    setw(10) << left << "North" << right <<
    res.north << 
    " (" << pairs.GetPlayerName(res.north) << ")\n";

  oss << 
    setw(10) << left << "East" << right <<
    res.east << 
    " (" << pairs.GetPlayerName(res.east) << ")\n";

  oss << 
    setw(10) << left << "South" << right <<
    res.south << 
    " (" << pairs.GetPlayerName(res.south) << ")\n";

  oss << setw(10) << left << "West" << right <<
    res.west << 
    " (" << pairs.GetPlayerName(res.west) << ")\n";

  oss << setw(10) << left << "Contract" << right <<
    res.level << " " <<
    ValetDenoms[res.denom] << " " <<
    ValetMultipliers[res.multiplier] << "\n";

  oss << setw(10) << left << "Declarer" << right <<
    ValetPositions[res.declarer] << "\n";

  oss << setw(10) << left << "Tricks" << right <<
    res.tricks << "\n";

  oss << setw(10) << left << "Lead" << right <<
    ValetDenoms[res.leadDenom] << 
    ValetRanks[res.leadRank] << "\n";
}


void PrintEntry(
  const ValetEntryType& entry,
  ostream& oss)
{
  oss << setw(12) << left << "Pair no." << right << entry.pairNo << "\n";

  oss << setw(12) << left << "Opp no." << right << entry.oppNo << "\n";

  oss << setw(12) << left << "Declaring" << right <<
    entry.declFlag[0] << " " << entry.declFlag[1] << "\n";

  oss << setw(12) << left << "Defending" << right << entry.defFlag << "\n";

  oss << setw(12) << left << "Leading" << right <<
    entry.leadFlag[0] << " " << entry.leadFlag[1] << "\n";

  oss << setw(12) << left << "Overall" << entry.overall << "\n";

  oss << setw(12) << left << "Bid score" << entry.bidScore << "\n";

  oss << setw(12) << left << "Play score" << right <<
    entry.playScore[0] << " " << entry.playScore[1] << "\n";

  oss << setw(12) << left << "Lead score" << right <<
    entry.leadScore[0] << " " << entry.leadScore[1] << "\n";

  oss << setw(12) << left << "Def score" << right <<
    entry.defScore << "\n";
}


string  ResultKey(const ResultType& res)
{
  if (res.level == 0)
    return "pass";

  stringstream ss;
  ss << res.level << ValetDenomsShort[res.denom] <<
    ValetMultipliers[res.multiplier] << ", " <<
    ValetPositions[res.declarer] << ", " <<
    ValetDenomsShort[res.leadDenom] << ", " << 
    res.tricks;

  return ss.str();
}


void PrintEntryTableau(
  const vector<ValetEntryType>& entries,
  const unsigned bno,
  ostream& oss)
{
  struct CumType
  {
    unsigned count;
    float overall;
    float bidScore;
    float leadScore;
    float defScore;
  };

  map<string, CumType> cum;

  // TODO Matchpoints
  int prec;
  if (1)
    prec = 2;
  else
    prec = 2;

  for (auto& entry: entries)
  {
    const ResultType& res = entry.result;
    const string key = ResultKey(res);

    auto it = cum.find(key);
    if (it == cum.end())
    {
      cum[key].count = 0;
      cum[key].overall = 0.f;
      cum[key].bidScore = 0.f;
      cum[key].leadScore = 0.f;
      cum[key].defScore = 0.f;
    }

    if (key == "pass")
    {
      cum[key].count++;
      cum[key].overall += entry.overall;
      cum[key].bidScore += entry.bidScore;
      cum[key].defScore += entry.defScore;
    }
    else
    {
      cum[key].count++;
      cum[key].overall += entry.overall;
      cum[key].bidScore += entry.bidScore;

      if (entry.leadFlag[0])
        cum[key].leadScore += entry.leadScore[0];
      else
        cum[key].leadScore += entry.leadScore[1];

      cum[key].defScore += entry.defScore;
    }
  }

  oss << "DECLARER, Board " << bno << "\n\n";

  oss << setw(16) << left << "Contract";
  oss << setw(8) << right << "Count";
  oss << setw(8) << "Overall";
  oss << setw(8) << "Bid";
  oss << setw(8) << "Play" << "\n";

  // TODO Only IMPs so far.  Always shows lead.  Ditto below.

  for (auto& cumit: cum)
  {
    const auto& celem = cumit.second;
    const unsigned n = celem.count;

    oss << left << setw(16) << cumit.first <<
      setw(8) << right << n  <<
      setw(8) << fixed << setprecision(prec) << celem.overall / n <<
      setw(8) << fixed << setprecision(prec) << celem.bidScore / n <<
      setw(8) << fixed << setprecision(prec) << 
        -(celem.leadScore + celem.defScore) / n << "\n";
  }

  oss << "\nDEFENDER, Board " << bno << "\n\n";

  oss << setw(16) << left << "Contract";
  oss << setw(8) << right << "Count";
  oss << setw(8) << "Overall";
  oss << setw(8) << "Bid";
  oss << setw(8) << "Lead";
  oss << setw(8) << "Restdef" << "\n";

  for (auto& cumit: cum)
  {
    const auto& celem = cumit.second;
    const unsigned n = celem.count;

    oss << left << setw(16) << cumit.first <<
      setw(8) << right << n  <<
      setw(8) << -celem.overall / n <<
      setw(8) << fixed << setprecision(prec) << -celem.bidScore / n <<
      setw(8) << fixed << setprecision(prec) << celem.leadScore / n <<
      setw(8) << fixed << setprecision(prec) << celem.defScore / n << "\n";
  }
}

