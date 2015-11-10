/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/



#include "stdafx.h"
#include <assert.h>

#include <iostream>
#include <iomanip>
#include <string>

using namespace std;

#include "valet.h"
#include "Pairs.h"
#include "Hand.h"
#include "scoring.h"

extern OptionsType options;
extern Pairs pairs;

typedef int (*fptrType)(int rawScore);
fptrType fptr;


//////////////////////////////////////////////////
//                                              //
// General functions for all types of scoring   //
//                                              //
//////////////////////////////////////////////////


Hand::Hand()
{
  Hand::Reset();
}


Hand::~Hand()
{
}


void Hand::Reset()
{
  boardNo = 0;
  numEntries = 0;
  results.resize(HAND_CHUNK_SIZE);
  length = HAND_CHUNK_SIZE;
}


int Hand::SetBoardNumber(
  const unsigned n)
{
  if (boardNo > 0 && n != boardNo)
    return RETURN_BOARD_NUMBER_CHANGE;

  boardNo = n;
  GetVul(boardNo, vulNS, vulEW);
  return RETURN_NO_FAULT;
}


unsigned Hand::GetBoardNumber()
{
  return boardNo;
}


unsigned Hand::GetNumEntries()
{
  return numEntries;
}


void Hand::AddResult(
  const ResultType& res)
{
  assert(boardNo > 0);
  if (numEntries == length)
  {
    length += 8;
    results.resize(length);
  }

  results[numEntries++] = res;
}


void Hand::ResetValetEntry(
  ValetEntryType& entry)
{
  entry.pairNo = 0;
  entry.oppNo = 0;
  entry.declFlag[0] = false;
  entry.declFlag[1] = false;
  entry.defFlag = false; 
  entry.leadFlag[0] = false;
  entry.leadFlag[1] = false;
  entry.overall = 0.;
  entry.bidScore = 0.;
  entry.playScore[0] = 0.;
  entry.playScore[1] = 0.;
  entry.leadScore[0] = 0.;
  entry.leadScore[1] = 0.;
  entry.defScore = 0.;
}


const unsigned Hswap[2][2] = { {0, 1}, {1, 0} };

void Hand::SetPairSwaps(
  const ResultType& res, 
  ValetEntryType& entry, 
  unsigned& decl,
  unsigned& leader)
{
  // This function takes care of assigning the scores to the right
  // players within a pair.  pairNo is negative if the players are
  // internally stored in the opposite order to the one that happens
  // to be at the table.

  unsigned swapNS, swapEW;
  int pairNoNS = pairs.GetPairNumber(res.north, res.south);
  assert(pairNoNS != 0);
  if (pairNoNS < 0)
  {
    entry.pairNo = static_cast<unsigned>(-pairNoNS);
    swapNS = 1;
  }
  else
  {
    entry.pairNo = static_cast<unsigned>(pairNoNS);
    swapNS = 0;
  }

  int pairNoEW = pairs.GetPairNumber(res.east, res.west);
  assert(pairNoEW != 0);
  if (pairNoEW < 0)
  {
    entry.oppNo = static_cast<unsigned>(-pairNoEW);
    swapEW = 1;
  }
  else
  {
    entry.oppNo = static_cast<unsigned>(pairNoEW);
    swapEW = 0;
  }

  if (res.declarer == VALET_NORTH || res.declarer == VALET_SOUTH)
  {
    decl = Hswap[swapNS][res.declarer == VALET_SOUTH];
    leader = Hswap[swapEW][res.declarer == VALET_SOUTH];
  }
  else if (res.declarer == VALET_EAST || res.declarer == VALET_WEST)
  {
    decl = Hswap[swapEW][res.declarer == VALET_WEST];
    leader = Hswap[swapNS][res.declarer == VALET_EAST];
  }
  else
  {
    decl = 0;
    leader = 0;
    assert(false);
  }
}


void Hand::SetPassout(
  const ResultType& res,
  const float totalIMPs,
  ValetEntryType& entry)
{
  // Pass-out.
  int pairNoNS = pairs.GetPairNumber(res.north, res.south);
  assert(pairNoNS != 0);
  if (pairNoNS < 0)
    pairNoNS = -pairNoNS; // Doesn't matter for pass-out

  int pairNoEW = pairs.GetPairNumber(res.east, res.west);
  assert(pairNoEW != 0);
  if (pairNoEW < 0)
    pairNoEW = -pairNoEW; // Doesn't matter for pass-out

  entry.pairNo = static_cast<unsigned>(pairNoNS);
  entry.oppNo = static_cast<unsigned>(pairNoEW);
  entry.overall = totalIMPs;
  entry.bidScore = totalIMPs;
}


