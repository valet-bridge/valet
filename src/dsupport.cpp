/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// These are support functions for the DLL driver.


#include <iostream>
#include <iomanip>
#include <string>
#include <stdlib.h>
#include <string.h>

#include "Valet.h"
#include "dsupport.h"

using namespace std;


// Bermuda Bowl 2015, Round 1, Board 1
// Also used in the documentation as Example 5

char example[TEST_ENTRIES][80] =
{
  "1|1|101|62|21|27|3N|E|7|C4",
  "1|1|102|17|77|99|4H|E|9|S2",
  "1|1|106|74|30|53|4H|W|8|CQ",
  "1|1|110|46|127|109|4H|W|10|CQ",
  "1|1|111|26|32|104|4H|E|8|D4",
  "1|1|113|1|54|28|4H|W|9|SJ",
  "1|1|12|124|16|61|3N|E|7|C4",
  "1|1|14|56|118|108|4H|E|9|D4",
  "1|1|15|120|73|115|4H|E|9|S2",
  "1|1|23|38|7|89|3N|E|7|C4",
  "1|1|29|34|79|20|3N|E|9|S2",
  "1|1|3|116|4|87|4H|E|10|D6",
  "1|1|45|10|44|95|4H|E|9|D4",
  "1|1|51|60|126|6|4H|E|9|D4",
  "1|1|55|57|86|42|4H|W|9|SJ",
  "1|1|66|94|49|22|4H|E|9|D4",
  "1|1|71|33|72|92|4H|E|10|D3",
  "1|1|78|82|41|98|4H|W|9|S6",
  "1|1|81|75|18|93|3N|E|9|C4",
  "1|1|83|68|43|90|3N|E|7|C6",
  "1|1|84|35|58|88|3N|E|7|C6",
  "1|1|85|128|91|24|3N|E|7|C6"
};

const unsigned northNoList[TEST_ENTRIES] =
{
  101, 102, 106, 110, 111, 113,  12,  14,  15,  23,
   29,   3,  45,  51,  55,  66,  71,  78,  81,  83,
   84,  85
};

string northTagList[TEST_ENTRIES] =
{
  "101", "102", "106", "110", "111", "113",  "12",  "14",  "15",  "23",
   "29",   "3",  "45",  "51",  "55",  "66",  "71",  "78",  "81",  "83",
   "84",  "85"
};

const unsigned eastNoList[TEST_ENTRIES] =
{
   62,  17,  74,  46,  26,   1, 124,  56, 120,  38,
   34, 116,  10,  60,  57,  94,  33,  82,  75,  68,
   35, 128
};

string eastTagList[TEST_ENTRIES] =
{
   "62",  "17",  "74",  "46",  "26",   "1", "124",  "56", "120",  "38",
   "34", "116",  "10",  "60",  "57",  "94",  "33",  "82",  "75",  "68",
   "35", "128"
};

const unsigned southNoList[TEST_ENTRIES] =
{
   21,  77,  30, 127,  32,  54,  16, 118,  73,   7,
   79,   4,  44, 126,  86,  49,  72,  41,  18,  43,
   58,  91
};

string southTagList[TEST_ENTRIES] =
{
   "21",  "77",  "30", "127",  "32",  "54",  "16", "118",  "73",   "7",
   "79",   "4",  "44", "126",  "86",  "49",  "72",  "41",  "18",  "43",
   "58",  "91"
};

const unsigned westNoList[TEST_ENTRIES] =
{
   27,  99,  53, 109, 104,  28,  61, 108, 115,  89,
   20,  87,  95,   6,  42,  22,  92,  98,  93,  90,
   88,  24
};

string westTagList[TEST_ENTRIES] =
{
   "27",  "99",  "53", "109", "104",  "28",  "61", "108", "115",  "89",
   "20",  "87",  "95",   "6",  "42",  "22",  "92",  "98",  "93",  "90",
   "88",  "24"
};

const unsigned levelList[TEST_ENTRIES] =
{
  3, 4, 4, 4, 4, 4, 3, 4, 4, 3, 3, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3
};

const unsigned denomList[TEST_ENTRIES] =
{
  4, 1, 1, 1, 1, 1, 4, 1, 1, 4, 4, 1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 4,
};

const unsigned multiplierList[TEST_ENTRIES] =
{
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};

const unsigned declList[TEST_ENTRIES] =
{
  1, 1, 3, 3, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1
};

const unsigned tricksList[TEST_ENTRIES] =
{
  7, 9, 8, 10, 8, 9, 7, 9, 9, 7, 9, 10, 9, 9, 9, 9, 10, 9, 9, 7, 7, 7
};

const unsigned leadSuitList[TEST_ENTRIES] =
{
  3, 0, 3, 3, 2, 0, 3, 2, 0, 3, 0, 2, 2, 2, 0, 2, 2, 0, 3, 3, 3, 3
};

const unsigned leadRankList[TEST_ENTRIES] =
{
  4, 2, 12, 12, 4, 11, 4, 4, 2, 4, 2, 6, 4, 4, 11, 4, 3, 6, 4, 6, 6, 6
};


void SetContractInputs(
  InputResultType& input,
  const unsigned i);

void PrintPlayedResultNumerical(
  OutputResultType& output);


int GetMode(
  int argc,
  char * argv[])
{
  if (argc != 2)
    return -1;
  else if (argv[1][0] == '1')
    return 0;
  else if (argv[1][0] == '2')
    return 1;
  else if (argv[1][0] == '3')
    return 2;
  else
    return -1;
}


