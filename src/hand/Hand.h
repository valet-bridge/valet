/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_HAND_H
#define VALET_HAND_H

#include <vector>
#include <string>

using namespace std;

struct ScoreInput;
class Result;

class Hand;
// typedef int (Hand::*CompPtr)(const int score1, const int score2) const;

#define HAND_CHUNK_SIZE 16


class Hand
{
  private:

    vector<Result> results;

    unsigned numEntries;
    unsigned length;
    unsigned boardNo;
    unsigned vulNS;
    unsigned vulEW;


    // Vector methods

    float unweightedOverResultsDropScore(
      const int ownScore,
      const vector<int>& resultsScoreVector) const;

    float unweightedOverResultsDropIndex(
      const int ownScore,                     // one score
      const vector<int>& resultsScoreVector,  // all result
      const unsigned skipIndex) const;


    // More complex help methods

    float calcBiddingNoCloudIAF(
      const vector<int>& artifScoresVector,   // all tricks
      const vector<int>& resultsScoreVector,  // all results
      const vector<unsigned>& countVector,    // all tricks
      float defaultScore);
      
    float calcScoreCloudIAF(
      const int ownScore,
      const unsigned skipIndex,
      const vector<vector<int>>& artifScoresMatrix,
      const vector<vector<vector<unsigned>>>& countsDecl,
      float overallResult);
      
    float calcBiddingCloudIAF(
      const unsigned skipIndex,
      const vector<vector<int>>& artifScoresMatrix,
      const vector<unsigned>& countVector,
      const vector<vector<vector<unsigned>>>& countsDecl,
      float defaultScore);


    // Tabulations needed for the score calculations

    void tabulateCounts(
      vector<vector<vector<unsigned>>>& countsDecl,
      vector<vector<vector<vector<unsigned>>>>& countsDeclLead) const;

    void tabulateScores(
      vector<int>& ownScoreVector,
      vector<vector<int>>& ownArtifScoresVector) const;


    // Cloud datum scores needed for IMPs

    void calcCloudDatumScores(
      const vector<vector<int>>& artifScoresMatrix,
      const vector<vector<vector<unsigned>>>& countsDecl,
      const vector<vector<vector<vector<unsigned>>>>& countsDeclLead,
      vector<int>& cloudDatumScore,
      vector<int>& cloudDatumLeadScore);


    // Valet calculations for the four main cases

    // Overall method o2, bidding method b3
    void calcCloudIMP(
       const Result& result,
       const int ownScore,
       const vector<int>& cloudDatumScore,
       const vector<int>& cloudDatumLeadScore,
       const unsigned skipIndex,
       ScoreInput& entry) const;

    // Overall method o0, bidding method b1
    void calcNoCloudIMP(
       const Result& result,
       const int ownScore,
       const vector<int>& artifScoresVector,
       const int datum,
       const vector<unsigned>& countVectorDecl,
       const vector<unsigned>& countVectorDeclLead,
       ScoreInput& entry) const;

    // Overall method o3, bidding method b4
    void calcCloudIAF(
      const Result& result,
      const int ownScore,
      const vector<vector<int>>& artifScoresMatrix,
      const vector<unsigned>& countVectorDecl,
      const vector<unsigned>& countVectorDeclLead,
      const vector<vector<vector<unsigned>>>& countsDecl,
      const unsigned skipIndex,
      ScoreInput& entry);

    // Overall method o1, bidding method b1
    void calcNoCloudIAF(
      const Result& result,
      const int ownScore,
      const vector<int>& resultsScoreVector,
      const vector<int>& artifScoresVector,
      const vector<unsigned>& countVectorDecl,
      const vector<unsigned>& countVectorDeclLead,
      const unsigned skipIndex,
      ScoreInput& entry);
    


  public:

    Hand();

    void reset();

    int setBoardNumber(const unsigned boardNoIn);

    unsigned getBoardNumber();

    unsigned getNumEntries();

    void add(const Result& result);

    void calculateScores(vector<ScoreInput>& entries);
};

#endif
