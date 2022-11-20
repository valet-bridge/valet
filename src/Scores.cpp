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

  for (auto& p: pairScores)
    p.clear();
}


CumulPair& Scores::getCrossCumulPair(
  const unsigned pairNo,
  const unsigned oppNo)
{
  const string oppstr = to_string(oppNo);

  OppMapType& oppMap = oppScores[pairNo];
  OppMapType::iterator it = oppMap.find(oppstr);

  if (it == oppMap.end())
    oppMap[oppstr].clear();

  return oppMap[oppstr];
}


void Scores::storeCrossCumul(const ValetEntryType& entry)
{
  // Remember the pairs who played in order to be able to compensate.
  CumulPair& opp = Scores::getCrossCumulPair(entry.pairNo, entry.oppNo);
  CumulPair& pair = Scores::getCrossCumulPair(entry.oppNo, entry.pairNo);

  CumulPair oppCP;
  CumulPair pairCP;

  oppCP.clear();
  pairCP.clear();

  // The entry always yields a declaring entry for us and a defending
  // entry for the other pair.
  oppCP.incrDefenders(entry);
  pairCP.incrDeclarer(entry);

  oppCP.scale(options.valet);
  pairCP.scale(options.valet);

  opp += oppCP;
  pair += pairCP;
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

  Scores::storeCrossCumul(entry);
}


void Scores::Compensate()
{
  // Compensate for the average strength of opponents, ignoring
  // each opponent's results against us.

  typedef OppMapType::iterator it_type;
  char *pend;

  for (unsigned pno = 1; pno < length; pno++)
  {
    CumulPair oppResults;
    oppResults.clear();

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
    oppComp[pno].scale(options.valet);
  }
}


void Scores::Normalize()
{
  for (unsigned pno = 1; pno < length; pno++)
  {
    CumulPair& c = pairScores[pno];

    c.scale(options.valet);

    if (options.compensateFlag)
      c.compensate(oppComp[pno], options.valet);
  }
}


void Scores::Sort(
  const SortingType stype)
{
  sort(next(pairScores.begin()), pairScores.end(),
    [stype](const CumulPair& c1, const CumulPair& c2)
    {
      return c1.figure(stype) > c2.figure(stype);
    });
}


bool Scores::PreparePrint(
  const TableType ttype,
  int& prec) const
{
  if (ttype == VALET_TABLE_FEW && options.minHands == 0)
    return false;

  bool flag = false;
  for (unsigned pno = 1; pno < length && ! flag; pno++)
  {
    const CumulPair& c = pairScores[pno];
    if (! c.skip(ttype))
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


string Scores::strHeader(const FormatType format) const
{
  stringstream ss;

  CumulPair c;

  // TODO Put players str into Pairs and pass Pairs to c

  if (format == VALET_FORMAT_TEXT)
  {
    ss << 
      setw(54) << "" << " | " <<
      c.strHeaderText1() << "\n" <<
      setw(54) << left << "Players" << right << " | " <<
      c.strHeaderText2() << "\n";
  }
  else if (format == VALET_FORMAT_CSV)
  {
    ss << "Players" << options.separator << c.strHeaderCSV() << "\n";
  }
  else
    assert(false);
  
  return ss.str();
}


string Scores::str(const TableType ttype) const
{
  stringstream ss;

  int prec;
  if (! Scores::PreparePrint(ttype, prec))
    return "";

  ss << Scores::strHeader(options.format);

  for (unsigned pno = 1; pno < length; pno++)
    ss << pairScores[pno].strLine(pairs, ttype, prec, options.format);

  ss << "\n";
  
  return ss.str();
}


string Scores::str() const
{
  return 
    Scores::str(VALET_TABLE_MANY) + 
    Scores::str(VALET_TABLE_FEW);
}
