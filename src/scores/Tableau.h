/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_TABLEAU_H
#define VALET_TABLEAU_H

#include <map>
#include <vector>
#include <string>

#include "Score.h"

using namespace std;

struct ScoreInput;


class Tableau
{
  private:

    map<string, Score> declarerNS, declarerEW;
    map<string, Score> defendersNS, defendersEW;

    vector<vector<unsigned>> levelStats;
    vector<vector<unsigned>> strainStats;

    string strLevels() const;

    string strStrains() const;

    string strMap(
      const map<string, Score>& scoreMap,
      const bool declarerFlag) const;

  public:

    Tableau();

    void add(const vector<ScoreInput>& entries);

    void scale();

    bool slammish() const;

    string str(const string& boardTag) const;
};

#endif
