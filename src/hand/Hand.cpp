/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#include <iostream>
#include <iomanip>
#include <string>
#include <sstream>
#include <cassert>

#include "Hand.h"
#include "products.h"

#include "../scores/ScoreInput.h"

#include "../valet.h"
#include "../scoring.h"
#include "../cst.h"
#include "../learn/LearnLevel.h"


extern Options options;


/************************************************************
 *                                                          *
 * Basic methods                                            *
 *                                                          *
 ************************************************************/

Hand::Hand()
{
  Hand::reset();
}


void Hand::reset()
{
  boardNo = 0;
  numEntries = 0;
  results.resize(HAND_CHUNK_SIZE);
  length = HAND_CHUNK_SIZE;
}


int Hand::setBoardNumber(const unsigned boardNoIn)
{
  if (boardNo > 0 && boardNoIn != boardNo)
    return RETURN_BOARD_NUMBER_CHANGE;

  boardNo = boardNoIn;
  getVul(boardNo, vulNS, vulEW);
  return RETURN_NO_FAULT;
}


unsigned Hand::getBoardNumber()
{
  return boardNo;
}


unsigned Hand::getNumEntries()
{
  return numEntries;
}


void Hand::add(const Result& result)
{
  assert(boardNo > 0);
  if (numEntries == length)
  {
    length += 8;
    results.resize(length);
  }

  results[numEntries++] = result;
}


/************************************************************
 *                                                          *
 * Vector methods                                           *
 *                                                          *
 ************************************************************/

float Hand::unweightedOverResultsDropScore(
  const int ownScore,
  const vector<int>& resultsScoreVector) const
{
  // For a given score, we calculate the average number of IMPs/MPs
  // against all the other pairs.

  float sum = 0.f;
  float count = 0.f;

  CompPtr cptr = (options.valet == VALET_MATCHPOINTS ?
    &scoreMP : &scoreIMP);

  // Normally ownScore is also in resultsScoreVector.
  // But it can happen that we generate an artificial score that
  // did not occur, e.g. when we have 1N+2, 3N=, 3N+1.  Then we
  // could get an artificial +180.  We do the best we can and find
  // the closest score in that case, but it's a kludge, and the
  // full cloud scoring is more satisfying.

  int distBest = numeric_limits<int>::max();
  unsigned skipIndex = numeric_limits<unsigned>::max();
  for (unsigned i = 0; i < numEntries; i++)
  {
    const int dist = abs(resultsScoreVector[i] - ownScore);
    if (dist < distBest)
    {
      distBest = dist;
      skipIndex = i;
    }
  }
  assert(distBest != numeric_limits<int>::max());

  for (unsigned i = 0; i < numEntries; i++)
  {
    if (i == skipIndex)
      continue;

    sum += static_cast<float>((*cptr)(ownScore, resultsScoreVector[i]));
    count++;
  }

  assert(count > 0);
  return sum / count;
}


float Hand::unweightedOverResultsDropIndex(
  const int ownScore,
  const vector<int>& resultsScoreVector,
  const unsigned skipIndex) const
{
  // Used in several places with different arguments: o1, o2, b3
  float sum = 0.f;
  float count = 0.f;

  CompPtr cptr = (options.valet == VALET_MATCHPOINTS ?
    &scoreMP : &scoreIMP);

  for (unsigned i = 0; i < numEntries; i++)
  {
    // Skip own index.
    if (i == skipIndex)
      continue;

    sum += static_cast<float>((*cptr)(ownScore, resultsScoreVector[i]));
    count++;
  }

  assert(count > 0);
  return (sum / count);
}


/************************************************************
 *                                                          *
 * More complex help methods                                *
 *                                                          *
 ************************************************************/

float Hand::calcBiddingNoCloudIAF(
  const vector<int>& artifScoresVector, // all tricks
  const vector<int>& resultsScoreVector,// all results
  const vector<unsigned>& countVector,  // all tricks
  const float defaultScore)
{
  // Bidding method b1.
  assert(artifScoresVector.size() == countVector.size());

  float sum = 0.f;
  float count = 0.f;

  for (unsigned t = 0; t < countVector.size(); t++)
  {
    if (countVector[t] == 0)
      continue;

    const float c = static_cast<float>(countVector[t]);
    sum += c * Hand::unweightedOverResultsDropScore(
      artifScoresVector[t], 
      resultsScoreVector);
    count += c;
  }

  if (count == 0)
    return defaultScore;
  else
    return sum / count;
}


