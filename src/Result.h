/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_RESULT_H
#define VALET_RESULT_H

#include <string>

using namespace std;


class Result
{
  private:

    string north;
    string east;
    string south;
    string west;

    unsigned level;
    unsigned denom;
    unsigned multiplier;
    unsigned declarer;
    unsigned tricks;
    unsigned leadDenom;
    unsigned leadRank;
    unsigned vulnerability;

    int calcDown(
      const unsigned vul,
      const int delta) const;

    int calcMade(
      const unsigned vul,
      const int delta) const;

  public:

  void setPlayers(
    const string& northIn,
    const string& eastIn,
    const string& southIn,
    const string& westIn);

  void setPassedOut();

  void setGeneralResult(
    const unsigned levelIn,
    const unsigned denomIn,
    const unsigned multiplierIn,
    const unsigned declarerIn,
    const unsigned tricksIn,
    const unsigned vulIn);

  void setNoLead();

  void setLead(
    const unsigned leadDenomIn,
    const unsigned leadRankIn);

  void setTricks(const unsigned tricksIn);

  void getPairData(
    unsigned& pairNS,
    unsigned& pairEW,
    unsigned& declIndex, // The indices are 0 or 1
    unsigned& leadIndex,
    bool& passedOutFlag) const;

  // Use the actual tricks.
  int calcScore() const;

  // Use the stated tricks.
  int calcScore(const unsigned tricks) const;

  bool isPassedOut() const;
  bool declarerNS() const;
  bool declarerEW() const;
  bool hasLead() const;

  unsigned getLevel() const;
  unsigned getDenom() const;
  unsigned getMultiplier() const;
  unsigned getDeclarer() const;
  unsigned getTricks() const;
  unsigned getLeadDenom() const;
  unsigned getLeadRank() const;

  string key() const;

  string strDebug() const;

};

#endif
