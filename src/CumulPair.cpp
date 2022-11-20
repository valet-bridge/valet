/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-23 by Soren Hein.

   See LICENSE and README.
*/


#include <iostream>
#include <iomanip>
#include <string>
#include <cassert>

#include "CumulPair.h"
#include "misc.h"
#include "cst.h"

extern OptionsType options;


float CumulPair::averagePlay() const
{
  const float n1 = static_cast<float>(num[VALET_PLAY1]);
  const float n2 = static_cast<float>(num[VALET_PLAY2]);
  const float n = n1 + n2;
  if (n > 0)
  {
    return (avgPerChance[VALET_PLAY1] * n1 +
      avgPerChance[VALET_PLAY2] * n2) / n;
  }
  else
    return 0.;
}


float CumulPair::averageDefense() const
{
  const float n1 = static_cast<float>(num[VALET_PLAY1]);
  const float n2 = static_cast<float>(num[VALET_PLAY2]);
  const float n3 = static_cast<float>(num[VALET_DEF]);
  const float n = n1 + n2 + n3;
  if (n > 0)
  {
    // TODO Not convinced that this is the only place 
    // that this needs to show up...
    const float offsetMP =
      (options.valet == VALET_MATCHPOINTS ? 50.f : 0.f);

    return -offsetMP +
      (avgPerChance[VALET_LEAD1] * n1 +
       avgPerChance[VALET_LEAD2] * n2 +
       avgPerChance[VALET_DEF] * n3) / n3;
  }
  else
    return 0.;
}


float CumulPair::averageLead1() const
{
  return avgPerChance[VALET_LEAD1];
}


float CumulPair::averageLead2() const
{
  return avgPerChance[VALET_LEAD2];
}


float CumulPair::averageLead() const
{
  const float n1 = static_cast<float>(num[VALET_LEAD1]);
  const float n2 = static_cast<float>(num[VALET_LEAD2]);
  const float n3 = static_cast<float>(num[VALET_PLAY1]);
  const float n4 = static_cast<float>(num[VALET_PLAY2]);
  const float n = n3 + n4;
  if (n > 0)
  {
    return (avgPerChance[VALET_LEAD1] * n1 +
      avgPerChance[VALET_LEAD2] * n2) / n;
  }
  else
    return 0.;
}


float CumulPair::averageNonLead() const
{
  return avgPerChance[VALET_DEF];
}


string CumulPair::strDetails(
  const int prec,
  const FormatType format) const
{
  stringstream ss;

  // Declarer score.
  unsigned n = num[VALET_PLAY1] + num[VALET_PLAY2];
  ss << strPair(CumulPair::averagePlay(), n, prec, format);

  // Defender score.
  ss << "  ";
  n = num[VALET_DEF];
  ss << strPair(CumulPair::averageDefense(), n, prec, format);

  ss << " | ";

  // Individual declarer scores.
  ss << strPair(
    avgPerChance[VALET_PLAY1], num[VALET_PLAY1], prec, format);
  ss << "  ";
  ss << strPair(
    avgPerChance[VALET_PLAY2], num[VALET_PLAY2], prec, format);

  ss << " | ";

  if (options.leadFlag)
  {
    ss << strPair(avgPerChance[VALET_LEAD1], num[VALET_LEAD1], prec,
      format);
    ss << "  ";
    ss << strPair(avgPerChance[VALET_LEAD2], num[VALET_LEAD2], prec,
      format);
    ss << "  ";

    if (options.averageFlag)
    {
      ss << strPair(
        CumulPair::averageLead(),
        num[VALET_PLAY1] + num[VALET_PLAY2],
        prec,
        format);
      ss << "  ";
    }

    ss << strPair(
      avgPerChance[VALET_DEF], num[VALET_DEF], prec, format);
    ss << " |";
  }

  ss << "\n";

  return ss.str();
}