void Usage(
  char * argv[])
{
  string basename(argv[0]);
  const size_t l = basename.find_last_of("\\/");
  if (l != string::npos)
    basename.erase(0, l+1);

  cout << "Usage: " << basename << " [1..3]" << endl;
  cout << "1: Test ValetAddByLine\n";
  cout << "2: Test ValetAddByTag\n";
  cout << "3: Test ValetAddByNumber\n";
}


void SetContractInputs(
  InputResultType& input,
  const unsigned i)
{
  input.level = levelList[i];
  input.denom = denomList[i];
  input.multiplier = multiplierList[i];
  input.declarer = declList[i];
  input.tricks = tricksList[i];
  input.leadDenom = leadSuitList[i];
  input.leadRank = leadRankList[i];
}


void SetTagInputs(
  PlayersTagType& players, 
  InputResultType& input, 
  const unsigned i)
{
#if (! defined(_MSC_VER) || _MSC_VER < 1400)
  strncpy(players.north, northTagList[i].c_str(), VALET_TAG_MAX_LENGTH);
  strncpy(players.east, eastTagList[i].c_str(), VALET_TAG_MAX_LENGTH);
  strncpy(players.south, southTagList[i].c_str(), VALET_TAG_MAX_LENGTH);
  strncpy(players.west, westTagList[i].c_str(), VALET_TAG_MAX_LENGTH);
#else
  strncpy_s(players.north, northTagList[i].c_str(), VALET_TAG_MAX_LENGTH);
  strncpy_s(players.east, eastTagList[i].c_str(), VALET_TAG_MAX_LENGTH);
  strncpy_s(players.south, southTagList[i].c_str(), VALET_TAG_MAX_LENGTH);
  strncpy_s(players.west, westTagList[i].c_str(), VALET_TAG_MAX_LENGTH);
#endif

  SetContractInputs(input, i);
}


void SetNumberInputs(
  PlayersNumberType& players, 
  InputResultType& input, 
  const unsigned i)
{
  players.north = northNoList[i];
  players.east = eastNoList[i];
  players.south = southNoList[i];
  players.west = westNoList[i];

  SetContractInputs(input, i);
}


void PrintPassedResultByTag(
  PositionsTagType& players,
  OutputResultType& output)
{
  cout << "Pair 1: " << 
    players.decl1 << " - " << 
    players.decl2 << "\n";
  cout << "Pair 2: " << 
    players.def1 << " - " << 
    players.def2 << "\n";
  cout << "Passed out\n";
  cout << "Overall and bidding score: " << 
    fixed << setprecision(2) << output.overallDecl << " / " << 
    fixed << setprecision(2) << -output.overallDecl << "\n";
}


void PrintPassedResultByNumber(
  PositionsNumberType& players,
  OutputResultType& output)
{
  cout << "Pair 1: " << 
    static_cast<int>(players.decl1) << " - " << 
    static_cast<int>(players.decl2) << "\n";
  cout << "Pair 2: " << 
    static_cast<int>(players.def1) << " - " << 
    static_cast<int>(players.def2) << "\n";
  cout << "Passed out\n";
  cout << "Overall and bidding score: " << 
    fixed << setprecision(2) << output.overallDecl << " / " << 
    fixed << setprecision(2) << -output.overallDecl << "\n";
}


void PrintPlayedResultNumerical(
  OutputResultType& output)
{
  cout << 
    setw(24) << left << "Overall score: " << right << setw(6) <<
    fixed << setprecision(2) << output.overallDecl << " / " << 
    fixed << setprecision(2) << -output.overallDecl << "\n";
  cout << 
    setw(24) << left << "Bidding score: " << right << setw(6) <<
    fixed << setprecision(2) << output.bidScoreDecl << " / " << 
    fixed << setprecision(2) << -output.bidScoreDecl << "\n";
  cout << 
    setw(24) << left << "Declarer play score: " << right << setw(6) <<
    fixed << setprecision(2) <<
    (output.declFlag[0] ? output.playScoreDecl[0] : 
        output.playScoreDecl[1]) << "\n";
  cout << 
    setw(24) << left << "Lead score: " << right << setw(6) <<
    "       / " <<
    fixed << setprecision(2) <<
    (output.leadFlag[0] ? output.leadScoreDef[0] : 
      output.leadScoreDef[1]) << "\n";
  cout << 
    setw(24) << left << "Rest defense score: " << right << setw(6) <<
    "       / " <<
    fixed << setprecision(2) << output.restScoreDef << "\n";
}


void PrintPlayedResultByTag(
  PositionsTagType& players,
  OutputResultType& output)
{
  cout << 
    setw(24) << left << "Declaring pair: " << right <<
    players.decl1 << " - " << 
    players.decl2 << 
    " (declarer is " <<
    (output.declFlag[0] ? "first" : "second") <<
    " player)\n";
    cout << 
      setw(24) << left << "Defending pair: " << right <<
      players.def1 << " - " << 
      players.def2 << 
      " (opening leader is " <<
      (output.leadFlag[0] ? "first" : "second") <<
      " player)\n";
  
  PrintPlayedResultNumerical(output);
}

void PrintPlayedResultByNumber(
  PositionsNumberType& players,
  OutputResultType& output)
{
  cout << 
    setw(24) << left << "Declaring pair: " << right <<
    static_cast<int>(players.decl1) << " - " << 
    static_cast<int>(players.decl2) << 
    " (declarer is " <<
    (output.declFlag[0] ? "first" : "second") <<
    " player)\n";
    cout << 
      setw(24) << left << "Defending pair: " << right <<
      static_cast<int>(players.def1) << " - " << 
      static_cast<int>(players.def2) << 
      " (opening leader is " <<
      (output.leadFlag[0] ? "first" : "second") <<
      " player)\n";
  
  PrintPlayedResultNumerical(output);
}

