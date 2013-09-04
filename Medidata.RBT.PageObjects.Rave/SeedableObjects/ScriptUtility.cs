using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    public class ScriptUtility : BaseRaveSeedableObject
    {
               /// <summary>
        /// Create a Draft if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="draftName">Feature defined name of the draft</param>
		public ScriptUtility(string scriptName)
        {
	        UniqueName = scriptName;
        }
    }
}
