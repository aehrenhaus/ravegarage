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
	public interface IEDCFieldControl : IControl
	{
		AuditsPage ClickAudit();

		void EnterData(string text, ControlType controlType, string additionalData = "");

        bool HasDataEntered(string text);  

		IWebElement FindQuery(QuerySearchModel filter);

		/// <summary>
		/// The area that represents the whole field area.
		/// </summary>
		IWebElement FieldControlContainer { get; }

        void PlaceSticky(string responder, string text);

		void AnswerQuery(QuerySearchModel filter);

		void CloseQuery(QuerySearchModel filter);

		void CancelQuery(QuerySearchModel filter);

		void Check(string checkName);

		void Uncheck(string checkName);

        string StatusIconPathLookup(string lookupIcon);

        void Click();

        bool IsDroppedDown();

         /// <summary>
        /// Refresh the control on a page after a change has been made to invalidate it.
        /// </summary>
        void RefreshControl();

		/// <summary>
		/// Determines whether or not a high level Rave EDC element, defined by ControlType enum,
		/// has focus. An EDC field can be composed of many elements so it is necessary to also specify the ordinal of the 
		/// type in question.
		/// </summary>
		/// <param name="type">High level Rave element type</param>
		/// <param name="position">The ordinal of the element in the composite field</param>
		/// <returns></returns>
		bool IsElementFocused(ControlType type, int position);
		/// <summary>
		/// Sets focus to a high level Rave EDC element, defined by ControlType enum.
		/// An EDC field can be composed of many elements so it is necessary to also specify the ordinal of the 
		/// type in question.
		/// </summary>
		/// <param name="type">High level Rave element type</param>
		/// <param name="position">The ordinal of the element in the composite field</param>
		void FocusElement(ControlType type, int position);

        bool IsVerificationRequired();
        /// <summary>
        /// Returns if review checkbox is enabled or disabled
        /// </summary>
        /// <returns>True if review checkbox is there, False if it is not there.</returns>
        bool IsReviewRequired();

        /// <summary>
        /// Check the review checkbox next to the field
        /// </summary>
        void CheckReview();

        /// <summary>
        /// Check if the field is inactive
        /// </summary>
        /// <param name="text">The text of the field to check</param>
        /// <returns>True if inactive, false if active</returns>
        bool IsInactive(string text);
    }
}
