/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_TABLEAUSTATS_H
#define VALET_TABLEAUSTATS_H

#include <vector>

#include "../cst.h"

using namespace std;


enum TableauLevel: unsigned
{
  LEVEL_GRAND = 0,
  LEVEL_SMALL = 1,
  LEVEL_GAME = 2,
  LEVEL_PARTIAL = 3,
  LEVEL_OPPS_DOUBLED = 4,
  LEVEL_SIZE = 5
};

struct LevelEntry
{
  TableauLevel level;
  string name;
};

const vector<LevelEntry> levels =
{
  {LEVEL_GRAND, "Grand"},
  {LEVEL_SMALL, "Small slam"},
  {LEVEL_GAME, "Game"},
  {LEVEL_PARTIAL, "Partial"},
  {LEVEL_OPPS_DOUBLED, "Double opps"}
};

enum TableauStrain: unsigned
{
  STRAIN_NOTRUMP = 0,
  STRAIN_SPADES = 1,
  STRAIN_HEARTS = 2,
  STRAIN_DIAMONDS = 3,
  STRAIN_CLUBS = 4,
  STRAIN_SIZE = 5
};

struct StrainEntry
{
  TableauStrain strain;
  string name;
};

const vector<StrainEntry> strains =
{
  {STRAIN_NOTRUMP, "NT"},
  {STRAIN_SPADES, "Spades"},
  {STRAIN_HEARTS, "Hearts"},
  {STRAIN_DIAMONDS, "Diamonds"},
  {STRAIN_CLUBS, "Clubs"}
};

struct SideEntry
{
  ValetSide side;
  string name;
};

const vector<SideEntry> sides =
{
  {SIDE_NS, "NS"},
  {SIDE_EW, "EW"}
};

#endif
