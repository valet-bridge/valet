/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


// These are support functions for the DLL driver.


#include <iostream>
#include <vector>
#include <string>
#include <cassert>

#include "valet.h"
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

const vector<PlayerTags> playerTagsList =
{
  { "SCHALTZ Martin",         "KRANYAK John",  
    "CHRISTIANSEN Soren",     "DEMUY Vincent"},
  { "SMITH Jeff",             "BRUM Paulo",  
    "MILES Daniel",           "SALOMAO Jeovani"},
  { "STEPHENS Robert",        "MAZURKIEWICZ Marcin",  
    "FICK Hennie",            "JASSEN Krzysztof"},
  { "SYLVAN Johan",           "HALLASA Jawan", 
    "WRANG Frederic",         "SWEIDAN Fadi"},
  { "TAN Gideon",             "DANAILOV Diyan",  
    "FONG Kien Hoong",        "STAMATOV Jerry"},
  { "TERAMOTO Tadashi",       "ABD ELLATEIF Khaled",  
    "KAKU Hiroshi",           "EISSA Tamer"},
  { "BARBOSA Roberto",        "WOLPERT Darren",  
    "BRENNER Diego",          "KORBEL Daniel"},
  { "BESSIS Thomas",          "KANG Meng", 
    "VOLCKER Frederic",       "SUN Shaolin"},
  { "BOUVERESSE Jean-Pierre", "WARE Michael",  
    "MATHIEU Philippe",       "TISLEVOLL Geir-Olav"},
  { "CORNELL Michael",        "GERIN Dominique",   
    "BACH Ashley",            "PELLETIER Jean-Claude"},
  { "ELSHORBAGY Emad",        "FURUTA Kazuo",  
    "MONIR Ahmed",            "CHEN Dawei"},
  { "ABDUL-HADI Rana",        "UPMARK Johan",   
    "ABDUL-JALIL Jamal",      "NYSTROM Fredrik"},
  { "HACKETT Justin",         "BANARJEE Amar",  
    "HACKETT Jason",          "ROY Rana"},
  { "HURD John",              "KONOW Kasper", 
    "WOOLDRIDGE Joel",        "ASKGAARD Michael"},
  { "KALITA Jacek",           "KAPREY Imtiaz",  
    "NOWOSADZKI Michal",      "GRUNDER Martin"},
  { "LI Xiaoyi",              "ROMBAUT Jerome",  
    "HU Linlin",              "COMBESCURE Francois"},
  { "MAJUMDER Subir",         "FORRESTER Tony",  
    "MANNA Gopinath",         "ROBSON Andrew"},
  { "MILNE Liam",             "NABIL Karim",  
    "GRIFFITHS Aneurin",      "SADEK Tarek"},
  { "MUZZIO Ernesto",         "MECKSTROTH Jeff",  
    "CAMBEROS Hector",        "RODWELL Eric"},
  { "NANEV Ivan",             "LOO Choon Chou",  
    "GUNV Rossen",            "POON Hua"},
  { "NICKELL Nick",           "GARCIA DA ROSA Rodrigo",  
    "KATZ Ralph",             "PELLEGRINI Carlos"},
  { "NOSHY Sherif",           "WYER Paul",  
    "RAMADAN Baher",          "COURTNEY Michael"}
};

const vector<PlayerNumbers> playerNumbersList =
{
  { 101,  62,  21,  27},
  { 102,  17,  77,  99},
  { 106,  74,  30,  53},
  { 110,  46, 127, 109},
  { 111,  26,  32, 104},
  { 113,   1,  54,  28},
  {  12, 124,  16,  61},
  {  14,  56, 118, 108},
  {  15, 120,  73, 115},
  {  23,  38,   7,  89},
  {  29,  34,  79,  20},
  {   3, 116,   4,  87},
  {  45,  10,  44,  95},
  {  51,  60, 126,   6},
  {  55,  57,  86,  42},
  {  66,  94,  49,  22},
  {  71,  33,  72,  92},
  {  78,  82,  41,  98},
  {  81,  75,  18,  93},
  {  83,  68,  43,  90},
  {  84,  35,  58,  88},
  {  85, 128,  91,  24}
};


