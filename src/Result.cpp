/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#include <iostream>
#include <iomanip>
#include <sstream>
#include <vector>
#include <cassert>

#include "Result.h"

#include "pairs/Players.h"
#include "pairs/Pairs.h"

#include "scoringTables.h"

extern Players players;
extern Pairs pairs;
extern Options options;


const vector<string> ValetPositions =
{
  "North", "East", "South", "West"
};

const vector<string> ValetPositionsShort =
{
  "N", "E", "S", "W"
};

const vector<string> ValetDenomsSingular =
{
  "Spade", "Heart", "Diamond", "Club", "Notrump"
};

const vector<string> ValetDenomsPlural =
{
  "Spades", "Hearts", "Diamonds", "Clubs", "Notrump"
};

const vector<string> ValetDenomsShort =
{
  "S", "H", "D", "C", "NT"
};

const vector<string> ValetMultipliers =
{
  "", "X", "XX"
};

const vector<char> ValetRanks =
{
  '0', '0', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'
};

const unsigned Hswap[2][2] = { {0, 1}, {1, 0} };


void Result::setPlayers(
  const string& northIn,
  const string& eastIn,
  const string& southIn,
  const string& westIn)
{
  north = northIn;
  east = eastIn;
  south = southIn;
  west = westIn;
}


void Result::setPassedOut()
{
  level = 0;
  tricks = 0;
}


void Result::setGeneralResult( // Without lead
  const unsigned levelIn,
  const unsigned denomIn,
  const unsigned multiplierIn,
  const unsigned declarerIn,
  const unsigned tricksIn,
  const unsigned vulIn)
{
  level = levelIn;
  denom = denomIn;
  multiplier = multiplierIn;
  declarer = declarerIn;
  tricks = tricksIn;
  vulnerability = vulIn;
}


void Result::setNoLead()
{
  leadRank = 0;
}


void Result::setLead(
  const unsigned leadDenomIn,
  const unsigned leadRankIn)
{
  leadDenom = leadDenomIn;
  leadRank = leadRankIn;
}


void Result::setTricks(const unsigned tricksIn)
{
  tricks = tricksIn;
}


void Result::getPairData(
  unsigned& pairNS,
  unsigned& pairEW,
  unsigned& declIndex,
  unsigned& leadIndex,
  bool& passedOutFlag) const
{
  PairData pairDataNS, pairDataEW;
  pairs.getPairData(north, south, pairDataNS);
  pairs.getPairData(east, west, pairDataEW);
  assert(pairDataNS.foundFlag);
  assert(pairDataEW.foundFlag);

  pairNS = pairDataNS.number;
  pairEW = pairDataEW.number;

  if (Result::isPassedOut())
  {
    declIndex = 0;
    leadIndex = 0;
    passedOutFlag = true;
  }
  else if (Result::declarerNS())
  {
    declIndex = Hswap[pairDataNS.flipFlag][declarer == VALET_SOUTH];
    leadIndex = Hswap[pairDataEW.flipFlag][declarer == VALET_SOUTH];
    passedOutFlag = false;
  }
  else if (Result::declarerEW())
  {
    declIndex = Hswap[pairDataEW.flipFlag][declarer == VALET_WEST];
    leadIndex = Hswap[pairDataNS.flipFlag][declarer == VALET_EAST];
    passedOutFlag = false;
  }
  else
    assert(false);
}


int Result::calcScore() const
{
  return Result::calcScore(tricks);
}


int Result::calcDown(
  const unsigned vul,
  const int delta) const
{
  // Undertricks.
  int sign = (Result::declarerNS() ?  1 : -1);

  switch(multiplier)
  {
    case VALET_UNDOUBLED:
      return sign * (vul == VALET_NOT_VUL ?  50 * delta : 100 * delta);

    case VALET_DOUBLED:
      return -sign * static_cast<int>(DoubledTricks[vul][-delta]);

    case VALET_REDOUBLED:
      return -sign * static_cast<int>(RedoubledTricks[vul][-delta]);

    default:
      assert(false);
      return 0;
  }
}


