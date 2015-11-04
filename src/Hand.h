/* 
   Valet, a bridge single-suit double-dummy quick-trick solver.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_HAND_H
#define VALET_HAND_H

#include <iostream>
#include <iomanip>
#include <string>
#include <vector>

using namespace std;

#include "cst.h"

#define HAND_CHUNK_SIZE 16


class Hand
{
  private:

    vector<ResultType> results;
    map<int, float> scoreLookup;

    unsigned numEntries;
    unsigned length;
    unsigned boardNo;
    unsigned vulNS;
    unsigned vulEW;

    void ResetValetEntry(
      ValetEntryType& entry);

    int GetDatum(
      const vector<int>& rawScore);

    float GetDatumBidding(
      const ResultType& res,
      const unsigned vul,
      const unsigned resMatrix[5][14],
      const int datum);

    float GetOverallScore(
      const vector<int> rawScore,
      const int score);

    float GetBiddingScore(
      const vector<int> rawScore,
      const unsigned no,
      const unsigned vul,
      const unsigned resMatrix[5][14],
      float overallResult);
      
    void SetPassout(
      const ResultType& res,
      const float totalIMPs,
      ValetEntryType& entryNS,
      ValetEntryType& entryEW);

    void SetPairSwaps(
      const ResultType& res,
      ValetEntryType& entryNS,
      ValetEntryType& entryEW,
      unsigned& decl,
      unsigned& leader);

    void SetPlayResult(
      const ResultType& res,
      const float totalIMPs,
      const float bidIMPs,
      const float leadIMPs,
      ValetEntryType& entryNS,
      ValetEntryType& entryEW);
      

  public:

    Hand();

    ~Hand();

    void Reset();

    unsigned GetNumEntries();

    int SetBoardNumber(
      const unsigned n);

    void AddResult(
      const ResultType& res);

    vector<ValetEntryType> CalculateScores();
};

#endif
