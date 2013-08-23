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
		IVerifyObjectExistence
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

		public void PositionCursorAtIndexOf(string message)
		{
			var id = this.GetQuickEditTextArea()
				.GetAttribute("ID");
			
			var script =
				@"
				var qeTextArea = $('#{0}');
				var index = qeTextArea.text().indexOf('{1}');
				
				qeTextArea[0].focus();
				qeTextArea[0].selectionStart = index;
				qeTextArea[0].selectionEnd = index;
				qeTextArea.trigger('keyup');
				";
			
			script = string.Format(script, id, message);

			this.Browser
				.ExecuteScript(script);
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
	}
}
