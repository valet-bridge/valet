/* 
   Valet, a bridge single-suit double-dummy quick-trick solver.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_ASPECT_H
#define VALET_ASPECT_H

#include <string>

#include "../misc.h"

using namespace std;

enum ScoringEnum: unsigned;


class Aspect
{
  private:

    unsigned num;

    float sum;

    float average;


  public:

    void incr(const float f);

    void decr(const float f);

    void operator += (const Aspect& a2);

    void operator -= (const Aspect& a2);

    bool empty() const;

    void scale(const ScoringEnum stype);

    void compensate(
      const Aspect& a2,
      const ScoringEnum stype);

    string str(const int prec) const;
};

#endif
