/* 
   Valet, a bridge single-suit double-dummy quick-trick solver.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_SCORES_H
#define VALET_SCORES_H

#include <string>
#include <vector>
#include <map>

#include "scores/Score.h"

using namespace std;

enum TableEnum: unsigned;
enum SortingEnum: unsigned;

struct ValetEntryType;


class Scores
{
  private:

    vector<Score> pairScores;
    vector<Score> oppComp;

    typedef map<string, Score> OppMapType;
    vector<OppMapType> oppScores;

    unsigned numPairs;
    unsigned length;

    Score& getCrossScore(
      const unsigned pairNo,
      const unsigned oppNo);

    void storeCrossCumul(const ValetEntryType& entry);

    void calcCompensation();

    bool onlySkips(const TableEnum ttype) const;

    string str(const TableEnum ttype) const;

  public:

    Scores();

    ~Scores();

    void Reset();

    void AddEntry(const ValetEntryType& entry);

    void scale();

    void compensate();

    void sort(const SortingEnum sort);

    string str() const;

};

#endif
