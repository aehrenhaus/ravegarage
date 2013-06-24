using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.EDC
{
    /// <summary>
    /// All of the searchable TDs on a page, separated into portrait or landscape. 
    /// This will work for both standard and log fields. 
    /// You do not need to separate those out.
    /// </summary>
    internal class SearchableTDs
    {
        public List<IWebElement> PortraitSearchableTDs { get; set; }
        public List<IWebElement> LandscapeSearchableTDs { get; set; }
        public List<IWebElement> LabSearchableTDs { get; set; }
    }

}
