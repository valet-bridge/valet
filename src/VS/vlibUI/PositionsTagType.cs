using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace vlibUI
{
    [StructLayout(LayoutKind.Sequential)]
    internal struct PositionsTagType
    {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)] 
        public string decl1;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)] 
        public string decl2;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)] 
        public string def1;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)] 
        public string def2;
    }
}
