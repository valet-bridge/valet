using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace vlibUI
{
    [StructLayout(LayoutKind.Sequential)]
    internal struct PlayersNumberType
    {
        public uint north;
        public uint east;
        public uint south;
        public uint west;
    }
}
