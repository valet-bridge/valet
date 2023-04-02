/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#include <iostream>
#include <iomanip>
#include <sstream>

#include "valet.h"

using namespace std;


string PositionTags::strPassedOut() const
{
  stringstream ss;
  ss << 
    "Pair 1: " << decl1 << " - " << decl2 << "\n" <<
    "Pair 2: " << def1 << " - " << def2 << "\n" <<
    "Passed out\n";
  return ss.str();
}


string PositionTags::strGeneral(
  const bool declFirstFlag,
  const bool leadFirstFlag) const
{
  stringstream ss;

  ss << 
    setw(24) << left << 
    "Declaring pair: " << right << decl1 << " - " << decl2 <<
    " (declarer is " << 
    (declFirstFlag ? "first" : "second") << " player)\n";
  ss <<
    setw(24) << left << 
    "Defending pair: " << right << def1 << " - " << def2 <<
    " (opening leader is " <<
    (leadFirstFlag ? "first" : "second") << " player)\n";

  return ss.str();
}


string PositionNumbers::strPassedOut() const
{
  stringstream ss;
  ss << 
    "Pair 1: " << decl1 << " - " << decl2 << "\n" <<
    "Pair 2: " << def1 << " - " << def2 << "\n" <<
    "Passed out\n";
  return ss.str();
}


string PositionNumbers::strGeneral(
  const bool declFirstFlag,
  const bool leadFirstFlag) const
{
  stringstream ss;

  ss <<
    setw(24) << left << 
      "Declaring pair: " << right << decl1 << " - " << decl2 <<
    " (declarer is " << 
    (declFirstFlag ? "first" : "second") << " player)\n";
  ss <<
    setw(24) << left << "Defending pair: " << right <<
    def1 << " - " << def2 <<
    " (opening leader is " <<
    (leadFirstFlag ? "first" : "second") << " player)\n";

  return ss.str();
}


bool OutputResult::passedOut() const
{
  return (! declFlag[0] && ! declFlag[1]);
}


string OutputResult::strPassedOut() const
{
  stringstream ss;

  ss << "Overall and bidding score: " <<
    fixed << setprecision(2) << overallDecl << " / " <<
    fixed << setprecision(2) << -overallDecl << "\n";

  return ss.str();
}


string OutputResult::strGeneral() const
{
  stringstream ss;

  ss <<
    setw(24) << left << "Overall score: " << right << setw(6) <<
    fixed << setprecision(2) << overallDecl << " / " <<
    fixed << setprecision(2) << -overallDecl << "\n";
  ss <<
    setw(24) << left << "Bidding score: " << right << setw(6) <<
    fixed << setprecision(2) << bidScoreDecl << " / " <<
    fixed << setprecision(2) << -bidScoreDecl << "\n";
  ss <<
    setw(24) << left << "Declarer play score: " << right << setw(6) <<
    fixed << setprecision(2) <<
    (declFlag[0] ? playScoreDecl[0] : playScoreDecl[1]) << "\n";
  ss <<
    setw(24) << left << "Lead score: " << right << setw(6) <<
    "       / " <<
    fixed << setprecision(2) <<
    (leadFlag[0] ? leadScoreDef[0] : leadScoreDef[1]) << "\n";
  ss <<
    setw(24) << left << "Rest defense score: " << right << setw(6) <<
    "       / " <<
    fixed << setprecision(2) << restScoreDef << "\n";

  return ss.str();
}

