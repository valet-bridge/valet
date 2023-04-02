/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#include "Players.h"


Players::Players()
{
  tagToName.clear();
}


bool Players::exists(const string& tag) const
{
  return (tagToName.find(tag) != tagToName.end());
}


bool Players::add(
  const string& tag,
  const string& name)
{
  // Don't reassign a name.
  if (Players::exists(tag))
    return false;
  else
  {
    tagToName[tag] = name;
    return true;
  }
}


string Players::getName(const string& tag)
{
  if (Players::exists(tag))
    return tagToName[tag];
  else
  {
    return "";
  }
}

