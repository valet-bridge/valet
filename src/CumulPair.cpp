/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-23 by Soren Hein.

   See LICENSE and README.
*/


#include <iostream>
#include <iomanip>
#include <string>
#include <cassert>

#include "Pairs.h"
#include "CumulPair.h"
#include "misc.h"
#include "cst.h"

extern OptionsType options;


void CumulPair::setPair(const unsigned pairNoIn)
{
  pairNo = pairNoIn;
}


void CumulPair::incrDeclarer(const ValetEntryType& entry)
{
  num[VALET_OVERALL]++;
  sum[VALET_OVERALL] += entry.overall;

  num[VALET_BID]++;
  sum[VALET_BID] += entry.bidScore;

  if (entry.declFlag[0])
  {
    num[VALET_PLAY1]++;
    sum[VALET_PLAY1] += entry.playScore[0];
  }
  else if (entry.declFlag[1])
  {
    num[VALET_PLAY2]++;
    sum[VALET_PLAY2] += entry.playScore[1];
  }
}


void CumulPair::incrDefenders(const ValetEntryType& entry)
{
  num[VALET_OVERALL]++;
  sum[VALET_OVERALL] -= entry.overall;

  num[VALET_BID]++;
  sum[VALET_BID] -= entry.bidScore;

  if (entry.defFlag)
  {
    num[VALET_DEF]++;
    sum[VALET_DEF] += entry.defScore;

    if (options.leadFlag)
    {
      if (entry.leadFlag[0])
      {
        num[VALET_LEAD1]++;
        sum[VALET_LEAD1] += entry.leadScore[0];
      }
      else if (entry.leadFlag[1])
      {
        num[VALET_LEAD2]++;
        sum[VALET_LEAD2] += entry.leadScore[1];
      }
    }
  }

}


float CumulPair::averagePlay() const
{
  const float n1 = static_cast<float>(num[VALET_PLAY1]);
  const float n2 = static_cast<float>(num[VALET_PLAY2]);
  const float n = n1 + n2;
  if (n > 0)
  {
    return (avgPerChance[VALET_PLAY1] * n1 +
      avgPerChance[VALET_PLAY2] * n2) / n;
  }
  else
    return 0.;
}


float CumulPair::averageDefense() const
{
  const float n1 = static_cast<float>(num[VALET_PLAY1]);
  const float n2 = static_cast<float>(num[VALET_PLAY2]);
  const float n3 = static_cast<float>(num[VALET_DEF]);
  const float n = n1 + n2 + n3;
  if (n > 0)
  {
    // TODO Not convinced that this is the only place 
    // that this needs to show up...
    const float offsetMP =
      (options.valet == VALET_MATCHPOINTS ? 50.f : 0.f);

    return -offsetMP +
      (avgPerChance[VALET_LEAD1] * n1 +
       avgPerChance[VALET_LEAD2] * n2 +
       avgPerChance[VALET_DEF] * n3) / n3;
  }
  else
    return 0.;
}


float CumulPair::averageLead1() const
{
  return avgPerChance[VALET_LEAD1];
}


float CumulPair::averageLead2() const
{
  return avgPerChance[VALET_LEAD2];
}


float CumulPair::averageLead() const
{
  const float n1 = static_cast<float>(num[VALET_LEAD1]);
  const float n2 = static_cast<float>(num[VALET_LEAD2]);
  const float n3 = static_cast<float>(num[VALET_PLAY1]);
  const float n4 = static_cast<float>(num[VALET_PLAY2]);
  const float n = n3 + n4;
  if (n > 0)
  {
    return (avgPerChance[VALET_LEAD1] * n1 +
      avgPerChance[VALET_LEAD2] * n2) / n;
  }
  else
    return 0.;
}


float CumulPair::averageNonLead() const
{
  return avgPerChance[VALET_DEF];
}


