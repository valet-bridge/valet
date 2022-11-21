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


void Aspect::scale()
{
  average = ::scale(sum, num, options.valet);
}


void Aspect::compensate(const Aspect& a2)
{
  if (options.valet == VALET_MATCHPOINTS)
    average += a2.average - 50.f;
  else
    average += a2.average;
}


unsigned Aspect::getCount() const
{
  return num;
}


float Aspect::getAverage() const
{
  return average;
}


string Aspect::pad(const Padding padding) const
{
  if (options.format != VALET_FORMAT_TEXT || padding == PAD_NONE)
    return "";
  else if (padding == PAD_SPACE)
    return "  ";
  else if (padding == PAD_BAR)
    return " | ";
  else if (padding == PAD_BAR_END)
    return " |";
  else
  {
    assert(false);
    return "";
  }
}


string Aspect::strCount(const int width) const
{
  stringstream ss;

  if (options.format == VALET_FORMAT_TEXT)
    ss << setw(width) << num;
  else if (options.format == VALET_FORMAT_CSV)
    ss << num << options.separator;
  else
    assert(false);

  return ss.str();
}


string Aspect::strAverage(
  const int width,
  const int prec,
  const Padding padding) const
{
  stringstream ss;

  if (options.format == VALET_FORMAT_TEXT)
  {
    ss << setw(width) << fixed << setprecision(prec) << average;
    ss << Aspect::pad(padding);
  }
  else if (options.format == VALET_FORMAT_CSV)
    ss << fixed << setprecision(prec) << average << options.separator;
  else
    assert(false);

  return ss.str();
}


string Aspect::str(
  const int prec,
  const Padding padding) const
{
  stringstream ss;

  if (options.format == VALET_FORMAT_TEXT)
  {
    if (num > 0)
      ss << setw(5) << fixed << setprecision(prec) << average <<
        " (" << setw(3) << num << ")";
    else
      ss << setw(5) << "-" << " (  0)";
    
    ss << Aspect::pad(padding);
  }
  else if (options.format == VALET_FORMAT_CSV)
  {
    if (num > 0)
      ss << fixed << setprecision(prec) << average << 
        options.separator << num << options.separator;
    else
      ss << "-" << options.separator << "0" << options.separator;
  }
  else
    assert(false);

  return ss.str();
}
