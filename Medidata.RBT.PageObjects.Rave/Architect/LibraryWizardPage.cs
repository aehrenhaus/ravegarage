using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.Architect
{
    /// <summary>
    /// The library wizard page
    /// </summary>
    public class LibraryWizardPage : RavePageBase, IVerifyState, IEnterValues, IVerifySomethingExists, IExpand
    {
        /// <summary>
        /// The URl of the page
        /// </summary>
        public override string URL
        {
            get
            {
                return "Modules/Architect/LibraryWizard.aspx";
            }
        }

        /// <summary>
        /// Expand an element on the page
        /// </summary>
        /// <param name="objectToExpand">The object to expand</param>
        /// <param name="areaIdentifier">The area to expand it in</param>
        public void Expand(string objectToExpand, string areaIdentifier)
        {
            ISearchContext context = Browser;
            if (areaIdentifier != null)
            {
                if (areaIdentifier.Equals("right", StringComparison.InvariantCultureIgnoreCase))
                    context = Browser.TryFindElementById("ClusterTreeDiv");
            }
            //This will expand the node on the left when it is in either in a:
            IWebElement expandableElement = context.TryFindElementBy(By.XPath(".//a[b[contains(text(),'" + objectToExpand + "')]" // bold tag
                + " or contains(text(), '" + objectToExpand + "')]" //anchor tag
                + "/../a/img[contains(@src,'plus.gif')]"));

            IWebElement expandedElement = null;

            //If the element is not expandable on the tree on the left, try to expand the arrow that appears after selecting a form or field
            if (expandableElement == null)
            {
                expandableElement = context.TryFindElementBy(By.XPath(".//a[contains(text(), '" + objectToExpand + "')]" //anchor tag
                + "/../img[contains(@src,'arrow_small_right.gif')]"));

                //Don't try to expand if already expanded
                if (expandableElement != null)
                {
                    expandableElement.Click();

                    //To verify that element has expanded try to look for the expandable element with updated image
                    expandedElement = context.TryFindElementBy(By.XPath(".//a[contains(text(), '" + objectToExpand + "')]" //anchor tag
                        + "/../img[contains(@src,'arrow_small_down.gif')]"));
                }
            }
            else
            {
                expandableElement.Click();

                //To verify that element has expanded try to look for the expandable element with updated image
                expandedElement = context.TryFindElementBy(By.XPath(".//a[b[contains(text(),'" + objectToExpand + "')]" // bold tag
                    + " or contains(text(), '" + objectToExpand + "')]" //anchor tag
                    + "/../a/img[contains(@src,'minus.gif')]"));
            }
        }

        /// <summary>
        /// Enter data into a textbox on the page
        /// </summary>
        /// <param name="identifier">The identifier of the textbox</param>
        /// <param name="valueToEnter">The text to enter into the textbox</param>
        public void EnterIntoTextbox(string identifier, string valueToEnter)
        {
            Textbox textbox = null;
            if (identifier.Equals("search", StringComparison.InvariantCultureIgnoreCase))
                textbox = Browser.TryFindElementByPartialID("SearchFilterTxt").EnhanceAs<Textbox>();
            else if (identifier.Equals("Proposal Name", StringComparison.InvariantCultureIgnoreCase))
            {
                textbox = Browser.TryFindElementByPartialID("ProposalNameTxt").EnhanceAs<Textbox>();
                valueToEnter = SeedingContext.GetExistingFeatureObjectOrMakeNew<Proposal>(valueToEnter, () => new Proposal(valueToEnter)).UniqueName;
            }
            else if (identifier.Equals("Proposal Description", StringComparison.InvariantCultureIgnoreCase))
                textbox = Browser.TryFindElementByPartialID("ProposalDescTxt").EnhanceAs<Textbox>();
            else if (identifier.Equals("Change OID in source", StringComparison.InvariantCultureIgnoreCase))
                textbox = Browser.TryFindElementById("NewOIDTxt").EnhanceAs<Textbox>();

            if (textbox == null)
                throw new Exception("Textbox not found!");

            textbox.Clear();
            textbox.SendKeys(valueToEnter);
        }

        /// <summary>
        /// Click a button on the page
        /// </summary>
        /// <param name="identifier">Identifier of the button to click (usually the text in the button)</param>
        /// <returns>The current page</returns>
        public override IPage ClickButton(string identifier)
        {
            IWebElement element = null;
            if (identifier.Equals("Search", StringComparison.InvariantCultureIgnoreCase))
                element = Browser.TryFindElementById("SearchBtn");
            else if (identifier.Equals("Accept", StringComparison.InvariantCultureIgnoreCase))
                element = Browser.TryFindElementById("SaveOID");
            else if (identifier.Equals("Next", StringComparison.InvariantCultureIgnoreCase))
                element = Browser.TryFindElementBy(By.XPath(".//input[@id='ButtonNext' and @type='submit' and not(@disabled)]"));

            if (element != null)
            {
                element.Click();
                return this.WaitForPageLoads();
            }
            else
                return base.ClickButton(identifier);
        }

        /// <summary>
        /// Check or uncheck checkbox on the page
        /// </summary>
        /// <param name="identifier">The identifier for the checkbox</param>
        /// <param name="isChecked">True if we should check the checkbox, false if we should not</param>
        /// <param name="areaIdentifier">The area the checkbox exists in</param>
        /// <param name="listItem">The item in the area the checkbox exists in</param>
        /// <returns>The current page</returns>
        public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
        {
            //Checkbox code on Global Library Volume or Project selection page
            Checkbox checkbox = null;
            if (areaIdentifier != null)
            {
                if (areaIdentifier.Equals("Forms", StringComparison.InvariantCultureIgnoreCase))
                {
                    Browser.TryFindElementByPartialID("_tab0").Click();
                    checkbox = Browser.LinkByPartialText(identifier).Parent().TryFindElementByXPath("input").EnhanceAs<Checkbox>();
                }
                else if (areaIdentifier.Equals("Versions", StringComparison.InvariantCultureIgnoreCase))
                {
                    checkbox = Browser.LinkByPartialText(
                        SeedingContext.GetExistingFeatureObjectOrMakeNew<CrfVersion>(identifier, null).UniqueName).Parent().TryFindElementByXPath("input").EnhanceAs<Checkbox>();
                }
                else
                    checkbox = Browser.TryFindElementByXPath(".//a[contains(text(), '" + identifier + "')]/../input").EnhanceAs<Checkbox>();

                if (isChecked)
                    checkbox.Check();
                else
                    checkbox.Uncheck();
            }
            
            //Checkbox code after Global Library Volume or a Project selected

            //If the main element is a bold and not an anchor tag, need to do this
            if(identifier.Equals("forms", StringComparison.InvariantCultureIgnoreCase))
                checkbox = Browser.TryFindElementByXPath(".//b[contains(text(), '" + identifier + "')]/../../input").EnhanceAs<Checkbox>();
            else
                checkbox = Browser.TryFindElementByXPath(".//a[contains(text(), '" + identifier + "')]/../input").EnhanceAs<Checkbox>();
                    

            if (isChecked)
            {
                checkbox.Check();
                //Wait for element to register as checked
                Browser.TryFindElementBy(b =>
                {
                    Checkbox tempCheckbox = Browser.FindElementByXPath(".//a[contains(text(), '" + identifier + "')]/../input").EnhanceAs<Checkbox>();
                    if (tempCheckbox != null && tempCheckbox.Checked == true)
                        return tempCheckbox;
                    return null;
                });
            }
            else
            {
                checkbox.Uncheck();
                //Wait for element to register as unchecked
                Browser.TryFindElementBy(b =>
                {
                    Checkbox tempCheckbox = Browser.FindElementByXPath(".//a[contains(text(), '" + identifier + "')]/../input").EnhanceAs<Checkbox>();
                    if (tempCheckbox != null && tempCheckbox.Checked == false)
                        return tempCheckbox;
                    return null;
                });
            }

            return this.WaitForPageLoads();
        }

        /// <summary>
        /// Check if a checkbox is checked or not checked
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        /// <param name="isChecked">True if the checkbox should be checked at this moment, false if it should not be</param>
        /// <param name="areaIdentifier">The area the checkbox exists in</param>
        /// <returns>True if the checkbox's state matches the isChecked value</returns>
        public bool VerifyCheckboxState(string identifier, bool isChecked, string areaIdentifier)
        {
            ISearchContext context = Browser;
            if(areaIdentifier != null)
            {
                if (areaIdentifier.Equals("right", StringComparison.InvariantCultureIgnoreCase))
                    context = Browser.TryFindElementById("ClusterTreeDiv");
            }

            //Need to use because AJAX checks the checkbox, 
            //and a normal TryFindByElement it loads the checkbox before this is checked, the "Checked" property will be wrong
            IWebElement checkedMatchingPassedInBool = null;
            if (isChecked)
            {
                checkedMatchingPassedInBool = context.TryFindElementBy(b =>
                {
                    Checkbox checkbox = context.FindElement(By.XPath(".//a[contains(text(), '" + identifier + "')]/../input")).EnhanceAs<Checkbox>();
                    if (checkbox != null && checkbox.Checked == true)
                        return checkbox;

                    return null;
                });
            }
            else
            {
                checkedMatchingPassedInBool = context.TryFindElementBy(b =>
                {
                    Checkbox checkbox = context.FindElement(By.XPath(".//a[contains(text(), '" + identifier + "')]/../input")).EnhanceAs<Checkbox>();
                    if (checkbox != null && checkbox.Checked == false)
                        return checkbox;

                    return null;
                });
            }

            return checkedMatchingPassedInBool != null;
        }

        /// <summary>
        /// Check if a control is enable
        /// </summary>
        /// <param name="identifier">The identifier of the control</param>
        /// <param name="areaIdentifier">The area the control exists in</param>
        /// <returns>True if the control is enabled</returns>
        public bool VerifyControlEnabledState(string identifier, bool isEnabled, string areaIdentifier)
        {
            ISearchContext context = Browser;
            if(areaIdentifier != null)
            {
                if(areaIdentifier.Equals("right", StringComparison.InvariantCultureIgnoreCase))
                    context = Browser.TryFindElementById("ClusterTreeDiv");
            }

            return Browser.TryFindElementBy(b =>
            {
                Checkbox checkbox = Browser.FindElementByXPath(".//a[contains(text(), '" + identifier + "')]/../input").EnhanceAs<Checkbox>();
                if (checkbox != null)
                {
                    if (isEnabled && checkbox.Enabled == true)
                        return checkbox;
                    else if (!isEnabled && checkbox.Disabled == true)
                        return checkbox;
                    else
                        return null;
                }
                else
                    return null;
            }) != null;
        }

        public bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch, int? amountOfTimes, RBT.BaseEnhancedPDF pdf, bool? bold)
        {
            if (type.Equals("text", StringComparison.InvariantCultureIgnoreCase))
                return Browser.FindElementByTagName("body").Text.Contains(identifier);
            else
                return false;
        }

        public bool VerifySomethingExist(string areaIdentifier, string type, List<string> identifiers, bool exactMatch = false, int? amountOfTimes = null, RBT.BaseEnhancedPDF pdf = null, bool? bold = null)
        {
            foreach (string identifier in identifiers)
                if (VerifySomethingExist(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }
    }
}
