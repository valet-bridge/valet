/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


// The functions in this file calculate basic bridge scores.


#include <assert.h>

#include "Result.h"

#include "valet.h"
#include "cst.h"
#include "scoring.h"

using namespace std;

extern Options options;


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

void setIMPlookup();

void setIMPlookup()
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


void setTables()
{
  setIMPlookup();
}


void getVul(
  const unsigned boardNo,
  unsigned& vulNS,
  unsigned& vulEW)
{
  vulNS = VulTable[boardNo & 0xf][0];
  vulEW = VulTable[boardNo & 0xf][1];
}


int calculateIMPs( int rawScore)
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

  if (options.datumHardRounding)
  {
    //  374 ->  370,  375 ->  370.
    v = (v/10)*10;
  }
  else
  {
    //  374 ->  370,  375 ->  380.
    v = ((v+5)/10)*10;
  }

  return sign * static_cast<int>(IMPlookup[v/10 + 1]);
}


int calculateMPs(int rawScore)
{
  if (rawScore == 0)
    return 0;
  else
    return (rawScore > 0 ? 1 : -1);
}

