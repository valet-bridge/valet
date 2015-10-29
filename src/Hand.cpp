/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/



#include <assert.h>

#include <iostream>
#include <iomanip>
#include <string>

using namespace std;

#include "cst.h"
#include "Pairs.h"
#include "Hand.h"
#include "scoring.h"

extern OptionsType options;
extern Pairs pairs;


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


void Hand::SetBoardNumber(
  const unsigned n)
{
  boardNo = n;
  GetVul(boardNo, vulNS, vulEW);
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
  ValetEntryType& entryNS, 
  ValetEntryType& entryEW,
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
    entryNS.pairNo = static_cast<unsigned>(-pairNoNS);
    swapNS = 1;
  }
  else
  {
    entryNS.pairNo = static_cast<unsigned>(pairNoNS);
    swapNS = 0;
  }

  int pairNoEW = pairs.GetPairNumber(res.east, res.west);
  assert(pairNoEW != 0);
  if (pairNoEW < 0)
  {
    entryEW.pairNo = static_cast<unsigned>(-pairNoEW);
    swapEW = 1;
  }
  else
  {
    entryEW.pairNo = static_cast<unsigned>(pairNoEW);
    swapEW = 0;
  }

  entryNS.oppNo = entryEW.pairNo;
  entryEW.oppNo = entryNS.pairNo;

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


//////////////////////////////////////////////////
//                                              //
// Functions common to datum and IAF scoring    //
//                                              //
//////////////////////////////////////////////////


void Hand::SetPassoutIMPs(
  const ResultType& res,
  const float totalIMPs,
  ValetEntryType& entryNS,
  ValetEntryType& entryEW)
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

  entryNS.pairNo = static_cast<unsigned>(pairNoNS);
  entryNS.oppNo = static_cast<unsigned>(pairNoEW);
  entryNS.overall = totalIMPs;
  entryNS.bidScore = totalIMPs;

  entryEW.pairNo = static_cast<unsigned>(pairNoEW);
  entryEW.oppNo = static_cast<unsigned>(pairNoNS);
  entryEW.overall = -totalIMPs;
  entryEW.bidScore = -totalIMPs;
}


void Hand::SetPlayResultIMPs(
  const ResultType& res, 
  const float totalIMPs, 
  const float bidIMPs, 
  const float leadIMPs,
  ValetEntryType& entryNS, 
  ValetEntryType& entryEW)
{
  unsigned decl, leader;
  Hand::SetPairSwaps(res, entryNS, entryEW, decl, leader);

  entryNS.overall = totalIMPs;
  entryNS.bidScore = bidIMPs;
  entryEW.overall = -totalIMPs;
  entryEW.bidScore = -bidIMPs;

  if (res.declarer == VALET_NORTH || res.declarer == VALET_SOUTH)
  {
    entryNS.declFlag[decl] = true;
    entryNS.playScore[decl] = totalIMPs - bidIMPs;

    entryEW.defFlag = true;
    entryEW.leadFlag[leader] = true;

    if (options.leadFlag && res.leadRank > 0)
    {
      // leadIMPs are seen from NS's side up to here.
      entryEW.leadScore[leader] = -leadIMPs;
      entryEW.defScore = bidIMPs - totalIMPs + leadIMPs;
    }
    else
      entryEW.defScore = bidIMPs - totalIMPs;
  }
  else
  {
    entryEW.declFlag[decl] = true;
    entryEW.playScore[decl] = bidIMPs - totalIMPs;

    entryNS.defFlag = true;
    entryNS.leadFlag[leader] = true;

    if (options.leadFlag && res.leadRank > 0)
    {
      // leadIMPs are seen from NS's side up to here.
      entryNS.leadScore[leader] = leadIMPs;
      entryNS.defScore = totalIMPs - bidIMPs - leadIMPs;
    }
    else
      entryNS.defScore = totalIMPs - bidIMPs;
  }
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

  if (options.datumHardRounding)
  {
    //  374 ->  370,  375 ->  370
    // -374 -> -370, -375 -> -370
    return (datum >= 0 ? ((datum+0)/10)*10 : -((-datum+0)/10)*10 );
  }
  else
  {
    //  374 ->  370,  375 ->  380
    // -374 -> -370, -375 -> -380
    return (datum >= 0 ? ((datum+5)/10)*10 : -((-datum+5)/10)*10 );
  }
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
// Functions only for IAF scoring               //
//                                              //
//////////////////////////////////////////////////


float Hand::GetIAFOverall(
  const vector<int> rawScore,
  const int score)
{
  // This is used for IMPs-across-the-field scoring.
  // For a given score, we calculate the average number of IMPs
  // against all the other pairs.  If we've seen the score before,
  // we use a cached value.

  map<int, float>::iterator it = scoreLookup.find(score);
  if (it != scoreLookup.end())
    return it->second;

  float IMPs = 0;
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
    IMPs += static_cast<float>(CalculateIMPs(score - rawScore[i]));
    count++;
  }

  assert(count > 0);
  return (scoreLookup[score] = IMPs / count);
}


