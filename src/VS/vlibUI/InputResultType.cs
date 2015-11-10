using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace vlibUI
{
    [StructLayout(LayoutKind.Sequential)]
    internal struct InputResultType
    {
        public uint level;
        public uint denom;
        public uint multiplier;
        public uint declarer;
        public uint tricks;
        public uint leadDenom;
        public uint leadRank;
    }
}
