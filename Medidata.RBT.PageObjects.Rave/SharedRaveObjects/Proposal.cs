using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// A non-active proposal
    /// </summary>
	public class Proposal : BaseRaveSeedableObject
	{
        /// <summary>
        /// Create a Proposal if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="proposalName">Feature defined name of the proposal</param>
        public Proposal(string proposalName)
        {
            UniqueName = proposalName + TID;
            SuppressSeeding = true;
        }
	}
}
