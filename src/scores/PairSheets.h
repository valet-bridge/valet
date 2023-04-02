/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_PAIRSHEETS_H
#define VALET_PAIRSHEETS_H

#include <string>
#include <vector>
#include <list>

#include "../inputs/parse.h"

using namespace std;

struct ScoreInput;


class PairSheets
{
  private:

    struct PairLine
    {
      string boardTag;
      string keyResult;
      string line;

      bool operator < (const PairLine& pl2) const
      {
        return lessByBoard(boardTag, pl2.boardTag);
      };
    };

    struct PairScores
    {
      list<PairLine> declarer;
      list<PairLine> defense;

      bool empty() const
      {
        return (declarer.empty() && defense.empty());
      };
    };

    vector<PairScores> pairData;


    void resize(const size_t index);

  public:

    PairSheets();

    void clear();

    void add(
      const string& boardTag,
      const ScoreInput& entry);

    void sort();

    string str() const;
};

#endif
