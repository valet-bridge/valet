/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/



#include <assert.h>

#include <iostream>
#include <string>
#include <sstream>
#include <stdio.h>
#include <stdlib.h>

#include "Scores.h"
#include "Pairs.h"

using namespace std;


extern Pairs pairs;
extern OptionsType options;


Scores::Scores()
{
  Scores::Reset();
}


Scores::~Scores()
{
}


void Scores::Reset()
{
  numPairs = 0;
  pairScores.resize(SCORES_CHUNK_SIZE);
  oppScores.resize(SCORES_CHUNK_SIZE);
  oppComp.resize(SCORES_CHUNK_SIZE);
  length = SCORES_CHUNK_SIZE;
}


Scores::OppType * Scores::PrepareCompensation(
  const unsigned pairNo,
  const unsigned oppNo)
{
  ostringstream oss;
  oss << oppNo;
  const string oppstr = oss.str();

  OppMapType& oppMap = oppScores[pairNo];
  OppMapType::iterator it = oppMap.find(oppstr);
  if (it == oppMap.end())
  {
    for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
    {
      oppMap[oppstr].num[i] = 0;
      oppMap[oppstr].sum[i] = 0.f;
    }
  }

  return &oppMap[oppstr];
}


void Scores::AddCompensation(
  const unsigned pairNo,
  const unsigned oppNo,
  const OppCompType& oppValues)
{
  OppType * opp = Scores::PrepareCompensation(pairNo, oppNo);
  OppType * pair = Scores::PrepareCompensation(oppNo, pairNo);

  for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
  {
    opp->num[i]++;
    opp->sum[i] += oppValues.sum[i];

    pair->num[i]++;
    pair->sum[i] -= oppValues.sum[i];
  }
}


void Scores::AddEntry(
  const ValetEntryType& entry)
{
  unsigned m = (entry.pairNo > entry.oppNo ? entry.pairNo : entry.oppNo);
  if (m >= length)
  {
    unsigned numNewChunks = (m / SCORES_CHUNK_SIZE) + 1;
    length = numNewChunks * SCORES_CHUNK_SIZE;
    pairScores.resize(static_cast<size_t>(length));
    oppScores.resize(static_cast<size_t>(length));
    oppComp.resize(static_cast<size_t>(length));
  }

  CumulType& cDecl = pairScores[entry.pairNo];
  cDecl.pairNo = entry.pairNo;

  cDecl.num[VALET_OVERALL]++;
  cDecl.sum[VALET_OVERALL] += entry.overall;

  cDecl.num[VALET_BID]++;
  cDecl.sum[VALET_BID] += entry.bidScore;

  if (entry.declFlag[0])
  {
    cDecl.num[VALET_PLAY1]++;
    cDecl.sum[VALET_PLAY1] += entry.playScore[0];
  }
  else if (entry.declFlag[1])
  {
    cDecl.num[VALET_PLAY2]++;
    cDecl.sum[VALET_PLAY2] += entry.playScore[1];
  }

  // The overall and bidding scores have to be inverted.
  // The detailed scores have already been inverted.

  CumulType& cDef = pairScores[entry.oppNo];
  cDef.pairNo = entry.oppNo;
  cDef.num[VALET_OVERALL]++;
  cDef.sum[VALET_OVERALL] -= entry.overall;

  cDef.num[VALET_BID]++;
  cDef.sum[VALET_BID] -= entry.bidScore;

  if (entry.defFlag)
  {
    cDef.num[VALET_DEF]++;
    cDef.sum[VALET_DEF] += entry.defScore;

    if (options.leadFlag)
    {
      if (entry.leadFlag[0])
      {
        cDef.num[VALET_LEAD1]++;
        cDef.sum[VALET_LEAD1] += entry.leadScore[0];
      }
      else if (entry.leadFlag[1])
      {
        cDef.num[VALET_LEAD2]++;
        cDef.sum[VALET_LEAD2] += entry.leadScore[1];
      }
    }
  }

  // Ugh.  But I don't feel like rewriting the entry data structure,
  // as this depends on list[2].
  OppCompType oppValues;
  oppValues.sum[VALET_OVERALL] = entry.overall;
  oppValues.sum[VALET_BID] = entry.bidScore;
  oppValues.sum[VALET_PLAY1] = entry.playScore[0];
  oppValues.sum[VALET_PLAY2] = entry.playScore[1];
  oppValues.sum[VALET_LEAD1] = entry.leadScore[0];
  oppValues.sum[VALET_LEAD2] = entry.leadScore[1];
  oppValues.sum[VALET_DEF] = entry.defScore;

  // Remember the opponent in order to be able to compensate.
  Scores::AddCompensation(entry.pairNo, entry.oppNo, oppValues);
}


