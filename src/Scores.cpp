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
#include "cst.h"

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


void Scores::AddEntry(
  const ValetEntryType& entry)
{
  if (entry.pairNo >= length)
  {
    unsigned numNewChunks = (entry.pairNo / SCORES_CHUNK_SIZE) + 1;
    length = numNewChunks * SCORES_CHUNK_SIZE;
    pairScores.resize(static_cast<size_t>(length));
    oppScores.resize(static_cast<size_t>(length));
    oppComp.resize(static_cast<size_t>(length));
  }

  CumulType& c = pairScores[entry.pairNo];
  c.pairNo = entry.pairNo;
  c.numHands++;
  c.bidCum += entry.bidScore;
  c.overallCum += entry.overall;

  if (entry.declFlag[0])
  {
    c.numPlay1++;
    c.play1Cum += entry.playScore[0];
  }
  else if (entry.declFlag[1])
  {
    c.numPlay2++;
    c.play2Cum += entry.playScore[1];
  }
  else if (entry.defFlag)
  {
    c.defCum += entry.defScore;
    c.numDef++;

    if (options.leadFlag)
    {
      if (entry.leadFlag[0])
      {
        c.numLead1++;
        c.lead1Cum += entry.leadScore[0];
      }
      else if (entry.leadFlag[1])
      {
        c.numLead2++;
        c.lead2Cum += entry.leadScore[1];
      }
    }
  }

  // Remember the opponent in order to be able to compensate.
  // char buffer[33];
  // const string oppstr(itoa(entry.oppNo, buffer, 10));
  ostringstream oss;
  oss << entry.oppNo;
  const string oppstr = oss.str();

  OppMapType& oppMap = oppScores[entry.pairNo];
  OppMapType::iterator it = oppMap.find(oppstr);
  if (it == oppMap.end())
  {
    oppMap[oppstr].cumul = 0.f;
    oppMap[oppstr].count = 0;
  }

  oppMap[oppstr].cumul += entry.overall;
  oppMap[oppstr].count++;
}


void Scores::Compensate()
{
  // Compensate for the average strength of opponents, ignoring
  // each opponent's results against us.

  typedef OppMapType::iterator it_type;
  char *pend;

  for (unsigned pno = 1; pno < length; pno++)
  {
    OppType oppResults = {0.f, 0};
    OppMapType& oppMap = oppScores[pno];

    for (it_type it = oppMap.begin(); it != oppMap.end(); it++)
    {
      unsigned oppNo = static_cast<unsigned>(
        strtol(it->first.c_str(), &pend, 10));
      assert(oppNo > 0 && oppNo < length);

      oppResults.cumul += pairScores[oppNo].overallCum - it->second.cumul;
      oppResults.count += pairScores[oppNo].numHands - it->second.count;
    }

    if (oppResults.count == 0)
      oppComp[pno] = 0.f;
    else if (options.valet == VALET_MATCHPOINTS)
      oppComp[pno] = -50.f + oppResults.cumul / oppResults.count;
    else
      oppComp[pno] = oppResults.cumul / oppResults.count;
  }
}


void Scores::Normalize()
{
  for (unsigned pno = 1; pno < length; pno++)
  {
    CumulType& c = pairScores[pno];
    if (c.numHands == 0)
      return;

    c.overall = c.overallCum / c.numHands;
    c.bid = c.bidCum / c.numHands;
    c.play1 = c.play1Cum / c.numHands;
    c.play2 = c.play2Cum / c.numHands;
    c.lead1 = c.lead1Cum / c.numHands;
    c.lead2 = c.lead2Cum / c.numHands;
    c.def = c.defCum / c.numHands;

    if (options.adjustForOpps)
    {
      // Quite arbitrary split.
      if (options.leadFlag)
      {
        c.overall += oppComp[pno];
        c.bid += oppComp[pno] / 3.f;
        c.play1 += oppComp[pno] / 6.f;
        c.play2 += oppComp[pno] / 6.f;
        c.lead1 += oppComp[pno] / 12.f;
        c.lead2 += oppComp[pno] / 12.f;
        c.def += oppComp[pno] / 6.f;
      }
      else
      {
        c.overall += oppComp[pno];
        c.bid += oppComp[pno] / 3.f;
        c.play1 += oppComp[pno] / 6.f;
        c.play2 += oppComp[pno] / 6.f;
        c.def += oppComp[pno] / 3.f;
      }
    }
  }
}


