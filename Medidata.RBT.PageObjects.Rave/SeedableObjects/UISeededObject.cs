using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    public abstract class RaveUISeededObject : UniquedSeedableObject
    {
        public override void Seed()
        {
            base.Seed();
            using (LoginSession session = new LoginSession(WebTestContext))
            {
                NavigateToSeedPage();
                CreateObject();
                session.RestoreOriginalUser = RedirectAfterSeed;
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
