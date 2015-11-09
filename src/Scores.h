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

    struct CumulType
    {
      unsigned pairNo;

      unsigned numHands;
      unsigned numPlay1;
      unsigned numPlay2;
      unsigned numDef;
      unsigned numLead1;
      unsigned numLead2;

      float overallCum;
      float bidCum;
      float play1Cum;
      float play2Cum;
      float lead1Cum;
      float lead2Cum;
      float defCum;

      float overall;
      float bid;
      float play1;
      float play2;
      float lead1;
      float lead2;
      float def;

      float play1perChance;
      float play2perChance;
      float lead1perChance;
      float lead2perChance;
      float defperChance;
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

    float ScaleMP(
      const float value,
      const unsigned num);

    void AddCompensation(
      const unsigned pairNo,
      const unsigned oppNo,
      const float value);

    double Difference(
      const CumulType& c1,
      const CumulType& c2,
      SortingType sort);

    bool PreparePrint(
      const unsigned mode,
      int& prec);

    bool SkipScore(
      const CumulType& c,
      const unsigned mode);

    void PrintTextPair(
      const float average,
      const unsigned no,
      const int prec);

    void PrintCSVPair(
      const float average,
      const unsigned no,
      const int prec,
      const string s);

    void PrintText(
      const unsigned mode);

    void PrintCSV(
      const unsigned mode);

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

    void Print();
};

#endif
