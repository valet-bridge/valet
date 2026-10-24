/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#include <iostream>
#include <iomanip>
#include <sstream>
#include <array>
#include <string>
#include <cassert>

#include "Pairs.h"
#include "Players.h"

extern Players players;
extern Options options;

#define PAIRS_CHUNK_SIZE 32


Pairs::Pairs()
{
  Pairs::reset();
}


void Pairs::reset()
{
  playersToPairNo.clear();
  pairNoToPairName.clear();
  pairNoToPairTags.clear();
  pairNoToPairName.resize(PAIRS_CHUNK_SIZE);
  pairNoToPairTags.resize(PAIRS_CHUNK_SIZE);
  numPairs = 0;
  listNo = PAIRS_CHUNK_SIZE;
  individualFlag = false;
  pairsToIndividuals.clear();
}


unsigned Pairs::size() const
{
  return numPairs;
}


bool Pairs::pairExists(const string& pair) const
{
  const auto it = playersToPairNo.find(pair);
  return (it != playersToPairNo.end());
}


void Pairs::getPairData(
  const string& tag1,
  const string& tag2,
  PairData& pairData)
{
  if (! players.exists(tag1) || ! players.exists(tag2))
  {
    pairData.foundFlag = false;
    pairData.flipFlag = false;
    pairData.number = numeric_limits<unsigned>::max();
    return;
  }

  int retval;
  string tag = (tag1 < tag2 ? tag1+"|"+tag2 : tag2+"|"+tag1);

  if (Pairs::pairExists(tag))
    retval = static_cast<int>(playersToPairNo[tag]);
  else
  {
    numPairs++;
    if (numPairs >= listNo)
    {
      unsigned numNewChunks = (numPairs / PAIRS_CHUNK_SIZE) + 1;
      listNo = numNewChunks * PAIRS_CHUNK_SIZE;
      pairNoToPairName.resize(listNo);
      pairNoToPairTags.resize(listNo);
    }
    playersToPairNo[tag] = numPairs;
    pairNoToPairName[numPairs] = Pairs::getPairName(tag1, tag2);
    if (tag1 < tag2)
    {
      pairNoToPairTags[numPairs].tag1 = tag1;
      pairNoToPairTags[numPairs].tag2 = tag2;
    }
    else
    {
      pairNoToPairTags[numPairs].tag1 = tag2;
      pairNoToPairTags[numPairs].tag2 = tag1;
    }
    retval = static_cast<int>(numPairs);
  }

  pairData.foundFlag = true;
  pairData.flipFlag = ! (tag1 < tag2);
  pairData.number = retval;
}


void Pairs::getIndividualData(
  const string& tag0,
  PairData& pairData)
{
  // The pair has a generic second player.

  if (! players.exists(tag0))
  {
    pairData.foundFlag = false;
    pairData.flipFlag = false;
    pairData.number = numeric_limits<unsigned>::max();
    return;
  }

  int retval;
  string tag = tag0 + "|" + INDIVIDUAL_PARTNER;

  if (Pairs::pairExists(tag))
    retval = static_cast<int>(playersToPairNo[tag]);
  else
  {
    numPairs++;
    if (numPairs >= listNo)
    {
      unsigned numNewChunks = (numPairs / PAIRS_CHUNK_SIZE) + 1;
      listNo = numNewChunks * PAIRS_CHUNK_SIZE;
      pairNoToPairName.resize(listNo);
      pairNoToPairTags.resize(listNo);
    }
    playersToPairNo[tag] = numPairs;
    pairNoToPairName[numPairs] = players.getName(tag0) + " - " +
      INDIVIDUAL_PARTNER;

    pairNoToPairTags[numPairs].tag1 = tag0;
    pairNoToPairTags[numPairs].tag2 = INDIVIDUAL_PARTNER;

    retval = static_cast<int>(numPairs);
  }

  pairData.foundFlag = true;
  pairData.flipFlag = false;
  pairData.number = retval;
}


string Pairs::getPairName(
  const string& tag1,
  const string& tag2)  const
{
  if (! players.exists(tag1) || ! players.exists(tag2))
    return "";

  if (tag1 < tag2)
  {
    if (Pairs::pairExists(tag1+"|"+tag2))
      return players.getName(tag1) + " - " + players.getName(tag2);
    else
      return "";
  }
  else
  {
    if (Pairs::pairExists(tag2+"|"+tag1))
      return players.getName(tag2) + " - " + players.getName(tag1);
    else
      return "";
  }
}


void Pairs::turnIntoIndividuals(const Pairs& realPairs)
{
  // The zero'th element is not used.
  Players pp;
  pp.pno1 = pp.pno2 = 0;
  pairsToIndividuals.push_back(pp);

  for (unsigned n = 1; n <= realPairs.numPairs; n++)
  {
    const auto& pairTags = realPairs.pairNoToPairTags[n];
    array<string, 2> pl = {pairTags.tag1, pairTags.tag2};

    unsigned pc = 0;

    for (const string& tag: pl)
    {
      // There will be duplicates in an individual, but getPairData
      // takes care not to create duplicate individuals.
      PairData pd;
      Pairs::getIndividualData(tag, pd);

      if (pc == 0)
      {
        pp.pno1 = pd.number;
        pc++;
      }
      else
      {
        pp.pno2 = pd.number;
      }
    }

    pairsToIndividuals.push_back(pp);
  }

  individualFlag = true;
}


void Pairs::individualLookup(
  const unsigned pno,
  unsigned& pno1,
  unsigned& pno2) const
{
  assert(pno >= 1 && pno < pairsToIndividuals.size());

  pno1 = pairsToIndividuals[pno].pno1;
  pno2 = pairsToIndividuals[pno].pno2;
}


void Pairs::getPairTags(
  const unsigned pno,
  string& tag1,
  string& tag2)
{
  assert(pno > 0);
  tag1 = pairNoToPairTags[pno].tag1;
  tag2 = pairNoToPairTags[pno].tag2;
}


string Pairs::getPairName(
  const unsigned pno,
  const unsigned width) const
{
  assert(pno < listNo);
  if (options.format == VALET_FORMAT_TEXT)
  {
    stringstream ss;
    ss << left << Pairs::padString(pairNoToPairName[pno], width) << right;
    return ss.str();
  }
  else if (options.format == VALET_FORMAT_CSV)
  {
    return pairNoToPairName[pno] + options.separator;
  }
  else
  {
    assert(false);
    return "";
  }
}


string Pairs::padString(
  const string& s,
  const unsigned width) const
{
  // Some foreign characters take up 2 chars but print as 1.
  // So we pad some spaces at the end.

  int padNo = static_cast<int>(width) - static_cast<int>(s.size());
  for (unsigned i = 0; i < s.size(); i++)
  {
    if (i > 0 && 
      static_cast<int>(s[i]) < 0 &&
      static_cast<int>(s[i-1]) < 0)
    {
      i++;
      padNo++;
    }
  }

  if (padNo > 0)
  {
    string pad(static_cast<unsigned>(padNo), ' ');
    return (s+pad);
  }
  else
    return s;
}
