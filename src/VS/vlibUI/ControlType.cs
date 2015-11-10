using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace vlibUI
{
  
    [StructLayout(LayoutKind.Sequential)]
    internal struct ControlType
    {
        public uint valet;
        [MarshalAs(UnmanagedType.I1)]
        public bool leadFlag;
        [MarshalAs(UnmanagedType.I1)]
        public bool datumHardRounding;
    }
}
