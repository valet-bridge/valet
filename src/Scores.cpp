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

#define SCORES_CHUNK_SIZE 16


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


Score& Scores::getCrossScore(
  const unsigned pairNo,
  const unsigned oppNo)
{
  const string oppstr = to_string(oppNo);

  OppMapType& oppMap = oppScores[pairNo];
  OppMapType::iterator it = oppMap.find(oppstr);

  return oppMap[oppstr];
}


void Scores::storeCrossCumul(const ValetEntryType& entry)
{
  // Remember the pairs who played in order to be able to compensate.
  Score& opp = Scores::getCrossScore(entry.pairNo, entry.oppNo);
  Score& pair = Scores::getCrossScore(entry.oppNo, entry.pairNo);

  Score oppCP;
  Score pairCP;

  // The entry always yields a declaring entry for us and a defending
  // entry for the other pair.
  oppCP.incrDefenders(entry);
  pairCP.incrDeclarer(entry);

  oppCP.scale();
  pairCP.scale();

  opp += oppCP;
  pair += pairCP;
}


void Scores::AddEntry(
  const ValetEntryType& entry)
{
  unsigned m = (entry.pairNo > entry.oppNo ? entry.pairNo : entry.oppNo);
  if (m >= length)
  {
    const unsigned numNewChunks = (m / SCORES_CHUNK_SIZE) + 1;
    const unsigned newScores = numNewChunks * SCORES_CHUNK_SIZE - length;

    length = numNewChunks * SCORES_CHUNK_SIZE;
    pairScores.resize(static_cast<size_t>(length));
    oppScores.resize(static_cast<size_t>(length));
    oppComp.resize(static_cast<size_t>(length));
  }

  Score& cDecl = pairScores[entry.pairNo];
  cDecl.setPair(entry.pairNo);
  cDecl.incrDeclarer(entry);

  // The overall and bidding scores have to be inverted.
  // The detailed scores have already been inverted.

  Score& cDef = pairScores[entry.oppNo];
  cDef.setPair(entry.oppNo);
  cDef.incrDefenders(entry);

  Scores::storeCrossCumul(entry);
}


void Scores::scale()
{
  for (unsigned pno = 1; pno < length; pno++)
    pairScores[pno].scale();
}


void Scores::calcCompensation()
{
  // Compensate for the average strength of opponents, ignoring
  // each opponent's results against us.

  typedef OppMapType::iterator it_type;
  char *pend;

  for (unsigned pno = 1; pno < length; pno++)
  {
    Score oppResults;

    OppMapType& oppMap = oppScores[pno];

    for (it_type it = oppMap.begin(); it != oppMap.end(); it++)
    {
      unsigned oppNo = static_cast<unsigned>(
        strtol(it->first.c_str(), &pend, 10));
      assert(oppNo > 0 && oppNo < length);

      // Add each opponent, then subtract out or own results against them.
      oppResults += pairScores[oppNo];
      oppResults -= it->second;
    }

    oppComp[pno] = oppResults;
    oppComp[pno].scale();
  }
}


void Scores::compensate()
{
  assert(options.compensateFlag);

  Scores::calcCompensation();

  for (unsigned pno = 1; pno < length; pno++)
    pairScores[pno].compensate(oppComp[pno]);
}


void Scores::sort(const SortingEnum stype)
{
  ::sort(next(pairScores.begin()), pairScores.end(),
    [stype](const Score& c1, const Score& c2)
    {
      return c1.figure(stype) > c2.figure(stype);
    });
}


bool Scores::onlySkips(const TableEnum ttype) const
{
  for (unsigned pno = 1; pno < length; pno++)
    if (! pairScores[pno].skip(ttype))
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
  ss << pairScores[0].strHeader();

  const int prec = (options.valet == VALET_MATCHPOINTS ? 1 : 2);

  for (unsigned pno = 1; pno < length; pno++)
    ss << pairScores[pno].strLine(pairs, ttype, prec);

  ss << "\n";
  
  return ss.str();
}


string Scores::str() const
{
  return 
    Scores::str(VALET_TABLE_MANY) + 
    Scores::str(VALET_TABLE_FEW);
}