int Result::calcMade(
  const unsigned vul,
  const int delta) const
{
  // Contract made.
  const int sign = (Result::declarerNS() ?  1 : -1);

  const unsigned denomOrder = DenomToOrder[denom];
  const unsigned contractNo = 5 * (level-1) + denomOrder;
  unsigned baseScore, adder = 0;

  switch(multiplier)
  {
    case VALET_UNDOUBLED:
      baseScore = static_cast<unsigned>(ContractScores[contractNo][vul]);

      if (delta > 0)
        adder = static_cast<unsigned>(delta * Overtricks[denomOrder]);
      break;

    case VALET_DOUBLED:
      baseScore = static_cast<unsigned>(
        DoubledContractScores[contractNo][vul]);

      if (delta > 0)
        adder = (vul == VALET_NOT_VUL ?
          100 * static_cast<unsigned>(delta) :
          200 * static_cast<unsigned>(delta));
      break;

    case VALET_REDOUBLED:
      baseScore = static_cast<unsigned>(
        RedoubledContractScores[contractNo][vul]);

      if (delta > 0)
        adder = (vul == VALET_NOT_VUL ?
          200 * static_cast<unsigned>(delta) :
          400 * static_cast<unsigned>(delta));
      break;

    default:
      assert(false);
      return 0;
  }

  return sign * static_cast<int>(baseScore + adder);
}


int Result::calcScore(const unsigned tricksIn) const
{
  if (level == 0)
    return 0;

  const int delta = static_cast<int>(tricksIn) - 
    (static_cast<int>(level)+6);

  if (delta < 0)
    return Result::calcDown(vulnerability, delta);
  else
    return Result::calcMade(vulnerability, delta);
}


bool Result::isPassedOut() const
{
  return (level == 0);
}


bool Result::declarerNS() const
{
  assert(! Result::isPassedOut());
  return (declarer == VALET_NORTH || declarer == VALET_SOUTH);
}


bool Result::declarerEW() const
{
  assert(! Result::isPassedOut());
  return (declarer == VALET_EAST || declarer == VALET_WEST);
}


bool Result::hasLead() const
{
  return (leadRank > 0);
}


unsigned Result::getLevel() const
{
  return level;
}


unsigned Result::getDenom() const
{
  return denom;
}


unsigned Result::getMultiplier() const
{
  return multiplier;
}


unsigned Result::getDeclarer() const
{
  return declarer;
}


unsigned Result::getTricks() const
{
  return tricks;
}


unsigned Result::getLeadDenom() const
{
  return leadDenom;
}


unsigned Result::getLeadRank() const
{
  return leadRank;
}


string Result::key() const
{
  if (level == 0)
    return "pass (NS)";

  stringstream ss;
  ss << level << ValetDenomsShort[denom] <<
    ValetMultipliers[multiplier] << ", " <<
    ValetPositionsShort[declarer] << ", ";

  if (options.leadFlag)
    ss << ValetDenomsShort[leadDenom] << ", ";

  ss << tricks;

  return ss.str();

}


string Result::strDebug() const
{
  stringstream ss;

  ss <<
    setw(10) << left << "North" << right <<
    north << " (" << players.getName(north) << ")\n";

  ss <<
    setw(10) << left << "East" << right <<
    east << " (" << players.getName(east) << ")\n";

  ss <<
    setw(10) << left << "South" << right <<
    south << " (" << players.getName(south) << ")\n";

  ss << setw(10) << left << "West" << right <<
    west << " (" << players.getName(west) << ")\n";

  ss << setw(10) << left << "Contract" << right <<
    level << " " <<
    (level > 0 ? ValetDenomsPlural[denom] :
      ValetDenomsSingular[denom]) << " " <<
    ValetMultipliers[multiplier] << "\n";

  ss << setw(10) << left << "Declarer" << right <<
    ValetPositions[declarer] << "\n";

  ss << setw(10) << left << "Tricks" << right <<
   tricks << "\n";

  ss << setw(10) << left << "Lead" << right <<
    ValetDenomsSingular[leadDenom] << " " <<
    ValetRanks[leadRank] << "\n";
  
  return ss.str();
}

