/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// These functions parse the command line for options.


#include <iostream>
#include <iomanip>
#include <string>
#include <stdlib.h>
#include <string.h>

#include "args.h"
#include "cst.h"

using namespace std;


extern OptionsType options;

struct optEntry
{
  string shortName;
  string longName;
  unsigned numArgs;
};

#define VALET_NUM_OPTIONS 13

const optEntry optList[VALET_NUM_OPTIONS] =
{
  {"v", "valettype", 1},
  {"d", "directory", 1},
  {"n", "names", 1},
  {"s", "scores", 1},
  {"r", "rounds", 1},
  {"m", "minhands", 1},
  {"l", "leads", 0},
  {"e", "extremes", 0},
  {"h", "hardround", 0},
  {"a", "adjustopps", 0},
  {"o", "order", 1},
  {"f", "format", 1},
  {"c", "char", 1}
};

string shortOptsAll, shortOptsWithArg;

int GetNextArgToken(
  int argc,
  char * argv[]);

void SetDefaults();

bool ParseRound();


void Usage(
  const char base[])
{
  string basename(base);
  const size_t l = basename.find_last_of("\\/");
  if (l != string::npos)
    basename.erase(0, l+1);

  cout <<
    "Usage: " << basename << " [options]\n\n" <<
    "-v, --valettype s  Valet type, one of datum, imps, matchpoints\n" <<
    "                   (default: datum).\n" <<
    "\n" <<
    "-d, --directory s  Read the input files from directory s.\n" <<
    "\n" <<
    "-n, --names s      Use s as the names file (default names.txt)\n" <<
    "\n" <<
    "-s, --scores s     Use s as the scores file (default scores.txt)\n" <<
    "\n" <<
    "-r, --rounds list  Selects only rounds specified in list.\n" <<
    "                   Example (note: no spaces) 1,3-5,7 (default all)\n" <<
    "\n" <<
    "-m, --minhands m   Only show results for pairs/players who have\n" <<
    "                   played at least m hands (default 0)\n" <<
    "\n" <<
    "-l, --lead         Show a Valet score for the lead separately\n" <<
    "                   (default: no)\n" <<
    "\n" <<
    "-e, --extremes     When calculating datum score (only for Butler\n" <<
    "                   IMPs), throw out the maximum and minimum\n" <<
    "                   scores (default: no, -e turns it on).\n" <<
    "\n" <<
    "-h, --hardround    When calculating datum score (only for Butler\n" <<
    "                   IMPs), round down and not to the nearest\n" <<
    "                   score.  So 379 rounds to 370, not to 380\n" <<
    "                   (default: no).\n" <<
    "\n" <<
    "-a, -adjustopps    Adjust overall score for the average strength\n" <<
    "                   of the specific opponents faced (default: no).\n" <<
    "\n" <<
    "-o, --order s      Sorting order of the output.  Valid orders are\n" <<
    "                   overall, bidding, play, defense, lead,\n" <<
    "                   bidoverplay (bidding minus play),\n" <<
    "                   defoverplay (defense minus play),\n" <<
    "                   leadoverplay (lead minus play),\n" <<
    "                   (case-insensitive).\n" <<
    "\n" <<
    "-f, --format s     Output file format: text or csv (broadly\n" <<
    "                   speaking, comma-separated values suitable for\n" <<
    "                   loading into e.g. Microsoft Excel)\n" <<
    "                   (default: text).\n" <<
    "\n" <<
    "-c, --char c       Separator for csv output (default the comma,\n" <<
    "                   ',' (without the marks).  In German Excel it \n" <<
    "                   is useful to set this to ';', and so on.\n" <<
    endl;
}


int nextToken = 1;
char * optarg;

int GetNextArgToken(
  int argc,
  char * argv[])
{
  // 0 means done, -1 means error.

  if (nextToken >= argc)
    return 0;

  string str(argv[nextToken]);
  if (str[0] != '-' || str.size() == 1)
    return -1;

  if (str[1] == '-')
  {
    if (str.size() == 2)
      return -1;
    str.erase(0, 2);
  }
  else if (str.size() == 2)
    str.erase(0, 1);
  else
    return -1;

  for (unsigned i = 0; i < VALET_NUM_OPTIONS; i++)
  {
    if (str == optList[i].shortName || str == optList[i].longName)
    {
      if (optList[i].numArgs == 1)
      {
        if (nextToken+1 >= argc)
          return -1;

        optarg = argv[nextToken+1];
        nextToken += 2;
      }
      else
        nextToken++;

      return str[0];
    }
  }

  return -1;
}


void SetDefaults()
{
  options.valet = VALET_IMPS;
  options.directory = ".";
  options.nameFile = "names.txt";
  options.scoresFile = "scores.txt";
  options.roundFlag = false;
  options.roundFirst = 0;
  options.roundLast = 0;
  options.minHands = 0;
  options.leadFlag = false;
  options.datumFilter = false;
  options.datumHardRounding = false;
  options.adjustForOpps = false;
  options.sort = VALET_SORT_OVERALL;
  options.format = VALET_FORMAT_TEXT;
  options.separator = ',';
}


