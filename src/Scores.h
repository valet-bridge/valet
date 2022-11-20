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

enum FormatType: unsigned;
enum TableauType: unsigned;

class Scores
{
  private:

    vector<CumulPair> pairScores;
    vector<CumulPair> oppComp;

    typedef map<string, CumulPair> OppMapType;
    vector<OppMapType> oppScores;

    unsigned numPairs;
    unsigned length;

    CumulPair * PrepareCompensation(
      const unsigned pairNo,
      const unsigned oppNo);

    void AddCompensation(
      const unsigned pairNo,
      const unsigned oppNo,
      const CumulPair& oppValues);

    bool PreparePrint(
      const unsigned mode,
      int& prec) const;

    string strHeader(const FormatType format) const;

    string str(const TableauType ttype) const;

  public:

    Scores();

    ~Scores();

    void Reset();

    void AddEntry(
      const ValetEntryType& entry);

    void Compensate();

    void Normalize();

    void Sort(const SortingType sort);

    string str() const;

};

#endif
