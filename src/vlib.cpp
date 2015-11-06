/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#include <string>
#include <stdlib.h>
#include <string.h>

#include "valet.h"
#include "parse.h"
#include "scoring.h"
#include "Pairs.h"
#include "Hand.h"

using namespace std;

OptionsType options;
Hand hand;
Pairs pairs;
ErrorType error;

unsigned numEntries = 16;
vector<ValetEntryType> entries(numEntries);
unsigned nextEntry = 0;


void ValetInit();

int CheckNonzeroPlayers(
  ResultType& res);

void AddPlayers(
  const ResultType& res);

int SetInput(
  InputResultType * input,
  ResultType& res);

void SetResults(
  OutputResultType * output,
  ValetEntryType& vres);


#if defined(_WIN32) || defined(USES_DLLMAIN)

#include <windows.h>

#ifndef UNUSED
  #define UNUSED(x) ((void)(true ? 0 : ((x), void(), 0)))
#endif

extern "C" BOOL APIENTRY DllMain(
  HMODULE hModule,
  DWORD ul_reason_for_call,
  LPVOID lpReserved);

extern "C" BOOL APIENTRY DllMain(
  HMODULE hModule,
  DWORD ul_reason_for_call,
  LPVOID lpReserved)
{

  if (ul_reason_for_call == DLL_PROCESS_ATTACH)
    ValetInit();
  else if (ul_reason_for_call == DLL_PROCESS_DETACH)
  {
  }

  UNUSED(hModule);
  UNUSED(lpReserved);

  return 1;
}

#elif defined(__linux) || defined(__APPLE__)

static void __attribute__ ((constructor)) libInit(void)
{
  ValetInit();
}


static void __attribute__ ((destructor)) libEnd(void)
{
}

#endif


void STDCALL ValetInit()
{
  error.flag = false;
  error.no = RETURN_NO_FAULT;
  error.message.str("");
  SetTables();
}


int STDCALL ValetSetControl(
  struct ControlType * control)
{
  if (control->valet == VALET_SCORING_DATUM)
    options.valet = VALET_IMPS;
  else if (control->valet == VALET_SCORING_IAF)
    options.valet = VALET_IMPS_ACROSS_FIELD;
  else if (control->valet == VALET_SCORING_MP)
    options.valet = VALET_MATCHPOINTS;
  else
  {
    error.flag = true;
    error.no = RETURN_VALET_MODE;
    error.message << "Got mode: " << control->valet << "\n";
    return error.no;
  }

  options.leadFlag = control->leadFlag;

  options.datumHardRounding = control->datumHardRounding;

  return RETURN_NO_FAULT;
}


void STDCALL ValetClear()
{
  ValetClearHand();
  pairs.Reset();
}


void STDCALL ValetClearHand()
{
  hand.Reset();
  nextEntry = 0;
}


int STDCALL ValetSetBoardNumber(
  unsigned no)
{
  if (no == 0)
    return RETURN_BOARD_NUMBER;
  else
    return hand.SetBoardNumber(no);
}


void AddPlayers(
  const ResultType& res)
{
  pairs.AddPlayer(res.north, res.north);
  pairs.AddPlayer(res.east, res.east);
  pairs.AddPlayer(res.south, res.south);
  pairs.AddPlayer(res.west, res.west);
}


int STDCALL ValetAddByLine(
  char line[VALET_INPUT_MAX_LENGTH])
{
  string str(line);
  ResultType res;
  unsigned rno, bno;

  int r = ParseScoreLine(str, res, rno, bno, true);
  if (r != RETURN_NO_FAULT)
    return r;

  if ((r = hand.SetBoardNumber(bno)) != RETURN_NO_FAULT)
  {
    error.message << "Got board number: " << bno <<
      " (expected " << hand.GetBoardNumber() << ")\n";
    error.message << "Parsed line: '" << line << "'\n";
    return r;
  }

  AddPlayers(res);

  hand.AddResult(res);
  return RETURN_NO_FAULT;
}


