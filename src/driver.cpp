/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


// This is the test driver for the DLL.


#include <iostream>
#include <iomanip>

#include "Valet.h"

using namespace std;


// Bermuda Bowl 2015, Round 1, Board 1
// Also used in the documentation as Example 5

#define ENTRIES 22

char example[22][80] =
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


int main()
{
  int errorCode;
  char line[80];

  ControlType control;
  control.valet = VALET_SCORING_IAF;
  control.leadFlag = true;
  control.datumHardRounding = false;
  if ((errorCode = ValetSetControl(&control)) != RETURN_NO_FAULT)
  {
    ValetErrorMessage(errorCode, line);
    cout << line << endl;
    return errorCode;
  }

  ValetClearData();

  ValetSetBoardNumber(1);

  for (int i = 0; i < ENTRIES; i++)
  {
    if ((errorCode = ValetAddByLine(example[i])) != RETURN_NO_FAULT)
    {
      ValetErrorMessage(errorCode, line);
      cout << line << endl;
      return errorCode;
    }
  }

  ValetCalculate();

  PositionsNumberType players;
  OutputResultType output;

  while (ValetGetNextScoreByNumber(&players, &output))
  {
    if (! output.declFlag[0] && ! output.declFlag[1])
    {
      if (! output.defFlag)
      {
        cout << "Pair 1: " << 
          static_cast<int>(players.decl1) << " - " << 
          static_cast<int>(players.decl2) << "\n";
        cout << "Pair 2: " << 
          static_cast<int>(players.def1) << " - " << 
          static_cast<int>(players.def2) << "\n";
        cout << "Passed out\n";
        cout << "Overall and bidding score: " << 
          fixed << setprecision(2) << output.overall << " / " << 
          fixed << setprecision(2) << -output.overall << "\n";
      }
      else
      {
        cout << 
          setw(24) << left << "Defending pair: " << right <<
          static_cast<int>(players.def1) << " - " << 
          static_cast<int>(players.def2) << 
          " (opening leader is " <<
          (output.leadFlag[0] ? "first" : "second") <<
          " player)\n";
        cout << 
          setw(24) << left << "Overall score: " << right << setw(6) <<
          fixed << setprecision(2) << output.overall << " / " << 
          fixed << setprecision(2) << -output.overall << "\n";
        cout << 
          setw(24) << left << "Lead score: " << right << setw(6) <<
          fixed << setprecision(2) <<
          (output.leadFlag[0] ? output.leadScore[0] : output.leadScore[1]) <<
          "\n";
        cout << 
          setw(24) << left << "Rest defense score: " << right << setw(6) <<
          fixed << setprecision(2) << output.defScore << "\n";
      }
    }
    else
    {
      cout << 
        setw(24) << left << "Declaring pair: " << right <<
        static_cast<int>(players.decl1) << " - " << 
        static_cast<int>(players.decl2) << 
        " (declarer is " <<
        (output.declFlag[0] ? "first" : "second") <<
        " player)\n";
      cout << 
        setw(24) << left << "Overall score: " << right << setw(6) <<
        fixed << setprecision(2) << output.overall << " / " << 
        fixed << setprecision(2) << -output.overall << "\n";
      cout << 
        setw(24) << left << "Bidding score: " << right << setw(6) <<
        fixed << setprecision(2) << output.bidScore << " / " << 
        fixed << setprecision(2) << -output.bidScore << "\n";
      cout << 
        setw(24) << left << "Declarer play score: " << right << setw(6) <<
        fixed << setprecision(2) <<
        (output.declFlag[0] ? output.playScore[0] : output.playScore[1]) <<
        "\n";
    }
    cout << "\n";
  }

  cout.flush();
}

