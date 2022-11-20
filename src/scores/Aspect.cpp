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


float Aspect::average(const ScoringEnum stype) const
{
  return scale(sum, num, stype);
}


string Aspect::str(const int prec) const
{
  stringstream ss;

  if (options.format == VALET_FORMAT_TEXT)
  {
    if (num > 0)
      ss << setw(5) << fixed << setprecision(prec) << 
        sum / static_cast<float>(num) <<
        " (" << setw(3) << num << ")";
    else
      ss << setw(5) << "-" << " (  0)";
  }
  else if (options.format == VALET_FORMAT_CSV)
  {
    if (num > 0)
      ss << setprecision(prec) << 
        sum / static_cast<float>(num) << options.separator <<
        num << options.separator;
    else
      ss << "-" << options.separator << "0" << options.separator;
  }
  else
    assert(false);

  return ss.str();
}
