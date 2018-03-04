/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/

#ifndef VALET_FILES_H
#define VALET_FILES_H

#include <string>

using namespace std;


bool ReadNameFile(
  const string& nameFile);

bool ReadScoresFile(
  const string& scoresFile);

#endif

