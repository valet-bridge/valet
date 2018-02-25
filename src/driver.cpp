/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// This is the test driver for the DLL.


#include <iostream>
#include <iomanip>
#include <string>
#include <stdlib.h>
#include <string.h>

#include "valet.h"
#include "dsupport.h"

using namespace std;

extern char example[TEST_ENTRIES][80];


int main(int argc, char * argv[])
{
  int mode = GetMode(argc, argv);
  if (mode == -1)
  {
    Usage(argv);
    return 0;
  }

  ValetInit();

  int errorCode;
  char line[160];

  ControlType control;
  control.valet = VALET_SCORING_IAF;
  control.leadFlag = true;
  control.datumHardRounding = false;
  control.tableauFlag = false;
  if ((errorCode = ValetSetControl(&control)) != RETURN_NO_FAULT)
  {
    ValetErrorMessage(errorCode, line);
    cout << line;
    return errorCode;
  }

  ValetClear();
  ValetSetBoardNumber(1);

  if (mode == 0)
  {
    for (int i = 0; i < TEST_ENTRIES; i++)
    {
      if ((errorCode = ValetAddByLine(example[i])) != RETURN_NO_FAULT)
      {
        ValetErrorMessage(errorCode, line);
        cout << line;
        return errorCode;
      }
    }
  }
  else if (mode == 1)
  {
    PlayersTagType players;
    InputResultType input;

    for (unsigned i = 0; i < TEST_ENTRIES; i++)
    {
      SetTagInputs(players, input, i);

      if ((errorCode = ValetAddByTag(&players, &input)) != RETURN_NO_FAULT)
      {
        ValetErrorMessage(errorCode, line);
        cout << line;
        return errorCode;
      }
    }
  }
  else
  {
    PlayersNumberType players;
    InputResultType input;

    for (unsigned i = 0; i < TEST_ENTRIES; i++)
    {
      SetNumberInputs(players, input, i);

      if ((errorCode = ValetAddByNumber(&players, &input)) != RETURN_NO_FAULT)
      {
        ValetErrorMessage(errorCode, line);
        cout << line;
        return errorCode;
      }
    }
  }

  ValetCalculate();

  if (mode == 0 || mode == 1)
  {
    PositionsTagType players;
    OutputResultType output;

    while (ValetGetNextScoreByTag(&players, &output))
    {
      if (! output.declFlag[0] && ! output.declFlag[1])
        PrintPassedResultByTag(players, output);
      else
        PrintPlayedResultByTag(players, output);
      cout << "\n";
    }
  }
  else
  {
    PositionsNumberType players;
    OutputResultType output;

    while (ValetGetNextScoreByNumber(&players, &output))
    {
      if (players.decl1 == 0 ||
          players.decl2 == 0 ||
          players.def1 == 0 ||
          players.def1 == 0)
      {
        cout << "A player tag was not numerical" << endl;
        return RETURN_UNKNOWN_FAULT;
      }

      if (! output.declFlag[0] && ! output.declFlag[1])
        PrintPassedResultByNumber(players, output);
      else
        PrintPlayedResultByNumber(players, output);
      cout << "\n";
    }
  }

  cout.flush();
}

