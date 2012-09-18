using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.Seeding
{
    ///<summary>
    ///All objects which can seed should implement this class. 
    ///The seedable objects should be marked for seeding when created.
    ///</summary>
    public abstract class SeedableObject
    {
        public Guid? UID { get; set; }
        public string Name { get; set; }
        public string UniqueName { get; set; }
        public string FileLocation { get; set; }
        public string UniqueFileLocation { get; set; }
        //This is a unique temporal ID for uniqueness purposes and ease of debugging
        private TemporalID m_TID;
        public TemporalID TID
        {
            get
            {
                if (m_TID == null)
                    m_TID = new TemporalID();
                return m_TID;
            }
            set
            {
                m_TID = value;
            }
        }

        public virtual void Seed()
        {
            IPage pageBeforeSeed = TestContext.CurrentPage;
            string loggedInUser = TestContext.CurrentUser;
            NavigateToSeedPage();
            MakeUnique();
            CreateObject();
            LoginPage.Login(loggedInUser, RaveConfiguration.Default.DefaultUserPassword);
            TestContext.CurrentPage = pageBeforeSeed.NavigateToSelf();
        }

        public virtual void MakeUnique()
        {
            throw new NotImplementedException("MakeUnique Not Implemented!");
        }

        public virtual void NavigateToSeedPage()
        {
            throw new NotImplementedException("ChangeToSeedPage Not Implemented!");
        }

        public virtual void CreateObject()
        {
            throw new NotImplementedException("ChangeToSeedPage Not Implemented!");
        }
    }
}