float Hand::calcScoreCloudIAF(
  const int ownScore,
  const unsigned skipIndex,
  const vector<vector<int>>& artifScoresMatrix,
  const vector<vector<vector<unsigned>>>& countsDecl,
  const float overallResult)
{
  // When called with the actual ownScore, this implements the
  // overall method o3.  We score against each opponent, not just
  // their actual scores but all their possible other scores in
  // their respective contracts, had they been replaced successively
  // by all other declarers in that same denomination from the same
  // side as they were (not that we were).

  if (numEntries <= 1)
    return overallResult;

  CompPtr cptr = (options.valet == VALET_MATCHPOINTS ?
    &scoreMP : &scoreIMP);

  float sum = 0.;
  for (unsigned i = 0; i < numEntries; i++)
  {
    // Loop over each opponent.
    if (i == skipIndex)
      continue;

    const Result& oppResult = results[i];
    if (oppResult.isPassedOut())
    {
      sum += static_cast<float>((*cptr)(ownScore, 0));
    }
    else
    {
      // Use the opponents' scores (artifScoresMatrix) and counts.
      sum += weightedResultOverScores(
        ownScore, 
        artifScoresMatrix[i], 
        countsDecl[oppResult.getDeclarer()][oppResult.getDenom()], 
        0.f);
    }
  }

  return sum / static_cast<float>(numEntries-1);
}


float Hand::calcBiddingCloudIAF(
  const unsigned skipIndex,
  const vector<vector<int>>& artifScoresMatrix,
  const vector<unsigned>& countVector,
  const vector<vector<vector<unsigned>>>& countsDecl,
  const float defaultScore)
{
  // This uses calcScoreCloudIAF to calculate our own
  // weighted score for all our possible own trick numbers.
  //
  // Bidding method b4.

  float sum = 0.f;
  float count = 0.f;

  for (unsigned t = 0; t < countVector.size(); t++)
  {
    if (countVector[t] == 0)
      continue;

    // Make a synthetic result of our contract with different
    // declarers (including ourselves, but that scores 0).

    const float r = static_cast<float>(countVector[t]);
    float b = r * Hand::calcScoreCloudIAF(
        artifScoresMatrix[skipIndex][t],
        skipIndex, 
        artifScoresMatrix, 
        countsDecl, 
        defaultScore);

    sum += b;
    count += r;
  }

  // Special case:  If we're the only ones to play in a denomination,
  // we somewhat arbitrarily assign the full score to the bidding.
  if (count == 0)
    return defaultScore;
  else
    return sum / count;
}


void Hand::calcCloudDatumScores(
  const vector<vector<int>>& artifScoresMatrix,
  const vector<vector<vector<unsigned>>>& countsDecl,
  const vector<vector<vector<vector<unsigned>>>>& countsDeclLead,
  vector<int>& cloudDatumScore,
  vector<int>& cloudDatumLeadScore)
{
  for (unsigned i = 0; i < numEntries; i++)
  {
    const unsigned decl = results[i].getDeclarer();
    const unsigned d = results[i].getDenom();
    const unsigned l = results[i].getLeadDenom();

    // These are the "cloud datum scores" {d_i} below.
    // They are used for datum-like calculations, so o2 and b3.
    cloudDatumScore[i] = weightedAverage(
      artifScoresMatrix[i], 
      countsDecl[decl][d]);

    if (options.leadFlag)
    {
      // The same, but limited to those results with the same lead.
      cloudDatumLeadScore[i] = weightedAverage(
        artifScoresMatrix[i], 
        countsDeclLead[decl][l][d]);
    }
  }
}



/************************************************************
 *                                                          *
 * Tabulations needed for the scoring                       *
 *                                                          *
 ************************************************************/

