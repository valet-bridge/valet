/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_H
#define VALET_H

#if defined(_WIN32) || defined(__CYGWIN__)
  #define DLLEXPORT __declspec(dllexport)
  #define STDCALL __stdcall
#else
  #define DLLEXPORT
  #define STDCALL
#endif

#ifdef __cplusplus
  #define EXTERN_C extern "C"
#else
  #define EXTERN_C
#endif


// Error codes. See interface document for more detail.
// Call ValetErrorMessage(code, line[]) to get the text form in line[].

// Success.
#define RETURN_NO_FAULT 1
#define TEXT_NO_FAULT "Success"

#define RETURN_UNKNOWN_FAULT -1
#define TEXT_UNKNOWN_FAULT "General error"

#define RETURN_VALET_MODE -2
#define TEXT_VALET_MODE "Not a valid valet mode"

#define RETURN_TOKEN_NUMBER -3
#define TEXT_TOKEN_NUMBER "Not a valid number of tokens"

#define RETURN_ROUND_NUMBER -10
#define TEXT_ROUND_NUMBER "Round number not in range"

#define RETURN_BOARD_NUMBER -11
#define TEXT_BOARD_NUMBER "Board number not in range"

#define RETURN_BOARD_NUMBER_CHANGE -12
#define TEXT_BOARD_NUMBER_CHANGE "Board number changed"

#define RETURN_PLAYER_NORTH -13
#define TEXT_PLAYER_NORTH "North is not a known or valid player"

#define RETURN_PLAYER_EAST -14
#define TEXT_PLAYER_EAST "East is not a known or valid player"

#define RETURN_PLAYER_SOUTH -15
#define TEXT_PLAYER_SOUTH "South is not a known or valid player"

#define RETURN_PLAYER_WEST -16
#define TEXT_PLAYER_WEST "West is not a known or valid player"

#define RETURN_CONTRACT_FORMAT_TEXT -17
#define TEXT_CONTRACT_FORMAT_TEXT "Contract is not in recognized format"

#define RETURN_TRICKS -18
#define TEXT_TRICKS "Number of tricks is not in range"

#define RETURN_LEAD_TEXT -19
#define TEXT_LEAD_TEXT "Not a valid lead"

#define RETURN_LEVEL -20
#define TEXT_LEVEL "Not a valid level"

#define RETURN_DENOM -21
#define TEXT_DENOM "Not a valid denomination"

#define RETURN_MULTIPLIER -22
#define TEXT_MULTIPLIER "Not a valid multiplier"

#define RETURN_DECLARER -23
#define TEXT_DECLARER "Not a valid declarer"

#define RETURN_LEAD_DENOM -24
#define TEXT_LEAD_DENOM "Not a valid leadDenom"

#define RETURN_LEAD_RANK -25
#define TEXT_LEAD_RANK "Not a valid leadRank"


#define VALET_NORTH 0
#define VALET_EAST 1
#define VALET_SOUTH 2
#define VALET_WEST 3

#define VALET_SPADES 0
#define VALET_HEARTS 1
#define VALET_DIAMONDS 2
#define VALET_CLUBS 3
#define VALET_NOTRUMP 4

#define VALET_UNDOUBLED 0
#define VALET_DOUBLED 1
#define VALET_REDOUBLED 2

#define VALET_NOT_VUL 0
#define VALET_VUL 1

#define VALET_SCORING_DATUM 0
#define VALET_SCORING_IAF 1
#define VALET_SCORING_MP 2

#define VALET_TAG_MAX_LENGTH 16
#define VALET_INPUT_MAX_LENGTH 128

#include <string>


struct Control
{
  unsigned valet;
  bool leadFlag;
  bool datumHardRounding;
  bool cloudFlag;
  bool tableauFlag;
};


struct PlayerTags
{
  char north[VALET_INPUT_MAX_LENGTH];
  char east[VALET_INPUT_MAX_LENGTH];
  char south[VALET_INPUT_MAX_LENGTH];
  char west[VALET_INPUT_MAX_LENGTH];
};


struct PlayerNumbers
{
  unsigned north;
  unsigned east;
  unsigned south;
  unsigned west;
};


struct PositionTags
{
  char decl1[VALET_INPUT_MAX_LENGTH];
  char decl2[VALET_INPUT_MAX_LENGTH];
  char def1[VALET_INPUT_MAX_LENGTH];
  char def2[VALET_INPUT_MAX_LENGTH];

  std::string strPassedOut() const;

  std::string strGeneral(
   const bool declFirstFlag,
   const bool leadFirstFlag) const;
};


struct PositionNumbers
{
  unsigned decl1;
  unsigned decl2;
  unsigned def1;
  unsigned def2;

  std::string strPassedOut() const;

  std::string strGeneral(
   const bool declFirstFlag,
   const bool leadFirstFlag) const;
};


struct InputResult
{
  unsigned level;
  unsigned denom;
  unsigned multiplier;
  unsigned declarer;
  unsigned tricks;
  unsigned leadDenom;
  unsigned leadRank;
};


struct OutputResult
{
  bool declFlag[2];
  bool defFlag;
  bool leadFlag[2];
  float overallDecl;
  float bidScoreDecl;
  float playScoreDecl[2];
  float leadScoreDef[2];
  float restScoreDef;

  bool passedOut() const;

  std::string strPassedOut() const;
  std::string strGeneral() const;
};


EXTERN_C DLLEXPORT void STDCALL ValetInit();

EXTERN_C DLLEXPORT int STDCALL ValetSetControl(
  struct Control * controlPtr);

EXTERN_C DLLEXPORT void STDCALL ValetClear();

EXTERN_C DLLEXPORT void STDCALL ValetClearHand();

EXTERN_C DLLEXPORT int STDCALL ValetSetBoardNumber(
  unsigned no);

EXTERN_C DLLEXPORT int STDCALL ValetAddByLine(
  char line[]);

EXTERN_C DLLEXPORT int STDCALL ValetAddByTag(
  struct PlayerTags * playerTagsPtr,
  struct InputResult * inputPtr);

EXTERN_C DLLEXPORT int STDCALL ValetAddByNumber(
  struct PlayerNumbers * playerNumbersPtr,
  struct InputResult * inputPtr);

EXTERN_C DLLEXPORT void STDCALL ValetCalculate();

EXTERN_C DLLEXPORT bool STDCALL ValetGetNextScoreByTag(
  struct PositionTags * positionTagsPtr,
  struct OutputResult * outputPtr);

EXTERN_C DLLEXPORT bool STDCALL ValetGetNextScoreByNumber(
  struct PositionNumbers * positionNumbersPtr,
  struct OutputResult * outputPtr);

EXTERN_C DLLEXPORT void STDCALL ValetErrorMessage(
  int code,
  char line[160]);

#endif