void Scores::Compensate()
{
  // Compensate for the average strength of opponents, ignoring
  // each opponent's results against us.

  typedef OppMapType::iterator it_type;
  char *pend;

  for (unsigned pno = 1; pno < length; pno++)
  {
    OppType oppResults;
    for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
    {
      oppResults.num[i] = 0;
      oppResults.sum[i] = 0.;
    }

    OppMapType& oppMap = oppScores[pno];

    for (it_type it = oppMap.begin(); it != oppMap.end(); it++)
    {
      unsigned oppNo = static_cast<unsigned>(
        strtol(it->first.c_str(), &pend, 10));
      assert(oppNo > 0 && oppNo < length);

      for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
      {
        oppResults.sum[i] += pairScores[oppNo].sum[i] - it->second.sum[i];
        oppResults.num[i] += pairScores[oppNo].num[i] - it->second.num[i];
      }
    }

    for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
    {
      if (oppResults.num[i] == 0)
        oppComp[pno].sum[i] = 0.f;
      else if (options.valet == VALET_MATCHPOINTS)
        oppComp[pno].sum[i] = -50.f + oppResults.sum[i] / oppResults.num[i];
      else
        oppComp[pno].sum[i] = oppResults.sum[i] / oppResults.num[i];
      }
  }
}


float Scores::Scale(
  const float value,
  const unsigned num) const
{
  if (num > 0)
    return value / num;
  else
    return 0.;
}


float Scores::ScaleMP(
  const float value,
  const unsigned num) const
{
  if (num > 0)
    return 100.f * (value + num) / (2.f * num);
  else
    return 50.f;
}


void Scores::Normalize()
{
  for (unsigned pno = 1; pno < length; pno++)
  {
    CumulType& c = pairScores[pno];
    if (c.num[VALET_OVERALL] == 0)
      return;

    if (options.valet == VALET_MATCHPOINTS)
    {
      // Convert scale from -1 .. +1 to 0 .. 100%.
      for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
        c.avgTotal[i] = Scores::ScaleMP(c.sum[i], c.num[VALET_OVERALL]);

      for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
        c.avgPerChance[i] = Scores::ScaleMP(c.sum[i], c.num[i]);
    }
    else
    {
      for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
        c.avgTotal[i] = Scores::Scale(c.sum[i], c.num[VALET_OVERALL]);

      for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
        c.avgPerChance[i] = Scores::Scale(c.sum[i], c.num[i]);
    }

    if (options.compensateFlag)
      for (int i = VALET_OVERALL; i < VALET_ENTRY_SIZE; i++)
        c.avgPerChance[i] += oppComp[pno].sum[i];
  }
}


