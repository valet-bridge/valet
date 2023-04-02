/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#include <iostream>
#include <iomanip>
#include <string>
#include <cassert>

#include "Score.h"
#include "ScoreInput.h"

#include "../pairs/Pairs.h"

extern Pairs pairs;
extern Options options;


enum ScoreEnum
{
  VALET_OVERALL = 0,
  VALET_BID = 1,
  VALET_PLAY = 2,
  VALET_DECL_SUM = 3,
  VALET_DECL1 = 4,
  VALET_DECL2 = 5,
  VALET_LEAD_SUM = 6,
  VALET_LEAD1 = 7,
  VALET_LEAD2 = 8,
  VALET_DEF_SUM = 9,
  VALET_DEF = 10,
  VALET_ENTRY_SIZE = 11
};


Score::Score()
{
  aspects.resize(VALET_ENTRY_SIZE);
}


void Score::setPair(const unsigned pairNoIn)
{
  pairNo = pairNoIn;
}


void Score::incrDeclarer(const ScoreInput& entry)
{
  aspects[VALET_OVERALL].incr(entry.overall);
  aspects[VALET_BID].incr(entry.bidScore);
  aspects[VALET_PLAY].incr(entry.overall - entry.bidScore);

  if (entry.declFlag[0])
  {
    aspects[VALET_DECL_SUM].incr(entry.playScore[0]);
    aspects[VALET_DECL1].incr(entry.playScore[0]);
  }
  else if (entry.declFlag[1])
  {
    aspects[VALET_DECL_SUM].incr(entry.playScore[1]);
    aspects[VALET_DECL2].incr(entry.playScore[1]);
  }
}


