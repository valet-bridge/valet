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


CumulPair::CumulPair()
{
  aspects.resize(VALET_ENTRY_SIZE);
}


void CumulPair::clear()
{
  for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
  {
    num[i] = 0;
    sum[i] = 0.f;
  }
}


void CumulPair::setPair(const unsigned pairNoIn)
{
  pairNo = pairNoIn;
}


void CumulPair::incrDeclarer(const ValetEntryType& entry)
{
  aspects[VALET_OVERALL].incr(entry.overall);
  aspects[VALET_BID].incr(entry.bidScore);

  if (entry.declFlag[0])
  {
    aspects[VALET_PLAY_SUM].incr(entry.playScore[0]);
    aspects[VALET_PLAY1].incr(entry.playScore[0]);
  }
  else if (entry.declFlag[1])
  {
    aspects[VALET_PLAY_SUM].incr(entry.playScore[1]);
    aspects[VALET_PLAY2].incr(entry.playScore[1]);
  }


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
  aspects[VALET_OVERALL].decr(entry.overall);
  aspects[VALET_BID].decr(entry.bidScore);

  if (entry.defFlag)
  {

    if (options.leadFlag)
    {
      aspects[VALET_DEF].incr(entry.defScore);

      float dsum = entry.defScore;

      if (entry.leadFlag[0])
      {
        aspects[VALET_LEAD_SUM].incr(entry.leadScore[0]);
        aspects[VALET_LEAD1].incr(entry.leadScore[0]);
        dsum += entry.leadScore[0];
      }
      else if (entry.leadFlag[1])
      {
        aspects[VALET_LEAD_SUM].incr(entry.leadScore[1]);
        aspects[VALET_LEAD2].incr(entry.leadScore[1]);
        dsum += entry.leadScore[1];
      }

      aspects[VALET_DEF_SUM].incr(dsum);
    }
    else
    {
      aspects[VALET_DEF].incr(entry.defScore);
      aspects[VALET_DEF_SUM].incr(entry.defScore);
    }
  }

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

    // return -offsetMP +
    //   (aspects[VALET_LEAD1].sum +
    //    aspects[VALET_LEAD2].sum +
    //    aspects[VALET_DEF].sum) / n3;
  }
  else
    return 0.;
}


void CumulPair::operator += (const CumulPair& c2)
{
  for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
  {
    sum[i] += c2.sum[i];
    num[i] += c2.num[i];

    aspects[i] += c2.aspects[i];
  }
}


void CumulPair::operator -= (const CumulPair& c2)
{
  for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
  {
    sum[i] -= c2.sum[i];
    num[i] -= c2.num[i];

    aspects[i] -= c2.aspects[i];
  }
}


float CumulPair::figure(const SortingEnum sort) const
{
  // Different figures of merit on which we can sort.
  if (sort == VALET_SORT_OVERALL)
    return avgPerChance[VALET_OVERALL];
  else if (sort == VALET_SORT_BIDDING)
    return avgPerChance[VALET_BID];
  else if (sort == VALET_SORT_PLAY)
    return avgPerChance[VALET_PLAY1] + avgPerChance[VALET_PLAY2];
  else if (sort == VALET_SORT_DEFENSE)
    return avgPerChance[VALET_DEF];
  else if (sort == VALET_SORT_LEAD)
    return avgPerChance[VALET_LEAD1] + avgPerChance[VALET_LEAD2];
  else if (sort == VALET_SORT_BID_OVER_PLAY)
    return avgPerChance[VALET_BID] -
      (avgPerChance[VALET_PLAY1] + avgPerChance[VALET_PLAY2]);
  else if (sort == VALET_SORT_DEF_OVER_PLAY)
    return avgPerChance[VALET_DEF] -
      (avgPerChance[VALET_PLAY1] + avgPerChance[VALET_PLAY2]);
  else if (sort == VALET_SORT_LEAD_OVER_PLAY)
    return avgPerChance[VALET_LEAD1] + avgPerChance[VALET_LEAD2] -
      (avgPerChance[VALET_PLAY1] + avgPerChance[VALET_PLAY2]);
  else
  {
    assert(false);
    return 0.f;
  }
}


bool CumulPair::skip(const TableEnum ttype) const
{
  if (num[VALET_OVERALL] == 0)
  {
    return true;
    assert(aspects[VALET_OVERALL].empty());
  }
  else
    assert(! aspects[VALET_OVERALL].empty());

  if (ttype == VALET_TABLE_MANY)
  {
    if (num[VALET_OVERALL] < options.minHands)
      return true;
  }
  else  if (ttype == VALET_TABLE_FEW)
  {
    if (num[VALET_OVERALL] > options.minHands)
      return true;
  }
  else
    assert(false);

  return false;
}


void CumulPair::scale(const ScoringEnum stype)
{
  for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
  {
    avgPerChance[i] = ::scale(sum[i], num[i], stype);
    aspects[i].scale(stype);
  }
}


void CumulPair::compensate(
  const CumulPair& oppComp,
  const ScoringEnum stype)
{
  for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
  {
    // cout << "i " << endl;
    // cout << "was  " << aspects[i].str(2) << endl;
    // cout << "comp " << oppComp.aspects[i].str(2) << endl;
    aspects[i].compensate(oppComp.aspects[i], stype);
    // cout << "is   " << aspects[i].str(2) << endl;
  }

  if (stype == VALET_MATCHPOINTS)
  {
    for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
      avgPerChance[i] += oppComp.avgPerChance[i] - 50.f;
  }
  else
  {
    for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
      avgPerChance[i] += oppComp.avgPerChance[i];
  }
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
  const FormatEnum format) const
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
  const FormatEnum format) const
{
  stringstream ss;

  // Declarer score.
  // unsigned n = num[VALET_PLAY1] + num[VALET_PLAY2];
  ss << aspects[VALET_PLAY_SUM].str(prec);

  if (format == VALET_FORMAT_TEXT)
    ss << "  ";

  // Defender score.
  unsigned n = num[VALET_DEF];
  ss << strPair(CumulPair::averageDefense(), n, prec, format);
  // ss << aspects[VALET_DEF_SUM].str(prec);

  if (format == VALET_FORMAT_TEXT)
    ss << " | ";

  // Individual declarer scores.
  ss << aspects[VALET_PLAY1].str(prec);

  if (format == VALET_FORMAT_TEXT)
    ss << "  ";

  ss << aspects[VALET_PLAY2].str(prec);

  if (format == VALET_FORMAT_TEXT)
    ss << " | ";

  if (options.leadFlag)
  {
    ss << aspects[VALET_LEAD1].str(prec);

    if (format == VALET_FORMAT_TEXT)
      ss << "  ";

    ss << aspects[VALET_LEAD2].str(prec);

    if (format == VALET_FORMAT_TEXT)
      ss << "  ";

    if (options.averageFlag)
    {
      ss << aspects[VALET_LEAD_SUM].str(prec);

      if (format == VALET_FORMAT_TEXT)
        ss << "  ";
    }

    ss << aspects[VALET_DEF].str(prec);

    if (format == VALET_FORMAT_TEXT)
      ss << " |";
  }

  ss << "\n";

  return ss.str();
}


string CumulPair::strLine(
  const Pairs& pairs,
  const TableEnum ttype,
  const int prec,
  const FormatEnum format) const
{
  if (CumulPair::skip(ttype))
    return "";

  return 
    CumulPair::strOverall(pairs, prec, format) +
    CumulPair::strDetails(prec, format);
}