void Hand::SetPlayResult(
  const ResultType& res, 
  const float totalIMPs, 
  const float bidIMPs, 
  const float leadIMPs,
  ValetEntryType& entry)
{
  unsigned decl, leader;
  Hand::SetPairSwaps(res, entry, decl, leader);

  // All IMPs are seen from NS's side up to here.
  float sign = 1.f;
  if (res.declarer == VALET_EAST || res.declarer == VALET_WEST)
  {
    sign = -1.f;
    unsigned tmp = entry.pairNo;
    entry.pairNo = entry.oppNo;
    entry.oppNo = tmp;
  }

  entry.declFlag[decl] = true;
  entry.defFlag = true;
  entry.leadFlag[leader] = true;

  entry.overall = sign * totalIMPs;
  entry.bidScore = sign * bidIMPs;

  entry.playScore[decl] = sign * (totalIMPs - bidIMPs);

  if (options.leadFlag && res.leadRank > 0)
  {
    entry.leadScore[leader] = - sign * leadIMPs;
    entry.defScore = sign * (bidIMPs - totalIMPs + leadIMPs);
  }
  else
    entry.defScore = sign * (bidIMPs - totalIMPs);
}


//////////////////////////////////////////////////
//                                              //
// Functions only for datum scoring (Butler)    //
//                                              //
//////////////////////////////////////////////////


int Hand::GetDatum(
  const vector<int>& rawScore)
{
  // Datum score (average), rounded to nearest 10.
  // This is used for Butler scoring.

  int datum = 0;
  int dmin = 9999, dmax = -9999;
  for (unsigned i = 0; i < numEntries; i++)
  {
    if (rawScore[i] < dmin)
      dmin = rawScore[i];
    if (rawScore[i] > dmax)
      dmax = rawScore[i];

    datum += rawScore[i];
  }

  if (options.datumFilter && numEntries > 2)
    datum = (datum-dmin-dmax) / static_cast<int>(numEntries-2);
  else
    datum = datum / static_cast<int>(numEntries);

  return datum;
}


float Hand::GetDatumBidding(
  const ResultType& res,
  const unsigned vul,
  const unsigned resMatrix[5][14],
  const int datum)
{
  // This is used for Butler scoring.  
  // We calculate the IMPs (across-the-field style) for our own
  // contract if we get an average declarer of our denomination
  // (playing from our side), and we compare this to the datum.  
  // This gives us the bidding performance, in a way.

  float bidIMPs = 0.;
  unsigned count = 0;
  unsigned d = res.denom;
  for (unsigned t = 0; t <= 13; t++)
  {
    if (resMatrix[d][t] == 0)
      continue;

    int artifScore = CalculateRawScore(res, vul, t);
    bidIMPs += resMatrix[d][t] * 
      static_cast<float>(CalculateIMPs(artifScore - datum));
    count += resMatrix[d][t];
  }

  assert(count > 0);
  return (bidIMPs / count);
}


//////////////////////////////////////////////////
//                                              //
// Functions only for IAF scoring and MPs       //
//                                              //
//////////////////////////////////////////////////


float Hand::GetOverallScore(
  const vector<int> rawScore,
  const int score)
{
  // For a given score, we calculate the average number of IMPs/MPs
  // against all the other pairs.  If we've seen the score before,
  // we use a cached value.

  map<int, float>::iterator it = scoreLookup.find(score);
  if (it != scoreLookup.end())
    return it->second;

  float result = 0;
  unsigned count = 0;
  bool seenSelfFlag = false;

  for (unsigned i = 0; i < numEntries; i++)
  {
    // Skip own score.
    if (! seenSelfFlag && rawScore[i] == score)
    {
      seenSelfFlag = true;
      continue;
    }
    result += static_cast<float>((*fptr)(score - rawScore[i]));
    count++;
  }

  assert(count > 0);
  return (scoreLookup[score] = result / count);
}


