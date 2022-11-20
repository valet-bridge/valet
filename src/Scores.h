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

      float averagePlay() const
      {
        const float n1 = static_cast<float>(num[VALET_PLAY1]);
        const float n2 = static_cast<float>(num[VALET_PLAY2]);
        const float n = n1 + n2;
        if (n > 0)
        {
          return (avgPerChance[VALET_PLAY1] * n1 +
            avgPerChance[VALET_PLAY2] * n2) / n;
        }
        else
          return 0.;
      };

      float averageDefense() const
      {
        const float n1 = static_cast<float>(num[VALET_PLAY1]);
        const float n2 = static_cast<float>(num[VALET_PLAY2]);
        const float n3 = static_cast<float>(num[VALET_DEF]);
        const float n = n1 + n2 + n3;
        if (n > 0)
        {
          // TODO Not convinced that this is the only place 
          // that this needs to show up...
          const float offsetMP =
            (options.valet == VALET_MATCHPOINTS ? 50.f : 0.f);

          return -offsetMP +
            (avgPerChance[VALET_LEAD1] * n1 +
             avgPerChance[VALET_LEAD2] * n2 +
             avgPerChance[VALET_DEF] * n3) / n3;
        }
        else
          return 0.;
      };

      float averageLead1() const
      {
        return avgPerChance[VALET_LEAD1];
      };

      float averageLead2() const
      {
        return avgPerChance[VALET_LEAD2];
      };

      float averageLead() const
      {
        const float n1 = static_cast<float>(num[VALET_LEAD1]);
        const float n2 = static_cast<float>(num[VALET_LEAD2]);
        const float n3 = static_cast<float>(num[VALET_PLAY1]);
        const float n4 = static_cast<float>(num[VALET_PLAY2]);
        const float n = n3 + n4;
        if (n > 0)
        {
          return (avgPerChance[VALET_LEAD1] * n1 +
            avgPerChance[VALET_LEAD2] * n2) / n;
        }
        else
          return 0.;
      };

      float averageNonLead() const
      {
        return avgPerChance[VALET_DEF];
      };
    };
    */

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

    double Difference(
      const CumulPair& c1,
      const CumulPair& c2,
      SortingType sort) const;

    bool PreparePrint(
      const unsigned mode,
      int& prec) const;

    bool SkipScore(
      const CumulPair& c,
      const unsigned mode) const;

    /*
    void PrintTextPair(
      const float average,
      const unsigned no,
      const int prec) const;

    void PrintCSVPair(
      const float average,
      const unsigned no,
      const int prec,
      const string& s) const;
      */

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
