using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Common.Steps;

namespace Medidata.RBT.Features.Rave
{
    ////If a dll is referenced but never used in this assembly, then the compiler will not actually reference the dll.
    ////This will cause problems that some dlls are not copied to test result folder, and test will fail
    class ReferenceFix
    {
    //    //use a class in that dll will ensure the compiler actually reference the dll
       MiscSteps fix;
    }
}
