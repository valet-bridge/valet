/* 
   Valet, a bridge single-suit double-dummy quick-trick solver.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_SCORES_H
#define VALET_SCORES_H

#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
#include <map>

using namespace std;

#include "CumulPair.h"
#include "cst.h"

extern OptionsType options;

#define SCORES_CHUNK_SIZE 16


class Scores
{
  private:

    /*
    struct OppCompType
    {
      float sum[VALET_ENTRY_SIZE];
    };
    */


    vector<CumulPair> pairScores;
    vector<CumulPair> oppComp;

    typedef map<string, CumulPair> OppMapType;
    vector<OppMapType> oppScores;

    unsigned numPairs;
    unsigned length;

    CumulPair * PrepareCompensation(
      const unsigned pairNo,
      const unsigned oppNo);

    /*
    float Scale(
      const float value,
      const unsigned num) const;

    float ScaleMP(
      const float value,
      const unsigned num) const;
      */

    void AddCompensation(
      const unsigned pairNo,
      const unsigned oppNo,
      const CumulPair& oppValues);

    bool PreparePrint(
      const unsigned mode,
      int& prec) const;

    void PrintText(
      const unsigned mode) const;

    string strHeader(const FormatType format) const;

    void PrintCSV(
      const unsigned mode) const;

  public:

    Scores();

    ~Scores();

    void Reset();

    void AddEntry(
      const ValetEntryType& entry);

    void Compensate();

    void Normalize();

    void Sort(
      const SortingType sort);

    void Print() const;
};

#endif
