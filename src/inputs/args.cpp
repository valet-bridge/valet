/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


// These functions parse the command line for options.


#include <iostream>
#include <iomanip>
#include <vector>

#include "args.h"
#include "parse.h"

#include "../cst.h"

using namespace std;


extern Options options;

struct OptEntry
{
  string shortName;
  string longName;
  unsigned numArgs;
};

const vector<OptEntry> optList =
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
  {"t", "tableau", 1},
  {"p", "pairs", 1},
  {"x", "nocloud", 0},
  {"c", "compensate", 0},
  {"o", "order", 1},
  {"a", "average", 0},
  {"f", "format", 1},
  {"j", "join", 1}
};


int getNextArgToken(
  const int argc,
  char const * argv[],
  int& nextToken,
  char const *& optarg);

void setDefaults();

bool parseRound(char const * optarg);


void usage(const char base[])
{
  string basename(base);
  const size_t l = basename.find_last_of("\\/");
  if (l != string::npos)
    basename.erase(0, l+1);

  cout <<
    "Usage: " << basename << " [options]\n\n" <<
    "-v, --valettype s  Valet type, one of datum, imps, matchpoints\n" <<
    "                   (default: imps).\n" <<
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
    "-x, --nocloud      Use the simpler, but mathematically less\n" <<
    "                   satisfying Valet score (default: not set).\n" <<
    "\n" <<
    "-t, --tableau      Output a file of tableaux for each hand\n" <<
    "                   to file argument (default: not set).\n" <<
    "\n" <<
    "-p, --pairs        Output a file of scores ordered by pair.\n" <<
    "\n" <<
    "-c, --compensate   Compensate overall score for the average strength\n" <<
    "                   of the specific opponents faced (default: no).\n" <<
    "\n" <<
    "-o, --order s      Sorting order of the output.  Valid orders are\n" <<
    "                   overall, bidding, play, defense, lead,\n" <<
    "                   bidoverplay (bidding minus play),\n" <<
    "                   defoverplay (defense minus play),\n" <<
    "                   leadoverplay (lead minus play),\n" <<
    "                   (case-insensitive).\n" <<
    "\n" <<
    "-a, --average      Show certain averages in the output tables.\n"
    "\n" <<
    "-f, --format s     Output file format: text or csv (broadly\n" <<
    "                   speaking, comma-separated values suitable for\n" <<
    "                   loading into e.g. Microsoft Excel)\n" <<
    "                   (default: text).\n" <<
    "\n" <<
    "-j, --join c       Separator for csv output (default the comma,\n" <<
    "                   ',' (without the marks).  In German Excel it \n" <<
    "                   is useful to set this to ';', and so on.\n" <<
    endl;
}


int getNextArgToken(
  const int argc,
  char const * argv[],
  int& nextToken,
  char const *& optarg)
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

  for (const auto& opt: optList)
  {
    if (str == opt.shortName || str == opt.longName)
    {
      if (opt.numArgs == 1)
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


void setDefaults()
{
  options.valet = VALET_IMPS_ACROSS_FIELD;
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
  options.cloudFlag = true;
  options.tableauFlag = false;
  options.pairSheetsFlag = false;
  options.compensateFlag = false;
  options.sort = VALET_SORT_OVERALL;
  options.averageFlag = false;
  options.format = VALET_FORMAT_TEXT;
  options.separator = ',';
}


void printOptions()
{
  cout << left;
  cout << setw(12) << "valettype" << 
    setw(12) << scoringTags[options.valet].arg << "\n";
  cout << setw(12) << "directory" << 
    setw(12) << options.directory << "\n";
  cout << setw(12) << "names" << 
    setw(12) << options.nameFile << "\n";
  cout << setw(12) << "scores" << 
    setw(12) << options.scoresFile << "\n";
  if (options.roundFlag)
    cout << setw(12) << "rounds" << options.roundFirst << 
      " to " << options.roundLast << "\n";
  else
    cout << setw(12) << "rounds" << "no limitation\n";
  cout << setw(12) << "minhands" << 
    setw(12) << options.minHands << "\n";
  cout << setw(12) << "lead" << setw(12) << 
    (options.leadFlag ? "true" : "false") << "\n";
  cout << setw(12) << "extremes" << 
    setw(12) << (options.datumFilter ? "true" : "false") << "\n";
  cout << setw(12) << "hardround" << 
    setw(12) << (options.datumHardRounding ? "true" : "false") << "\n";
  cout << setw(12) << "cloud" << 
    setw(12) << (options.cloudFlag ? "true" : "false") << "\n";
  cout << setw(12) << "tableau" << setw(12) << 
    (options.datumHardRounding ? options.tableauFile : "false") << "\n";
  cout << setw(12) << "pair sheet" << setw(12) << 
    options.pairSheetsFlag << "\n";
  cout << setw(12) << "compensate" << 
    setw(12) << (options.compensateFlag ? "true" : "false") << "\n";
  cout << setw(12) << "order" << 
    setw(12) << sortingTags[options.sort].str << "\n";
  cout << setw(12) << "average" << 
    setw(12) << (options.averageFlag ? "true" : "false") << "\n";
  cout << setw(12) << "format" << setw(12) << 
    (options.format == VALET_FORMAT_TEXT ? "text" : "csv") << "\n";
  cout << setw(12) << "join" << 
    setw(12) << options.separator << "\n";
  cout << "\n" << right;
}


bool parseRound(char const * optarg)
{
  // Allow 5 as well as 1-3
  string str(optarg);
  int m;

  if (parseInt(str, m))
  {
    if (m <= 0)
      return false;

    options.roundFirst = static_cast<unsigned>(m);
    options.roundLast = static_cast<unsigned>(m);
    return true;
  }

  vector<string> tokens;
  tokenize(str, tokens, "-");
  if (tokens.size() != 2)
    return false;

  if (! parseInt(tokens[0], m) || m <= 0)
      return false;

  options.roundFirst = static_cast<unsigned>(m);

  if (! parseInt(tokens[1], m) || m <= 0)
      return false;

  options.roundLast = static_cast<unsigned>(m);

  return (options.roundFirst <= options.roundLast);
}


void readArgs(
  const int argc,
  const char * argv[])
{
  if (argc == 1)
  {
    usage(argv[0]);
    exit(0);
  }

  setDefaults();

  int c, m, nextToken = 1;
  bool errFlag = false, matchFlag;
  char const * optarg;

  string stmp;

  while ((c = getNextArgToken(argc, argv, nextToken, optarg)) > 0)
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
        if (! parseRound(optarg))
        {
          cout << " Could not parse round\n";
          nextToken -= 2;
          errFlag = true;
        }
        break;

      case 'm':
        stmp = optarg;
        if (! parseInt(stmp, m) || m < 1)
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

      case 'x':
        options.cloudFlag = false;
        break;

      case 't':
        options.tableauFlag = true;
        options.tableauFile = optarg;
        break;

      case 'p':
        options.pairSheetsFlag = true;
        options.pairSheetsFile = optarg;
        break;

      case 'c':
        options.compensateFlag = true;
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

      case 'a':
        options.averageFlag = true;
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

      case 'j':
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

