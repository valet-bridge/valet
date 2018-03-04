/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/



#include <assert.h>

#include <iostream>
#include <string>

using namespace std;

#include "Pairs.h"

#define PAIRS_CHUNK_SIZE 32


Pairs::Pairs()
{
  Pairs::Reset();
}


Pairs::~Pairs()
{
}


void Pairs::Reset()
{
  tagToPlayerName.clear();
  playersToPairNo.clear();
  pairNoToPairName.clear();
  pairNoToPairTags.clear();
  pairNoToPairName.resize(PAIRS_CHUNK_SIZE);
  pairNoToPairTags.resize(PAIRS_CHUNK_SIZE);
  numPairs = 0;
  listNo = PAIRS_CHUNK_SIZE;
}


bool Pairs::TagExists(
  const string& tag)
{
  map<string, string>::iterator it = tagToPlayerName.find(tag);
  return (it != tagToPlayerName.end());
}


bool Pairs::AddPlayer(
  const string& tag,
  const string& name)
{
  // Don't reassign a name.
  if (Pairs::TagExists(tag))
    return false;
  else
  {
    tagToPlayerName[tag] = name;
    return true;
  }
}


string Pairs::GetPlayerName(
  const string& tag)
{
  if (Pairs::TagExists(tag))
    return tagToPlayerName[tag];
  else
  {
    return "";
  }
}


bool Pairs::PairExists(
  const string& pair)
{
  map<string, unsigned>::iterator it = playersToPairNo.find(pair);
  return (it != playersToPairNo.end());
}


int Pairs::GetPairNumber(
  const string& tag1,
  const string& tag2)
{
  if (! TagExists(tag1) || ! TagExists(tag2))
    return 0;

  int retval;
  string tag = (tag1 < tag2 ? tag1+"|"+tag2 : tag2+"|"+tag1);

  if (Pairs::PairExists(tag))
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
    pairNoToPairName[numPairs] = Pairs::GetPairName(tag1, tag2);
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

  if (tag1 < tag2)
    return retval;
  else
    return -retval;
}


string Pairs::GetPairName(
  const string& tag1,
  const string& tag2)
{
  if (! TagExists(tag1) || ! TagExists(tag2))
    return 0;

  if (tag1 < tag2)
  {
    if (Pairs::PairExists(tag1+"|"+tag2))
      return tagToPlayerName[tag1] + " - " + tagToPlayerName[tag2];
    else
      return "";
  }
  else
  {
    if (Pairs::PairExists(tag2+"|"+tag1))
      return tagToPlayerName[tag2] + " - " + tagToPlayerName[tag1];
    else
      return "";
  }
}


string Pairs::GetPairName(
  const unsigned pno)
{
  assert(pno < listNo);
  return pairNoToPairName[pno];
}


void Pairs::GetPairTags(
  const unsigned pno,
  string& tag1,
  string& tag2)
{
  assert(pno > 0);
  tag1 = pairNoToPairTags[pno].tag1;
  tag2 = pairNoToPairTags[pno].tag2;
}


string Pairs::GetPairNamePadded(
  const unsigned pno,
  const unsigned width)
{
  assert(pno < listNo);
  return Pairs::PadString(pairNoToPairName[pno], width);
}


string Pairs::PadString(
  const string& s,
  const unsigned width)
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
