using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;

namespace Medidata.RBT.PageObjects.Rave
{
    /// <summary>
    /// The control for the form's header bar
    /// </summary>
	public class FormHeaderControl : ControlBase
	{
        public FormHeaderControl(IPage page)
            : base(page)
        {
        }

        /// <summary>
        /// Check if the review checkbox is enabled in the header bar
        /// </summary>
        /// <returns>True if the checkbox is enabled, false if it is not</returns>
        public bool IsReviewRequired()
        {
            IWebElement headerReviewGroupBox = TestContext.Browser.TryFindElementByPartialID("header_SG_ReviewGroupBox");
            return headerReviewGroupBox.EnhanceAs<Checkbox>().Enabled;
        }
    }
}