float Hand::GetIAFBidding(
  const vector<int> rawScore,
  const unsigned no,
  const unsigned vul,
  const unsigned resMatrix[5][14],
  const float IAFs)
{
  // This is analogous to GetDatumBidding for Butler scoring.
  // We compare to all other scores, not to the datum.

  float bidIAF = 0.;
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

    bidIAF += resMatrix[d][t] * GetIAFOverall(rawScore, artifScore);
    count += resMatrix[d][t];
  }

  // Special case:  If we're the only ones to play in a denomination,
  // we somewhat arbitrarily assign the full score to the bidding.
  if (count == 0)
    return IAFs;
  else
    return bidIAF / count;
}


//////////////////////////////////////////////////
//                                              //
// Functions only for matchpoint scoring        //
//                                              //
//////////////////////////////////////////////////


void Hand::SetPassoutMatchpoints(
  const ResultType& res,
  const float totalMPs,
  ValetEntryType& entryNS,
  ValetEntryType& entryEW)
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

  entryNS.pairNo = static_cast<unsigned>(pairNoNS);
  entryNS.oppNo = static_cast<unsigned>(pairNoEW);
  entryNS.overall = totalMPs;
  entryNS.bidScore = totalMPs;

  entryEW.pairNo = static_cast<unsigned>(pairNoEW);
  entryEW.oppNo = static_cast<unsigned>(pairNoNS);
  entryEW.overall = 100.f - totalMPs;
  entryEW.bidScore = 100.f - totalMPs;
}


void Hand::SetPlayResultMatchpoints(
  const ResultType& res, 
  const float totalMPs, 
  const float bidMPs, 
  const float leadMPs, 
  ValetEntryType& entryNS, 
  ValetEntryType& entryEW)
{
  unsigned decl, leader;
  Hand::SetPairSwaps(res, entryNS, entryEW, decl, leader);

  entryNS.overall = totalMPs;
  entryNS.bidScore = bidMPs;
  entryEW.overall = 100.f - totalMPs;
  entryEW.bidScore = 100.f - bidMPs;

  if (res.declarer == VALET_NORTH || res.declarer == VALET_SOUTH)
  {
    // Average of bid score and play score is overall score.

    entryNS.declFlag[decl] = true;
    entryNS.playScore[decl] = 2*totalMPs - bidMPs;

    entryEW.defFlag = true;
    entryEW.leadFlag[leader] = true;

    if (options.leadFlag && res.leadDenom > 0)
    {
      // leadMPs are seen from NS's side up to here.
      // Average of lead score and defense score is overall score.

      entryEW.leadScore[leader] = 100.f - leadMPs;
      entryEW.defScore = 100.f - 2 * entryNS.playScore[decl] + leadMPs;
    }
    else
      entryEW.defScore = 100.f - entryNS.playScore[decl];
  }
  else
  {
    entryEW.declFlag[decl] = true;
    entryEW.playScore[decl] = bidMPs - 2*totalMPs;

    entryNS.defFlag = true;
    entryNS.leadFlag[leader] = true;

    if (options.leadFlag && res.leadDenom > 0)
    {
      // leadMPs are seen from NS's side up to here.
      entryNS.leadScore[leader] = leadMPs;
      entryNS.defScore = 200.f - 2 * entryEW.playScore[decl] - leadMPs;
    }
    else
      entryNS.defScore = 100.f - entryEW.playScore[decl];
  }
}


float Hand::GetMPOverall(
  const vector<int> rawScore,
  const int score)
{
  // This is used for matchpoint scoring.
  // For a given score, we calculate the average number of MPs
  // against all the other pairs.  If we've seen the score before,
  // we use a cached value.

  map<int, float>::iterator it = scoreLookup.find(score);
  if (it != scoreLookup.end())
    return it->second;

  float MPs = 0;
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

    if (score > rawScore[i])
      MPs += 1.;
    else if (score == rawScore[i])
      MPs += 0.5;
    count++;
  }

  assert(count > 0);
  return (scoreLookup[score] = (100.f * MPs) / count);
}


