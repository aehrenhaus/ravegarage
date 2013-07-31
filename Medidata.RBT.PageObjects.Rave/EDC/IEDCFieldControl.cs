using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using Medidata.RBT.PageObjects.Rave.TableModels;

namespace Medidata.RBT.PageObjects.Rave
{
	public interface IEDCFieldControl : IControl
	{
		AuditsPage ClickAudit(bool isRecord = false);

		void EnterData(string text, ControlType controlType, string additionalData = "");

        bool HasDataEntered(string text);

        /// <summary>
        /// Find a response attached to a field (Query, Sticky, or Protocol Deviation)
        /// </summary>
        /// <param name="filter">Filters to narrow down the response we are looking for</param>
        /// <param name="responseType">The type of response we are looking for (Query, Sticky, or Protocol Deviation)</param>
        /// <returns>The found web element</returns>
        IWebElement FindResponse(ResponseSearchModel filter, MarkingType responseType);

        /// <summary>
        /// Find a protocol deviation attached to a field
        /// </summary>
        /// <param name="filter">Filters to narrow down the protocol deviation we are looking for</param>
        /// <param name="responseTables">The tables on the field which may match the protocol deviation we are looking for</param>
        /// <returns>The found web element</returns>
        IWebElement FindNonQueryMarking(ResponseSearchModel filter, IEnumerable<IWebElement> responseTables);

        /// <summary>
        /// Find a query attached to a field
        /// </summary>
        /// <param name="filter">Filters to narrow down the query we are looking for</param>
        /// <param name="responseTables">The tables on the field which may match the query we are looking for</param>
        /// <returns>The found web element</returns>
        IWebElement FindQuery(QuerySearchModel filter, IEnumerable<IWebElement> responseTables);

        /// <summary>
        /// Select the value in the response type dropdown when opening a response (Query, Sticky, or Protocol Deviation)
        /// </summary>
        /// <param name="responseType">The type of response to open (Query, Sticky, or Protocol Deviation)</param>
        /// <param name="fieldDropdownExists">The field dropdown will exist for fields that are a landscape log field and the first on a form.
        /// True if the field dropdown exists, false if it doesn't</param>
        void SelectResponseType(MarkingType responseType, bool fieldDropdownExists);

        /// <summary>
        /// Place a marking (Protocol deviation, sticky, query) against a field
        /// </summary>
        /// <param name="responder">Who responds to the marking (e.g. Marking Group 1)</param>
        /// <param name="text">The Text of the marking</param>
        /// <param name="responseType">The type of marking (Protocol deviation, sticky, query)</param>
        /// <param name="pdClass">If the marking is a protocol deviation, you may need to select a protocol deviation class</param>
        /// <param name="pdCode">If the marking is a protocol deviation, you may need to select a protocol deviation code</param>
        void PlaceMarking(string responder, string text, MarkingType responseType, string pdClass = null, string pdCode = null);

        /// <summary>
        /// Answer a query against a field
        /// </summary>
        /// <param name="filter">Information to locate the query to answer</param>
		void AnswerQuery(QuerySearchModel filter);

        /// <summary>
        /// Close a query against a field
        /// </summary>
        /// <param name="filter">Information to locate the query to close</param>
		void CloseQuery(QuerySearchModel filter);

        /// <summary>
        /// Cancel a query against a field
        /// </summary>
        /// <param name="filter">Information to locate the query to cancel</param>
		void CancelQuery(QuerySearchModel filter);

		void Check(string checkName);

		void Uncheck(string checkName);

        string StatusIconPathLookup(string lookupIcon);

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