double Scores::Difference(
  const CumulType& c1,
  const CumulType& c2,
  SortingType sort) const
{
  switch(sort)
  {
    case VALET_SORT_OVERALL:
      return c1.avgPerChance[VALET_OVERALL] - c2.avgPerChance[VALET_OVERALL];

    case VALET_SORT_BIDDING:
      return c1.avgPerChance[VALET_BID] - c2.avgPerChance[VALET_BID];

    case VALET_SORT_PLAY:
      return c1.avgPerChance[VALET_PLAY1] + c1.avgPerChance[VALET_PLAY2] - 
        (c2.avgPerChance[VALET_PLAY1] + c2.avgPerChance[VALET_PLAY2]);

    case VALET_SORT_DEFENSE:
      return c1.avgPerChance[VALET_DEF] - c2.avgPerChance[VALET_DEF];

    case VALET_SORT_LEAD:
      return c1.avgPerChance[VALET_LEAD1] + c1.avgPerChance[VALET_LEAD2] - 
        (c2.avgPerChance[VALET_LEAD1] + c2.avgPerChance[VALET_LEAD2]);

    case VALET_SORT_BID_OVER_PLAY:
      return (c1.avgPerChance[VALET_BID] - c2.avgPerChance[VALET_BID]) -
        (c1.avgPerChance[VALET_PLAY1] + c1.avgPerChance[VALET_PLAY2] - 
        (c2.avgPerChance[VALET_PLAY1] + c2.avgPerChance[VALET_PLAY2]));

    case VALET_SORT_DEF_OVER_PLAY:
      return c1.avgPerChance[VALET_DEF] - c2.avgPerChance[VALET_DEF] -
        (c1.avgPerChance[VALET_PLAY1] + c1.avgPerChance[VALET_PLAY2] - 
        (c2.avgPerChance[VALET_PLAY1] + c2.avgPerChance[VALET_PLAY2]));

    case VALET_SORT_LEAD_OVER_PLAY:
      return c1.avgPerChance[VALET_LEAD1] + c1.avgPerChance[VALET_LEAD2] - 
        (c2.avgPerChance[VALET_LEAD1] + c2.avgPerChance[VALET_LEAD2]) -
        (c1.avgPerChance[VALET_PLAY1] + c1.avgPerChance[VALET_PLAY2] - 
        (c2.avgPerChance[VALET_PLAY1] + c2.avgPerChance[VALET_PLAY2]));
    
    default:
      assert(false);
      return 0.;
  }
}


void Scores::Sort(
  const SortingType sort)
{
  // Simple bubble sort.

  unsigned n = length-1;
  do
  {
    unsigned new_n = 1;
    for (unsigned i = 2; i < n; i++)
    {
      if (Scores::Difference(pairScores[i-1], pairScores[i], sort) >= 0)
        continue;

      CumulType ctmp = pairScores[i-1];
      pairScores[i-1] = pairScores[i];
      pairScores[i] = ctmp;

      new_n = i;
    }
    n = new_n;
  }
  while (n > 1);
}


bool Scores::PreparePrint(
  const unsigned mode,
  int& prec) const
{
  if (mode == 1 && options.minHands == 0)
    return false;

  bool flag = false;
  for (unsigned pno = 1; pno < length && ! flag; pno++)
  {
    const CumulType& c = pairScores[pno];
    if (mode == 0)
    {
      // Players with at least a certain number of boards
      if (c.num[VALET_OVERALL] >= options.minHands)
        flag = true;
    }
    else
    {
      // Players with less than a certain number of boards
      if (c.num[VALET_OVERALL] < options.minHands) 
        flag = true;
    }
  }

  if (! flag)
    return false;

  if (options.valet == VALET_MATCHPOINTS)
    prec = 1;
  else
    prec = 2;

  return true;
}


bool Scores::SkipScore(
  const CumulType& c,
  const unsigned mode) const
{
  if (c.num[VALET_OVERALL] == 0)
    return true;

  if (mode == 0)
  {
    if (c.num[VALET_OVERALL] < options.minHands)
      return true;
  }
  else if (c.num[VALET_OVERALL] > options.minHands)
      return true;

  return false;
}


void Scores::PrintTextPair(
  const float average,
  const unsigned no,
  const int prec) const
{
  if (no > 0)
    cout << setw(5) << fixed << setprecision(prec) << average << 
      " (" << setw(3) << no << ")";
  else
    cout << setw(5) << "-" << " (  0)";
}


void Scores::PrintCSVPair(
  const float average,
  const unsigned no,
  const int prec,
  const string s) const
{
  if (no > 0)
    cout << setprecision(prec) << average << s << no << s;
  else
    cout << "-" << s << "0" << s;
}


