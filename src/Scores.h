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

    struct OppType
    {
      unsigned num[VALET_ENTRY_SIZE];
      float sum[VALET_ENTRY_SIZE];
    };

    struct OppCompType
    {
      float sum[VALET_ENTRY_SIZE];
    };


    vector<CumulPair> pairScores;
    vector<OppCompType> oppComp;

    typedef map<string, OppType> OppMapType;
    vector<OppMapType> oppScores;

    unsigned numPairs;
    unsigned length;

    OppType * PrepareCompensation(
      const unsigned pairNo,
      const unsigned oppNo);

    float Scale(
      const float value,
      const unsigned num) const;

    float ScaleMP(
      const float value,
      const unsigned num) const;

    void AddCompensation(
      const unsigned pairNo,
      const unsigned oppNo,
      const OppCompType& oppValues);

    bool PreparePrint(
      const unsigned mode,
      int& prec) const;

    bool SkipScore(
      const CumulPair& c,
      const unsigned mode) const;

    void PrintTextHeader() const;

    void PrintText(
      const unsigned mode) const;

    void PrintCSVHeader() const;

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
