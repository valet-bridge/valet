/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_SCORING_H
#define VALET_SCORING_H

void setTables();

void getVul(
  const unsigned boardNo,
  unsigned& vulNS,
  unsigned& vulEW);

int calculateIMPs(int rawScore);

int calculateMPs(int rawScore);

#endif

