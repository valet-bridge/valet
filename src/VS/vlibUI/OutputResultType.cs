using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace vlibUI
{
    [StructLayout(LayoutKind.Sequential)]
    internal struct OutputResultType
    {
        [MarshalAs(UnmanagedType.I1)]
        public bool declFlag1;
        [MarshalAs(UnmanagedType.I1)]
        public bool declFlag2;
        [MarshalAs(UnmanagedType.I1)]
        public bool defFlag;
        [MarshalAs(UnmanagedType.I1)]
        public bool leadFlag1;
        [MarshalAs(UnmanagedType.I1)]
        public bool leadFlag2;
        public float overallDecl;
        public float bidScoreDecl;
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 2)]
        public float[] playScoreDecl;
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 2)]
        public float[] leadScoreDef;
        public float restScoreDef;
    }

}
