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


class Pairs
{
  private:

    std::map<std::string, std::string> tagToPlayerName;

    std::map<std::string, unsigned> playersToPairNo;

    std::vector<std::string> pairNoToPairName;

    struct pairTags
    {
      std::string tag1;
      std::string tag2;
    };

    std::vector<pairTags> pairNoToPairTags;

    unsigned numPairs;

    unsigned listNo;

    bool PairExists(
      const std::string pair);

    std::string PadString(
      const std::string& s,
      const unsigned width = 32);


  public:

    Pairs();

    ~Pairs();

    void Reset();

    // Returns false if the player already exists.

    bool AddPlayer(
      const std::string tag,
      const std::string name);

    std::string GetPlayerName(
      const std::string tag);

    bool TagExists(
      const std::string tag);

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
      const std::string tag1,
      const std::string tag2);

    // Returns "" if the pair does not exist.

    std::string GetPairName(
      const std::string tag1,
      const std::string tag2);

    void GetPairTags(
      const unsigned pno,
      std::string& tag1,
      std::string& tag2);

    std::string GetPairName(
      const unsigned pno);

    std::string GetPairNamePadded(
      const unsigned pno,
      const unsigned width = 32);
      
};

#endif
