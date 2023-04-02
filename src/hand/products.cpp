/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#include <cassert>

#include "products.h"

#include "../scoring.h"
#include "../cst.h"


extern Options options;


int scoreMP(
  const int score1,
  const int score2)
{
  return calculateMPs(score1 - score2);
}


int scoreIMP(
  const int score1,
  const int score2)
{
  return calculateIMPs(score1 - score2);
}


int average(const vector<int>& scores)
{
  // Datum score (average), rounded to nearest 10.

  int sum = 0;
  int dmin = numeric_limits<int>::max();
  int dmax = numeric_limits<int>::min();

  for (int r: scores)
  {
    if (r < dmin)
      dmin = r;
    if (r > dmax)
      dmax = r;

    sum += r;
  }

  const auto n = scores.size();
  if (options.datumFilter && n > 2)
    return (sum - dmin - dmax) / static_cast<int>(n-2);
  else
    return sum / static_cast<int>(n);
}


int weightedAverage(
  const vector<int>& scores,
  const vector<unsigned>& countVector)
{
  // Used to calculate cloud datum scores.  There is no concept
  // of datum filter here as it is not clear how it would apply.
  assert(scores.size() == countVector.size());

  int sum = 0;
  int count = 0;

  for (unsigned t = 0; t < countVector.size(); t++)
  {
    sum += scores[t] * countVector[t];
    count += countVector[t];
  }

  if (count == 0)
    return 0;
  else
    return sum / count;
}


float weightedResultOverDatum(
  const vector<int>& artifScoreVector,
  const vector<unsigned>& countVector,
  const int datum)
{
  // This is used for bidding method b1.
  // We average our theoretical, artificial results (when we are 
  // replaced by all declarers in our denomination from our side)
  // against the datum.

  assert(artifScoreVector.size() == countVector.size());
  float sum = 0.f;
  float count = 0.f;

  CompPtr cptr = (options.valet == VALET_MATCHPOINTS ?
    &scoreMP : &scoreIMP);

  for (unsigned t = 0; t < countVector.size(); t++)
  {
    if (countVector[t] == 0)
      continue;

    const float r = static_cast<float>(countVector[t]);
    sum += r *
      static_cast<float>((*cptr)(artifScoreVector[t], datum));
    count += r;
  }

  assert(count > 0);
  return (sum / count);
}


float weightedResultOverScores(
  const int ownScore,                   // one score
  const vector<int>& refScoreVector,    // all tricks
  const vector<unsigned>& ownCounts,    // all tricks
  const float defaultScore)
{
  assert(refScoreVector.size() == ownCounts.size());
  float sum = 0.f;
  float count = 0.f;

  CompPtr cptr = (options.valet == VALET_MATCHPOINTS ?
    &scoreMP : &scoreIMP);

  for (unsigned t = 0; t < refScoreVector.size(); t++)
  {
    const float c = static_cast<float>(ownCounts[t]);
    sum += c * 
      static_cast<float>((*cptr)(ownScore, refScoreVector[t]));
    count += c;
  }

  if (count > 0.f)
    return sum / count;
  else
    return defaultScore;
}

