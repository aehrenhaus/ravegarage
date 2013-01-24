using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave.Architect
{
    /// <summary>
    /// The define copy source page
    /// </summary>
    public class DefineCopySourcesPage : RavePageBase
    {
        /// <summary>
        /// The URL of the page
        /// </summary>
        public override string URL
        {
            get
            {
                return "Modules/Architect/DefineCopySources.aspx";
            }
        }

        /// <summary>
        /// Get the element on the page by name
        /// </summary>
        /// <param name="identifier">The name of the elment to get</param>
        /// <param name="areaIdentifier">The area the element exists in</param>
        /// <param name="listItem">The item in the list the element exists in</param>
        /// <returns>The element on the page</returns>
        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            if(identifier.Equals("Define all Projects and Global Libraries as Copy Sources.", StringComparison.InvariantCultureIgnoreCase))
                return Browser.TryFindElementById("_ctl0_Content_ChkAllCopySources");
            else if (identifier.Equals("Header", StringComparison.InvariantCultureIgnoreCase))
                return Browser.Table("_ctl0_PgHeader_TabTable");
            else throw new ElementNotVisibleException("Couldn't find element on define copy sources page");
        }
    }
}
