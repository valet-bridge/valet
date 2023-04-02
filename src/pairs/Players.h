/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_PLAYERS_H
#define VALET_PLAYERS_H

#include <map>
#include <string>

using namespace std;


class Players
{
  private:

    map<string, string> tagToName;


  public:

    Players();

    bool exists(const string& tag) const;

    // Returns false if the player already exists.
    bool add(
      const string& tag,
      const string& name);

    string getName(const string& tag);
};

#endif
