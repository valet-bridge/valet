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
#include "ScoreInput.h"

#include "../cst.h"

using namespace std;

#define SCORES_CHUNK_SIZE 16

extern Options options;


Scores::Scores()
{
  Scores::clear();
}


void Scores::clear()
{
  scoreData.clear();
  scoreData.resize(SCORES_CHUNK_SIZE);
}


void Scores::resize(const size_t index)
{
  if (index < scoreData.size())
    return;

  const size_t length = ((index / SCORES_CHUNK_SIZE) + 1) * 
    SCORES_CHUNK_SIZE;

  scoreData.resize(length);
}


void Scores::add(const ScoreInput& entry)
{
  Scores::resize(max(entry.pairNo, entry.oppNo));

  // The entry always yields a declaring entry for us and a defending
  // entry for the other pair.
  Score ownScore;
  Score oppScore;

  ownScore.incrDeclarer(entry);
  oppScore.incrDefenders(entry);

  Score& ownCumScore = scoreData[entry.pairNo].score;
  ownCumScore.setPair(entry.pairNo);
  ownCumScore += ownScore;

  Score& oppCumScore = scoreData[entry.oppNo].score;
  oppCumScore.setPair(entry.oppNo);
  oppCumScore += oppScore;

  if (! options.compensateFlag)
    return;

  // Remember the pairs who played in order to be able to compensate.
  scoreData[entry.pairNo].oppScores[entry.oppNo] += oppScore;
  scoreData[entry.oppNo].oppScores[entry.pairNo] += ownScore;
}


void Scores::scale()
{
  for (auto& sdata: scoreData)
    sdata.score.scale();
}


void Scores::compensate()
{
  // Compensate for the average strength of opponents, ignoring
  // each opponent's results against us.
  assert(options.compensateFlag);

  for (auto& sdata: scoreData)
  {
    Score oppResults;

    for (auto it = sdata.oppScores.begin(); 
        it != sdata.oppScores.end(); it++)
    {
      const size_t oppNo = it->first;
      assert(oppNo > 0 && oppNo < scoreData.size());

      // Add each opponent, then subtract out our own results against them.
      oppResults += scoreData[oppNo].score;
      oppResults -= it->second;
    }

    oppResults.scale();

    sdata.score.compensate(oppResults);
  }
}


void Scores::sort(const SortingEnum stype)
{
  ::sort(scoreData.begin(), scoreData.end(),
    [stype](const ScoreData& s1, const ScoreData& s2)
    {
      return s1.score.figure(stype) > s2.score.figure(stype);
    });
}


bool Scores::onlySkips(const TableEnum ttype) const
{
  for (auto& sdata: scoreData)
    if (! sdata.score.skip(ttype))
      return false;

  return true;
}


string Scores::str(const TableEnum ttype) const
{
  if (ttype == VALET_TABLE_FEW && options.minHands == 0)
    return "";

  if (Scores::onlySkips(ttype))
    return "";

  stringstream ss;
  ss << scoreData[0].score.strHeader();

  const int prec = (options.valet == VALET_MATCHPOINTS ? 1 : 2);

  for (auto& sdata: scoreData)
    ss << sdata.score.strLine(ttype, prec);

  ss << "\n";
  
  return ss.str();
}


string Scores::str() const
{
  return 
    Scores::str(VALET_TABLE_MANY) + 
    Scores::str(VALET_TABLE_FEW);
}

