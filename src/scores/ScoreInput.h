/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_SCOREINPUT_H
#define VALET_SCOREINPUT_H

#include <string>

#include "../Result.h"

using namespace std;

enum TableauLevel: unsigned;
enum TableauStrain: unsigned;
enum TableauSide: unsigned;


struct ScoreInput
{
  unsigned pairNo;
  unsigned oppNo;
  bool declFlag[2];
  bool defFlag;
  bool leadFlag[2];
  float overall;
  float bidScore;
  float playScore[2];
  float leadScore[2];
  float defScore;

  unsigned multiplier;
  TableauLevel level;
  TableauStrain strain;
  TableauSide sideActual;
  TableauSide sideEffective;

  string keyResult;


  ScoreInput();

  void set(
    const Result& result,
    const float totalIMPs,
    const float bidIMPs,
    const float leadIMPs);

  void setPassout(
    const Result& result,
    const float totalIMPs);

  void getLevelStats(
    TableauSide& tsideEffective,
    TableauLevel& tlevel) const;

  void getStrainStats(
    TableauSide& tsideActual,
    TableauStrain& tstrain) const;

  string str() const;
};

#endif
