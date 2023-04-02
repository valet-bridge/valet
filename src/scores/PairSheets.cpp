/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-23 by Soren Hein.

   See LICENSE and README.
*/



#include <iostream>
#include <iomanip>
#include <sstream>
#include <cassert>

#include "PairSheets.h"
#include "ScoreInput.h"
#include "Score.h"

#include "../pairs/Pairs.h"
#include "../pairs/Players.h"

extern Pairs pairs;
extern Players players;


using namespace std;

#define SHEETS_CHUNK_SIZE 16


PairSheets::PairSheets()
{
  PairSheets::clear();
}


void PairSheets::clear()
{
  pairData.clear();
  pairData.resize(SHEETS_CHUNK_SIZE);
}


void PairSheets::resize(const size_t index)
{
  if (index < pairData.size())
    return;

  const size_t length = ((index / SHEETS_CHUNK_SIZE) + 1) * 
    SHEETS_CHUNK_SIZE;

  pairData.resize(length);
}


void PairSheets::add(
  const string& boardTag,
  const ScoreInput& entry)
{
  PairSheets::resize(max(entry.pairNo, entry.oppNo));

  // The entry always yields a declaring entry for us and a defending
  // entry for the other pair.
  Score ownScore;
  ownScore.incrDeclarer(entry);
  ownScore.scale();

  Score oppScore;
  oppScore.incrDefenders(entry);
  oppScore.scale();

  auto& pdata1 = pairData[entry.pairNo];
  pdata1.declarer.emplace_back(PairLine());
  auto& pdecl = pdata1.declarer.back();

  pdecl.boardTag = boardTag;
  pdecl.keyResult = entry.keyResult;
  pdecl.line = ownScore.strDeclarerLineTrunc();

  auto& pdata2 = pairData[entry.oppNo];
  pdata2.defense.emplace_back(PairLine());
  auto& pdef = pdata2.defense.back();

  pdef.boardTag = boardTag;
  pdef.keyResult = entry.keyResult;
  pdef.line = oppScore.strDefenseLineTrunc();
}


void PairSheets::sort()
{
  for (auto& pdata: pairData)
  {
    pdata.declarer.sort();
    pdata.defense.sort();
  }
}


string PairSheets::str() const
{
  stringstream ss;
  Score score;

  for (unsigned pno = 0; pno < pairData.size(); pno++)
  {
    auto& pdata = pairData[pno];
    if (pdata.empty())
      continue;

    string player1, player2;
    pairs.getPairTags(pno, player1, player2);
    string pname = "PAIR " + 
      players.getName(player1) + " - " + 
      players.getName(player2);
    
    ss << pname << "\n";
    ss << string(pname.size(), '=') << "\n\n";

    if (! pdata.declarer.empty())
    {
      ss << "AS DECLARER\n\n";
      ss << 
        setw(6) << right << "Board" <<
        "  " <<
        left << setw(16) << "Contract" <<
        score.strDeclarerHeaderTrunc();

      for (auto& decl: pdata.declarer)
      {
        ss <<
          setw(6) << right << decl.boardTag <<
          "  " <<
          setw(16) << left << decl.keyResult <<
          decl.line;
      }
      ss << "\n";
    }

    if (! pdata.defense.empty())
    {
      ss << "AS DEFENDERS\n\n";
      ss << 
        setw(6) << right << "Board" <<
        "  " <<
        left << setw(16) << "Contract" <<
        score.strDefenseHeaderTrunc();

      for (auto& def: pdata.defense)
      {
        ss <<
          setw(6) << right << def.boardTag <<
          "  " <<
          setw(16) << left << def.keyResult <<
          def.line;
      }
      ss << "\n";
    }
  }
  
  return ss.str();
}

