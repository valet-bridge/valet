/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/

#include "valet.h"

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

#include <fstream>
#include <string>
#include <stdlib.h>
#include <string.h>

#include "pairs/Players.h"
#include "pairs/Pairs.h"
#include "hand/Hand.h"

#include "scores/ScoreInput.h"

#include "inputs/parse.h"

#include "scoring.h"


using namespace std;

Options options;
Players players;
Pairs pairs;
map<string, Hand> hands;
Hand hand;
Error error;

vector<ScoreInput> entries;
unsigned nextEntry = 0;


bool checkNonzeroPlayer(
  const int& playerNo,
  const string& str,
  const int errNo);

bool checkNonzeroPlayer(
  const string& playerStr,
  const string& str,
  const int errNo);

int checkNonzeroPlayers(const PlayerNumbers& playersIn);

int checkNonzeroPlayers(const PlayerTags& playersIn);

void addPlayers(const PlayerTags& playersIn);

void addPlayers(const PlayerNumbers& playersIn);

int setResult(
  const InputResult& input,
  Result& result);

void setOutput(
  const ScoreInput& vres,
  OutputResult& output);



void STDCALL ValetInit()
{
  setTables();

  error.flag = false;
  error.no = RETURN_NO_FAULT;
  error.message.str("");

  options.valet = static_cast<ScoringEnum>(VALET_SCORING_IAF);
  options.leadFlag = false;
  options.datumHardRounding = false;
  options.cloudFlag = true;
  options.tableauFlag = false;
}


int STDCALL ValetSetControl(
  struct Control * controlPtr)
{
  if (controlPtr->valet == VALET_SCORING_DATUM)
    options.valet = VALET_IMPS;
  else if (controlPtr->valet == VALET_SCORING_IAF)
    options.valet = VALET_IMPS_ACROSS_FIELD;
  else if (controlPtr->valet == VALET_SCORING_MP)
    options.valet = VALET_MATCHPOINTS;
  else
  {
    error.flag = true;
    error.no = RETURN_VALET_MODE;
    error.message << "Got mode: " << controlPtr->valet << "\n";
    return error.no;
  }

  options.leadFlag = controlPtr->leadFlag;

  options.datumHardRounding = controlPtr->datumHardRounding;

  options.cloudFlag = controlPtr->cloudFlag;

  options.tableauFlag = controlPtr->tableauFlag;

  return RETURN_NO_FAULT;
}


void STDCALL ValetClear()
{
  ValetClearHand();
  pairs.reset();
}


void STDCALL ValetClearHand()
{
  hand.reset();
  nextEntry = 0;
}


int STDCALL ValetSetBoardNumber(
  unsigned no)
{
  if (no == 0)
    return RETURN_BOARD_NUMBER;
  else
    return hand.setBoardNumber(no);
}


void addPlayers(const PlayerTags& playerTags)
{
  players.add(string(playerTags.north), string(playerTags.north));
  players.add(string(playerTags.east), string(playerTags.east));
  players.add(string(playerTags.south), string(playerTags.south));
  players.add(string(playerTags.west), string(playerTags.west));
}


void addPlayers(const PlayerNumbers& playerNumbers)
{
  players.add(to_string(playerNumbers.north), 
    to_string(playerNumbers.north));
  players.add(to_string(playerNumbers.east), 
    to_string(playerNumbers.east));
  players.add(to_string(playerNumbers.south), 
    to_string(playerNumbers.south));
  players.add(to_string(playerNumbers.west), 
    to_string(playerNumbers.west));
}


int STDCALL ValetAddByLine(char line[])
{
  string str(line);
  Result result;

  unsigned rno = 0, bno = 0;

  int r = parseScoreLine(str, result, rno, bno, true);
  if (r != RETURN_NO_FAULT)
    return r;

  if ((r = hand.setBoardNumber(bno)) != RETURN_NO_FAULT)
  {
    error.message << "Got board number: " << bno <<
      " (expected " << hand.getBoardNumber() << ")\n";
    error.message << "Parsed line: '" << line << "'\n";
    return r;
  }

  // Inelegant: Reparse the string, this time into a PlayerTags.
  PlayerTags playerTags;
  r = parseScoreLine(str, playerTags);
  if (r != RETURN_NO_FAULT)
    return r;

  addPlayers(playerTags);

  hand.add(result);
  return RETURN_NO_FAULT;
}


int setResult(
  const InputResult& input,
  Result& result)
{
  unsigned vulNS, vulEW;
  getVul(hand.getBoardNumber(), vulNS, vulEW);
  const unsigned vul = 
    (input.declarer == VALET_NORTH || input.declarer == VALET_SOUTH ?
    vulNS : vulEW);

  result.setGeneralResult(
    input.level,
    input.denom,
    input.multiplier,
    input.declarer,
    input.tricks,
    vul);

  result.setLead(
    input.leadDenom,
    input.leadRank);

  return RETURN_NO_FAULT;
}


bool checkNonzeroPlayer(
  const int& playerNo,
  const string& str,
  const int errNo)
{
  if (playerNo == 0)
  {
    error.flag = true;
    error.no = errNo;
    error.message << "Got " << str << " number: " << 
      playerNo << " (must be >= 1)\n";

    return false;
  }
  else
    return true;
}


