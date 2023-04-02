/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#include <iostream>
#include <iomanip>
#include <sstream>
#include <cassert>

#include <list>

#include "Tableau.h"
#include "ScoreInput.h"
#include "TableauStats.h"


Tableau::Tableau()
{
  levelStats.resize(SIDE_SIZE);
  for (auto& ls: levelStats)
    ls.resize(LEVEL_SIZE);

  strainStats.resize(SIDE_SIZE);
  for (auto& strs: strainStats)
    strs.resize(STRAIN_SIZE);
}


void Tableau::add(const vector<ScoreInput>& entries)
{
  ValetSide tsideEffective, tsideActual;
  TableauLevel tlevel;
  TableauStrain tstrain;

  for (auto& entry: entries)
  {
    if (entry.sideActual == SIDE_EW)
    {
      declarerEW[entry.keyResult].incrDeclarer(entry);
      defendersNS[entry.keyResult].incrDefenders(entry);
    }
    else
    {
      declarerNS[entry.keyResult].incrDeclarer(entry);
      defendersEW[entry.keyResult].incrDefenders(entry);
    }

    entry.getLevelStats(tsideEffective, tlevel);
    if (tsideEffective != SIDE_SIZE)
      levelStats[tsideEffective][tlevel]++;

    entry.getStrainStats(tsideActual, tstrain);
    if (tsideActual != SIDE_SIZE)
      strainStats[tsideActual][tstrain]++;
  }
}


void Tableau::scale()
{
  for (auto& dpair: declarerNS)
    dpair.second.scale();

  for (auto& dpair: declarerEW)
    dpair.second.scale();

  for (auto& dpair: defendersNS)
    dpair.second.scale();

  for (auto& dpair: defendersEW)
    dpair.second.scale();
}


bool Tableau::slammish() const
{
  // The criteria are:
  // 1. One side plays >= 90% of the time.
  // 2. That side plays in slam at least 20% of the time.
  
  // Count the time that each side plays.
  vector<unsigned> counts;
  counts.resize(SIDE_SIZE);
  float fsum = 0.f;

  for (unsigned side = SIDE_NS; side < SIDE_SIZE; side++)
    for (unsigned level = LEVEL_GRAND; level < LEVEL_SIZE; level++)
    {
      if (level != LEVEL_OPPS_DOUBLED)
        counts[side] += levelStats[side][level];
      fsum += static_cast<float>(levelStats[side][level]);
    }

  // Reject tableaux that are not one-sided enough.
  if (fsum == 0.)
    return false;

  if (fsum > 0.)
  {
    const float frac_NS = static_cast<float>(counts[SIDE_NS]) / fsum;
    if (frac_NS >= 0.1f && frac_NS <= 0.9f)
      return false;
  }

  // Reject tableaux that are too competitive.
  const float csum = static_cast<float>(counts[SIDE_NS] + counts[SIDE_EW]);
  if (csum / fsum <= 0.9f)
    return false;

  const unsigned side = 
    (counts[SIDE_NS] >= counts[SIDE_EW] ?  SIDE_NS : SIDE_EW);

  // Count the slams.
  const float fslams = static_cast<float>(
    levelStats[side][LEVEL_SMALL] + levelStats[side][LEVEL_GRAND]);

  const float fracSlams = fslams / static_cast<float>(counts[side]);

  // Reject tableaux with too little slam potential.
  if (fracSlams <= 0.2f)
    return false;
  else
    return true;
}


string Tableau::strLevels() const
{
  stringstream ss;

  // Level header
  ss << setw(12) << left << "Side";
  for (unsigned level = LEVEL_GRAND; level < LEVEL_SIZE; level++)
    ss << setw(12) << right << levels[level].name;
  ss << "\n";

  // Level stats
  for (unsigned side = SIDE_NS; side < SIDE_SIZE; side++)
  {
    ss << setw(12) << left << sides[side].name;
    for (unsigned level = LEVEL_GRAND; level < LEVEL_SIZE; level++)
    {
      if (levelStats[side][level] == 0)
        ss << setw(12) << right << "-";
      else
        ss << setw(12) << right << levelStats[side][level];
    }
    ss << "\n";
  }
  ss << "\n";

  return ss.str();
}


string Tableau::strStrains() const
{
  stringstream ss;

  // Strain header
  ss << setw(12) << left << "Side";
  for (unsigned strain = STRAIN_NOTRUMP; strain < STRAIN_SIZE; strain++)
    ss << setw(12) << right << strains[strain].name;
  ss << "\n";

  // Strain stats
  for (unsigned side = SIDE_NS; side < SIDE_SIZE; side++)
  {
    ss << setw(12) << left << sides[side].name;
    for (unsigned strain = STRAIN_NOTRUMP; strain < STRAIN_SIZE; strain++)
    {
      if (strainStats[side][strain] == 0)
        ss << setw(12) << right << "-";
      else
        ss << setw(12) << right << strainStats[side][strain];
    }
    ss << "\n";
  }
  ss << "\n";

  return ss.str();
}


string Tableau::strMap(
  const map<string, Score>& scoreMap,
  const bool declarerFlag) const
{
  stringstream ss;

  if (declarerFlag)
    ss << scoreMap.begin()->second.strDeclarerHeader();
  else
    ss << scoreMap.begin()->second.strDefenseHeader();

  struct ListEntry
  {
    string str;
    Score const * scorePtr;

    bool operator < (const ListEntry& le2) const
    {
      return (* scorePtr < * le2.scorePtr);
    };
  };

  // Output in score-sorted order.
  list<ListEntry> slist;
  for (auto& dpair: scoreMap)
    slist.push_back({dpair.first, &dpair.second});

  slist.sort();

  for (auto& lentry: slist)
  {
    if (declarerFlag)
      ss << lentry.scorePtr->strDeclarerLine(
        lentry.str, lentry.scorePtr->getCount());
    else
      ss << lentry.scorePtr->strDefenseLine(
        lentry.str, lentry.scorePtr->getCount());
  }
  ss << "\n";

  return ss.str();
}


string Tableau::str(const string& boardTag) const
{
  stringstream ss;

  ss << "BOARD " << boardTag << "\n";

  ss << "\n";
  // ss << string(6 + boardTag.size(), '=') << "\n\n";

  if (Tableau::slammish())
    ss << "Slammish\n\n";

  ss << "LEVELS\n";

  // ss << "\n";
  // ss << string(6, '-') << "\n\n";
  ss << Tableau::strLevels();

  ss << "STRAINS\n";
  // ss << "\n";
  // ss << string(7, '-') << "\n\n";
  ss << Tableau::strStrains();


  if (! declarerNS.empty())
  {
    ss << "DECLARER NORTH-SOUTH\n";
    // ss << "\n";
    // ss << string(20, '-') << "\n\n";
    ss << Tableau::strMap(declarerNS, true);
  }

  if (! declarerEW.empty())
  {
    ss << "DECLARER EAST-WEST\n";
    // ss << "\n";
    // ss << string(18, '-') << "\n\n";
    ss << Tableau::strMap(declarerEW, true);
  }

  if (! defendersNS.empty())
  {
    ss << "DEFENDERS NORTH-SOUTH\n";
    // ss << "\n";
    // ss << string(21, '-') << "\n\n";
    ss << Tableau::strMap(defendersNS, false);
  }

  if (! defendersEW.empty())
  {
    ss << "DEFENDERS EAST-WEST\n";
    // ss << "\n";
    // ss << string(19, '-') << "\n\n";
    ss << Tableau::strMap(defendersEW, false);
  }
  ss << "\n";

  return ss.str();
}

