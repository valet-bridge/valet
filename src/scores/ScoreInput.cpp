/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#include <iostream>
#include <iomanip>
#include <sstream>
#include <algorithm>
#include <cassert>

#include "ScoreInput.h"
#include "TableauStats.h"

#include "../valet.h"
#include "../cst.h"

extern Options options;


ScoreInput::ScoreInput()
{
  pairNo = 0;
  oppNo = 0;
  declFlag[0] = false;
  declFlag[1] = false;
  defFlag = false;
  leadFlag[0] = false;
  leadFlag[1] = false;
  overall = 0.;
  bidScore = 0.;
  playScore[0] = 0.;
  playScore[1] = 0.;
  leadScore[0] = 0.;
  leadScore[1] = 0.;
  defScore = 0.;

  multiplier = VALET_UNDOUBLED;
  level = LEVEL_SIZE;
  strain = STRAIN_SIZE;
  sideActual = SIDE_SIZE;
  sideEffective = SIDE_SIZE;

  keyResult = "";
}


void ScoreInput::set(
  const Result& result,
  const float totalIMPs,
  const float bidIMPs,
  const float leadIMPs)
{
  unsigned declIndex, leadIndex;
  bool passedOutFlag;
  result.getPairData(pairNo, oppNo, declIndex, leadIndex, passedOutFlag);
  assert(! passedOutFlag);

  // All IMPs are seen from NS's side up to here.
  float sign = 1.f;
  if (result.declarerEW())
  {
    sign = -1.f;
    swap(pairNo, oppNo);
  }

  declFlag[declIndex] = true;
  defFlag = true;
  leadFlag[leadIndex] = true;

  overall = sign * totalIMPs;
  bidScore = sign * bidIMPs;

  playScore[declIndex] = sign * (totalIMPs - bidIMPs);

  if (options.leadFlag && result.hasLead())
  {
    leadScore[leadIndex] = - sign * leadIMPs;
    defScore = sign * (bidIMPs - totalIMPs + leadIMPs);
  }
  else
    defScore = sign * (bidIMPs - totalIMPs);

  multiplier = result.getMultiplier();

  if (result.getLevel() == 7)
    level = LEVEL_GRAND;
  else if (result.getLevel() == 6)
    level = LEVEL_SMALL;
  else if (result.getLevel() == 5)
    level = LEVEL_GAME;
  else if (result.getLevel() == 4 &&
      result.getDenom() != VALET_DIAMONDS &&
      result.getDenom() != VALET_CLUBS)
    level = LEVEL_GAME;
  else if (result.getLevel() == 3 && 
       result.getDenom() == VALET_NOTRUMP)
    level = LEVEL_GAME;
  else
    level = LEVEL_PARTIAL;

  if (result.getDenom() == VALET_NOTRUMP)
    strain = STRAIN_NOTRUMP;
  else if (result.getDenom() == VALET_SPADES)
    strain = STRAIN_SPADES;
  else if (result.getDenom() == VALET_HEARTS)
    strain = STRAIN_HEARTS;
  else if (result.getDenom() == VALET_DIAMONDS)
    strain = STRAIN_DIAMONDS;
  else if (result.getDenom() == VALET_CLUBS)
    strain = STRAIN_CLUBS;
  else
    assert(false);
    

  sideActual = (result.declarerNS() ? SIDE_NS : SIDE_EW);

  if (multiplier == VALET_UNDOUBLED ||
      multiplier == VALET_REDOUBLED)
  {
    sideEffective = sideActual;
  }
  else
  {
    // Effectively EW have chosen to double NS.
    level = LEVEL_OPPS_DOUBLED;
    sideEffective = (result.declarerNS() ? SIDE_EW : SIDE_NS);
  }

  keyResult = result.key();
}


void ScoreInput::setPassout(
  const Result& result,
  const float totalIMPs)
{
  unsigned declIndex, leadIndex;
  bool passedOutFlag;
  result.getPairData(pairNo, oppNo, declIndex, leadIndex, passedOutFlag);
  assert(passedOutFlag);

  overall = totalIMPs;
  bidScore = totalIMPs;

  keyResult = result.key();
}


void ScoreInput::getLevelStats(
  TableauSide& tsideEffective,
  TableauLevel& tlevel) const
{
  tsideEffective = sideEffective;
  tlevel = level;
}


void ScoreInput::getStrainStats(
  TableauSide& tsideActual,
  TableauStrain& tstrain) const
{
  tsideActual = sideActual;
  tstrain = strain;
}


string ScoreInput::str() const
{
  stringstream ss;

  ss << setw(12) << left << "Pair no." << right << pairNo << "\n";

  ss << setw(12) << left << "Opp no." << right << oppNo << "\n";

  ss << setw(12) << left << "Declaring" << right <<
    declFlag[0] << " " << declFlag[1] << "\n";

  ss << setw(12) << left << "Defending" << right << defFlag << "\n";

  ss << setw(12) << left << "Leading" << right <<
    leadFlag[0] << " " << leadFlag[1] << "\n";

  ss << setw(12) << left << "Overall" << overall << "\n";

  ss << setw(12) << left << "Bid score" << bidScore << "\n";

  ss << setw(12) << left << "Play score" << right <<
    playScore[0] << " " << playScore[1] << "\n";

  ss << setw(12) << left << "Lead score" << right <<
    leadScore[0] << " " << leadScore[1] << "\n";

  ss << setw(12) << left << "Def score" << right <<
    defScore << "\n";

  ss << setw(12) << left << "Key result" << right <<
    keyResult << "\n";

  return ss.str();
}