bool CumulPair::greater(
  const CumulPair& c2,
  const SortingType sort) const
{
 float f1, f2;

 switch (sort)
 {
    case VALET_SORT_OVERALL:
      return (avgPerChance[VALET_OVERALL] >
        c2.avgPerChance[VALET_OVERALL]);

    case VALET_SORT_BIDDING:
      return (avgPerChance[VALET_BID] > 
        c2.avgPerChance[VALET_BID]);

    case VALET_SORT_PLAY:
      return (avgPerChance[VALET_PLAY1] + avgPerChance[VALET_PLAY2] >
        c2.avgPerChance[VALET_PLAY1] + c2.avgPerChance[VALET_PLAY2]);

    case VALET_SORT_DEFENSE:
      return (avgPerChance[VALET_DEF] > c2.avgPerChance[VALET_DEF]);

    case VALET_SORT_LEAD:
      return (avgPerChance[VALET_LEAD1] + avgPerChance[VALET_LEAD2] >
        c2.avgPerChance[VALET_LEAD1] + c2.avgPerChance[VALET_LEAD2]);

    case VALET_SORT_BID_OVER_PLAY:
      f1 = avgPerChance[VALET_BID] -
        (avgPerChance[VALET_PLAY1] + avgPerChance[VALET_PLAY2]);
      f2 = c2.avgPerChance[VALET_BID] -
        (c2.avgPerChance[VALET_PLAY1] + c2.avgPerChance[VALET_PLAY2]);
      return (f1 > f2);

    case VALET_SORT_DEF_OVER_PLAY:
      f1 = avgPerChance[VALET_DEF] -
        (avgPerChance[VALET_PLAY1] + avgPerChance[VALET_PLAY2]);
      f2 = c2.avgPerChance[VALET_DEF] -
        (c2.avgPerChance[VALET_PLAY1] + c2.avgPerChance[VALET_PLAY2]);
      return (f1 > f2);

    case VALET_SORT_LEAD_OVER_PLAY:
      f1 = 
        avgPerChance[VALET_LEAD1] + avgPerChance[VALET_LEAD2] -
        (avgPerChance[VALET_PLAY1] + avgPerChance[VALET_PLAY2]);
      f2 = 
        c2.avgPerChance[VALET_LEAD1] + c2.avgPerChance[VALET_LEAD2] -
        (c2.avgPerChance[VALET_PLAY1] + c2.avgPerChance[VALET_PLAY2]);
      return (f1 > f2);

    default:
      assert(false);
      return 0.;
  }
}


bool CumulPair::skip(const unsigned mode) const
{
  if (num[VALET_OVERALL] == 0)
    return true;

  if (mode == 0)
  {
    if (num[VALET_OVERALL] < options.minHands)
      return true;
  }
  else if (num[VALET_OVERALL] > options.minHands)
      return true;

  return false;
}


string CumulPair::strHeaderText1() const
{
  stringstream ss;

  ss <<
    setw(11) << "" << " | " <<
    setw(12) << "" << " | " <<
    setw(8) << "" <<
    setw(6) << "Play" <<
    setw(10) << "" << " | " <<
    setw(7) << "" <<
    setw(4) << "Declaring" <<
    setw(8) << "" << " | ";

  if (options.leadFlag)
  {
    if (options.averageFlag)
      ss <<
        setw(19) << "" <<
        setw(11) << "Defending" <<
        setw(20) << "" << " |";
    else
      ss <<
        setw(13) << "" <<
        setw(11) << "Defending" <<
        setw(13) << "" << " |";
  }

  return ss.str();
}


string CumulPair::strHeaderText2() const
{
  stringstream ss;

  ss <<
    setw(4) << "No." <<
    setw(7) << scoringTags[options.valet].header << " | " <<
    setw(5) << "Bid" <<
    setw(7) << "Play" << " | " <<
    setw(11) << "Declaring" << "  " <<
    setw(11) << "Defending" << " | " <<
    setw(11) << "Declarer1" <<
    setw(13) << "Declarer2";

  if (options.leadFlag)
  {
    ss <<
      " | " <<
      setw(11) << "Lead1" << "  " <<
      setw(11) << "Lead2";

    if (options.averageFlag)
      ss << setw(13) << "Average";

    ss <<
      setw(13) << "Play";
  }

  ss << " |";

  return ss.str();
}


