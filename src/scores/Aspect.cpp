/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-23 by Soren Hein.

   See LICENSE and README.
*/



#include <iostream>
#include <iomanip>
#include <sstream>
#include <cassert>

#include "Aspect.h"
#include "../misc.h"

extern OptionsType options;


void Aspect::incr(const float f)
{
  num++;
  sum += f;
}


void Aspect::decr(const float f)
{
  num++;
  sum -= f;
}


void Aspect::operator += (const Aspect& a2)
{
  num += a2.num;
  sum += a2.sum;
}


void Aspect::operator -= (const Aspect& a2)
{
  num -= a2.num;
  sum -= a2.sum;
}


bool Aspect::empty() const
{
  return (num == 0);
}


void Aspect::scale(const ScoringEnum stype)
{
  average = ::scale(sum, num, stype);
}


void Aspect::compensate(
  const Aspect& a2,
  const ScoringEnum stype)
{
  if (stype == VALET_MATCHPOINTS)
    average += a2.average - 50.f;
  else
    average += a2.average;
}


string Aspect::str(const int prec) const
{
  stringstream ss;

  if (options.format == VALET_FORMAT_TEXT)
  {
    if (num > 0)
      ss << setw(5) << fixed << setprecision(prec) << average <<
        " (" << setw(3) << num << ")";
    else
      ss << setw(5) << "-" << " (  0)";
  }
  else if (options.format == VALET_FORMAT_CSV)
  {
    if (num > 0)
      ss << setprecision(prec) << average << options.separator <<
        num << options.separator;
    else
      ss << "-" << options.separator << "0" << options.separator;
  }
  else
    assert(false);

  return ss.str();
}
