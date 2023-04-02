/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

// Score is a single line in the output Valet sheet (a single pair).


#ifndef VALET_SCORE_H
#define VALET_SCORE_H

#include <vector>
#include <string>

#include "Aspect.h"

struct ScoreInput;

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

    void incrDeclarer(const ScoreInput& entry);
    void incrDefenders(const ScoreInput& entry);

    void operator += (const Score& s2);
    void operator -= (const Score& s2);

    bool operator < (const Score& s2) const;

    void scale();

    void compensate(const Score& oppScore);

    unsigned getCount() const;

    float figure(const SortingEnum sort) const;

    bool skip(const TableEnum ttype) const;

    string strHeader() const;

    string strLine(
      const TableEnum ttype,
      const int prec) const;

    string strDeclarerHeaderTrunc() const;
    string strDeclarerHeader() const;

    string strDefenseHeaderTrunc() const;
    string strDefenseHeader() const;

    string strDeclarerLineTrunc() const;

    string strDeclarerLine(
      const string& key,
      const unsigned count) const;

    string strDefenseLineTrunc() const;

    string strDefenseLine(
      const string& key,
      const unsigned count) const;
};

#endif