void Scores::PrintTextHeader() const
{
  cout << 
    setw(54) << "" << " | " <<
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
      cout << 
        setw(19) << "" << 
        setw(11) << "Defending" <<
        setw(20) << "" << " |";
    else
      cout << 
        setw(13) << "" << 
        setw(11) << "Defending" <<
        setw(13) << "" << " |";
  }

  cout << "\n";

  cout << 
    setw(54) << left << "Players" << right << " | " <<
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
    cout << 
      " | " <<
      setw(11) << "Lead1" << "  " <<
      setw(11) << "Lead2";

    if (options.averageFlag)
      cout << setw(13) << "Average";

    cout << 
      setw(13) << "Play";
  }

  cout << " |\n";
}


void Scores::PrintText(
  const unsigned mode) const
{
  int prec;
  if (! Scores::PreparePrint(mode, prec))
    return;

  Scores::PrintTextHeader();

  for (unsigned pno = 1; pno < length; pno++)
  {
    const CumulType& c = pairScores[pno];
    if (Scores::SkipScore(c, mode))
      continue;

    cout << 
      left << pairs.GetPairNamePadded(c.pairNo, 54) << right << " | " <<
      setw(4) << c.num[VALET_OVERALL] << 
      setw(7) << fixed << setprecision(prec) << 
        c.avgPerChance[VALET_OVERALL] <<  " | " <<
      setw(5) << fixed << setprecision(prec) << 
        c.avgPerChance[VALET_BID] << 
      setw(7) << fixed << setprecision(prec) << 
        c.avgPerChance[VALET_OVERALL] - c.avgPerChance[VALET_BID] << " | ";

    unsigned n = c.num[VALET_PLAY1] + c.num[VALET_PLAY2];
    if (n > 0)
      Scores::PrintTextPair(
        (c.avgPerChance[VALET_PLAY1] * c.num[VALET_PLAY1] + 
         c.avgPerChance[VALET_PLAY2] * c.num[VALET_PLAY2]) / n, 
        n, prec);
    else
      Scores::PrintTextPair(0., 0, prec);

    cout << "  ";
    n = c.num[VALET_DEF];
    if (n)
      Scores::PrintTextPair(
        (c.avgPerChance[VALET_LEAD1] * c.num[VALET_PLAY1] +
         c.avgPerChance[VALET_LEAD2] * c.num[VALET_PLAY2] +
         c.avgPerChance[VALET_DEF] * c.num[VALET_DEF]) / n, n, prec);
    else
      Scores::PrintTextPair(0., 0, prec);

    cout << " | ";

    Scores::PrintTextPair(c.avgPerChance[VALET_PLAY1], 
      c.num[VALET_PLAY1], prec);
    cout << "  ";
    Scores::PrintTextPair(c.avgPerChance[VALET_PLAY2], 
      c.num[VALET_PLAY2], prec);

    cout << " | ";

    if (options.leadFlag)
    {
      Scores::PrintTextPair(c.avgPerChance[VALET_LEAD1], 
        c.num[VALET_LEAD1], prec);
      cout << "  ";
      Scores::PrintTextPair(c.avgPerChance[VALET_LEAD2], 
        c.num[VALET_LEAD2], prec);
      cout << "  ";
      
      if (options.averageFlag)
      {
        Scores::PrintTextPair(
          (c.avgPerChance[VALET_LEAD1] * c.num[VALET_LEAD1] + 
           c.avgPerChance[VALET_LEAD2] * c.num[VALET_LEAD2]) /
          (c.num[VALET_PLAY1] + c.num[VALET_PLAY2]), 
          c.num[VALET_PLAY1] + c.num[VALET_PLAY2], prec);
        cout << "  ";
      }

      Scores::PrintTextPair(c.avgPerChance[VALET_DEF], 
        c.num[VALET_DEF], prec);
      cout << " |";
    }

    cout << "\n";
  }
  cout << "\n";
}


