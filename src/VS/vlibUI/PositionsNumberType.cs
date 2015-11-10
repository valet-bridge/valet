using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace vlibUI
{

    [StructLayout(LayoutKind.Sequential)]
    internal struct PositionsNumberType
    {
        public uint decl1;
        public uint decl2;
        public uint def1;
        public uint def2;
    }
}
