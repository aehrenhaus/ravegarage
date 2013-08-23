using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.SharedObjects;
using System.Reflection;
using System.IO;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{

	///<summary>
    ///All objects which can seed should implement this class. 
    ///The seedable objects should be marked for seeding when created.
    ///</summary>
    public abstract class UniquedSeedableObject : BaseRaveSeedableObject
	{
		protected virtual void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }

        /// <summary>
        /// Create a unique name for the object by appending a TID.
        /// </summary>
        public override void Seed()
        {
            MakeUnique();
            base.Seed();
        }
	}
}
