using System;

namespace vlibUI
{
    class Program
    {
        // Bermuda Bowl 2015, Round 1, Board 1
        // Also used in the documentation as Example 5

        readonly static string[]  example =
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

        readonly static uint[] northNoList =
        { 101, 102, 106, 110, 111, 113,  12,  14,  15,  23, 29,   3,  45,  51,  55,  66,  71,  78,  81,  83,  84,  85};

        readonly static string[] northTagList =
        {  "101", "102", "106", "110", "111", "113",  "12",  "14",  "15",  "23", "29",   "3",  "45",  "51",  "55",  "66",  "71",  "78",  "81",  "83",  "84",  "85"};

        readonly static uint[] eastNoList=
        {   62,  17,  74,  46,  26,   1, 124,  56, 120,  38,   34, 116,  10,  60,  57,  94,  33,  82,  75,  68,   35, 128};

        readonly static string[] eastTagList =
        {   "62",  "17",  "74",  "46",  "26",   "1", "124",  "56", "120",  "38", "34", "116",  "10",  "60",  "57",  "94",  "33",  "82",  "75",  "68", "35", "128"};

        readonly static uint[] southNoList =
        {   21,  77,  30, 127,  32,  54,  16, 118,  73,   7,   79,   4,  44, 126,  86,  49,  72,  41,  18,  43,   58,  91};

        readonly static string[] southTagList =
        {   "21",  "77",  "30", "127",  "32",  "54",  "16", "118",  "73",   "7",  "79",   "4",  "44", "126",  "86",  "49",  "72",  "41",  "18",  "43",  "58",  "91"};

        readonly static uint[] westNoList =
        {   27,  99,  53, 109, 104,  28,  61, 108, 115,  89,   20,  87,  95,   6,  42,  22,  92,  98,  93,  90,   88,  24};

        readonly static string[] westTagList =
        {   "27",  "99",  "53", "109", "104",  "28",  "61", "108", "115",  "89", "20",  "87",  "95",   "6",  "42",  "22",  "92",  "98",  "93",  "90",   "88",  "24"};

        readonly static uint[] levelList =
        { 3, 4, 4, 4, 4, 4, 3, 4, 4, 3, 3, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3};

        readonly static uint[] denomList =
        {  4, 1, 1, 1, 1, 1, 4, 1, 1, 4, 4, 1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 4};

