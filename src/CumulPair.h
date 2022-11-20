/* 
   Valet, a bridge single-suit double-dummy quick-trick solver.

   Copyright (C) 2015-23 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_CUMUL_PAIR_H
#define VALET_CUMUL_PAIR_H

#include <vector>
#include <string>

#include "scores/Aspect.h"

class Pairs;
struct ValetEntryType;

enum FormatEnum: unsigned;
enum ScoringEnum: unsigned;
enum SortingEnum: unsigned;


enum CumulEnum
{
  VALET_OVERALL = 0,
  VALET_BID = 1,
  VALET_PLAY_SUM = 2,
  VALET_PLAY1 = 3,
  VALET_PLAY2 = 4,
  VALET_LEAD_SUM = 5,
  VALET_LEAD1 = 6,
  VALET_LEAD2 = 7,
  VALET_DEF_SUM = 8,
  VALET_DEF = 9,
  VALET_ENTRY_SIZE = 10
};

class CumulPair
{
  private:

    unsigned pairNo;

    unsigned num[VALET_ENTRY_SIZE];
    float sum[VALET_ENTRY_SIZE];
    float avgPerChance[VALET_ENTRY_SIZE];

    vector<Aspect> aspects;

    float averageDefense() const;

    string strOverall(
      const Pairs& pairs,
      const int prec,
      const FormatEnum format) const;

    string strDetails(
      const int prec,
      const FormatEnum format) const;

  public:

    CumulPair();

    void clear();

    void setPair(const unsigned pairNoIn);

    void incrDeclarer(const ValetEntryType& entry);
    void incrDefenders(const ValetEntryType& entry);

    void operator += (const CumulPair& c2);
    void operator -= (const CumulPair& c2);

    void scale(const ScoringEnum stype);

    void compensate(
      const CumulPair& oppComp,
      const ScoringEnum stype);

    float figure(const SortingEnum sort) const;

    bool skip(const TableEnum ttype) const;

    string strHeaderCSV() const;

    string strHeaderText1() const;
    string strHeaderText2() const;

    string strLine(
      const Pairs& pairs,
      const TableEnum ttype,
      const int prec,
      const FormatEnum format) const;
};

#endif
