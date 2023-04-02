/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


// This is the test driver for the DLL.


#include <iostream>
#include <iomanip>
#include <vector>
#include <string>
#include <stdlib.h>
#include <string.h>

#include "valet.h"
#include "dsupport.h"

using namespace std;

extern char example[TEST_ENTRIES][80];


int main(int argc, char * argv[])
{
  int mode = getMode(argc, argv);
  if (mode == -1)
  {
    usage(argv);
    return 0;
  }

  ValetInit();

  int errorCode;
  char line[160];

  Control control;
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
    PlayerTags playerTags;
    InputResult input;

    for (unsigned i = 0; i < TEST_ENTRIES; i++)
    {
      setTagInputs(playerTags, input, i);

      if ((errorCode = ValetAddByTag(&playerTags, &input)) != 
        RETURN_NO_FAULT)
      {
        ValetErrorMessage(errorCode, line);
        cout << line;
        return errorCode;
      }
    }
  }
  else
  {
    PlayerNumbers playerNumbers;
    InputResult input;

    for (unsigned i = 0; i < TEST_ENTRIES; i++)
    {
      setNumberInputs(playerNumbers, input, i);

      if ((errorCode = ValetAddByNumber(&playerNumbers, &input)) != 
        RETURN_NO_FAULT)
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
    PositionTags positionTags;
    OutputResult output;

    while (ValetGetNextScoreByTag(&positionTags, &output))
    {
      if (output.passedOut())
      {
        cout << positionTags.strPassedOut();
        cout << output.strPassedOut();
      }
      else
      {
        cout << positionTags.strGeneral(
          output.declFlag[0], output.leadFlag[0]);
        cout << output.strGeneral();
      }
      cout << "\n";
    }
  }
  else
  {
    PositionNumbers positionNumbers;
    OutputResult output;

    while (ValetGetNextScoreByNumber(&positionNumbers, &output))
    {
      if (positionNumbers.decl1 == 0 ||
          positionNumbers.decl2 == 0 ||
          positionNumbers.def1 == 0 ||
          positionNumbers.def2 == 0)
      {
        cout << "A player tag was not numerical" << endl;
        return RETURN_UNKNOWN_FAULT;
      }

      if (output.passedOut())
      {
        cout << positionNumbers.strPassedOut();
        cout << output.strPassedOut();
      }
      else
      {
        cout << positionNumbers.strGeneral(
          output.declFlag[0], output.leadFlag[0]);
        cout << output.strGeneral();
      }
      cout << "\n";
    }
  }

  cout.flush();
}

