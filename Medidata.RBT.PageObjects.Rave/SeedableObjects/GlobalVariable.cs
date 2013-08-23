using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    ///This is a rave specific GlobalVariable. It is seedable via the UI.
    ///</summary>
    public class GlobalVariable : UniquedSeedableObject
    {
        /// <summary>
        /// The Global Variable constructor
        /// </summary>
        /// <param name="globalVariableName">The feature file range type name</param>
        public GlobalVariable(string globalVariableName)
        {
            UniqueName = globalVariableName;
        }
    }
}