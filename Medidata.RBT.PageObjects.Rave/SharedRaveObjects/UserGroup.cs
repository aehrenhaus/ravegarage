using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using System.IO;
using System.Xml;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
using Medidata.RBT.PageObjects.Rave.Configuration;
using Medidata.RBT.SharedObjects;
using Medidata.RBT.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific UserGroup. It is seedable. 
    ///These sit in Uploads/UserGroups.
    ///</summary>
    public class UserGroup : BaseRaveSeedableObject
    {
         /// <summary>
        /// The User Group constructor
        /// </summary>
        /// <param name="userGroupName">The feature file user group name</param>
        public UserGroup(string userGroupName)
        {
            UniqueName = userGroupName;
            SuppressSeeding = true;
        }
    }
}