void Hand::tabulateCounts(
  vector<vector<vector<unsigned>>>& countsDecl,
  vector<vector<vector<vector<unsigned>>>>& countsDeclLead) const
{
  countsDecl.resize(4);
  for (unsigned decl = 0; decl < 4; decl++)
  {
    countsDecl[decl].resize(5);
    for (unsigned denom = 0; denom < 5; denom++)
      countsDecl[decl][denom].resize(14);
  }

  countsDeclLead.resize(4);
  for (unsigned decl = 0; decl < 4; decl++)
  {
    countsDeclLead[decl].resize(4);
    for (unsigned leader = 0; leader < 4; leader++)
    {
      countsDeclLead[decl][leader].resize(5);
      for (unsigned denom = 0; denom < 5; denom++)
        countsDeclLead[decl][leader][denom].resize(14);
    }
  }

  for (unsigned i = 0; i < numEntries; i++)
  {
    unsigned decl = results[i].getDeclarer();
    unsigned denom = results[i].getDenom();
    unsigned tricks = results[i].getTricks();

    if (results[i].isPassedOut())
      continue;

    countsDecl[decl][denom][tricks]++;

    if (options.leadFlag && results[i].hasLead())
    {
      unsigned lead = results[i].getLeadDenom();
      countsDeclLead[decl][lead][denom][tricks]++;
    }
  }
}


void Hand::tabulateScores(
  vector<int>& ownScoreVector,
  vector<vector<int>>& artifScoresMatrix) const
{
  ownScoreVector.resize(numEntries);
  artifScoresMatrix.resize(numEntries);

  for (unsigned i = 0; i < numEntries; i++)
  {
    // Actual scores.
    ownScoreVector[i] = results[i].calcScore();

    // Theoretical, artificial scores when taking a different number
    // of tricks in the same denomination from the same side.
    // If we ourselves are doubled or redoubled, when all the
    // artificial scores are too.
    artifScoresMatrix[i].resize(14);
    for (unsigned t = 0; t < artifScoresMatrix[i].size(); t++)
      artifScoresMatrix[i][t] = results[i].calcScore(t);
  }
}


/************************************************************
 *                                                          *
 * The four main groups of methods that are implemented     *
 *                                                          *
 ************************************************************/

void Hand::calcCloudIMP(
  const Result& result, 
  const int ownScore,
  const vector<int>& cloudDatumScore,
  const vector<int>& cloudDatumLeadScore,
  const unsigned skipIndex,
  ScoreInput& entry) const
{
  // Overall method o2
  const float butlerIMPs =
    Hand::unweightedOverResultsDropIndex(
      ownScore, cloudDatumScore, skipIndex);

  if (result.isPassedOut())
    entry.setPassout(result, butlerIMPs);
  else
  {
    // Overall method b3
    const float bidIMPs = Hand::unweightedOverResultsDropIndex(
      cloudDatumScore[skipIndex], cloudDatumScore, skipIndex);

    float leadIMPs;
    if (options.leadFlag && result.hasLead())
    {
      const float bidLeadIMPs = Hand::unweightedOverResultsDropIndex(
        cloudDatumScore[skipIndex], cloudDatumLeadScore, skipIndex);

      leadIMPs = bidLeadIMPs - bidIMPs;
    }
    else
      leadIMPs = 0.f;

    entry.set(result, butlerIMPs, bidIMPs, leadIMPs);
  }
}


void Hand::calcNoCloudIMP(
  const Result& result, 
  const int ownScore,
  const vector<int>& artifScoresVector,
  const int datum,
  const vector<unsigned>& countVectorDecl,
  const vector<unsigned>& countVectorDeclLead,
  ScoreInput& entry) const
{
  // Overall method o0.
  const float butlerIMPs = static_cast<float>(scoreIMP(ownScore, datum));

  if (result.isPassedOut())
    entry.setPassout(result, butlerIMPs);
  else
  {
    // Bidding method b1.
    const float bidIMPs = weightedResultOverDatum(
      artifScoresVector, countVectorDecl, datum);

    float leadIMPs;
    if (options.leadFlag && result.hasLead())
    {
      const float bidLeadIMPs = weightedResultOverDatum(
        artifScoresVector, countVectorDeclLead, datum);

      leadIMPs = bidLeadIMPs - bidIMPs;
    }
    else
      leadIMPs = 0.f;

    entry.set(result, butlerIMPs, bidIMPs, leadIMPs);
  }
}