int checkNonzeroPlayers(const PlayerNumbers& playerNumbers)
{
  if (! checkNonzeroPlayer(playerNumbers.north, "North", 
      RETURN_PLAYER_NORTH))
    return error.no;

  if (! checkNonzeroPlayer(playerNumbers.east, "East", 
      RETURN_PLAYER_EAST))
    return error.no;

  if (! checkNonzeroPlayer(playerNumbers.south, "South", 
      RETURN_PLAYER_SOUTH))
    return error.no;

  if (! checkNonzeroPlayer(playerNumbers.west, "West", 
      RETURN_PLAYER_WEST))
    return error.no;

  return RETURN_NO_FAULT;
}


bool checkNonzeroPlayer(
  const string& playerStr,
  const string& str,
  const int errNo)
{
  if (playerStr == "0")
  {
    error.flag = true;
    error.no = errNo;
    error.message << "Got " << str << " number: " << 
      playerStr << " (must be >= 1)\n";

    return false;
  }
  else
    return true;
}


int checkNonzeroPlayers(const PlayerTags& playerTags)
{
  if (! checkNonzeroPlayer(playerTags.north, "North", RETURN_PLAYER_NORTH))
    return error.no;

  if (! checkNonzeroPlayer(playerTags.east, "East", RETURN_PLAYER_EAST))
    return error.no;

  if (! checkNonzeroPlayer(playerTags.south, "South", RETURN_PLAYER_SOUTH))
    return error.no;

  if (! checkNonzeroPlayer(playerTags.west, "West", RETURN_PLAYER_WEST))
    return error.no;

  return RETURN_NO_FAULT;
}


int STDCALL ValetAddByTag(
  struct PlayerTags * playerTagsPtr,
  struct InputResult * inputPtr)
{
  Result result;
  result.setPlayers(
    playerTagsPtr->north,
    playerTagsPtr->east,
    playerTagsPtr->south,
    playerTagsPtr->west);

  int r;
  if ((r = checkNonzeroPlayers(* playerTagsPtr)) != RETURN_NO_FAULT)
    return r;

  if ((r = setResult(* inputPtr, result)) != RETURN_NO_FAULT)
    return r;

  addPlayers(* playerTagsPtr);
  hand.add(result);
  return RETURN_NO_FAULT;
}


int STDCALL ValetAddByNumber(
  struct PlayerNumbers * playerNumbersPtr,
  struct InputResult * inputPtr)
{
  Result result;
  result.setPlayers(
    to_string(playerNumbersPtr->north),
    to_string(playerNumbersPtr->east),
    to_string(playerNumbersPtr->south),
    to_string(playerNumbersPtr->west));

  int r;
  if ((r = checkNonzeroPlayers(* playerNumbersPtr)) != RETURN_NO_FAULT)
    return r;

  if ((r = setResult(* inputPtr, result)) != RETURN_NO_FAULT)
    return r;

  addPlayers(* playerNumbersPtr);
  hand.add(result);
  return RETURN_NO_FAULT;
}


void STDCALL ValetCalculate()
{
  entries.clear();
  hand.calculateScores(entries);
  nextEntry = 0;
}


void setOutput(
  const ScoreInput& entry,
  OutputResult& output)
{
  output.declFlag[0] = entry.declFlag[0];
  output.declFlag[1] = entry.declFlag[1];

  output.defFlag = entry.defFlag;

  output.leadFlag[0] = entry.leadFlag[0];
  output.leadFlag[1] = entry.leadFlag[1];

  output.overallDecl = entry.overall;
  output.bidScoreDecl = entry.bidScore;
  
  output.playScoreDecl[0] = entry.playScore[0];
  output.playScoreDecl[1] = entry.playScore[1];
  
  output.leadScoreDef[0] = entry.leadScore[0];
  output.leadScoreDef[1] = entry.leadScore[1];

  output.restScoreDef = entry.defScore;
}


bool STDCALL ValetGetNextScoreByTag(
  struct PositionTags * positionTagsPtr,
  struct OutputResult * outputPtr)
{
  if (nextEntry == entries.size())
    return false;

  const ScoreInput& entry = entries[nextEntry];
  nextEntry++;

  string decl1, decl2, def1, def2;
  pairs.getPairTags(entry.pairNo, decl1, decl2);
  pairs.getPairTags(entry.oppNo, def1, def2);

  strncpy(positionTagsPtr->decl1, decl1.c_str(), VALET_INPUT_MAX_LENGTH);
  strncpy(positionTagsPtr->decl2, decl2.c_str(), VALET_INPUT_MAX_LENGTH);
  strncpy(positionTagsPtr->def1, def1.c_str(), VALET_INPUT_MAX_LENGTH);
  strncpy(positionTagsPtr->def2, def2.c_str(), VALET_INPUT_MAX_LENGTH);

  setOutput(entry, * outputPtr);
  return true;
}


bool STDCALL ValetGetNextScoreByNumber(
  struct PositionNumbers * positionNumbersPtr,
  struct OutputResult * outputPtr)
{
  if (nextEntry == entries.size())
    return false;

  const ScoreInput& entry = entries[nextEntry];
  nextEntry++;

  string decl1, decl2, def1, def2;
  pairs.getPairTags(entry.pairNo, decl1, decl2);
  pairs.getPairTags(entry.oppNo, def1, def2);

  char *pend;
  positionNumbersPtr->decl1 = 
    static_cast<unsigned>(strtol(decl1.c_str(), &pend, 10));
  positionNumbersPtr->decl2 = 
    static_cast<unsigned>(strtol(decl2.c_str(), &pend, 10));
  positionNumbersPtr->def1 = 
    static_cast<unsigned>(strtol(def1.c_str(), &pend, 10));
  positionNumbersPtr->def2 = 
    static_cast<unsigned>(strtol(def2.c_str(), &pend, 10));

  setOutput(entry, * outputPtr);
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