void Scores::PrintCSVHeader() const
{
  const string s = options.separator;

  cout << 
    "Players" << s <<
    "Count" << s <<
    scoringTags[options.valet].header << s <<
    "Bid" << s <<
    "Play" << s <<
    "Decl" << s <<
    "#" << s <<
    "Def" << s <<
    "#" << s <<
    "Decl1" << s <<
    "#" << s <<
    "Decl2" << s <<
    "#" << s;

  if (options.leadFlag)
  {
    cout <<
      "Lead1" << s <<
      "#" << s <<
      "Lead2" << s <<
      "#" << s;

    if (options.averageFlag)
      cout << "Avg" << s << "#" << s;

    cout << "Play" << s << "#";
  }

  cout << "\n";
}


void Scores::PrintCSV(
  const unsigned mode) const
{
  int prec;
  if (! Scores::PreparePrint(mode, prec))
    return;

  Scores::PrintCSVHeader();

  const string s = options.separator;

  for (unsigned pno = 1; pno < length; pno++)
  {
    const CumulType& c = pairScores[pno];
    if (Scores::SkipScore(c, mode))
      continue;

    cout << 
      pairs.GetPairName(c.pairNo) << s <<
      c.num[VALET_OVERALL] << s <<
      fixed << setprecision(prec) << c.avgPerChance[VALET_OVERALL] << s <<
      fixed << setprecision(prec) << c.avgPerChance[VALET_BID] << s <<
      fixed << setprecision(prec) << 
        c.avgPerChance[VALET_OVERALL] - c.avgPerChance[VALET_BID] << s;

    unsigned n = c.num[VALET_PLAY1] + c.num[VALET_PLAY2];
    if (n > 0)
      Scores::PrintCSVPair(
        (c.avgPerChance[VALET_PLAY1] * c.num[VALET_PLAY1] + 
         c.avgPerChance[VALET_PLAY2] * c.num[VALET_PLAY2]) / n, 
        n, prec, s);
    else
      Scores::PrintCSVPair(0., 0, prec, s);

    cout << "  ";
    n = c.num[VALET_DEF];
    if (n)
      Scores::PrintCSVPair(
        (c.avgPerChance[VALET_LEAD1] * c.num[VALET_LEAD1] +
         c.avgPerChance[VALET_LEAD2] * c.num[VALET_LEAD2] +
         c.avgPerChance[VALET_DEF] * c.num[VALET_DEF]) / n, n, prec, s);
    else
      Scores::PrintCSVPair(0., 0, prec, s);

    Scores::PrintCSVPair(c.avgPerChance[VALET_PLAY1], 
      c.num[VALET_PLAY1], prec, s);
    Scores::PrintCSVPair(c.avgPerChance[VALET_PLAY2], 
      c.num[VALET_PLAY2], prec, s);

    if (options.leadFlag)
    {
      Scores::PrintCSVPair(c.avgPerChance[VALET_LEAD1], 
        c.num[VALET_LEAD1], prec, s);
      Scores::PrintCSVPair(c.avgPerChance[VALET_LEAD2], 
        c.num[VALET_LEAD2], prec, s);
      
      if (options.averageFlag)
        Scores::PrintCSVPair(
          (c.avgPerChance[VALET_LEAD1] * c.num[VALET_LEAD1] + 
           c.avgPerChance[VALET_LEAD2] * c.num[VALET_LEAD2]) /
          (c.num[VALET_PLAY1] + c.num[VALET_PLAY2]), 
          c.num[VALET_PLAY1] + c.num[VALET_PLAY2], prec, s);

      Scores::PrintCSVPair(c.avgPerChance[VALET_DEF], 
        c.num[VALET_DEF], prec, s);
    }

    cout << "\n";
  }
  cout << "\n";
}


void Scores::Print() const
{
  if (options.format == VALET_FORMAT_TEXT)
  {
    Scores::PrintText(0);
    Scores::PrintText(1);
  }
  else
  {
    Scores::PrintCSV(0);
    Scores::PrintCSV(1);
  }
}