        readonly static uint[] multiplierList =
        {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

        readonly static uint[] declList =
        {  1, 1, 3, 3, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1};

        readonly static uint[] tricksList =
        {  7, 9, 8, 10, 8, 9, 7, 9, 9, 7, 9, 10, 9, 9, 9, 9, 10, 9, 9, 7, 7, 7};

        readonly static uint[] leadSuitList =
        {  3, 0, 3, 3, 2, 0, 3, 2, 0, 3, 0, 2, 2, 2, 0, 2, 2, 0, 3, 3, 3, 3};

        readonly static uint[] leadRankList =
        {  4, 2, 12, 12, 4, 11, 4, 4, 2, 4, 2, 6, 4, 4, 11, 4, 3, 6, 4, 6, 6, 6};

        const int RETURN_NO_FAULT = 1;
        const int TEST_ENTRIES = 22;
        static void Main(string[] args)
        {
            int mode = GetMode(args);
            if (mode == -1)
            {
                Usage(args);
            }
            else
            {
                ControlType control = new ControlType();
                control.valet = 1; // VALET_SCORING_IAF;
                control.leadFlag = true;
                control.datumHardRounding = false;

                int errorCode;
                char[] line = new char[160];
                if ((errorCode = VlibImport.ValetSetControl(ref control)) != RETURN_NO_FAULT)
                {
                    VlibImport.ValetErrorMessage(errorCode, line);
                    Console.WriteLine(line);
                } else
                {
                    VlibImport.ValetClear();
                    VlibImport.ValetSetBoardNumber(1);
                    if (mode == 0)
                    {
                        for (int i = 0; i < TEST_ENTRIES; i++)
                        {
                            char[] inputline = (example[i] + "\0").ToCharArray();
                            if ((errorCode = VlibImport.ValetAddByLine(inputline)) != RETURN_NO_FAULT)
                            {
                                VlibImport.ValetErrorMessage(errorCode, line);
                                Console.WriteLine(example[i]);
                                Console.WriteLine(line);
                            }
                        }
                    }
                    else if (mode == 1)
                    {
                        PlayersTagType players = new PlayersTagType();
                        InputResultType input = new InputResultType();

                        for (uint i = 0; i < TEST_ENTRIES; i++)
                        {
                            SetTagInputs(ref players, ref input, i);

                            if ((errorCode = VlibImport.ValetAddByTag( ref players, ref input)) != RETURN_NO_FAULT)
                            {
                                VlibImport.ValetErrorMessage(errorCode, line);
                                Console.WriteLine(line);
                            }
                        }
                    }
                    else
                    {
                        PlayersNumberType players = new PlayersNumberType();
                        InputResultType input = new InputResultType();

                        for (uint i = 0; i < TEST_ENTRIES; i++)
                        {
                            SetNumberInputs(ref players, ref input, i);

                            if ((errorCode = VlibImport.ValetAddByNumber(ref players, ref input)) != RETURN_NO_FAULT)
                            {
                                VlibImport.ValetErrorMessage(errorCode, line);
                                Console.WriteLine(line);
                            }
                        }
                    }

                    VlibImport.ValetCalculate();

                    if (mode == 0 || mode == 1)
                    {
                        PositionsTagType players = new PositionsTagType();
                        OutputResultType output = new OutputResultType();

                        while (VlibImport.ValetGetNextScoreByTag(ref players, ref output))
                        {
                            if (!output.declFlag1 && !output.declFlag2)
                                PrintPassedResultByTag(players, output);
                            else
                                PrintPlayedResultByTag(players, output);
                            Console.WriteLine();
                        }
                    }
                    else
                    {
                        PositionsNumberType players = new PositionsNumberType();
                        OutputResultType output = new OutputResultType();

                        while (VlibImport.ValetGetNextScoreByNumber(ref players, ref output))
                        {
                            if (players.decl1 == 0 ||
                                players.decl2 == 0 ||
                                players.def1 == 0 ||
                                players.def1 == 0)
                            {
                                Console.WriteLine("A player tag was not numerical");
                            } else
                            {
                                if (!output.declFlag1 && !output.declFlag2)
                                    PrintPassedResultByNumber(players, output);
                                else
                                    PrintPlayedResultByNumber(players, output);
                            }

                            Console.WriteLine();
                        }
                    }

                }

            }
            Console.WriteLine("Press any key to exit");
            Console.ReadKey();

        }

        static int GetMode(string[] args)
        {
            if (args == null || args.Length != 1)
            {
                return -1;
            }

            else if (args[0][0] == '1')
                return 0;
            else if (args[0][0] == '2')
                return 1;
            else if (args[0][0] == '3')
                return 2;
            else
                return -1;
        }


        static void Usage(string[] args)
        {

            Console.WriteLine("Usage: vlibUI [1..3]\n");
            Console.WriteLine("1: Test ValetAddByLine\n");
            Console.WriteLine("2: Test ValetAddByTag\n");
            Console.WriteLine("3: Test ValetAddByNumber\n");
        }

        static void SetContractInputs(ref InputResultType input, uint i)
{
  input.level = levelList[i];
  input.denom = denomList[i];
  input.multiplier = multiplierList[i];
  input.declarer = declList[i];
  input.tricks = tricksList[i];
  input.leadDenom = leadSuitList[i];
  input.leadRank = leadRankList[i];
}


    static void SetTagInputs(ref PlayersTagType players, ref InputResultType input, uint i)
    {
            players.north = (northTagList[i] + "\0");
            players.east = (eastTagList[i] + "\0");
            players.south = (southTagList[i] + "\0");
            players.west = (westTagList[i] + "\0");
        SetContractInputs(ref input, i);
    }


    static void SetNumberInputs(ref PlayersNumberType players, ref InputResultType input, uint i)
    {
        players.north = northNoList[i];
        players.east = eastNoList[i];
        players.south = southNoList[i];
        players.west = westNoList[i];

        SetContractInputs(ref input, i);
    }


    static void PrintPassedResultByTag(PositionsTagType players,  OutputResultType output)
    {
        Console.WriteLine("Pair 1: " + (players.decl1) + " - " + (players.decl2)); 
        Console.WriteLine("Pair 2: " + (players.def1) + " - " + (players.def2));
        Console.WriteLine("Passed out");
        Console.WriteLine("Overall and bidding score: ({0:N2} / { 0:N2}", output.overallDecl, (-output.overallDecl));
    }


        static void PrintPassedResultByNumber(PositionsNumberType players, OutputResultType output)
    {
        Console.WriteLine("Pair 1: " + (players.decl1) + " - " +(players.decl2) );
        Console.WriteLine("Pair 2: " + (players.def1) + " - " +(players.def2));
        Console.WriteLine("Passed out\n");
        Console.WriteLine("Overall and bidding score: {0:N2} / {1:N2} ", output.overallDecl, (-output.overallDecl));
    }


        static void PrintPlayedResultNumerical(OutputResultType output)
    {
        Console.WriteLine("Overall score:       {0:N2} / {1:N2} ", output.overallDecl, (-output.overallDecl));
        Console.WriteLine("Bidding score:       {0:N2} / {1:N2} ", output.bidScoreDecl, (-output.bidScoreDecl));
        Console.WriteLine("Declarer play score: {0:N2}          ", (output.declFlag1 ? output.playScoreDecl[0] : output.playScoreDecl[1]));
        Console.WriteLine("Lead score:                / {0:N2} ", (output.leadFlag1 ? output.leadScoreDef[0] : output.leadScoreDef[1]));
        Console.WriteLine("Rest defense score:        / {0:N2} ", output.restScoreDef);
    }


        static void PrintPlayedResultByTag(PositionsTagType players, OutputResultType output)
    {
        Console.WriteLine("Declaring pair: " + (players.decl1) + " - " + (players.decl2) + " (declarer is " + (output.declFlag1 ? "first" : "second") + " player)");
        Console.WriteLine("Defending pair: " + (players.def1) + " - " + (players.def2) + " (opening leader is " + (output.leadFlag1 ? "first" : "second") + " player)");

        PrintPlayedResultNumerical(output);
    }

        static void PrintPlayedResultByNumber(PositionsNumberType players, OutputResultType output)
    {
        Console.WriteLine("Declaring pair: " + (players.decl1) + " - " + (players.decl2) + " (declarer is " +  (output.declFlag1 ? "first" : "second") + " player)");
        Console.WriteLine("Defending pair: " + (players.def1) + " - " + (players.def2) + " (opening leader is " + (output.leadFlag1 ? "first" : "second") + " player)");

        PrintPlayedResultNumerical(output);
    }

    }
}
