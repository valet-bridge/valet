/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_SCORINGTABLE_H
#define VALET_SCORINGTABLE_H

#include "valet.h"

using namespace std;


// Map denomination to order 0, 1, 2, 3, 4.
// The denominations are in the order S, H, D, C, N (as in DDS).

const vector<unsigned> DenomToOrder =
{
  3, 2, 1, 0, 4
};

// First index: 0 nonvul, 1 vul. Second index: tricks down
const vector<vector<int>> DoubledTricks =
{
  {
    0   ,  100,  300,  500,  800, 1100, 1400, 1700,
    2000, 2300, 2600, 2900, 3200, 3500
  },
  {
    0   ,  200,  500,  800, 1100, 1400, 1700, 2000,
    2300, 2600, 2900, 3200, 3500, 3800
  }
};

const vector<vector<int>> RedoubledTricks =
{
  {
    0   ,  200,  600, 1000, 1600, 2200, 2800, 3400,
    4000, 4600, 5200, 5800, 6400, 7000
  },
  {
    0   ,  400, 1000, 1600, 2200, 2800, 3400, 4000,
    4600, 5200, 5800, 6400, 7000, 7600
  }
};


const vector<int> Overtricks =
{
  20, 20, 30, 30, 30
};


/* First index is contract number,
   0 is pass, 1 is 1C, ..., 35 is 7NT.
   Second index is 0 nonvul, 1 vul. */

const vector<vector<int>> ContractScores =
{
  {  70,   70}, {  70,   70}, {  80,   80}, {  80,   80}, {  90,   90},
  {  90,   90}, {  90,   90}, { 110,  110}, { 110,  110}, { 120,  120},
  { 110,  110}, { 110,  110}, { 140,  140}, { 140,  140}, { 400,  600},
  { 130,  130}, { 130,  130}, { 420,  620}, { 420,  620}, { 430,  630},
  { 400,  600}, { 400,  600}, { 450,  650}, { 450,  650}, { 460,  660},
  { 920, 1370}, { 920, 1370}, { 980, 1430}, { 980, 1430}, { 990, 1440},
  {1440, 2140}, {1440, 2140}, {1510, 2210}, {1510, 2210}, {1520, 2220}
};

const vector<vector<int>> DoubledContractScores =
{
  { 140,  140}, { 140,  140}, { 160,  160}, { 160,  160}, { 180,  180},
  { 180,  180}, { 180,  180}, { 470,  670}, { 470,  670}, { 490,  690},
  { 470,  670}, { 470,  670}, { 530,  730}, { 530,  730}, { 550,  750},
  { 510,  710}, { 510,  710}, { 590,  790}, { 590,  790}, { 610,  810},
  { 550,  750}, { 550,  750}, { 650,  850}, { 650,  850}, { 670,  870},
  {1090, 1540}, {1090, 1540}, {1210, 1660}, {1210, 1660}, {1230, 1680},
  {1630, 2330}, {1630, 2330}, {1770, 2470}, {1770, 2470}, {1790, 2490}
};

const vector<vector<int>> RedoubledContractScores =
{
  { 230,  230}, { 230,  230}, { 520,  720}, { 520,  720}, { 560,  760},
  { 560,  760}, { 560,  760}, { 640,  840}, { 640,  840}, { 680,  880},
  { 640,  840}, { 640,  840}, { 760,  960}, { 760,  960}, { 800, 1000},
  { 720,  920}, { 720,  920}, { 880, 1080}, { 880, 1080}, { 920, 1120},
  { 800, 1000}, { 800, 1000}, {1000, 1200}, {1000, 1200}, {1040, 1240},
  {1380, 1830}, {1380, 1830}, {1620, 2070}, {1620, 2070}, {1660, 2110},
  {1960, 2660}, {1960, 2660}, {2240, 2940}, {2240, 2940}, {2280, 2980}
};

const vector<unsigned> IMPscale =
{
     0,   10,   40,   80,  120,  160,  210,  260, 
   310,  360,  420,  490,  590,  740,  890, 1090, 
  1290, 1490, 1740, 1990, 2240, 2490, 2990, 3490, 
  3990, 9990 
};


// Second index is 0 NS, 1 EW.
const vector<vector<unsigned>> VulTable =
{
  { VALET_NOT_VUL, VALET_VUL     }, // 16
  { VALET_NOT_VUL, VALET_NOT_VUL }, //  1
  { VALET_VUL    , VALET_NOT_VUL }, //  2
  { VALET_NOT_VUL, VALET_VUL     }, //  3
  { VALET_VUL    , VALET_VUL     }, //  4
  { VALET_VUL    , VALET_NOT_VUL }, //  5
  { VALET_NOT_VUL, VALET_VUL     }, //  6
  { VALET_VUL    , VALET_VUL     }, //  7
  { VALET_NOT_VUL, VALET_NOT_VUL }, //  8
  { VALET_NOT_VUL, VALET_VUL     }, //  9
  { VALET_VUL    , VALET_VUL     }, // 10
  { VALET_NOT_VUL, VALET_NOT_VUL }, // 11
  { VALET_VUL    , VALET_NOT_VUL }, // 12
  { VALET_VUL    , VALET_VUL     }, // 13
  { VALET_NOT_VUL, VALET_NOT_VUL }, // 14
  { VALET_VUL    , VALET_NOT_VUL }, // 15
};

#endif
