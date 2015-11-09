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


void Scores::AddCompensation(
  const unsigned pairNo,
  const unsigned oppNo,
  const float value)
{
  ostringstream oss;
  oss << oppNo;
  const string oppstr = oss.str();

  OppMapType& oppMap = oppScores[pairNo];
  OppMapType::iterator it = oppMap.find(oppstr);
  if (it == oppMap.end())
  {
    oppMap[oppstr].cumul = 0.f;
    oppMap[oppstr].count = 0;
  }

  oppMap[oppstr].cumul += value;
  oppMap[oppstr].count++;
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
  cDecl.numHands++;
  cDecl.bidCum += entry.bidScore;
  cDecl.overallCum += entry.overall;

  if (entry.declFlag[0])
  {
    cDecl.numPlay1++;
    cDecl.play1Cum += entry.playScore[0];
  }
  else if (entry.declFlag[1])
  {
    cDecl.numPlay2++;
    cDecl.play2Cum += entry.playScore[1];
  }

  // The overall and bidding scores have to be inverted.
  // The detailed scores have already been inverted.

  CumulType& cDef = pairScores[entry.oppNo];
  cDef.pairNo = entry.oppNo;
  cDef.numHands++;
  cDef.bidCum -= entry.bidScore;
  cDef.overallCum -= entry.overall;

  if (entry.defFlag)
  {
    cDef.defCum += entry.defScore;
    cDef.numDef++;

    if (options.leadFlag)
    {
      if (entry.leadFlag[0])
      {
        cDef.numLead1++;
        cDef.lead1Cum += entry.leadScore[0];
      }
      else if (entry.leadFlag[1])
      {
        cDef.numLead2++;
        cDef.lead2Cum += entry.leadScore[1];
      }
    }
  }

  // Remember the opponent in order to be able to compensate.
  Scores::AddCompensation(entry.pairNo, entry.oppNo, entry.overall);
  Scores::AddCompensation(entry.oppNo, entry.pairNo, -entry.overall);
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


float Scores::ScaleMP(
  const float value,
  const unsigned num)
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
    if (c.numHands == 0)
      return;

    if (options.valet == VALET_MATCHPOINTS)
    {
      // Convert scale from -1 .. +1 to 0 .. 100%.
      c.overall = Scores::ScaleMP(c.overallCum, c.numHands);
      c.bid = Scores::ScaleMP(c.bidCum, c.numHands);
      c.play1 = Scores::ScaleMP(c.play1Cum, c.numHands);
      c.play2 = Scores::ScaleMP(c.play2Cum, c.numHands);
      c.lead1 = Scores::ScaleMP(c.lead1Cum, c.numHands);
      c.lead2 = Scores::ScaleMP(c.lead2Cum, c.numHands);
      c.def = Scores::ScaleMP(c.defCum, c.numHands);

      c.play1perChance = Scores::ScaleMP(c.play1Cum, c.numPlay1);
      c.play2perChance = Scores::ScaleMP(c.play2Cum, c.numPlay2);
      c.lead1perChance = Scores::ScaleMP(c.lead1Cum, c.numLead1);
      c.lead2perChance = Scores::ScaleMP(c.lead2Cum, c.numLead2);
      c.defperChance = Scores::ScaleMP(c.defCum, c.numDef);
    }
    else
    {
      c.overall = c.overallCum / c.numHands;
      c.bid = c.bidCum / c.numHands;
      c.play1 = c.play1Cum / c.numHands;
      c.play2 = c.play2Cum / c.numHands;
      c.lead1 = c.lead1Cum / c.numHands;
      c.lead2 = c.lead2Cum / c.numHands;
      c.def = c.defCum / c.numHands;

      if (c.numPlay1 > 0)
        c.play1perChance = c.play1Cum / c.numPlay1;
      if (c.numPlay2 > 0)
        c.play2perChance = c.play2Cum / c.numPlay2;
      if (c.numLead1 > 0)
        c.lead1perChance = c.lead1Cum / c.numLead1;
      if (c.numLead2 > 0)
        c.lead2perChance = c.lead2Cum / c.numLead2;
      if (c.numDef > 0)
        c.defperChance = c.defCum / c.numDef;
    }

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
    setw(7) << scoringTags[options.valet].header <<
    setw(7) << "Bid" <<
    setw(7) << "Play" <<
    setw(7) << "Def" <<
    setw(6) << "#Pl1" << 
    setw(6) << "Pl1" << 
    setw(6) << "#Pl2" << 
    setw(6) << "Pl2";

  if (options.leadFlag)
    cout << 
      setw(6) << "#L1" << 
      setw(6) << "L1" << 
      setw(6) << "#L2" << 
      setw(6) << "L2";

  cout <<
    setw(6) << "#Def" <<
    setw(6) << "Def" << "\n";

  for (unsigned pno = 1; pno < length; pno++)
  {
    CumulType& c = pairScores[pno];
    if (Scores::SkipScore(c, mode))
      continue;

    cout << 
      left << pairs.GetPairNamePadded(c.pairNo, 54) << right <<
      setw(4) << c.numHands << 
      setw(7) << fixed << setprecision(prec) << c.overall << 
      setw(7) << fixed << setprecision(prec) << c.bid << 
      setw(7) << fixed << setprecision(prec) << c.play1 + c.play2 << 
      setw(7) << fixed << setprecision(prec) << 
        c.lead1 + c.lead2 + c.def << 
      setw(6) << c.numPlay1 << 
      setw(6) << fixed << setprecision(prec) << c.play1perChance << 
      setw(6) << c.numPlay2 << 
      setw(6) << fixed << setprecision(prec) << c.play2perChance;

    if (options.leadFlag)
      cout <<
        setw(6) << c.numLead1 << 
        setw(6) << fixed << setprecision(prec) << c.lead1perChance << 
        setw(6) << c.numLead2 << 
        setw(6) << fixed << setprecision(prec) << c.lead2perChance;

    cout <<
      setw(6) << c.numDef << 
      setw(6) << fixed << setprecision(prec) << c.def << "\n";
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
    scoringTags[options.valet].header << s <<
    "Bid" << s <<
    "Play" << s <<
    "Def" << s <<
    "#Pl1" << s <<
    "Pl1" << s <<
    "#Pl2" << s <<
    "Pl2" << s;

  if (options.leadFlag)
    cout << 
      "#L1" << s <<
      "L1" << s <<
      "#L2" << s <<
      "L2" << s;

  cout <<
    "#Def" << s <<
    "Def" << "\n";

  for (unsigned pno = 1; pno < length; pno++)
  {
    CumulType& c = pairScores[pno];
    if (Scores::SkipScore(c, mode))
      continue;

    cout << 
      pairs.GetPairName(c.pairNo) << s <<
      c.numHands << s <<
      fixed << setprecision(prec) << c.overall << s <<
      fixed << setprecision(prec) << c.bid << s <<
      fixed << setprecision(prec) << c.play1 + c.play2 << s <<
      fixed << setprecision(prec) << 
        c.lead1 + c.lead2 + c.def << s << 
      c.numPlay1 << s <<
      fixed << setprecision(prec) << c.play1perChance << s <<
      c.numPlay2 << s <<
      fixed << setprecision(prec) << c.play2perChance << s;

    if (options.leadFlag)
      cout <<
        c.numLead1 << s <<
        fixed << setprecision(prec) << c.lead1perChance <<  s <<
        c.numLead2 << s <<
        fixed << setprecision(prec) << c.lead2perChance << s;

    cout <<
      c.numDef <<  s <<
      fixed << setprecision(prec) << c.defperChance << "\n";
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