string CumulPair::strHeaderCSV() const
{
  stringstream ss;

  const string sep = options.separator;

  ss <<
    "Count" << sep <<
    scoringTags[options.valet].header << sep <<
    "Bid" << sep <<
    "Play" << sep <<
    "Decl" << sep <<
    "#" << sep <<
    "Def" << sep <<
    "#" << sep <<
    "Decl1" << sep <<
    "#" << sep <<
    "Decl2" << sep <<
    "#" << sep;

  if (options.leadFlag)
  {
    ss <<
      "Lead1" << sep <<
      "#" << sep <<
      "Lead2" << sep <<
      "#" << sep;

    if (options.averageFlag)
      ss << "Avg" << sep << "#" << sep;

    ss << "Play" << sep << "#";
  }

  return ss.str();
}


string CumulPair::strOverall(
  const Pairs& pairs,
  const int prec,
  const FormatType format) const
{
  stringstream ss;

  const float MP_OFFSET =
    (options.valet == VALET_MATCHPOINTS ? 50.f : 0.f);

  if (format == VALET_FORMAT_TEXT)
  {
    ss <<
      left << pairs.GetPairNamePadded(pairNo, 54) << right << " | " <<
      setw(4) << num[VALET_OVERALL] <<
      setw(7) << fixed << setprecision(prec) <<
        avgPerChance[VALET_OVERALL] <<  " | " <<
      setw(5) << fixed << setprecision(prec) <<
        avgPerChance[VALET_BID] <<
      setw(7) << fixed << setprecision(prec) <<
        MP_OFFSET +
        avgPerChance[VALET_OVERALL] -
        avgPerChance[VALET_BID] << " | ";
  }
  else if (format == VALET_FORMAT_CSV)
  {
    const string sep = options.separator;
    ss <<
      pairs.GetPairName(pairNo) << sep << 
      num[VALET_OVERALL] << sep <<
      fixed << setprecision(prec) << 
        avgPerChance[VALET_OVERALL] << sep <<
      fixed << setprecision(prec) << 
        avgPerChance[VALET_BID] << sep <<
      fixed << setprecision(prec) <<
        MP_OFFSET +
        avgPerChance[VALET_OVERALL] -
        avgPerChance[VALET_BID] << sep;
  }
  else
    assert(false);

  return ss.str();
}


string CumulPair::strDetails(
  const int prec,
  const FormatType format) const
{
  stringstream ss;

  // Declarer score.
  unsigned n = num[VALET_PLAY1] + num[VALET_PLAY2];
  ss << strPair(CumulPair::averagePlay(), n, prec, format);

  if (format == VALET_FORMAT_TEXT)
    ss << "  ";

  // Defender score.
  n = num[VALET_DEF];
  ss << strPair(CumulPair::averageDefense(), n, prec, format);

  if (format == VALET_FORMAT_TEXT)
    ss << " | ";

  // Individual declarer scores.
  ss << strPair(avgPerChance[VALET_PLAY1], num[VALET_PLAY1], 
    prec, format);

  if (format == VALET_FORMAT_TEXT)
    ss << "  ";

  ss << strPair(avgPerChance[VALET_PLAY2], num[VALET_PLAY2], 
    prec, format);

  if (format == VALET_FORMAT_TEXT)
    ss << " | ";

  if (options.leadFlag)
  {
    ss << strPair(avgPerChance[VALET_LEAD1], num[VALET_LEAD1], 
      prec, format);

    if (format == VALET_FORMAT_TEXT)
      ss << "  ";

    ss << strPair(avgPerChance[VALET_LEAD2], num[VALET_LEAD2], 
      prec, format);

    if (format == VALET_FORMAT_TEXT)
      ss << "  ";

    if (options.averageFlag)
    {
      ss << strPair(CumulPair::averageLead(),
        num[VALET_PLAY1] + num[VALET_PLAY2], prec, format);

      if (format == VALET_FORMAT_TEXT)
        ss << "  ";
    }

    ss << strPair(
      avgPerChance[VALET_DEF], num[VALET_DEF], prec, format);

    if (format == VALET_FORMAT_TEXT)
      ss << " |";
  }

  ss << "\n";

  return ss.str();
}