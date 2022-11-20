/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// The functions in this file are help functions.


#include <iostream>
#include <fstream>
#include <sstream>
#include <cassert>

using namespace std;

#include "Pairs.h"
#include "misc.h"

extern Pairs pairs;
extern OptionsType options;

struct CumType
{
  unsigned count;
  float overall;
  float bidScore;
  float leadScore;
  float defScore;
};


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


string ResultKey(const ResultType& res)
{
  if (res.level == 0)
    return "pass";

  stringstream ss;
  ss << res.level << ValetDenomsShort[res.denom] <<
    ValetMultipliers[res.multiplier] << ", " <<
    ValetPositionsShort[res.declarer] << ", ";

  if (options.leadFlag)
    ss << ValetDenomsShort[res.leadDenom] << ", ";

  ss << res.tricks;

  return ss.str();
}


void AccumulateTableau(
  const vector<ValetEntryType>& entries,
  map<string, CumType>& cum)
{
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
}


void AverageTableau(
  map<string, CumType>& cum)
{
  if (options.valet == VALET_MATCHPOINTS)
  {
    for (auto& cumit: cum)
    {
      const string key = cumit.first;
      auto& celem = cumit.second;
      const float n = static_cast<float>(celem.count);

      celem.overall /= n;
      celem.bidScore /= n;
      celem.leadScore /= n;
      celem.defScore /= n;

      celem.overall = 100.f * (celem.overall + 1.f) / 2.f;
      celem.bidScore = 100.f * (celem.bidScore + 1.f) / 2.f;
      celem.leadScore = 100.f * (celem.leadScore + 1.f) / 2.f;
      celem.defScore = 100.f * (celem.defScore + 1.f) / 2.f;
    }
  }
  else
  {
    for (auto& cumit: cum)
    {
      const string key = cumit.first;
      auto& celem = cumit.second;
      const float n = static_cast<float>(celem.count);

      celem.overall /= n;
      celem.bidScore /= n;
      celem.leadScore /= n;
      celem.defScore /= n;
    }
  }
}


void PrintTableauText(
  const vector<ValetEntryType>& entries,
  const string& boardtag,
  ostream& oss)
{
  map<string, CumType> cum;
  AccumulateTableau(entries, cum);
  AverageTableau(cum);

  oss << "DECLARER, Board " << boardtag << "\n\n";

  oss << setw(16) << left << "Contract";
  oss << setw(8) << right << "Count";
  oss << setw(8) << "Overall";
  oss << setw(8) << "Bid";
  oss << setw(8) << "Play" << "\n";

  const int prec = 2;

  const float MP_OFFSET = (options.valet == VALET_MATCHPOINTS ?
    100.f : 0.f);

  for (auto& cumit: cum)
  {
    const auto& celem = cumit.second;
    const unsigned n = celem.count;

    oss << left << setw(16) << cumit.first <<
      setw(8) << right << n  <<
      setw(8) << fixed << setprecision(prec) << celem.overall <<
      setw(8) << fixed << setprecision(prec) << celem.bidScore <<
      setw(8) << fixed << setprecision(prec) << 
        1.5f * MP_OFFSET -(celem.leadScore + celem.defScore) << "\n";
  }

  oss << "\nDEFENDER, Board " << boardtag << "\n\n";

  oss << setw(16) << left << "Contract";
  oss << setw(8) << right << "Count";
  oss << setw(8) << "Overall";
  oss << setw(8) << "Bid";
  if (options.leadFlag)
  {
    oss << setw(8) << "Lead";
    oss << setw(8) << "Restdef" << "\n";
  }
  else
    oss << setw(8) << "Def" << "\n";

  for (auto& cumit: cum)
  {
    const auto& celem = cumit.second;
    const unsigned n = celem.count;

    oss << left << setw(16) << cumit.first <<
      setw(8) << right << n  <<
      setw(8) << MP_OFFSET -celem.overall <<
      setw(8) << fixed << setprecision(prec) << 
        MP_OFFSET - celem.bidScore;

    if (options.leadFlag)
      oss << setw(8) << fixed << setprecision(prec) << celem.leadScore;

    oss << setw(8) << fixed << setprecision(prec) << celem.defScore << "\n";
  }
  oss << "\n";
}


float scale(
  const float sum,
  const unsigned num,
  const ScoringType stype)
{
  if (stype == VALET_MATCHPOINTS)
  {
    if (num > 0)
    {
      // Convert -1 .. +1 to 0 .. 100%.
      const float n = static_cast<float>(num);
      return 100.f * (sum + n) / (2.f * n);
    }
    else
      return 50.f;
  }
  else
  {
    if (num > 0)
      return sum / static_cast<float>(num);
    else
      return 0.;
  }
}


string strPair(
  const float average,
  const unsigned count,
  const int prec,
  const FormatType format)
{
  stringstream ss;

  if (format == VALET_FORMAT_TEXT)
  {
    if (count > 0)
      ss << setw(5) << fixed << setprecision(prec) << average <<
        " (" << setw(3) << count << ")";
    else
      ss << setw(5) << "-" << " (  0)";
  }
  else if (format == VALET_FORMAT_CSV)
  {
    if (count > 0)
      ss << setprecision(prec) << average << options.separator <<
        count << options.separator;
    else
      ss << "-" << options.separator << "0" << options.separator;
  }
  else
    assert(false);

  return ss.str();
}

