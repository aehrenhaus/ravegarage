using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    ///<summary>
    ///All objects which seed using the UI must inherit from this class
    ///</summary>
    public abstract class RaveUISeededObject : UniquedSeedableObject
    {
        /// <summary>
        /// Redirect to the original user after seed
        /// </summary>
        protected bool RedirectAfterSeed { get; set; }

        protected RaveUISeededObject(bool uploadAfterMakingUnique = true)
        {
            UploadAfterMakingUnique = uploadAfterMakingUnique;
            //set global suppress seeding option, it can be overwrite later
            RedirectAfterSeed = true;
        }

        public override void Seed()
        {
            base.Seed();
            if (UploadAfterMakingUnique)
            {
                NavigateToSeedPage();
                CreateObject();
            }
        }

        protected virtual void NavigateToSeedPage()
        {
            throw new NotSupportedException("RaveUISeededObject must be able to navigate to seed page before seeding.");
        }

        /// <summary>
        /// Create a unique version of the object, usually by uploading the object.
        /// </summary>
        protected virtual void CreateObject()
        {
            throw new NotSupportedException("RaveUISeededObject must be able to navigate to create object to seed.");
        }
    }
}