int SetInput(
  InputResultType * input,
  ResultType& res)
{
  res.level = input->level;
  res.denom = input->denom;
  res.multiplier = input->multiplier;
  res.declarer = input->declarer;
  res.tricks = input->tricks;
  res.leadDenom = input->leadDenom;
  res.leadRank = input->leadRank;

  if (res.level == 0 || res.level > 7)
  {
    error.flag = true;
    error.no = RETURN_LEVEL;
    error.message << "Got level: " << res.level << " (expected 1 .. 7)\n";
    return RETURN_LEVEL;
  }

  if (res.denom > 4)
  {
    error.flag = true;
    error.no = RETURN_DENOM;
    error.message << "Got denom: " << res.denom << " (expected 0 .. 3)\n";
    return RETURN_DENOM;
  }

  if (res.multiplier > 2)
  {
    error.flag = true;
    error.no = RETURN_MULTIPLIER;
    error.message << "Got multiplier: " << res.multiplier << 
      " (expected 0 .. 2)\n";
    return RETURN_MULTIPLIER;
  }

  if (res.declarer > 3)
  {
    error.flag = true;
    error.no = RETURN_DECLARER;
    error.message << "Got declarer: " << res.declarer << 
      " (expected 0 .. 3)\n";
    return RETURN_DECLARER;
  }

  if (res.tricks > 13)
  {
    error.flag = true;
    error.no = RETURN_TRICKS;
    error.message << "Got tricks: " << res.tricks << 
      " (expected 0 .. 13)\n";
    return RETURN_TRICKS;
  }

  if (res.leadDenom > 4)
  {
    error.flag = true;
    error.no = RETURN_LEAD_DENOM;
    error.message << "Got leadDenom: " << res.leadDenom << 
      " (expected 0 .. 3)\n";
    return RETURN_LEAD_DENOM;
  }

  if (res.leadRank < 2 || res.leadRank > 14)
  {
    error.flag = true;
    error.no = RETURN_LEAD_RANK;
    error.message << "Got leadRank: " << res.leadDenom << 
      " (expected 2 .. 14)\n";
    return RETURN_LEAD_RANK;
  }

  return RETURN_NO_FAULT;
}


int CheckNonzeroPlayers(
  ResultType& res)
{
  if (res.north == "0")
  {
    error.flag = true;
    error.no = RETURN_PLAYER_NORTH;
    error.message << "Got North number: " << res.north <<
      " (must be >= 1)\n";
    return error.no;
  }

  if (res.east == "0")
  {
    error.flag = true;
    error.no = RETURN_PLAYER_EAST;
    error.message << "Got East number: " << res.east <<
      " (must be >= 1)\n";
    return error.no;
  }

  if (res.south == "0")
  {
    error.flag = true;
    error.no = RETURN_PLAYER_SOUTH;
    error.message << "Got South number: " << res.south <<
      " (must be >= 1)\n";
    return error.no;
  }

  if (res.west == "0")
  {
    error.flag = true;
    error.no = RETURN_PLAYER_WEST;
    error.message << "Got West number: " << res.west <<
      " (must be >= 1)\n";
    return error.no;
  }

  return RETURN_NO_FAULT;
}


int STDCALL ValetAddByTag(
  struct PlayersTagType * players,
  struct InputResultType * input)
{
  ResultType res;
  ostringstream ossn, osse, osss, ossw;

  ossn << players->north;
  res.north = ossn.str();
  osse << players->east;
  res.east = osse.str();
  osss << players->south;
  res.south = osss.str();
  ossw << players->west;
  res.west = ossw.str();

  int r;
  if ((r = CheckNonzeroPlayers(res)) != RETURN_NO_FAULT)
    return r;

  if ((r = SetInput(input, res)) != RETURN_NO_FAULT)
    return r;

  AddPlayers(res);
  hand.AddResult(res);
  return RETURN_NO_FAULT;
}


int STDCALL ValetAddByNumber(
  struct PlayersNumberType * players,
  struct InputResultType * input)
{
  ResultType res;
  ostringstream ossn, osse, osss, ossw;

  ossn << players->north;
  res.north = ossn.str();
  osse << players->east;
  res.east = osse.str();
  osss << players->south;
  res.south = osss.str();
  ossw << players->west;
  res.west = ossw.str();

  int r;
  if ((r = CheckNonzeroPlayers(res)) != RETURN_NO_FAULT)
    return r;

  if ((r = SetInput(input, res)) != RETURN_NO_FAULT)
    return r;

  AddPlayers(res);
  hand.AddResult(res);
  return RETURN_NO_FAULT;
}


void STDCALL ValetCalculate()
{
  unsigned num = hand.GetNumEntries();
  if (num > numEntries)
  {
    entries.resize(num);
    numEntries = num;
  }

  entries = hand.CalculateScores();
  nextEntry = 0;
}


void SetResults(
  OutputResultType * output,
  ValetEntryType& vres)
{
  output->declFlag[0] = vres.declFlag[0];
  output->declFlag[1] = vres.declFlag[1];

  output->defFlag = vres.defFlag;

  output->leadFlag[0] = vres.leadFlag[0];
  output->leadFlag[1] = vres.leadFlag[1];

  output->overallDecl = vres.overall;
  output->bidScoreDecl = vres.bidScore;
  
  output->playScoreDecl[0] = vres.playScore[0];
  output->playScoreDecl[1] = vres.playScore[1];
  
  output->leadScoreDef[0] = vres.leadScore[0];
  output->leadScoreDef[1] = vres.leadScore[1];

  output->restScoreDef = vres.defScore;
}


bool STDCALL ValetGetNextScoreByTag(
  struct PositionsTagType * positions,
  struct OutputResultType * output)
{
  if (nextEntry == entries.size())
    return false;