float Hand::GetMPBidding(
  const vector<int> rawScore,
  const unsigned no,
  const unsigned vul,
  const unsigned resMatrix[5][14],
  const float MPs)
{
  // This is analogous to GetIAFBidding for IAF scoring.
  // We compare to all other scores, not to the datum.

  float bidMP = 0.;
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

    bidMP += resMatrix[d][t] * GetMPOverall(rawScore, artifScore);
    count += resMatrix[d][t];
  }

  // Special case:  If we're the only ones to play in a denomination,
  // we somewhat arbitrarily assign the full score to the bidding.
  if (count == 0)
    return MPs;
  else
    return bidMP / count;

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

  vector<ValetEntryType> entries(2*numEntries);
  if (numEntries == 0)
    return entries;

  unsigned vno = 0;

  if (options.valet == VALET_IMPS)
  {
    int datum = Hand::GetDatum(rawScore);
    float bidIMPs, bidLeadIMPs, leadIMPs = 0.f;

    for (unsigned i = 0; i < numEntries; i++)
    {
      ValetEntryType& entryNS = entries[vno++];
      ValetEntryType& entryEW = entries[vno++];
      Hand::ResetValetEntry(entryNS);
      Hand::ResetValetEntry(entryEW);

      const ResultType& res = results[i];

      float butlerIMPs = static_cast<float>(
        CalculateIMPs(rawScore[i] - datum));

      if (res.level == 0)
        Hand::SetPassoutIMPs(res, butlerIMPs, entryNS, entryEW);
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

        Hand::SetPlayResultIMPs(res, butlerIMPs, bidIMPs, leadIMPs,
          entryNS, entryEW);
      }
    }
  }
  else if (options.valet == VALET_IMPS_ACROSS_FIELD)
  {
    scoreLookup.clear();
    float bidIAF, bidLeadIAF, leadIAF = 0.f;

    for (unsigned i = 0; i < numEntries; i++)
    {
      ValetEntryType& entryNS = entries[vno++];
      ValetEntryType& entryEW = entries[vno++];
      Hand::ResetValetEntry(entryNS);
      Hand::ResetValetEntry(entryEW);

      const ResultType& res = results[i];

      float IAFs = Hand::GetIAFOverall(rawScore, rawScore[i]);

      if (res.level == 0)
        Hand::SetPassoutIMPs(res, IAFs, entryNS, entryEW);
      else
      {
        bidIAF = GetIAFBidding(rawScore, i, vulList[i], 
          resDeclMatrix[res.declarer], IAFs);

        if (options.leadFlag && res.leadRank > 0)
        {
          bidLeadIAF = GetIAFBidding(rawScore, i, vulList[i], 
            resDeclLeadMatrix[res.declarer][res.leadDenom], IAFs);
          leadIAF = bidLeadIAF - bidIAF;
        }
        else
          leadIAF = 0.f;

        Hand::SetPlayResultIMPs(res, IAFs, bidIAF, leadIAF,
          entryNS, entryEW);
      }
    }
  }
  else if (options.valet == VALET_MATCHPOINTS)
  {
    scoreLookup.clear();
    float bidMP, bidLeadMP, leadMP = 0.f;

    for (unsigned i = 0; i < numEntries; i++)
    {
      ValetEntryType& entryNS = entries[vno++];
      ValetEntryType& entryEW = entries[vno++];
      Hand::ResetValetEntry(entryNS);
      Hand::ResetValetEntry(entryEW);

      const ResultType& res = results[i];

      float MPs = Hand::GetMPOverall(rawScore, rawScore[i]);

      if (res.level == 0)
        Hand::SetPassoutMatchpoints(res, MPs, entryNS, entryEW);
      else
      {
        bidMP = GetMPBidding(rawScore, i, vulList[i], 
          resDeclMatrix[res.declarer], MPs);

        if (options.leadFlag && res.leadRank > 0)
        {
          bidLeadMP = GetMPBidding(rawScore, i, vulList[i], 
            resDeclLeadMatrix[res.declarer][res.leadDenom], MPs);
          leadMP = bidLeadMP - bidMP;
        }
        else
          leadMP = 0.f;

        Hand::SetPlayResultMatchpoints(res, MPs, bidMP, leadMP,
          entryNS, entryEW);
      }
    }
  }
  else
    assert(false);

  return entries;
}

