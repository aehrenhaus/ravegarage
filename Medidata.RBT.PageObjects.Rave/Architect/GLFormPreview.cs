using System;
using System.Linq;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using System.Collections.ObjectModel;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SharedObjects;
namespace Medidata.RBT.PageObjects.Rave
{
    public class GLFormPreview : ArchitectBasePage, IVerifyObjectExistence
	{
		
		public override string URL
		{
			get
			{
                return "Modules/Architect/GLCRFPreview.aspx";
			}
		}

		#region IVerifySomethingExists

        public bool VerifyObjectExistence(
            string areaIdentifier,
            string type,
            string identifier,
            bool exactMatch,
            int? amountOfTimes,
            RBT.BaseEnhancedPDF pdf,
            bool? bold,
            bool shouldExist = true)
		{
            bool retVal = false;
			if ("text".Equals(type, StringComparison.InvariantCultureIgnoreCase))
            {
                if (!exactMatch && Browser.FindElementByTagName("body").Text.Contains(identifier))
                    retVal = true;
            }
			else if ("image".Equals(type, StringComparison.InvariantCultureIgnoreCase))
			{
				var image = Browser.TryFindElementBy(By.XPath(string.Format("//img[contains(@src, '{0}')]", identifier)));
				retVal = image != null;
			}

            return retVal;
		}

        public bool VerifyObjectExistence(
            string areaIdentifier,
            string type,
            List<string> identifiers,
            bool exactMatch,
            int? amountOfTimes,
            RBT.BaseEnhancedPDF pdf,
            bool? bold,
            bool shouldExist = true)
        {
            foreach (string identifier in identifiers)
                if (VerifyObjectExistence(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
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
            var fieldsGrid = Browser.TryFindElementByPartialID("FieldsGrid");
            if (fieldsGrid != null)
            {
                ReadOnlyCollection<IWebElement> fieldRowsAtStart = fieldsGrid.TryFindElementsBy(By.XPath(".//td/span[contains(text(), '" + fieldName + "')]/../.."));

                //Cant use foreach here because the Click method causes stale element reference, must get the rows each time
                for (int i = 0; i < fieldRowsAtStart.Count; i++)
                {
                    ReadOnlyCollection<IWebElement> fieldRowsRefresh = fieldsGrid.TryFindElementsBy(By.XPath(".//td/span[contains(text(), '" + fieldName + "')]/../.."));
                    if (CheckFieldHasOID(fieldRowsRefresh[i], fieldOID))
                        return true;
                }
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
            var txtFieldOID = Browser.TryFindElementById("FDC_txtFieldOID");
            if (txtFieldOID != null)
                return txtFieldOID.GetAttribute("value").Trim().Equals(fieldOID.Trim());
            else
                return false;
        }

		#endregion

      
    }
}
