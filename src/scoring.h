/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_SCORING_H
#define VALET_SCORING_H

void SetTables();

int CalculateRawScore(
  const ResultType& res,
  const unsigned vul);

int CalculateRawScore(
  const ResultType& res,
  const unsigned vul,
  const unsigned tricks);

void GetVul(
  const unsigned boardNo,
  unsigned& vulNS,
  unsigned& vulEW);

int CalculateIMPs(
  int rawScore);

int CalculateMPs(
  int rawScore);

#endif

