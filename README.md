Introduction
============
Valet calculates the "Valet score" for pairs in a bridge tournament.  It is an improved "Butler score" that splits a pair's performance into several components:
* Bidding,
* Declarer play,
* Defense, optionally divided into opening lead and subsequent defense.

The sum of the components is effectively the Butler score.

Unlike the Butler score, the Valet score can be applied in principle to all kinds of tournament forms including matchpointed pairs.  It does require a fair quantity of data to provide meaningful results.  It will not be very meaningful in the local duplicate, although it could be applied across all the club evenings in a year, perhaps.

Please refer to the "doc" directory for explanations.

The main use can hopefully be as an integral part of scoring programs.  I expressly would like programmers of scoring programs to do this.  You are welcome to port the code to other languages, integrate it into your own code etc.  I just ask that the acknowledge the origin and let me know.  Most of the program just shuffles data around -- the real logic is in Hand.cpp and a bit in Scoring.cpp.

It is possible to use Valet as a stand-alone program, and I've done it for a fair number of major tournaments.  The main trouble is getting the data into a suitable format.  Here I have chosen a very simple input format, and it should be possible to write filters to convert other structured data to this format.  (Please consider submitting your filter if you write one.)

Valet is also available as a DLL with a relatively simple interface modeled on DDS (of which I am a co-author).

I developed the Valet concept in 2004 after playing the Istanbul Olympiad (for Luxembourg with Stefan Helling), and I implemented the ideas in Excel VBA code.  I tried to publish a short article on it in Bridge World at the time, but that never came about.  

I next thought about the Valet score when a related subject came up on BridgeWinners, and I posted about it [here](http://bridgewinners.com/article/view/the-valet-score/).  The discussion encouraged me to port the code to C++ (the Excel code spent a lot of time getting data into and out of cells) and to generalize it in various ways.

The current version is Valet 1.0 released in October 2015 and licensed under the Apache 2.0 license in the LICENSE FILE.

Release notes are in the ChangeLog file.

(c) Soren Hein 2015.


Overview
========
The distribution consists of the following directories.

* **src**, the source code for the library.
* **doc**, where the file interface is documented and the ideas are explained.
* **data**, with example input files.
* **scripts**, with some largely undocumented and not very robust scripts that I used to download tournament results from websites.  You can use these as a starting point for other tournaments, perhaps.



Supported systems
=================
The code compiles on windows (see INSTALL) with at least:

* Visual C++ 2010 Express editions or later.
* The TDM-GCC/Mingw port of g++.
* g++ on Cygwin.

I have also compiled the code on the following systems.

* Linux Ubuntu with g++.
* Mac OS 10.9 with g++ and clang.


Usage
=====
Compile the program (see the INSTALL file).

In the src directory, type (on Windows)

./valet.exe

or (on Linux or MacOS)

./valet


at the command prompt and you should get a usage summary.  An actual example would be

./valet.exe -imps -csv=';' ../data/2004-Istanbul-Olympiad 

which should generate a comma-separated value file, using across-the-field IMPs, that you can open from Excel.  (Not that csv files use different separators in different Microsoft Office languages.  I showed the way to get a semi-colon which is the one used in German.)


Bugs
====
Version 1.0 has no known bugs.

Please report bugs to soren.hein@gmail.com.

