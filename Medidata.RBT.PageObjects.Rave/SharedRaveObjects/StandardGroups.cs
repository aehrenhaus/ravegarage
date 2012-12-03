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
using Medidata.RBT.SharedObjects;
using Medidata.RBT.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.Lab;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    class StandardGroup : BaseRaveSeedableObject
    {
        /// <summary>
        /// The StandardGroup constructor
        /// </summary>
        /// <param name="analyteName">The feature file StandardGroup name</param>
         public StandardGroup(string standardGroupName)
        {
            UniqueName = standardGroupName;
        }

        /// <summary>
        /// Create a unique name for the site by appending a TID.
        /// </summary>
        protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }
    }
}