void Score::incrDefenders(const ScoreInput& entry)
{
  aspects[VALET_OVERALL].decr(entry.overall);
  aspects[VALET_BID].decr(entry.bidScore);
  aspects[VALET_PLAY].decr(entry.overall - entry.bidScore);

  if (! entry.defFlag)
    return;

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


void Score::operator += (const Score& s2)
{
  assert(aspects.size() == s2.aspects.size());
  for (size_t i = 0; i < aspects.size(); i++)
    aspects[i] += s2.aspects[i];
}


void Score::operator -= (const Score& s2)
{
  assert(aspects.size() == s2.aspects.size());
  for (size_t i = 0; i < aspects.size(); i++)
    aspects[i] -= s2.aspects[i];
}


bool Score::operator < (const Score& s2) const
{
  if (aspects[VALET_OVERALL].getAverage() > 
      s2.aspects[VALET_OVERALL].getAverage())
    return true;
  else if (aspects[VALET_OVERALL].getAverage() < 
      s2.aspects[VALET_OVERALL].getAverage())
    return false;
  else if (aspects[VALET_BID].getAverage() > 
      s2.aspects[VALET_BID].getAverage())
    return true;
  else
    return false;
}


unsigned Score::getCount() const
{
  return aspects[VALET_OVERALL].getCount();
}


float Score::figure(const SortingEnum sort) const
{
  // Different figures of merit on which we can sort.

  if (sort == VALET_SORT_OVERALL)
    return aspects[VALET_OVERALL].getAverage();
  else if (sort == VALET_SORT_BIDDING)
    return aspects[VALET_BID].getAverage();
  else if (sort == VALET_SORT_DECL)
    return aspects[VALET_DECL_SUM].getAverage();
  else if (sort == VALET_SORT_DEFENSE)
    return aspects[VALET_DEF].getAverage();
  else if (sort == VALET_SORT_LEAD)
    return aspects[VALET_LEAD_SUM].getAverage();
  else if (sort == VALET_SORT_BID_OVER_DECL)
    return aspects[VALET_BID].getAverage() - 
      aspects[VALET_DECL_SUM].getAverage();
  else if (sort == VALET_SORT_DEF_OVER_DECL)
    return aspects[VALET_DEF].getAverage() -
      aspects[VALET_DECL_SUM].getAverage();
  else if (sort == VALET_SORT_LEAD_OVER_DECL)
    return aspects[VALET_LEAD_SUM].getAverage() -
      aspects[VALET_DECL_SUM].getAverage();
  else
  {
    assert(false);
    return 0.f;
  }
}


bool Score::skip(const TableEnum ttype) const
{
  if (aspects[VALET_OVERALL].empty())
    return true;

  if (ttype == VALET_TABLE_MANY)
  {
    if (aspects[VALET_OVERALL].getCount() < options.minHands)
      return true;
  }
  else  if (ttype == VALET_TABLE_FEW)
  {
    if (aspects[VALET_OVERALL].getCount() > options.minHands)
      return true;
  }
  else
    assert(false);

  return false;
}


void Score::scale()
{
  for (auto& aspect: aspects)
    aspect.scale();
}


void Score::compensate(const Score& oppScore)
{
  assert(aspects.size() == oppScore.aspects.size());
  for (size_t i = 0; i < aspects.size(); i++)
    aspects[i].compensate(oppScore.aspects[i]);
}


string Score::strHeaderText1() const
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


string Score::strHeaderText2() const
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


string Score::strHeaderCSV() const
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


string Score::strHeader() const
{
  stringstream ss;

  if (options.format == VALET_FORMAT_TEXT)
  {
    ss <<
      setw(54) << "" << " | " <<
      Score::strHeaderText1() << "\n" <<
      setw(54) << left << "Players" << right << " | " <<
      Score::strHeaderText2() << "\n";
  }
  else if (options.format == VALET_FORMAT_CSV)
  {
    ss << "Players" << options.separator << Score::strHeaderCSV() << "\n";
  }
  else
    assert(false);

  return ss.str();
}


string Score::strOverall(const int prec) const
{
  stringstream ss;

  ss <<
    pairs.getPairName(pairNo, 54) << 
    aspects[VALET_OVERALL].pad(PAD_BAR) << 
    aspects[VALET_OVERALL].strCount(4) <<
    aspects[VALET_OVERALL].strAverage(7, prec, PAD_BAR) <<
    aspects[VALET_BID].strAverage(5, prec, PAD_NONE) <<
    aspects[VALET_PLAY].strAverage(7, prec, PAD_BAR);

  return ss.str();
}


string Score::strDetails(const int prec) const
{
  stringstream ss;

  // Declarer score.
  ss << aspects[VALET_DECL_SUM].str(prec, PAD_SPACE);

  // Defender score.
  ss << aspects[VALET_DEF_SUM].str(prec, PAD_BAR);

  // Individual declarer scores.
  ss << aspects[VALET_DECL1].str(prec, PAD_SPACE);
  ss << aspects[VALET_DECL2].str(prec, PAD_BAR);

  if (options.leadFlag)
  {
    // Individual lead scores.
    ss << aspects[VALET_LEAD1].str(prec, PAD_SPACE);
    ss << aspects[VALET_LEAD2].str(prec, PAD_SPACE);

    if (options.averageFlag)
    {
      // Overall lead score.
      ss << aspects[VALET_LEAD_SUM].str(prec, PAD_SPACE);
    }

    // Defense score (excluding leads if these are shown).
    ss << aspects[VALET_DEF].str(prec, PAD_BAR_END);
  }

  ss << "\n";

  return ss.str();
}


string Score::strDeclarerHeaderTrunc() const
{
  stringstream ss;
  ss << setw(8) << "Overall";
  ss << setw(8) << "Bid";
  ss << setw(8) << "Play" << "\n";
  return ss.str();
}


string Score::strDeclarerHeader() const
{
  stringstream ss;

  ss << setw(16) << left << "Contract";
  ss << setw(8) << right << "Count";
  ss << Score::strDeclarerHeaderTrunc();

  return ss.str();
}


string Score::strDefenseHeaderTrunc() const
{
  stringstream ss;
  ss << setw(8) << "Overall";
  ss << setw(8) << "Bid";

  if (options.leadFlag)
  {
    ss << setw(8) << "Lead";
    ss << setw(8) << "Restdef" << "\n";
  }
  else
    ss << setw(8) << "Def" << "\n";

  return ss.str();
}


string Score::strDefenseHeader() const
{
  stringstream ss;

  ss << setw(16) << left << "Contract";
  ss << setw(8) << right << "Count";
  ss << Score::strDefenseHeaderTrunc();

  return ss.str();
}


string Score::strLine(
  const TableEnum ttype,
  const int prec) const
{
  if (Score::skip(ttype))
    return "";

  return Score::strOverall(prec) + Score::strDetails(prec);
}


string Score::strDeclarerLineTrunc() const
{
  stringstream ss;

  ss << 
    aspects[VALET_OVERALL].strAverageText(8, 2) << 
    aspects[VALET_BID].strAverageText(8, 2) << 
    aspects[VALET_PLAY].strAverageText(8, 2) << "\n";

  return ss.str();
}


string Score::strDeclarerLine(
  const string& key,
  const unsigned count) const
{
  stringstream ss;

  ss << left << setw(16) << key <<
    setw(8) << right << count <<
    Score::strDeclarerLineTrunc();

  return ss.str();
}


string Score::strDefenseLineTrunc() const
{
  stringstream ss;

  ss << 
    aspects[VALET_OVERALL].strAverageText(8, 2) << 
    aspects[VALET_BID].strAverageText(8, 2);

  if (options.leadFlag)
    ss << aspects[VALET_LEAD_SUM].strAverageText(8, 2);

  ss << aspects[VALET_DEF].strAverageText(8, 2) << "\n";

  return ss.str();
}

string Score::strDefenseLine(
  const string& key,
  const unsigned count) const
{
  stringstream ss;

  ss << left << setw(16) << key <<
    setw(8) << right << count <<
    Score::strDefenseLineTrunc();

  return ss.str();
}