  ValetEntryType& vres = entries[nextEntry];
  nextEntry++;

  string decl1, decl2, def1, def2;
  pairs.GetPairTags(vres.pairNo, decl1, decl2);
  pairs.GetPairTags(vres.oppNo, def1, def2);

#if (! defined(_MSC_VER) || _MSC_VER < 1400)
  strncpy(positions->decl1, decl1.c_str(), VALET_TAG_MAX_LENGTH);
  strncpy(positions->decl2, decl2.c_str(), VALET_TAG_MAX_LENGTH);
  strncpy(positions->def1, def1.c_str(), VALET_TAG_MAX_LENGTH);
  strncpy(positions->def2, def2.c_str(), VALET_TAG_MAX_LENGTH);
#else
  strncpy_s(positions->decl1, decl1.c_str(), VALET_TAG_MAX_LENGTH);
  strncpy_s(positions->decl2, decl2.c_str(), VALET_TAG_MAX_LENGTH);
  strncpy_s(positions->def1, def1.c_str(), VALET_TAG_MAX_LENGTH);
  strncpy_s(positions->def2, def2.c_str(), VALET_TAG_MAX_LENGTH);
#endif

  SetResults(output, vres);
  return true;
}


bool STDCALL ValetGetNextScoreByNumber(
  struct PositionsNumberType * positions,
  struct OutputResultType * output)
{
  if (nextEntry == entries.size())
    return false;

  ValetEntryType& vres = entries[nextEntry];
  nextEntry++;

  string decl1, decl2, def1, def2;
  pairs.GetPairTags(vres.pairNo, decl1, decl2);
  pairs.GetPairTags(vres.oppNo, def1, def2);

  char *pend;
  positions->decl1 = static_cast<unsigned>(strtol(decl1.c_str(), &pend, 10));
  positions->decl2 = static_cast<unsigned>(strtol(decl2.c_str(), &pend, 10));
  positions->def1 = static_cast<unsigned>(strtol(def1.c_str(), &pend, 10));
  positions->def2 = static_cast<unsigned>(strtol(def2.c_str(), &pend, 10));

  SetResults(output, vres);
  return true;
}


void STDCALL ValetErrorMessage(
  int code,
  char line[160])
{
  switch (code)
  {
    case RETURN_NO_FAULT:
      strcpy(line, TEXT_NO_FAULT);
      break;
    case RETURN_UNKNOWN_FAULT:
      strcpy(line, TEXT_UNKNOWN_FAULT);
      break;
    case RETURN_VALET_MODE:
      strcpy(line, TEXT_VALET_MODE);
      break;
    case RETURN_TOKEN_NUMBER:
      strcpy(line, TEXT_TOKEN_NUMBER);
      break;

    case RETURN_ROUND_NUMBER:
      strcpy(line, TEXT_ROUND_NUMBER);
      break;
    case RETURN_BOARD_NUMBER:
      strcpy(line, TEXT_BOARD_NUMBER);
      break;
    case RETURN_BOARD_NUMBER_CHANGE:
      strcpy(line, TEXT_BOARD_NUMBER_CHANGE);
      break;
    case RETURN_PLAYER_NORTH:
      strcpy(line, TEXT_PLAYER_NORTH);
      break;
    case RETURN_PLAYER_EAST:
      strcpy(line, TEXT_PLAYER_EAST);
      break;
    case RETURN_PLAYER_SOUTH:
      strcpy(line, TEXT_PLAYER_SOUTH);
      break;
    case RETURN_PLAYER_WEST:
      strcpy(line, TEXT_PLAYER_WEST);
      break;
    case RETURN_CONTRACT_FORMAT_TEXT:
      strcpy(line, TEXT_CONTRACT_FORMAT_TEXT);
      break;
    case RETURN_TRICKS:
      strcpy(line, TEXT_TRICKS);
      break;
    case RETURN_LEAD_TEXT:
      strcpy(line, TEXT_LEAD_TEXT);
      break;
    case RETURN_LEVEL:
      strcpy(line, TEXT_LEVEL);
      break;
    case RETURN_DENOM:
      strcpy(line, TEXT_DENOM);
      break;
    case RETURN_MULTIPLIER:
      strcpy(line, TEXT_MULTIPLIER);
      break;
    case RETURN_DECLARER:
      strcpy(line, TEXT_DECLARER);
      break;
    case RETURN_LEAD_DENOM:
      strcpy(line, TEXT_LEAD_DENOM);
      break;
    case RETURN_LEAD_RANK:
      strcpy(line, TEXT_LEAD_RANK);
      break;
    default:
      strcpy(line, "Not a valet error code");
      return;
  }
  strcat(line, "\n");
  string tmp = error.message.str();
  strcat(line, tmp.c_str());
}

