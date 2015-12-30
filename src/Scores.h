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

#include "cst.h"

#define SCORES_CHUNK_SIZE 16


class Scores
{
  private:

    enum CumulEntryType
    {
      VALET_OVERALL = 0,
      VALET_BID = 1,
      VALET_PLAY1 = 2,
      VALET_PLAY2 = 3,
      VALET_LEAD1 = 4,
      VALET_LEAD2 = 5,
      VALET_DEF = 6,
      VALET_ENTRY_SIZE = 7
    };

    struct CumulType
    {
      unsigned pairNo;

      unsigned num[VALET_ENTRY_SIZE];
      float sum[VALET_ENTRY_SIZE];
      float avgTotal[VALET_ENTRY_SIZE];
      float avgPerChance[VALET_ENTRY_SIZE];
    };

    struct OppType
    {
      float cumul;
      unsigned count;
    };


    vector<CumulType> pairScores;
    vector<float> oppComp;

    typedef map<string, OppType> OppMapType;
    vector<OppMapType> oppScores;

    unsigned numPairs;
    unsigned length;

    float Scale(
      const float value,
      const unsigned num) const;

    float ScaleMP(
      const float value,
      const unsigned num) const;

    void AddCompensation(
      const unsigned pairNo,
      const unsigned oppNo,
      const float value);

    double Difference(
      const CumulType& c1,
      const CumulType& c2,
      SortingType sort) const;

    bool PreparePrint(
      const unsigned mode,
      int& prec) const;

    bool SkipScore(
      const CumulType& c,
      const unsigned mode) const;

    void PrintTextPair(
      const float average,
      const unsigned no,
      const int prec) const;

    void PrintCSVPair(
      const float average,
      const unsigned no,
      const int prec,
      const string s) const;

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
