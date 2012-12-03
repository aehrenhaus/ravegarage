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
    /// <summary>
    ///This is a rave specific RangeType. It is seedable via the UI.
    ///</summary>
    public class RangeType : BaseRaveSeedableObject
    {
        /// <summary>
        /// The Range Type constructor
        /// </summary>
        /// <param name="rangeTypeName">The feature file range type name</param>
        public RangeType(string rangeTypeName)
        {
            UniqueName = rangeTypeName;
        }

        /// <summary>
        /// Navigate to the Range Type page.
        /// </summary>
        protected override void NavigateToSeedPage()
        {
            new RangeTypesPage().NavigateToSelf();
        }

        /// <summary>
        /// Upload the unique version of the Range Type.
        /// </summary>
        protected override void CreateObject()
        {
            TestContext.CurrentPage.As<RangeTypesPage>().AddRangeType(UniqueName);
        }

        /// <summary>
        /// Add TID to the Range Type name to make the name unique
        /// </summary>
        protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }
    }
}