double Scores::Difference(
  const CumulType& c1,
  const CumulType& c2,
  SortingType sort)
{
  switch(sort)
  {
    case VALET_SORT_OVERALL:
      return c1.overall - c2.overall;

    case VALET_SORT_BIDDING:
      return c1.bid - c2.bid;

    case VALET_SORT_PLAY:
      return c1.play1 + c1.play2 - (c2.play1 + c2.play2);

    case VALET_SORT_DEFENSE:
      return c1.def - c2.def;

    case VALET_SORT_LEAD:
      return c1.lead1 + c1.lead2 - (c2.lead1 + c2.lead2);

    case VALET_SORT_BID_OVER_PLAY:
      return (c1.bid - c2.bid) -
        (c1.play1 + c1.play2 - (c2.play1 + c2.play2));

    case VALET_SORT_DEF_OVER_PLAY:
      return c1.def - c2.def -
        (c1.play1 + c1.play2 - (c2.play1 + c2.play2));

    case VALET_SORT_LEAD_OVER_PLAY:
      return c1.lead1 + c1.lead2 - (c2.lead1 + c2.lead2) -
        (c1.play1 + c1.play2 - (c2.play1 + c2.play2));
    
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
  int& prec)
{
  if (mode == 1 && options.minHands == 0)
    return false;

  bool flag = false;
  for (unsigned pno = 1; pno < length && ! flag; pno++)
  {
    CumulType& c = pairScores[pno];
    if (mode == 0)
    {
      // Players with at least a certain number of boards
      if (c.numHands >= options.minHands)
        flag = true;
    }
    else
    {
      // Players with less than a certain number of boards
      if (c.numHands < options.minHands) 
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
  const unsigned mode)
{
  if (c.numHands == 0)
    return true;

  if (mode == 0)
  {
    if (c.numHands < options.minHands)
      return true;
  }
  else if (c.numHands > options.minHands)
      return true;

  return false;
}


void Scores::PrintText(
  const unsigned mode)
{
  int prec;
  if (! Scores::PreparePrint(mode, prec))
    return;

  cout << 
    setw(54) << left << "Players" << right <<
    setw(4) << "No." << 
    setw(4) << "Pl1" << 
    setw(4) << "Pl2" << 
    setw(4) << "Def" << 
    setw(4) << "L1" << 
    setw(4) << "L2" <<
    setw(7) << scoringTags[options.valet].header <<
    setw(7) << "Bid" <<
    setw(7) << "Play1" <<
    setw(7) << "Play2";

  if (options.leadFlag)
    cout << setw(8) << "Lead1" << setw(8) << "Lead2";

  cout <<
    setw(7) << "Def" << "\n";

  for (unsigned pno = 1; pno < length; pno++)
  {
    CumulType& c = pairScores[pno];
    if (Scores::SkipScore(c, mode))
      continue;

    cout << 
      left << pairs.GetPairNamePadded(c.pairNo, 54) << right <<
      setw(4) << c.numHands << 
      setw(4) << c.numPlay1 << 
      setw(4) << c.numPlay2 << 
      setw(4) << c.numDef << 
      setw(4) << c.numLead1 << 
      setw(4) << c.numLead2 <<
      setw(7) << fixed << setprecision(prec) << c.overall << 
      setw(7) << fixed << setprecision(prec) << c.bid << 
      setw(7) << fixed << setprecision(prec) << c.play1 << 
      setw(7) << fixed << setprecision(prec) << c.play2;

    if (options.leadFlag)
      cout <<
        setw(8) << fixed << setprecision(prec) << c.lead1 << 
        setw(8) << fixed << setprecision(prec) << c.lead2;

    cout <<
      setw(7) << fixed << setprecision(prec) << c.def << "\n";
  }
  cout << "\n";
}


void Scores::PrintCSV(
  const unsigned mode)
{
  int prec;
  if (! Scores::PreparePrint(mode, prec))
    return;

  const string s = options.separator;
  cout << 
    "Players" << s <<
    "No." << s <<
    "Pl1" << s <<
    "Pl2" << s <<
    "Def" << s <<
    "L1" << s <<
    "L2" << s <<
    scoringTags[options.valet].header << s <<
    "Bid" << s <<
    "Play1" << s <<
    "Play2" << s;

  if (options.leadFlag)
    cout << s << "Lead1" << s << "Lead2" << s;

  cout << "Def" << "\n";

  for (unsigned pno = 1; pno < length; pno++)
  {
    CumulType& c = pairScores[pno];
    if (Scores::SkipScore(c, mode))
      continue;

    cout << 
      pairs.GetPairName(c.pairNo) << s <<
      c.numHands << s <<
      c.numPlay1 << s <<
      c.numPlay2 << s <<
      c.numDef << s <<
      c.numLead1 << s <<
      c.numLead2 <<s <<
      fixed << setprecision(prec) << c.overall << s <<
      fixed << setprecision(prec) << c.bid << s <<
      fixed << setprecision(prec) << c.play1 << s <<
      fixed << setprecision(prec) << c.play2 << s;

    if (options.leadFlag)
      cout << fixed << setprecision(prec) << c.lead1 << s << 
        fixed << setprecision(prec) << c.lead2 << s;

    cout <<
      fixed << setprecision(prec) << c.def << "\n";
  }
  cout << "\n";
}


void Scores::Print()
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

