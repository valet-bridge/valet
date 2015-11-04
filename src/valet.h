/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

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
// Call ErrorMessage(code, line[]) to get the text form in line[].

// Success.
#define RETURN_NO_FAULT 1
#define TEXT_NO_FAULT "Success"

// Currently doesn't happen
#define RETURN_UNKNOWN_FAULT -1
#define TEXT_UNKNOWN_FAULT "General error"

#define RETURN_ROUND_NUMBER -2
#define TEXT_ROUND_NUMBER "Round number not in range"

#define RETURN_BOARD_NUMBER -3
#define TEXT_BOARD_NUMBER "Board number not in range"

#define RETURN_BOARD_NUMBER_CHANGE -4
#define TEXT_BOARD_NUMBER_CHANGE "Board number changed"

#define RETURN_PLAYER_NORTH_TAG -5
#define TEXT_PLAYER_NORTH_TAG "North is not a known player"

#define RETURN_PLAYER_EAST_TAG -6
#define TEXT_PLAYER_EAST_TAG "East is not a known player"

#define RETURN_PLAYER_SOUTH_TAG -7
#define TEXT_PLAYER_SOUTH_TAG "South is not a known player"

#define RETURN_PLAYER_WEST_TAG -8
#define TEXT_PLAYER_WEST_TAG "West is not a known player"

#define RETURN_CONTRACT_FORMAT_TEXT -9
#define TEXT_CONTRACT_FORMAT_TEXT "Contract is not in recognized format"

#define RETURN_DECLARER_TEXT -10
#define TEXT_DECLARER_TEXT "Contract is not in recognized format"

#define RETURN_TRICKS -11
#define TEXT_TRICKS "Number of tricks is not in range"

#define RETURN_LEAD_TEXT -12
#define TEXT_LEAD_TEXT "Not a valid lead"

#define RETURN_VALET_MODE -13
#define TEXT_VALET_MODE "Not a valid valet mode"

#define RETURN_TOKEN_NUMBER -14
#define TEXT_TOKEN_NUMBER "Not a valid number of tokens"

#define RETURN_LEVEL -15
#define TEXT_LEVEL "Not a valid level"

#define RETURN_DENOM -16
#define TEXT_DENOM "Not a valid denom"

#define RETURN_MULTIPLIER -17
#define TEXT_MULTIPLIER "Not a valid multiplier"

#define RETURN_DECLARER -18
#define TEXT_DECLARER "Not a valid declarer"

#define RETURN_LEAD_DENOM -19
#define TEXT_LEAD_DENOM "Not a valid leadDenom"

#define RETURN_LEAD_RANK -20
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


struct ControlType
{
  unsigned valet;
  bool leadFlag;
  bool datumHardRounding;
};


struct PlayersTagType
{
  char north[VALET_TAG_MAX_LENGTH];
  char east[VALET_TAG_MAX_LENGTH];
  char south[VALET_TAG_MAX_LENGTH];
  char west[VALET_TAG_MAX_LENGTH];
};


struct PlayersNumberType
{
  unsigned north;
  unsigned east;
  unsigned south;
  unsigned west;
};


struct PositionsTagType
{
  char decl1[VALET_TAG_MAX_LENGTH];
  char decl2[VALET_TAG_MAX_LENGTH];
  char def1[VALET_TAG_MAX_LENGTH];
  char def2[VALET_TAG_MAX_LENGTH];
};


struct PositionsNumberType
{
  unsigned decl1;
  unsigned decl2;
  unsigned def1;
  unsigned def2;
};


struct InputResultType
{
  unsigned level;
  unsigned denom;
  unsigned multiplier;
  unsigned declarer;
  unsigned tricks;
  unsigned leadDenom;
  unsigned leadRank;
};


struct OutputResultType
{
  bool declFlag[2];
  bool defFlag;
  bool leadFlag[2];
  float overall;
  float bidScore;
  float playScore[2];
  float leadScore[2];
  float defScore;
};


EXTERN_C DLLEXPORT int STDCALL ValetSetControl(
  struct ControlType * control);

EXTERN_C DLLEXPORT void STDCALL ValetClearData();

EXTERN_C DLLEXPORT int STDCALL ValetSetBoardNumber(
  unsigned no);

EXTERN_C DLLEXPORT int STDCALL ValetAddByLine(
  char line[VALET_INPUT_MAX_LENGTH]);

EXTERN_C DLLEXPORT int STDCALL ValetAddByTagStruct(
  struct PlayersTagType * players,
  struct InputType * input);

EXTERN_C DLLEXPORT int STDCALL ValetAddByNumberStruct(
  struct PlayersNumberType * players,
  struct InputType * input);

EXTERN_C DLLEXPORT int STDCALL ValetCalculate();

EXTERN_C DLLEXPORT bool STDCALL ValetGetNextScoreByTag(
  struct PositionsTagType * players,
  struct OutputResultType * output);

EXTERN_C DLLEXPORT bool STDCALL ValetGetNextScoreByNumber(
  struct PositionsNumberType * players,
  struct OutputResultType * output);

EXTERN_C DLLEXPORT void STDCALL ValetErrorMessage(
  int code,
  char line[80]);

#endif