void Hand::calcCloudIAF(
  const Result& result,
  const int ownScore,
  const vector<vector<int>>& artifScoresMatrix,
  const vector<unsigned>& countVectorDecl,
  const vector<unsigned>& countVectorDeclLead,
  const vector<vector<vector<unsigned>>>& countsDecl,
  const unsigned skipIndex,
  ScoreInput& entry)
{
  // Overall method o3.
  const float IAFs = Hand::calcScoreCloudIAF(
    ownScore, 
    skipIndex, 
    artifScoresMatrix,
    countsDecl, 
    0.);

  if (result.isPassedOut())
  {
    entry.setPassout(result, IAFs);
  }
  else
  {
    // Bidding method b4.
    const float bidIAF = Hand::calcBiddingCloudIAF(
      skipIndex,
      artifScoresMatrix,
      countVectorDecl,
      countsDecl,
      IAFs);

    float leadIAF;
    if (options.leadFlag && result.hasLead())
    {
      // Bidding score b4 for the specific lead.
      const float bidLeadIAF = Hand::calcBiddingCloudIAF(
        skipIndex,
        artifScoresMatrix,
        countVectorDeclLead,
        countsDecl,
        IAFs);

      // The difference is the lead score.
      leadIAF = bidLeadIAF - bidIAF;
    }
    else
      leadIAF = 0.f;

    entry.set(result, IAFs, bidIAF, leadIAF);
  }
}


void Hand::calcNoCloudIAF(
  const Result& result,
  const int ownScore,
  const vector<int>& resultsScoreVector,
  const vector<int>& artifScoresVector,
  const vector<unsigned>& countVectorDecl,
  const vector<unsigned>& countVectorDeclLead,
  const unsigned skipIndex,
  ScoreInput& entry)
{
  // Overall method o1.
  const float IAFs = Hand::unweightedOverResultsDropIndex(
    ownScore, resultsScoreVector, skipIndex);

  if (result.isPassedOut())
    entry.setPassout(result, IAFs);
  else
  {
    // Bidding method b1: Get bidding score for all leads.
    // If we're the only ones to play in a denomination, we
    // somewhat arbitrarily assign the full score to the bidding.
    const float bidIAF = calcBiddingNoCloudIAF(
      artifScoresVector,
      resultsScoreVector,
      countVectorDecl,
      IAFs);

    float leadIAF;
    if (options.leadFlag && result.hasLead())
    {
      // Get bidding score for the specific lead.
      const float bidLeadIAF = calcBiddingNoCloudIAF(
        artifScoresVector,
        resultsScoreVector,
        countVectorDeclLead,
        IAFs);
  
      // The difference is the lead score.
      leadIAF = bidLeadIAF - bidIAF;
    }
    else
      leadIAF = 0.f;

    entry.set(result, IAFs, bidIAF, leadIAF);
  }
}


 
/************************************************************
 *                                                          *
 * The overall method with several variants                 *
 *                                                          *
 ************************************************************/

