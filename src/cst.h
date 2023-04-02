/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_CST_H
#define VALET_CST_H

#include <string>
#include <sstream>

using namespace std;


enum FormatEnum: unsigned
{
  VALET_FORMAT_TEXT,
  VALET_FORMAT_CSV
};


enum TableEnum: unsigned
{
  VALET_TABLE_MANY = 0,
  VALET_TABLE_FEW = 1
};


enum ScoringEnum: unsigned
{
  VALET_IMPS,
  VALET_IMPS_ACROSS_FIELD,
  VALET_MATCHPOINTS
};

struct ScoringPair
{
  ScoringEnum scoring;
  string arg;
  string explanation;
  string header;
};

const ScoringPair scoringTags[] =
{
  {VALET_IMPS, "datum", "Butler IMPs", "Butler"},
  {VALET_IMPS_ACROSS_FIELD, "imps", "IMPs across the field", "IMPs"},
  {VALET_MATCHPOINTS, "matchpoints", "Matchpoints", "MP"}
};


enum SortingEnum: unsigned
{
  VALET_SORT_OVERALL,
  VALET_SORT_BIDDING,
  VALET_SORT_DECL,
  VALET_SORT_DEFENSE,
  VALET_SORT_LEAD,
  VALET_SORT_BID_OVER_DECL,
  VALET_SORT_DEF_OVER_DECL,
  VALET_SORT_LEAD_OVER_DECL
};

struct SortPair
{
  SortingEnum sort;
  string str;
};

const SortPair sortingTags[] =
{
  {VALET_SORT_OVERALL, "overall"},
  {VALET_SORT_BIDDING, "bidding"},
  {VALET_SORT_DECL, "decl"},
  {VALET_SORT_DEFENSE, "defense"},
  {VALET_SORT_LEAD, "lead"},
  {VALET_SORT_BID_OVER_DECL, "bidoverdecl"},
  {VALET_SORT_DEF_OVER_DECL, "defoverdecl"},
  {VALET_SORT_LEAD_OVER_DECL, "leadoverdecl"}
};


struct Options
{
  ScoringEnum valet;

  string directory;
  string nameFile;
  string scoresFile;
  string tableauFile;
  string pairSheetsFile;

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
  bool pairSheetsFlag;

  SortingEnum sort;
  bool averageFlag;

  FormatEnum format;
  string separator;

  bool learnFlag;
  string learnFile;
};

struct Error
{
  bool flag;
  int no;
  stringstream message;
};

#endif