const vector<InputResult> inputResults =
{
  // level, denom,   multiplier, decl,   tricks, lead suit, lead rank
  {      3, VALET_NOTRUMP,    0, VALET_EAST,  7, VALET_CLUBS,     4},
  {      4, VALET_HEARTS,     0, VALET_EAST,  9, VALET_SPADES,    2},
  {      4, VALET_HEARTS,     0, VALET_WEST,  8, VALET_CLUBS,    12},
  {      4, VALET_HEARTS,     0, VALET_WEST, 10, VALET_CLUBS,    12},
  {      4, VALET_HEARTS,     0, VALET_EAST,  8, VALET_DIAMONDS,  4},
  {      4, VALET_HEARTS,     0, VALET_WEST,  9, VALET_SPADES,   11},
  {      3, VALET_NOTRUMP,    0, VALET_EAST,  7, VALET_CLUBS,     4},
  {      4, VALET_HEARTS,     0, VALET_EAST,  9, VALET_DIAMONDS,  4},
  {      4, VALET_HEARTS,     0, VALET_EAST,  9, VALET_SPADES,    2},
  {      3, VALET_NOTRUMP,    0, VALET_EAST,  7, VALET_CLUBS,     4},
  {      3, VALET_NOTRUMP,    0, VALET_EAST,  9, VALET_SPADES,    2},
  {      4, VALET_HEARTS,     0, VALET_EAST, 10, VALET_DIAMONDS,  6},
  {      4, VALET_HEARTS,     0, VALET_EAST,  9, VALET_DIAMONDS,  4},
  {      4, VALET_HEARTS,     0, VALET_EAST,  9, VALET_DIAMONDS,  4},
  {      4, VALET_HEARTS,     0, VALET_WEST,  9, VALET_SPADES,   11},
  {      4, VALET_HEARTS,     0, VALET_EAST,  9, VALET_DIAMONDS,  4},
  {      4, VALET_HEARTS,     0, VALET_EAST, 10, VALET_DIAMONDS,  3},
  {      4, VALET_HEARTS,     0, VALET_WEST,  9, VALET_SPADES,    6},
  {      3, VALET_NOTRUMP,    0, VALET_EAST,  9, VALET_CLUBS,     4},
  {      3, VALET_NOTRUMP,    0, VALET_EAST,  7, VALET_CLUBS,     6},
  {      3, VALET_NOTRUMP,    0, VALET_EAST,  7, VALET_CLUBS,     6},
  {      3, VALET_NOTRUMP,    0, VALET_EAST,  7, VALET_CLUBS,     6}
};


void setContractInputs(
  InputResult& input,
  const unsigned resultNo);


int getMode(
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


void usage(char * argv[])
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


void setContractInputs(
  InputResult& input,
  const unsigned resultNo)
{
  input = inputResults[resultNo];

  assert(input.level <= 7);
  assert(input.denom <= 4);
  assert(input.multiplier <= 2);
  assert(input.declarer <= 3);
  assert(input.tricks <= 13);
  assert(input.leadDenom <= 4);
  assert(input.leadRank >= 2 && input.leadRank <= 14);
}


void setTagInputs(
  PlayerTags& playerTags, 
  InputResult& input, 
  const unsigned resultNo)
{
  playerTags = playerTagsList[resultNo];

  setContractInputs(input, resultNo);
}


void setNumberInputs(
  PlayerNumbers& playerNumbers, 
  InputResult& input, 
  const unsigned resultNo)
{
  playerNumbers = playerNumbersList[resultNo];

  assert(playerNumbers.north > 0);
  assert(playerNumbers.east > 0);
  assert(playerNumbers.west > 0);
  assert(playerNumbers.south > 0);

  setContractInputs(input, resultNo);
}

