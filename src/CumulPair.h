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

enum FormatType: unsigned;
enum ScoringType: unsigned;
enum SortingType: unsigned;


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

class CumulPair
{
  private:

    unsigned pairNo;

    unsigned num[VALET_ENTRY_SIZE];
    float sum[VALET_ENTRY_SIZE];
    float avgTotal[VALET_ENTRY_SIZE];
    float avgPerChance[VALET_ENTRY_SIZE];

    vector<Aspect> aspects;

    float averagePlay() const;

    float averageDefense() const;

    float averageLead1() const;

    float averageLead2() const;

    float averageLead() const;

    float averageNonLead() const;

    string strOverall(
      const Pairs& pairs,
      const int prec,
      const FormatType format) const;

    string strDetails(
      const int prec,
      const FormatType format) const;

  public:

    CumulPair();

    void clear();

    void setPair(const unsigned pairNoIn);

    void incrDeclarer(const ValetEntryType& entry);
    void incrDefenders(const ValetEntryType& entry);

    void operator += (const CumulPair& c2);
    void operator -= (const CumulPair& c2);

    void scale(const ScoringType stype);

    void compensate(
      const CumulPair& oppComp,
      const ScoringType stype);

    float figure(const SortingType sort) const;

    bool skip(const TableType ttype) const;

    string strHeaderCSV() const;

    string strHeaderText1() const;
    string strHeaderText2() const;

    string strLine(
      const Pairs& pairs,
      const TableType ttype,
      const int prec,
      const FormatType format) const;
};

#endif
