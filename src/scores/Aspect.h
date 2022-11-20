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

enum SortingType: unsigned;


class Aspect
{
  private:

    unsigned num;

    float sum;


  public:

    void incr(const float f)
    {
      num++;
      sum += f;
    };

    void decr(const float f)
    {
      num++;
      sum -= f;
    };

    void operator += (const Aspect& a2)
    {
      num += a2.num;
      sum += a2.sum;
    };

    void operator -= (const Aspect& a2)
    {
      num -= a2.num;
      sum -= a2.sum;
    };

    bool empty() const
    {
      return (num == 0);
    };

    float average(const ScoringType stype) const
    {
      return scale(sum, num, stype);
    };
};

#endif
