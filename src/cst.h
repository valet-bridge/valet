/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_CST_H
#define VALET_CST_H

#include <string>
#include <sstream>

using namespace std;


const char ValetPositions[4][6] =
{
  "North", "East", "South", "West"
};

const char ValetPositionsShort[4][6] =
{
  "N", "E", "S", "W"
};

const char ValetDenoms[5][9] =
{
  "Spades", "Hearts", "Diamonds", "Clubs", "Notrump"
};

const char ValetDenomsShort[5][9] =
{
  "S", "H", "D", "C", "NT"
};

const char ValetMultipliers[3][3] =
{
  "", "X", "XX"
};

const char ValetRanks[15] =
{
  '0', '0', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'
};


enum FormatType
{
  VALET_FORMAT_TEXT,
  VALET_FORMAT_CSV
};


enum ScoringType
{
  VALET_IMPS,
  VALET_IMPS_ACROSS_FIELD,
  VALET_MATCHPOINTS
};

struct ScoringPairType
{
  ScoringType scoring;
  string arg;
  string explanation;
  string header;
};

const ScoringPairType scoringTags[] =
{
  {VALET_IMPS, "datum", "Butler IMPs", "Butler"},
  {VALET_IMPS_ACROSS_FIELD, "imps", "IMPs across the field", "IMPs"},
  {VALET_MATCHPOINTS, "matchpoints", "Matchpoints", "MP"}
};


enum SortingType: unsigned
{
  VALET_SORT_OVERALL,
  VALET_SORT_BIDDING,
  VALET_SORT_PLAY,
  VALET_SORT_DEFENSE,
  VALET_SORT_LEAD,
  VALET_SORT_BID_OVER_PLAY,
  VALET_SORT_DEF_OVER_PLAY,
  VALET_SORT_LEAD_OVER_PLAY
};

struct sortPairType
{
  SortingType sort;
  string str;
};

const sortPairType sortingTags[] =
{
  {VALET_SORT_OVERALL, "overall"},
  {VALET_SORT_BIDDING, "bidding"},
  {VALET_SORT_PLAY, "play"},
  {VALET_SORT_DEFENSE, "defense"},
  {VALET_SORT_LEAD, "lead"},
  {VALET_SORT_BID_OVER_PLAY, "bidoverplay"},
  {VALET_SORT_DEF_OVER_PLAY, "defoverplay"},
  {VALET_SORT_LEAD_OVER_PLAY, "leadoverplay"}
};


struct OptionsType
{
  ScoringType valet;

  string directory;
  string nameFile;
  string scoresFile;
  string tableauFile;

  bool roundFlag;
  unsigned roundFirst;
  unsigned roundLast;

  unsigned minHands;

  bool leadFlag;

  bool datumFilter;
  bool datumHardRounding;
  bool compensateFlag;
  bool cloudFlag;
  bool tableauFlag;

  SortingType sort;
  bool averageFlag;

  FormatType format;
  string separator;
};


struct ResultType
{
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
};


struct ValetEntryType
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

  ResultType result;
};


struct ErrorType
{
  bool flag;
  int no;
  stringstream message;
};


#endif
