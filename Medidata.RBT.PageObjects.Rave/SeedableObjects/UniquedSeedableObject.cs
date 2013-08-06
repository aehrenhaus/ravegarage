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
    ///All objects which can seed and are made unique before seeding are uniqued seedable objects
    ///Usually this is done by appending a TID, but you can make unique through other methods as well by overriding make unique
    ///</summary>
    public abstract class UniquedSeedableObject : BaseRaveSeedableObject
	{
        protected bool UploadAfterMakingUnique { get; set; }
        protected UniquedSeedableObject(bool uploadAfterMakingUnique = true)
        {
            UploadAfterMakingUnique = uploadAfterMakingUnique;
        }

        /// <summary>
        /// The method to make the seedable object unique
        /// </summary>
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
