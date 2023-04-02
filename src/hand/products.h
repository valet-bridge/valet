/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_PRODUCTS_H
#define VALET_PRODUCTS_H

#include <vector>

using namespace std;

typedef int (*CompPtr)(const int score1, const int score2);


int scoreMP(
  const int score1,
  const int score2);

int scoreIMP(
  const int score1,
  const int score2);

int average(const vector<int>& scores);

int weightedAverage(
  const vector<int>& scores,
  const vector<unsigned>& countVector);

float weightedResultOverDatum(
  const vector<int>& artifScoreVector,    // all tricks
  const vector<unsigned>& countVector,    // all tricks
  const int datum);                       // one result

float weightedResultOverScores(
  const int ownScore,                     // one score
  const vector<int>& refScoreVector,      // all tricks
  const vector<unsigned>& countVector,    // all tricks
  const float defaultScore);

#endif
