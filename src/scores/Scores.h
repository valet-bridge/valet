/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_SCORES_H
#define VALET_SCORES_H

#include <string>
#include <vector>
#include <map>

#include "Score.h"

using namespace std;

enum TableEnum: unsigned;
enum SortingEnum: unsigned;

struct ScoreInput;


class Scores
{
  private:

    struct ScoreData
    {
      Score score;
      map<size_t, Score> oppScores;
    };

    vector<ScoreData> scoreData;


    void resize(const size_t index);

    bool onlySkips(const TableEnum ttype) const;

    string str(const TableEnum ttype) const;

  public:

    Scores();

    void clear();

    void add(const ScoreInput& entry);

    void scale();

    void compensate();

    void sort(const SortingEnum sort);

    string str() const;
};

#endif
