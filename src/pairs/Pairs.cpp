/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#include <iostream>
#include <iomanip>
#include <sstream>
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


Pairs::~Pairs()
{
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
