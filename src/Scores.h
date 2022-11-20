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

using namespace std;

#include "CumulPair.h"

enum FormatEnum: unsigned;
enum TableEnum: unsigned;

class Scores
{
  private:

    vector<CumulPair> pairScores;
    vector<CumulPair> oppComp;

    typedef map<string, CumulPair> OppMapType;
    vector<OppMapType> oppScores;

    unsigned numPairs;
    unsigned length;

    CumulPair& getCrossCumulPair(
      const unsigned pairNo,
      const unsigned oppNo);

    void storeCrossCumul(const ValetEntryType& entry);

    bool PreparePrint(
      const TableEnum ttype,
      int& prec) const;

    string strHeader(const FormatEnum format) const;

    string str(const TableEnum ttype) const;

  public:

    Scores();

    ~Scores();

    void Reset();

    void AddEntry(const ValetEntryType& entry);

    void Compensate();

    void Normalize();

    void Sort(const SortingEnum sort);

    string str() const;

};

#endif
