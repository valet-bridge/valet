/* 
   Valet, a bridge single-suit double-dummy quick-trick solver.

   Copyright (C) 2015 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_PAIRS_H
#define VALET_PAIRS_H

#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
#include <map>

#include "cst.h"

using namespace std;


class Pairs
{
  private:

    map<string, string> tagToPlayerName;

    map<string, unsigned> playersToPairNo;

    vector<string> pairNoToPairName;

    struct pairTags
    {
      string tag1;
      string tag2;
    };

    vector<pairTags> pairNoToPairTags;

    unsigned numPairs;

    unsigned listNo;

    bool PairExists(const string& pair) const;

    string PadString(
      const string& s,
      const unsigned width = 32) const;


  public:

    Pairs();

    ~Pairs();

    void Reset();

    // Returns false if the player already exists.

    bool AddPlayer(
      const string& tag,
      const string& name);

    string GetPlayerName(
      const string& tag);

    bool TagExists(const string& tag) const;

    // May return a negative number, which means that the real pair 
    // number is positive and that the pair tags were in the opposite 
    // order to the way they are stored internally.  For example the 
    // pair is stored as Zia-Willenken, and the tags were "Willenken" 
    // and "Zia".  This is important because we need to assign some 
    // score components to individuals, so it is not enough to know 
    // the pair number.
    // The pair numbers are consecutive, starting from 1.
    // Returns 0 as an error (at least one tag does not exist).

    int GetPairNumber(
      const string& tag1,
      const string& tag2);

    // Returns "" if the pair does not exist.

    string GetPairName(
      const string& tag1,
      const string& tag2) const;

    void GetPairTags(
      const unsigned pno,
      string& tag1,
      string& tag2);

    string GetPairName(
      const unsigned pno,
      const unsigned width = 32) const;
      
};

#endif