void Hand::calculateScores(vector<ScoreInput>& entries)
{
  // Set the histogram counts.
  vector<vector<vector<unsigned>>> countsDecl;
  vector<vector<vector<vector<unsigned>>>> countsDeclLead;
  Hand::tabulateCounts(countsDecl, countsDeclLead);

  // Set the real and artificial scores for each result.
  vector<int> ownScoreVector;
  vector<vector<int>> artifScoresMatrix;
  Hand::tabulateScores(ownScoreVector, artifScoresMatrix);

  // Correspondences with the math in the Valet Principles document:
  //
  // {r_j} = ownScoreVector[]
  //
  // artifScoresMatrix[j] does not have a direct relation.  It is the
  // vector of scores for all possible numbers of tricks 0 .. 13,
  // including tricks that nobody obtained at the table.
  //
  // We know the trick histograms (including the j'th result itself):
  // countsDecl[declarer][denom][*]
  // countsDeclLead[declarer][denom][*]
  //
  // We don't explicitly calculate {e_j}, but it is stored in a
  // combination of {r_j} and countsDecl.  {e_j} is a list (of
  // variable length) of scores, and here we instead have a histogram
  // representation.
  //
  // So d_j = (sum over t of 
  //   artifScoresMatrix[j][t] *
  //   countsDecl[declarer][denom][t]) /
  //   (sum over t of countsDecl[declarer][denom][t]),
  //
  // the "weighted average" of the artificial scores.  This is the
  // average score if the declarer is replaced with all declarers in
  // the same denomination (from the same side).
  //
  // o0_j = average' over k of score(r_j, datum)
  //
  // (not in the paper) is just the Butler score against a single datum.
  //
  // o1_j = average' over k of score(r_j, r_k)
  //
  // where average' means "excluding its own score, k != j".
  // This is the Butler score against all other scores.
  //
  // o2_j = (average' over k of score(r_j, d_k))
  //
  // is a "cloud Butler datum".
  //
  // o3_j = (average' over k of) (sum over t of
  //   score(r_j, artifScoresMatrix[k][t]) *
  //   countsDecl[declarer][denom][t]) /
  //   (sum over t of countsDecl[declarer][denom][t]).
  //
  // b1_j = sum over t of 
  //   countsDecl[declarer][denom][t] * 
  //   (average' over k of score(artifScoresMatrix[j][t], r_k)) /
  //   (sum over t of countsDecl[declarer][denom][t]).
  //
  // b2_j = average' over k of score(d_j, r_k).
  //
  // b3_j = average' over k of score(d_j, d_k).
  //
  // b4_j = avg_n avg_k avg_q score(e_jn, e_kq)
  // is like o3_j, but for each artificial own result and not just
  // for the actual own result.


  entries.resize(numEntries);
  if (numEntries == 0)
    return;

  if (options.valet == VALET_IMPS)
  {
    if (options.cloudFlag)
    {
      // Calculate cloud "datum scores" for each result.
      vector<int> cloudDatumScore(numEntries);
      vector<int> cloudDatumLeadScore(numEntries);

      // The cloud datum scores are the {d_k}.
      Hand::calcCloudDatumScores(
        artifScoresMatrix,
        countsDecl,
        countsDeclLead,
        cloudDatumScore,
        cloudDatumLeadScore);

      for (unsigned index = 0; index < numEntries; index++)
      {
        // Methods o2, b3.
        Hand::calcCloudIMP(
          results[index],
          ownScoreVector[index],
          cloudDatumScore,
          cloudDatumLeadScore,
          index,
          entries[index]);
      }
    }
    else
    {
      // Calculate the single datum score.
      const int datum = average(ownScoreVector);

      for (unsigned index = 0; index < numEntries; index++)
      {
        const Result& result = results[index];
        const unsigned decl = result.getDeclarer();
        const unsigned leadDenom = result.getLeadDenom();
        const unsigned denom = result.getDenom();

        // Methods o0, b1.
        Hand::calcNoCloudIMP(
          result, 
          ownScoreVector[index], 
          artifScoresMatrix[index], 
          datum,
          countsDecl[decl][denom],
          countsDeclLead[decl][leadDenom][denom],
          entries[index]);
      }
    }
  }
  else
  {
    if (options.cloudFlag)
    {
      for (unsigned index = 0; index < numEntries; index++)
      {
        const Result& result = results[index];
        const unsigned decl = result.getDeclarer();
        const unsigned leadDenom = result.getLeadDenom();
        const unsigned denom = result.getDenom();

        // Methods o3, b4.
        Hand::calcCloudIAF(
          result,
          ownScoreVector[index],
          artifScoresMatrix,
          countsDecl[decl][denom],
          countsDeclLead[decl][leadDenom][denom],
          countsDecl,
          index,
          entries[index]);
      }
    }
    else
    {
      for (unsigned index = 0; index < numEntries; index++)
      {
        const Result& result = results[index];
        const unsigned decl = result.getDeclarer();
        const unsigned leadDenom = result.getLeadDenom();
        const unsigned denom = result.getDenom();

        // Methods o1, b1.
        Hand::calcNoCloudIAF(
          result,
          ownScoreVector[index],
          ownScoreVector,
          artifScoresMatrix[index],
          countsDecl[decl][denom],
          countsDeclLead[decl][leadDenom][denom],
          index,
          entries[index]);
      }
    }
  }
}


string Hand::strProfile() const
{
  float passed = 0.f;
  vector<float> first, second;
  first.resize(VALET_LEARN_SIZE);
  second.resize(VALET_LEARN_SIZE);

  const float incr = 1.f / static_cast<float>(numEntries);
  int cumScore = 0;

  for (unsigned index = 0; index < numEntries; index++)
  {
    const Result& result = results[index];
    if (result.isPassedOut())
      passed += incr;
    else if (result.declarerNS())
    {
      first[result.getLearn()] += incr;
      cumScore += result.calcScore();
    }
    else if (result.declarerEW())
    {
      second[result.getLearn()] += incr;
      cumScore += result.calcScore();
    }
    else
      assert(false);
  }

  if (cumScore < 0)
    swap(first, second);

  stringstream ss;
  ss << setprecision(4) << fixed;
  for (unsigned level = 0; level < VALET_PASSED_OUT; level++)
    ss << first[level] << ",";
  for (unsigned level = 0; level < VALET_PASSED_OUT; level++)
    ss << second[level] << ",";
  ss << passed << "\n";

  return ss.str();
}

