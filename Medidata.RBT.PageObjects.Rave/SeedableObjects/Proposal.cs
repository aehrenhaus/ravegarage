using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    /// A non-active proposal
    /// </summary>
	public class Proposal : UniquedSeedableObject
	{
        /// <summary>
        /// Create a Proposal if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="proposalName">Feature defined name of the proposal</param>
        public Proposal(string proposalName)
        {
            UniqueName = proposalName;
        }
	}
}
