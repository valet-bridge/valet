/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// The functions in this file calculate basic bridge scores.


#include <assert.h>

#include "valet.h"
#include "cst.h"
#include "scoring.h"

using namespace std;


// Map denomination to order 0, 1, 2, 3, 4.
// The denominations are in the order S, H, D, C, N (as in DDS).

const unsigned DenomToOrder[5] =
{
  3, 2, 1, 0, 4
};

// First index: 0 nonvul, 1 vul. Second index: tricks down
const int DoubledTricks[2][14] =
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

const int RedoubledTricks[2][14] =
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


const int Overtricks[5] =
{
  20, 20, 30, 30, 30
};


/* First index is contract number,
   0 is pass, 1 is 1C, ..., 35 is 7NT.
   Second index is 0 nonvul, 1 vul. */

int ContractScores[35][2] =
{
  {  70,   70}, {  70,   70}, {  80,   80}, {  80,   80}, {  90,   90},
  {  90,   90}, {  90,   90}, { 110,  110}, { 110,  110}, { 120,  120},
  { 110,  110}, { 110,  110}, { 140,  140}, { 140,  140}, { 400,  600},
  { 130,  130}, { 130,  130}, { 420,  620}, { 420,  620}, { 430,  630},
  { 400,  600}, { 400,  600}, { 450,  650}, { 450,  650}, { 460,  660},
  { 920, 1370}, { 920, 1370}, { 980, 1430}, { 980, 1430}, { 990, 1440},
  {1440, 2140}, {1440, 2140}, {1510, 2210}, {1510, 2210}, {1520, 2220}
};

int DoubledContractScores[35][2] =
{
  { 140,  140}, { 140,  140}, { 160,  160}, { 160,  160}, { 180,  180},
  { 180,  180}, { 180,  180}, { 470,  670}, { 470,  670}, { 490,  690},
  { 470,  670}, { 470,  670}, { 530,  730}, { 530,  730}, { 550,  750},
  { 510,  710}, { 510,  710}, { 590,  790}, { 590,  790}, { 610,  810},
  { 550,  750}, { 550,  750}, { 650,  850}, { 650,  850}, { 670,  870},
  {1090, 1540}, {1090, 1540}, {1210, 1660}, {1210, 1660}, {1230, 1680},
  {1630, 2330}, {1630, 2330}, {1770, 2470}, {1770, 2470}, {1790, 2490}
};

int RedoubledContractScores[35][2] =
{
  { 230,  230}, { 230,  230}, { 520,  720}, { 520,  720}, { 560,  760},
  { 560,  760}, { 560,  760}, { 640,  840}, { 640,  840}, { 680,  880},
  { 640,  840}, { 640,  840}, { 760,  960}, { 760,  960}, { 800, 1000},
  { 720,  920}, { 720,  920}, { 880, 1080}, { 880, 1080}, { 920, 1120},
  { 800, 1000}, { 800, 1000}, {1000, 1200}, {1000, 1200}, {1040, 1240},
  {1380, 1830}, {1380, 1830}, {1620, 2070}, {1620, 2070}, {1660, 2110},
  {1960, 2660}, {1960, 2660}, {2240, 2940}, {2240, 2940}, {2280, 2980}
};

const unsigned IMPscale[26] =
{
     0,   10,   40,   80,  120,  160,  210,  260, 
   310,  360,  420,  490,  590,  740,  890, 1090, 
  1290, 1490, 1740, 1990, 2240, 2490, 2990, 3490, 
  3990, 9990 
};


// Second index is 0 NS, 1 EW.
const unsigned VulTable[16][2] =
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


unsigned IMPlookup[501];

void SetIMPlookup();

void SetIMPlookup()
{
  // IMPlookup  1,  2,  3,  4,  5,  6,  7, ... 
  // value      0,  0,  1,  1,  1,  2,  2, ...
  // score      0, 10, 20, 30, 40, 50, 60, ...

  IMPlookup[0] = 0; // Unused
  for (unsigned i = 1; i < 501; i++)
  {
    unsigned j = 10 * (i-1);
    unsigned hit = 1;
    while (j > IMPscale[hit])
      hit++;

    IMPlookup[i] = hit-1;
  }
}


void SetTables()
{
  SetIMPlookup();
}


int CalculateRawScore(
  const ResultType& res,
  const unsigned vul)
{
  return CalculateRawScore(res, vul, res.tricks);
}


int CalculateRawScore(
  const ResultType& res,
  const unsigned vul,
  const unsigned tricks)
{
  if (res.level == 0)
    return 0;

  int delta = static_cast<int>(tricks) - (static_cast<int>(res.level)+6);
  int sign = 
    (res.declarer == VALET_NORTH || res.declarer == VALET_SOUTH ?  1 : -1);

  if (delta < 0)
  {
    // Undertricks.
    switch(res.multiplier)
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
  else
  {
    unsigned denomOrder = DenomToOrder[res.denom];
    unsigned contractNo = 5 * (res.level-1) + denomOrder;
    unsigned baseScore, adder = 0;
    switch(res.multiplier)
    {
      case VALET_UNDOUBLED:
        baseScore = static_cast<unsigned>(
          ContractScores[contractNo][vul]);

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
}


void GetVul(
  const unsigned boardNo,
  unsigned& vulNS,
  unsigned& vulEW)
{
  vulNS = VulTable[boardNo & 0xf][0];
  vulEW = VulTable[boardNo & 0xf][1];
}


int CalculateIMPs(
  int rawScore)
{
  int v, sign;
  if (rawScore < 0)
  {
    v = -rawScore;
    sign = -1;
  }
  else
  {
    v = rawScore;
    sign = 1;
  }

  return sign * static_cast<int>(IMPlookup[v/10 + 1]);
}


int CalculateMPs(
  int rawScore)
{
  if (rawScore == 0)
    return 0;
  else
    return (rawScore > 0 ? 1 : -1);
}

