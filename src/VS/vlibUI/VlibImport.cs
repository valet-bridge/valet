using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace vlibUI
{
    class VlibImport
    {
        [DllImport("vlib.dll")]
        public static extern int ValetSetControl(ref ControlType control);
        [DllImport("vlib.dll")]
        public static extern int ValetInit();
        [DllImport("vlib.dll")]
        public static extern int ValetClear();
        [DllImport("vlib.dll")]
        public static extern int ValetClearHand();
        [DllImport("vlib.dll")]
        public static extern int ValetSetBoardNumber(int board);
        [DllImport("vlib.dll")]
        public static extern int ValetErrorMessage(int error, char[] message);
        [DllImport("vlib.dll")]
        public static extern int ValetAddByLine(char[] line);
        [DllImport("vlib.dll")]
        public static extern int ValetAddByTag(ref PlayersTagType players, ref InputResultType input);
        [DllImport("vlib.dll")]
        public static extern int ValetAddByNumber(ref PlayersNumberType players, ref InputResultType input);
        [DllImport("vlib.dll")]
        public static extern int ValetCalculate();
        [DllImport("vlib.dll")]
        [return: MarshalAs(UnmanagedType.I1)]
        public static extern bool ValetGetNextScoreByTag(ref PositionsTagType players, ref OutputResultType output);
        [DllImport("vlib.dll")]
        [return: MarshalAs(UnmanagedType.I1)]
        public static extern bool ValetGetNextScoreByNumber(ref PositionsNumberType players, ref OutputResultType output);
    }
}
