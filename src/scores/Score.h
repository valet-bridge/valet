/* 
   Valet, a bridge single-suit double-dummy quick-trick solver.

   Copyright (C) 2015-23 by Soren Hein.

   See LICENSE and README.
*/

// Score is a single line in the output Valet sheet (a single pair).


#ifndef VALET_SCORE_H
#define VALET_SCORE_H

#include <vector>
#include <string>

#include "Aspect.h"

struct ValetEntryType;

enum SortingEnum: unsigned;
enum TableEnum: unsigned;


class Score
{
  private:

    unsigned pairNo;

    vector<Aspect> aspects;

    string strHeaderCSV() const;

    string strHeaderText1() const;
    string strHeaderText2() const;

    string strOverall(const int prec) const;
    string strDetails(const int prec) const;

  public:

    Score();

    void setPair(const unsigned pairNoIn);

    void incrDeclarer(const ValetEntryType& entry);
    void incrDefenders(const ValetEntryType& entry);

    void operator += (const Score& s2);
    void operator -= (const Score& s2);

    void scale();

    void compensate(const Score& oppScore);

    float figure(const SortingEnum sort) const;

    bool skip(const TableEnum ttype) const;

    string strHeader() const;

    string strLine(
      const TableEnum ttype,
      const int prec) const;
};

#endif