float Hand::GetBiddingScore(
  const vector<int> rawScore,
  const unsigned no,
  const unsigned vul,
  const unsigned resMatrix[5][14],
  const float overallResult)
{
  // This is analogous to GetDatumBidding for Butler scoring.
  // We compare to all other scores, not to the datum.

  float bidResult = 0.;
  unsigned count = 0;
  ResultType resArtif = results[no];
  unsigned d = resArtif.denom;
  for (unsigned t = 0; t <= 13; t++)
  {
    if (resMatrix[d][t] == 0)
      continue;

    // Make a synthetic result of our contract with different
    // declarers (including ourselves, but that scores 0).

    resArtif.tricks = t;
    int artifScore = CalculateRawScore(resArtif, vul, t);

    bidResult +=
      resMatrix[d][t] * Hand::GetOverallScore(rawScore, artifScore);
    count += resMatrix[d][t];
  }

  // Special case:  If we're the only ones to play in a denomination,
  // we somewhat arbitrarily assign the full score to the bidding.
  if (count == 0)
    return overallResult;
  else
    return bidResult / count;
}


//////////////////////////////////////////////////
//                                              //
// General scoring function, uses above         //
//                                              //
//////////////////////////////////////////////////


vector<ValetEntryType> Hand::CalculateScores()
{
  vector<int> rawScore(numEntries);
  vector<unsigned> vulList(numEntries);
  unsigned resDeclMatrix[4][5][14] = {0};
  unsigned resDeclLeadMatrix[4][4][5][14] = {0};

  for (unsigned i = 0; i < numEntries; i++)
  {
    unsigned decl = results[i].declarer;
    unsigned denom = results[i].denom;
    unsigned tricks = results[i].tricks;

    vulList[i] = (decl == VALET_NORTH || 
      decl == VALET_SOUTH ? vulNS : vulEW);

    rawScore[i] = CalculateRawScore(results[i], vulList[i]);

    resDeclMatrix[decl][denom][tricks]++;

    if (options.leadFlag && results[i].leadRank > 0)
    {
      unsigned lead = results[i].leadDenom;
      resDeclLeadMatrix[decl][lead][denom][tricks]++;
    }
  }

  vector<ValetEntryType> entries(numEntries);
  if (numEntries == 0)
    return entries;

  if (options.valet == VALET_IMPS)
  {
    int datum = Hand::GetDatum(rawScore);
    float bidIMPs, bidLeadIMPs, leadIMPs = 0.f;

    for (unsigned i = 0; i < numEntries; i++)
    {
      ValetEntryType& entry = entries[i];
      Hand::ResetValetEntry(entry);

      const ResultType& res = results[i];

      float butlerIMPs = static_cast<float>(
        CalculateIMPs(rawScore[i] - datum));

      if (res.level == 0)
        Hand::SetPassout(res, butlerIMPs, entry);
      else
      {
        bidIMPs = GetDatumBidding(res, vulList[i], 
          resDeclMatrix[res.declarer], datum);

        if (options.leadFlag && res.leadRank > 0)
        {
          bidLeadIMPs = GetDatumBidding(res, vulList[i], 
            resDeclLeadMatrix[res.declarer][res.leadDenom], datum);
          leadIMPs = bidLeadIMPs - bidIMPs;
        }
        else
          leadIMPs = 0.f;

        Hand::SetPlayResult(res, butlerIMPs, bidIMPs, leadIMPs, entry);
      }
    }
  }
  else
  {
    if (options.valet == VALET_IMPS_ACROSS_FIELD)
      fptr = &CalculateIMPs;
    else if (options.valet == VALET_MATCHPOINTS)
      fptr = &CalculateMPs;
    else
     assert(false);

    scoreLookup.clear();
    float bidIAF, bidLeadIAF, leadIAF = 0.f;

    for (unsigned i = 0; i < numEntries; i++)
    {
      ValetEntryType& entry = entries[i];
      Hand::ResetValetEntry(entry);

      const ResultType& res = results[i];

      float IAFs = Hand::GetOverallScore(rawScore, rawScore[i]);

      if (res.level == 0)
        Hand::SetPassout(res, IAFs, entry);
      else
      {
        bidIAF = GetBiddingScore(rawScore, i, vulList[i], 
          resDeclMatrix[res.declarer], IAFs);

        if (options.leadFlag && res.leadRank > 0)
        {
          bidLeadIAF = GetBiddingScore(rawScore, i, vulList[i], 
            resDeclLeadMatrix[res.declarer][res.leadDenom], IAFs);
          leadIAF = bidLeadIAF - bidIAF;
        }
        else
          leadIAF = 0.f;

        Hand::SetPlayResult(res, IAFs, bidIAF, leadIAF, entry);
      }
    }
  }

  return entries;
}

