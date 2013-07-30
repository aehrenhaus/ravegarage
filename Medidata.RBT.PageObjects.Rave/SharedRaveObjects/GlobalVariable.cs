using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific GlobalVariable. It is seedable via the UI.
    ///</summary>
    public class GlobalVariable : BaseRaveSeedableObject
    {
        /// <summary>
        /// The Global Variable constructor
        /// </summary>
        /// <param name="globalVariableName">The feature file range type name</param>
        public GlobalVariable(string globalVariableName)
        {
            //TODO: Find a better solution to this issue
            //if (globalVariableName.Contains('_'))
            //    throw new ArgumentOutOfRangeException("Global variable cannot contain \"_\"). This will cause issues when parsing AnalyteRanges.");
            UniqueName = globalVariableName;
        }

        /// <summary>
        /// Add TID to the Global Variable name to make the name unique
        /// </summary>
        protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }
    }
}