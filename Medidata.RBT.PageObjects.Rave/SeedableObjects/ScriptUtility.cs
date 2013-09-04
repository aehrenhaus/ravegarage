using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    public class ScriptUtility : BaseRaveSeedableObject
    {
               /// <summary>
        /// Create a script utility entry if it is not already in the dictionary of FeatureObject
        /// </summary>
        /// <param name="scriptName">Name of the script utility XML file (ie. gotten from MyMedidata or custom packaged) </param>
		public ScriptUtility(string scriptName)
        {
	        UniqueName = scriptName;
        }
    }
}
