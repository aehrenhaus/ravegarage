using System;
using System.Linq;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Collections.ObjectModel;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SharedObjects;
namespace Medidata.RBT.PageObjects.Rave
{
    public class GLFormPreview : ArchitectBasePage, IVerifySomethingExists
	{
		
		public override string URL
		{
			get
			{
                return "Modules/Architect/GLCRFPreview.aspx";
			}
		}

		#region IVerifySomethingExists

        public bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch, int? amountOfTimes, RBT.BaseEnhancedPDF pdf, bool? bold)
		{
            bool retVal = false;
            if (string.IsNullOrEmpty(type) || type.Equals("text", StringComparison.InvariantCultureIgnoreCase))
            {
                if (!exactMatch && Browser.FindElementByTagName("body").Text.Contains(identifier))
                    retVal = true;
            }
            return retVal;
		}

        public bool VerifySomethingExist(string areaIdentifier, string type, List<string> identifiers, bool exactMatch, int? amountOfTimes, RBT.BaseEnhancedPDF pdf, bool? bold)
        {
            foreach (string identifier in identifiers)
                if (VerifySomethingExist(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }

        /// <summary>
        /// Check that a field exists with the passed in name and oid
        /// </summary>
        /// <param name="fieldName">The field name to check for</param>
        /// <param name="fieldOID">The field oid to check for</param>
        /// <returns>True if the field is there, false if it is not</returns>
        private bool CheckFields(string fieldName, string fieldOID)
        {
            ReadOnlyCollection<IWebElement> fieldRowsAtStart = Browser.TryFindElementByPartialID("FieldsGrid").TryFindElementsBy(By.XPath(".//td/span[contains(text(), '" + fieldName +"')]/../.."));

            //Cant use foreach here because the Click method causes stale element reference, must get the rows each time
            for (int i = 0; i < fieldRowsAtStart.Count; i++)
            {
                ReadOnlyCollection<IWebElement> fieldRowsRefresh = Browser.TryFindElementByPartialID("FieldsGrid").TryFindElementsBy(By.XPath(".//td/span[contains(text(), '" + fieldName + "')]/../.."));
                if (CheckFieldHasOID(fieldRowsRefresh[i], fieldOID))
                    return true;
            }

            return false;
        }

        /// <summary>
        /// Check that a specific field has the passed in fieldOID
        /// </summary>
        /// <param name="fieldRow">The row in the fields table to click edit on to check</param>
        /// <param name="fieldOID">The field OID we are looking to match</param>
        /// <returns>True if the field passed in (represented by the fieldRow) has the correct field OID, false otherwise</returns>
        private bool CheckFieldHasOID(IWebElement fieldRow, string fieldOID)
        {
            //Click edit button, can't use existing method because that would click the first edit button on a field matching the name (there could be multiples in this case)
            fieldRow.TryFindElementByPartialID("ImgBtnSelect").Click();
            return Browser.TryFindElementById("FDC_txtFieldOID").GetAttribute("value").Trim().Equals(fieldOID.Trim());
        }

		#endregion

      
    }
}
