/* 
   Valet, a bridge single-suit double-dummy quick-trick solver.

   Copyright (C) 2015-23 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_CUMUL_PAIR_H
#define VALET_CUMUL_PAIR_H

#include <string>
#include <vector>

using namespace std;

#include "cst.h"

enum CumulEnum
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

struct CumulPair
{
  unsigned pairNo;

  unsigned num[VALET_ENTRY_SIZE];
  float sum[VALET_ENTRY_SIZE];
  float avgTotal[VALET_ENTRY_SIZE];
  float avgPerChance[VALET_ENTRY_SIZE];

  float averagePlay() const;

  float averageDefense() const;

  float averageLead1() const;

  float averageLead2() const;

  float averageLead() const;

  float averageNonLead() const;

  string strOverall(
    const int prec,
    const FormatType format) const;

  string strDetails(
    const int prec,
    const FormatType format) const;
};

#endif
