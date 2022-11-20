/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-23 by Soren Hein.

   See LICENSE and README.
*/



#include <iostream>
#include <sstream>
#include <string>
#include <algorithm>
#include <cassert>

#include "Scores.h"
#include "Pairs.h"
#include "misc.h"

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

  CumulPair& cDecl = pairScores[entry.pairNo];
  cDecl.setPair(entry.pairNo);
  cDecl.incrDeclarer(entry);

  // The overall and bidding scores have to be inverted.
  // The detailed scores have already been inverted.

  CumulPair& cDef = pairScores[entry.oppNo];
  cDef.setPair(entry.oppNo);
  cDef.incrDefenders(entry);

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
      const float n = static_cast<float>(oppResults.num[i]);
      if (n == 0)
        oppComp[pno].sum[i] = 0.f;
      else if (options.valet == VALET_MATCHPOINTS)
        oppComp[pno].sum[i] = -50.f + oppResults.sum[i] / n;
      else
        oppComp[pno].sum[i] = oppResults.sum[i] / n;
      }
  }
}


float Scores::Scale(
  const float value,
  const unsigned num) const
{
  if (num > 0)
    return value / static_cast<float>(num);
  else
    return 0.;
}


float Scores::ScaleMP(
  const float value,
  const unsigned num) const
{
  if (num > 0)
  {
    const float n = static_cast<float>(num);
    return 100.f * (value + n) / (2.f * n);
  }
  else
    return 50.f;
}


void Scores::Normalize()
{
  for (unsigned pno = 1; pno < length; pno++)
  {
    CumulPair& c = pairScores[pno];
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


void Scores::Sort(
  const SortingType stype)
{
  sort(next(pairScores.begin()), pairScores.end(),
    [stype](const CumulPair& c1, const CumulPair& c2)
    {
      return c1.greater(c2, stype);
    });
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
    const CumulPair& c = pairScores[pno];
    if (! c.skip(mode))
      flag = true;
  }

  // Skip if all entries are skipped.
  if (! flag)
    return false;

  if (options.valet == VALET_MATCHPOINTS)
    prec = 1;
  else
    prec = 2;

  return true;
}


/*
bool Scores::SkipScore(
  const CumulPair& c,
  const unsigned mode) const
{
  return c.skip(mode);
}
*/


void Scores::PrintTextHeader() const
{
  CumulPair c;

  cout << 
    setw(54) << "" << " | " <<
    c.strHeaderText1() << "\n" <<
    setw(54) << left << "Players" << right << " | " <<
    c.strHeaderText2() << "\n";
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
    const CumulPair& c = pairScores[pno];
    // if (Scores::SkipScore(c, mode))
    if (c.skip(mode))
      continue;

    cout << 
      // left << pairs.GetPairNamePadded(c.pairNo, 54) << right << " | " <<
      c.strOverall(pairs, prec, VALET_FORMAT_TEXT);

    cout << c.strDetails(prec, VALET_FORMAT_TEXT);
  }
  cout << "\n";
}


void Scores::PrintCSVHeader() const
{
  CumulPair c;

  cout << 
    "Players" << options.separator <<
    c.strHeaderCSV() << "\n";
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
    const CumulPair& c = pairScores[pno];
    // if (Scores::SkipScore(c, mode))
    if (c.skip(mode))
      continue;

    cout << 
      // pairs.GetPairName(c.pairNo) << s <<
      c.strOverall(pairs, prec, VALET_FORMAT_CSV);

    cout << c.strDetails(prec, VALET_FORMAT_CSV);
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

