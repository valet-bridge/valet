using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace vlibUI
{
    [StructLayout(LayoutKind.Sequential)]
    internal struct PlayersTagType
    {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)] 
        public string north;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)] 
        public string east;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)] 
        public string south;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)] 
        public string west;
    }
}
