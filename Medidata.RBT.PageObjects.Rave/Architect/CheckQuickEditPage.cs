using System;
using System.Linq;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave
{
    public class CheckQuickEditPage : 
		ArchitectBasePage, 
		IVerifyObjectExistence,
        IPositionCursor
    {
        /// <summary>
        /// Method to enter text into Quick Edit
        /// </summary>
        /// <param name="text"></param>
        public void EnterIntoQuickEdit(string text)
        {
			this.GetQuickEditTextArea().SetInnerHtml(text);
        }

		private IWebElement GetQuickEditTextArea()
		{
			return Browser
				.TryFindElementById("_ctl0_Content_TxtQuickEdit");
		}

        public override string URL
        {
            get
            {
                return "Modules/Architect/CheckQuickEdit.aspx";
            }
        }

		public bool VerifyObjectExistence(string areaIdentifier, string type, string identifier, bool exactMatch = false, int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null, bool shouldExist = true)
		{
			var result = false;
			if ("text".Equals(type))
			{
				result = Browser.PageSource.Contains(identifier);
			}

			return result;
		}

		public bool VerifyObjectExistence(string areaIdentifier, string type, List<string> identifiers, bool exactMatch = false, int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null, bool shouldExist = true)
		{
			throw new NotImplementedException();
		}

        public void PositionCursorAtStart(string matchText, string areaIdentifier)
        {
            if (areaIdentifier.Equals("quick edit", StringComparison.InvariantCultureIgnoreCase))
            {
                GetQuickEditTextArea().EnhanceAs<TextArea>().PostionCursorBefore(matchText);
            }
        }

        public void PositionCursorAtEnd(string matchText, string areaIdentifier)
        {
            if (areaIdentifier.Equals("quick edit", StringComparison.InvariantCultureIgnoreCase))
            {
                GetQuickEditTextArea().EnhanceAs<TextArea>().PositionCursorAfter(matchText);
            }
        }
    }
}
