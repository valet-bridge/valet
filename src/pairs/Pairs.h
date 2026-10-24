/* 
   Valet, a generalized Butler scorer for bridge.

   Copyright (C) 2015-2023 by Soren Hein.

   See LICENSE and README.
*/


#ifndef VALET_PAIRS_H
#define VALET_PAIRS_H

#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
#include <map>

#include "../cst.h"

using namespace std;


struct PairData
{
  bool foundFlag;
  bool flipFlag;
  unsigned number;
};


class Pairs
{
  private:

    map<string, unsigned> playersToPairNo;

    vector<string> pairNoToPairName;

    struct PairTags
    {
      string tag1;
      string tag2;
    };

    vector<PairTags> pairNoToPairTags;

    // The vector indices go 1 .. numPairs, not 0 .. numPairs-1.

    unsigned numPairs;

    unsigned listNo;

    // This is a bit of kludge.  If the flag is set, this is a
    // Pairs where the first player is a real player, and the second
    // player is whatever partners that player had in an individual.
    // We also keep track of the mapping from pair numbers
    // (of which there were many in the individual) and the two
    // "player pairs" here, in order.
    //
    // An individual is a pair with a first, real player and a
    // second player called "All partners".

    bool individualFlag;

    struct Players
    {
      unsigned pno1;
      unsigned pno2;
    };

    vector<Players> pairsToIndividuals;


    bool pairExists(const string& pair) const;

    // Returns "" if the pair does not exist.
    string getPairName(
      const string& tag1,
      const string& tag2) const;

    string padString(
      const string& s,
      const unsigned width = 32) const;


  public:

    Pairs();

    void reset();
    
    unsigned size() const;

    bool playerExists(const string& tag) const;

    // May return a negative number, which means that the real pair 
    // number is positive and that the pair tags were in the opposite 
    // order to the way they are stored internally.  For example the 
    // pair is stored as Zia-Willenken, and the tags were "Willenken" 
    // and "Zia".  This is important because we need to assign some 
    // score components to individuals, so it is not enough to know 
    // the pair number.
    // The pair numbers are consecutive, starting from 1.
    // Returns 0 as an error (at least one tag does not exist).

    void turnIntoIndividuals(const Pairs& realPairs);

    void individualLookup(
      const unsigned pno,
      unsigned& pno1,
      unsigned& pno2) const;

    void getPairData(
      const string& tag1,
      const string& tag2,
      PairData& pairData);

    void getIndividualData(
      const string& tag0,
      PairData& pairData);

    void getPairTags(
      const unsigned pno,
      string& tag1,
      string& tag2);

    string getPairName(
      const unsigned pno,
      const unsigned width = 32) const;
};

#endif
