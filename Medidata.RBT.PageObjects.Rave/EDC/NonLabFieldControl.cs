using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.PageObjects.Rave.TableModels;

namespace Medidata.RBT.PageObjects.Rave
{
	public class NonLabFieldControl : BaseEDCFieldControl
	{
        public override IEnumerable<IWebElement> ResponseTables
        {
            get
            {
                return NameElement.FindElements(By.XPath(".//td[@class='crf_preText']/table"));
            }
        }

        /// <summary>
        /// Create a NonLabFieldControl which will contain the information about any non-lab field
        /// </summary>
        /// <param name="page">The current page</param>
        /// <param name="leftSideOrTopTD">The TD containing the field name</param>
        /// <param name="rightSideOrBottomTD">The TD containing the field data</param>
		public NonLabFieldControl(IPage page, IWebElement leftSideOrTopTD, IWebElement rightSideOrBottomTD, string fieldName)
			: base(page)
		{
            IWebElement rightSideOrBottomTR = rightSideOrBottomTD.Parent();
			NameElement = leftSideOrTopTD.EnhanceAs<EnhancedElement>();
			FieldDataGeneric = rightSideOrBottomTR.EnhanceAs<EnhancedElement>();
            FieldDataSpecific = rightSideOrBottomTD.GetAttribute("style").Contains("padding-left:4px;") ?
                rightSideOrBottomTD.EnhanceAs<EnhancedElement>()
                : rightSideOrBottomTD.TryFindElementBy(By.XPath(".//td[@style='padding-left:4px;']"), isWait: false).EnhanceAs<EnhancedElement>();
            FieldName = fieldName;
            QueryArea = FindQueryArea(rightSideOrBottomTR);
		}
        #region IEDCFieldControl

        private EnhancedElement FindQueryArea(IWebElement rightSideOrBottomTR)
        {
            if(rightSideOrBottomTR.Text.Contains("Open Query"))
                return rightSideOrBottomTR.EnhanceAs<EnhancedElement>();
            else
            {
                //If the field is a landscape form, it is possible that the OpenQuery row is the next row, checking for that case
                IWebElement possibleNextRowContainsQuery = rightSideOrBottomTR.TryFindElementBy(By.XPath("following-sibling::tr"), isWait: false);
                if(possibleNextRowContainsQuery != null)
                    return possibleNextRowContainsQuery.EnhanceAs<EnhancedElement>();
            }
            return null;
        }

		public override AuditsPage ClickAudit(bool isRecord = false)
		{
            IWebElement auditButton = null;
            if(isRecord)
                auditButton = FieldDataGeneric.TryFindElementByPartialID("DataStatusHyperlink");
            else
                auditButton = FieldDataGeneric.TryFindElementByPartialID("DataStatusHyperlink");
			auditButton.Click();
			return new AuditsPage();
		}
        
        /// <summary>
        /// Checks the checkbox specified by the checkbox name
        /// </summary>
        /// <param name="checkName"></param>
        public override void Check(string checkName)
        {
            string partialID = GetCheckboxPartialIdFromCheckName(checkName);

            if (partialID.Length > 0)
            {     
                Checkbox checkbox = FieldDataGeneric.CheckboxByID(partialID);
                checkbox.Check();
            }
        }

        /// <summary>
        /// Unchecks the checkbox specified by the checkbox name
        /// </summary>
        /// <param name="checkName"></param>
        public override void Uncheck(string checkName)
        {
            string partialID = GetCheckboxPartialIdFromCheckName(checkName);

            if (partialID.Length > 0)
            {
                Checkbox checkbox = FieldDataGeneric.CheckboxByID(partialID);
                checkbox.Uncheck();
            }
        }

        /// <summary>
        /// Check if the field is inactive for non lab field control
        /// </summary>
        /// <param name="text">Not necessary for NonLabFieldControl, but must be there for LabFieldControl</param>
        /// <returns>True if inactive, false if active</returns>
        public override bool IsInactive(string text = "")
        {
            IWebElement strikeoutElement = FieldDataGeneric.TryFindElementBy(By.XPath("//s"));
            return !(strikeoutElement == null);
        }
		#endregion

        public bool VerifyData(LabRangeModel field)
        {
            throw new NotImplementedException();
        }

        #region helper memebers
        /// <summary>
        /// returns the partial id for checkbox based on checkbox name
        /// </summary>
        /// <param name="checkName"></param>
        /// <returns></returns>
        private string GetCheckboxPartialIdFromCheckName(string checkName)
        {
            string partialID = "";

            if (checkName == "Freeze")
            {
                partialID = "EntryLockBox";
            }
            else if (checkName == "Hard Lock")
            {
                partialID = "HardLockBox";
            }
            else if (checkName == "Verify")
            {
                partialID = "VerifyBox";
            }

            return partialID;
        }
        #endregion
    }
}