void PrintOptions()
{
  cout << left;
  cout << setw(12) << "valet" << setw(12) << 
    scoringTags[options.valet].arg << "\n";
  cout << setw(12) << "directory" << setw(12) << options.directory << "\n";
  cout << setw(12) << "names" << setw(12) << options.nameFile << "\n";
  cout << setw(12) << "scores" << setw(12) << options.scoresFile << "\n";
  if (options.roundFlag)
    cout << setw(12) << "rounds" << options.roundFirst << " to " <<
      options.roundLast << "\n";
  else
    cout << setw(12) << "rounds" << "no limitation\n";
  cout << setw(12) << "minhands" << setw(12) << options.minHands << "\n";
  cout << setw(12) << "lead" << setw(12) << 
    (options.leadFlag ? "true" : "false") << "\n";
  cout << setw(12) << "extremes" << setw(12) << 
    (options.datumFilter ? "true" : "false") << "\n";
  cout << setw(12) << "hardround" << setw(12) << 
    (options.datumHardRounding ? "true" : "false") << "\n";
  cout << setw(12) << "adjustopps" << setw(12) << 
    (options.adjustForOpps ? "true" : "false") << "\n";
  cout << setw(12) << "order" << setw(12) << 
    sortingTags[options.sort].str << "\n";
  cout << setw(12) << "format" << setw(12) << 
    (options.format == VALET_FORMAT_TEXT ? "text" : "csv") << "\n";
  cout << setw(12) << "char" << setw(12) << options.separator << "\n";
  cout << "\n" << right;
}


bool ParseRound()
{
  // Allow 5 as well as 1-3
  char * temp;
  int m = static_cast<int>(strtol(optarg, &temp, 0));
  if (* temp == '\0')
  {
    if (m <= 0)
    {
      return false;
    }
    else
    {
      options.roundFirst = static_cast<unsigned>(m);
      options.roundLast = static_cast<unsigned>(m);
      return true;
    }
  }

  string stmp(optarg);
  string::size_type pos;
  pos = stmp.find_first_of("-", 0);
  if (pos == std::string::npos || pos > 7)
    return false;

  char str1[8], str2[8];
#if (! defined_MSC_VER || _MSC_VER < 1400)
  strncpy(str1, stmp.c_str(), pos);
#else
  strncpy_s(str1, stmp.c_str(), pos);
#endif
  str1[pos] = '\0';
  if ((m = atoi(str1)) <= 0)
    return false;
  options.roundFirst = static_cast<unsigned>(m);

  stmp.erase(0, pos+1);
#if (! defined_MSC_VER || _MSC_VER < 1400)
  strncpy(str2, stmp.c_str(), stmp.size());
#else
  strncpy_s(str2, stmp.c_str(), stmp.size());
#endif
  str2[stmp.size()] = '\0';
  if ((m = atoi(str2)) <= 0)
    return false;
  options.roundLast = static_cast<unsigned>(m);

  if (options.roundLast < options.roundFirst)
    return false;

  return true;
}


void ReadArgs(
  int argc,
  char * argv[])
{
  for (unsigned i = 0; i < VALET_NUM_OPTIONS; i++)
  {
    shortOptsAll += optList[i].shortName;
    if (optList[i].numArgs)
      shortOptsWithArg += optList[i].shortName;
  }

  if (argc == 1)
  {
    Usage(argv[0]);
    exit(0);
  }

  SetDefaults();

  int c, m;
  bool errFlag = false, matchFlag;
  string stmp;

  while ((c = GetNextArgToken(argc, argv)) > 0)
  {
    switch(c)
    {
      case 'v':
        stmp = optarg;
        matchFlag = false;
        for (unsigned i = 0; i < 3; i++)
        {
          if (stmp == scoringTags[i].arg)
          {
            options.valet = scoringTags[i].scoring;
            matchFlag = true;
            break;
          }
        }
        if (! matchFlag)
        {
          cout << "valet must be written exactly as in the list\n";
          nextToken -= 2;
          errFlag = true;
        }
        break;

      case 'd':
        options.directory = optarg;
        break;

      case 'n':
        options.nameFile = optarg;
        break;

      case 's':
        options.scoresFile = optarg;
        break;

      case 'r':
        options.roundFlag = true;
        if (! ParseRound())
        {
          cout << " Could not parse round\n";
          nextToken -= 2;
          errFlag = true;
        }
        break;

      case 'm':
        char * temp;
        m = static_cast<int>(strtol(optarg, &temp, 0));
        if (m < 1)
        {
          cout << "Number of hands must be >= 1\n\n";
          nextToken -= 2;
          errFlag = true;
        }
        options.minHands = static_cast<unsigned>(m);
        break;

      case 'l':
        options.leadFlag = true;
        break;

      case 'e':
        options.datumFilter = true;
        break;

      case 'h':
        options.datumHardRounding = true;
        break;

      case 'a':
        options.adjustForOpps = true;
        break;

      case 'o':
        stmp = optarg;
        matchFlag = false;
        for (unsigned i = 0; i < 8; i++)
        {
          if (stmp == sortingTags[i].str)
          {
            options.sort = sortingTags[i].sort;
            matchFlag = true;
            break;
          }
        }
        if (! matchFlag)
        {
          cout << "order must be written exactly as in the list\n";
          nextToken -= 2;
          errFlag = true;
        }
        break;

      case 'f':
        stmp = optarg;
        if (stmp == "text")
          options.format = VALET_FORMAT_TEXT;
        else if (stmp == "csv")
          options.format = VALET_FORMAT_CSV;
        else
        {
          cout << "format must be text or csv\n";
          nextToken -= 2;
          errFlag = true;
        }
        break;

      case 'c':
        options.separator = optarg;
        if (options.separator.size() != 1)
        {
          cout << "char must consist of a single character\n";
          nextToken -= 2;
          errFlag = true;
        }
        break;

      default:
        cout << "Unknown option\n";
        errFlag = true;
        break;
    }
    if (errFlag)
      break;
  }

  if (errFlag || c == -1)
  {
    cout << "Error while parsing option '" << argv[nextToken] << "'\n";
    cout << "Invoke the program without arguments for help" << endl;
    exit(0);
  }
}

