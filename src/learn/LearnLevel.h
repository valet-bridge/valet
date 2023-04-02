/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_LEARN_H
#define VALET_LEARN_H

#include <string>

enum LearnLevel: unsigned
{
  VALET_PARTIAL_UNDOUBLED = 0,
  VALET_PARTIAL_DOUBLED_NOT_GAME = 1,
  VALET_PARTIAL_DOUBLED_GAME = 2,
  VALET_PARTIAL_REDOUBLED_NOT_GAME = 3,
  VALET_PARTIAL_REDOUBLED_GAME = 4,
  VALET_GAME_UNDOUBLED = 5,
  VALET_GAME_DOUBLED = 6,
  VALET_GAME_REDOUBLED = 7,
  VALET_SMALL_SLAM_UNDOUBLED = 8,
  VALET_SMALL_SLAM_DOUBLED = 9,
  VALET_SMALL_SLAM_REDOUBLED = 10,
  VALET_GRAND_SLAM_UNDOUBLED = 11,
  VALET_GRAND_SLAM_DOUBLED = 12,
  VALET_GRAND_SLAM_REDOUBLED = 13,
  VALET_PASSED_OUT = 14,
  VALET_LEARN_SIZE = 15
};

struct LearnPair
{
  LearnLevel level;
  string str;
};

const LearnPair learnTags[] =
{
  {VALET_PARTIAL_UNDOUBLED, "Undoubled partial"},
  {VALET_PARTIAL_DOUBLED_NOT_GAME, "Doubled but not game"},
  {VALET_PARTIAL_DOUBLED_GAME, "Doubled into game"},
  {VALET_PARTIAL_REDOUBLED_NOT_GAME, "Redoubled but not game"},
  {VALET_PARTIAL_REDOUBLED_GAME, "Redoubled into game"},
  {VALET_GAME_UNDOUBLED, "Undoubled game"},
  {VALET_GAME_DOUBLED, "Doubled game"},
  {VALET_GAME_REDOUBLED, "Redoubled game"},
  {VALET_SMALL_SLAM_UNDOUBLED, "Undoubled small slam"},
  {VALET_SMALL_SLAM_DOUBLED, "Doubled small slam"},
  {VALET_SMALL_SLAM_REDOUBLED, "Redoubled small slam"},
  {VALET_GRAND_SLAM_UNDOUBLED, "Undoubled grand slam"},
  {VALET_GRAND_SLAM_DOUBLED, "Doubled grand slam"},
  {VALET_GRAND_SLAM_REDOUBLED, "Redoubled grand slam"},
  {VALET_PASSED_OUT, "Passed out"}
};

#endif
