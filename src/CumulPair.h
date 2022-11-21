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
#include "cst.h"

class Pairs;
struct ValetEntryType;

enum ScoringEnum: unsigned;
enum SortingEnum: unsigned;


class CumulPair
{
  private:

    unsigned pairNo;

    vector<Aspect> aspects;

    string strOverall(
      const Pairs& pairs,
      const int prec) const;

    string strDetails(const int prec) const;

  public:

    CumulPair();

    void setPair(const unsigned pairNoIn);

    void incrDeclarer(const ValetEntryType& entry);
    void incrDefenders(const ValetEntryType& entry);

    void operator += (const CumulPair& c2);
    void operator -= (const CumulPair& c2);

    void scale();

    void compensate(const CumulPair& oppComp);

    float figure(const SortingEnum sort) const;

    bool skip(const TableEnum ttype) const;

    string strHeaderCSV() const;

    string strHeaderText1() const;
    string strHeaderText2() const;

    string strLine(
      const Pairs& pairs,
      const TableEnum ttype,
      const int prec) const;
};

#endif
