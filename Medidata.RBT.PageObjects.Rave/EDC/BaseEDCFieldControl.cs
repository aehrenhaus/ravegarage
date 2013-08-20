using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.ConfigurationHandlers;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
using System.Text.RegularExpressions;
using System.Collections.ObjectModel;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using Medidata.RBT.PageObjects.Rave.TableModels;
using System.Reflection;


namespace Medidata.RBT.PageObjects.Rave
{
	public abstract class BaseEDCFieldControl : ControlBase, IEDCFieldControl
	{
        #region Properties
        public string FieldName { get; set; }
        public abstract IEnumerable<IWebElement> ResponseTables { get; }
        public EnhancedElement NameElement { get; set; }
        public EnhancedElement QueryArea { get; set; }
        // <summary>
        /// The area with the specific user-enetered data pertaining to that field
        /// </summary>
        public EnhancedElement FieldDataSpecific { get; set; }
        /// <summary>
        /// The area with the data pertaining to that field
        /// includes the checkboxes on the side which allow locking, freezing, the status icon, and all data pertaining to the field
        /// </summary>
        public EnhancedElement FieldDataGeneric { get; set; }
        #endregion

        #region Constructor 
        public BaseEDCFieldControl(IPage page)
			: base(page)
		{
		}
        #endregion

        #region Virtual Methods
        public virtual bool HasDataEntered(string text)
        {
            return text.Equals(FieldDataSpecific.Text);
        }

        public virtual AuditsPage ClickAudit(bool isRecord = false)
        {
            var auditButton = FieldDataSpecific.TryFindElementByPartialID("DataStatusHyperlink");
            auditButton.Click();
            return new AuditsPage();
        }

        public virtual void EnterData(string text, ControlType controlType = ControlType.Default, string additionalData = "")
        {
            switch (controlType)
            {
                case ControlType.Default:
                    EnterValueGuessControlType(text);
                    break;

                case ControlType.Text:
                case ControlType.LongText:
                    EnterTextBoxValue(text, additionalData);
                    break;

                case ControlType.Datetime:
                    EnterDatetimeValue(text);
                    break;

                case ControlType.RadioButton:
                case ControlType.RadioButtonVertical:
                    EnterRadiobuttonValue(text);
                    break;

                case ControlType.SearchList:
                case ControlType.DynamicSearchList:
                    EnterDynamicSearchListValue(text);
                    break;

                case ControlType.CheckBox:
                    EnterCheckBox(bool.Parse(text));
                    break;

                case ControlType.Signature:
                    new SignatureBox().Sign(SeedingContext.GetExistingFeatureObjectOrMakeNew<User>(text, () => new User(text)));
                    //EnterSignature(SeedingContext.GetExistingFeatureObjectOrMakeNew<User>(text, () => new User(text)));
                    break;
                case ControlType.DropDown:
                    EnterDropdownValue(text);
                    break;
                case ControlType.FileUpload:
                    EnterFileUploadValue(RBTConfiguration.Default.UploadPath + @"\Misc\" + text);
                    break;
                default:
                    throw new Exception("Not supported control type:" + controlType);
            }
        }

	    protected void EnterFileUploadValue(string text)
	    {
            FieldDataGeneric.FindElementsByPartialId("_CRFControl_CRFFileUpload")[0].SendKeys(text);
	    }

	    public virtual void Check(string checkName)
        {
            IWebElement actionArea = FieldDataSpecific;
            if (checkName == "Freeze")
            {
                actionArea.CheckboxByID("EntryLockBox").Check();
            }

            if (checkName == "Hard Lock")
            {
                actionArea.CheckboxByID("HardLockBox").Check();
            }

            if (checkName == "Verify")
            {
                actionArea.CheckboxByID("VerifyBox").Check();
            }
        }

        public virtual void Uncheck(string checkName)
        {
            IWebElement actionArea = FieldDataSpecific;
            if (checkName == "Freeze")
            {
                actionArea.CheckboxByID("EntryLockBox").Uncheck();
            }

            if (checkName == "Hard Lock")
            {
                actionArea.CheckboxByID("HardLockBox").Uncheck();
            }

            if (checkName == "Verify")
            {
                actionArea.CheckboxByID("VerifyBox").Uncheck();
            }
        }

        public virtual bool IsElementFocused(ControlType type, int position)
        {
            throw new NotImplementedException();
        }

        public virtual void FocusElement(ControlType type, int position)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Check if the field is inactive
        /// </summary>
        /// <param name="text">The text of the field to check</param>
        /// <returns>True if inactive, false if active</returns>
        public virtual bool IsInactive(string text = "")
        {
            throw new NotImplementedException();
        }
        #endregion

        #region NonVirtual Methods
        /// <summary>
        /// Check the review checkbox next to the field
        /// </summary>
        public void CheckReview()
        {
            FieldDataGeneric.CheckboxByID("ReviewGroupBox").EnhanceAs<Checkbox>().Check();
        }

        /// <summary>
        /// Returns if review checkbox is enabled or disabled
        /// </summary>
        /// <returns>True if review checkbox is there, False if it is not there.</returns>
        public bool IsReviewRequired()
        {
            return FieldDataGeneric.CheckboxByID("ReviewGroupBox").EnhanceAs<Checkbox>().Enabled;
        }

        /// <summary>
        /// Returns in verification checkbox is enabled or disabled
        /// </summary>
        /// <returns></returns>
        public bool IsVerificationRequired()
        {
            return (FieldDataGeneric.CheckboxByID("VerifyBox") as Checkbox).Enabled;
        }

        public void AnswerQuery(QuerySearchModel filter)
        {
            FindResponse(filter, MarkingType.Query).Textboxes()[0].SetText(filter.Answer);
        }

        public void CloseQuery(QuerySearchModel filter)
        {
            FindResponse(filter, MarkingType.Query).Dropdowns()[0].SelectByText("Close Query");
        }

        public void CancelQuery(QuerySearchModel filter)
        {
            FindResponse(filter, MarkingType.Query).Checkboxes()[0].Check();
        }

        public IWebElement FindNonQueryMarking(ResponseSearchModel filter, IEnumerable<IWebElement> responseTables)
        {
            foreach (IWebElement tmpCommentTable in responseTables)
            {
                if (filter.Message != null && !tmpCommentTable.Text.Contains(filter.Message))
                    continue;

                return tmpCommentTable;
            }

            return null;
        }

        protected void EnterDropdownValue(string val)
        {
            var dropdowns = FieldDataSpecific.FindElements(By.TagName("select")).ToList();
            new SelectElement(dropdowns[0]).SelectByText(val);
        }

        protected void EnterDynamicSearchListValue(string val)
        {
            CompositeDropdown dsl = new CompositeDropdown(this.Page, "DSL", FieldDataSpecific);
            dsl.TypeAndSelect(val);
        }

        protected void EnterRadiobuttonValue(string val)
        {
            HtmlTable table = FieldDataSpecific.Table("_RadioBtnList");
            var optionTDs = table.FindElements(By.XPath("./tbody/tr/td"));
            var td = optionTDs.FirstOrDefault(x => ISearchContextExtend.ReplaceTagsWithEscapedCharacters(x.FindElement(By.XPath("label")).GetInnerHtml()).Trim()
                .Equals(ISearchContextExtend.ReplaceSpecialCharactersWithEscapeCharacters(val)));
            td.RadioButtons()[0].Set();
        }

        protected void EnterDatetimeValue(string val)
        {
            //Create an array with length i where each cell is an empty string
            //Used to clear out each text box / dropdown
            var defaultDateParts = new Func<int, string[]>((i) =>
            {
                var s = new string[i];
                for (var j = 0; j < i; j++)
                    s[j] = string.Empty;    //We cannot pass null to these text boxes

                return s;
            });

            var textboxes = FieldDataSpecific.Textboxes();
            var dropdowns = FieldDataSpecific.FindElements(By.TagName("select")).ToList();

            if (textboxes.Count == 2 && dropdowns.Count == 1)//date field  .format: dd MM yyyy
            {
                string[] dateParts = string.IsNullOrWhiteSpace(val)
                    ? defaultDateParts(3)
                    : val.Split(' ');
                if (dateParts.Length != 3)
                {
                    throw new Exception("not valid date time");
                    //throw new Exception("Expection date format for field " + FieldName + " , got: " + text);
                }
                //assign 3 parts of the date format
                textboxes[0].SetText(dateParts[0]);
                new SelectElement(dropdowns[0]).SelectByValue(dateParts[1]);
                textboxes[1].SetText(dateParts[2]);
            }
            else if (textboxes.Count == 1 && dropdowns.Count == 0) // date where only "year" is needed, for example
                EnterTextBoxValue(val);
            else if (textboxes.Count == 0 && dropdowns.Count == 1) // date where only "month" is needed, for example
                EnterDropdownValue(val);
            else if (textboxes.Count >= 2 && dropdowns.Count == 0) // atypical date format without dropdown without using month in dropdown, could be 2, 3, 4, etc textboxes
            {
                string[] dateParts = string.IsNullOrWhiteSpace(val)
                    ? defaultDateParts(textboxes.Count)
                    : val.Replace(":", " ").Split(' ');
                if (!(dateParts.Length >= 2))
                {
                    throw new Exception("wrong datetime format");
                }
                //parse out values for each textbox 
                for (int i = 0; i < textboxes.Count; i++)
                {
                    textboxes[i].SetText(dateParts[i]);
                }
            }
        }

        protected void EnterCheckBox(bool selected)
        {
            var checkboxes = FieldDataSpecific.Checkboxes();
            if (checkboxes[0].Selected != selected)
                checkboxes[0].Click();
        }

        public string StatusIconPathLookup(string lookupIcon)
        {
            string result = "/Img/";
            switch (lookupIcon)
            {
                case "+":
                    result += "high.gif";
                    break;
                case "++":
                    result += "alerthigh.gif";
                    break;
                case "-":
                    result += "low.gif";
                    break;
                case "--":
                    result += "alertlow.gif";
                    break;
                case "Incomplete":
                    result += "dp_pc.gif";
                    break;
                case "Complete":
                    result += "dp_ok.gif";
                    break;
                case "Frozen":
                    result += "dp_fr.gif";
                    break;
                case "Locked":
                    result += "dp_lo.gif";
                    break;
                case "Requires Review":
                    result += "dp_rr.gif";
                    break;
                case "Requires Verification":
                    result += "dp_ru.gif";
                    break;
                case "Requires Signature":
                    result += "dp_sg.gif";
                    break;
                case "Inactive":
                    result += "dp_ia.gif";
                    break;
                default:
                    throw new InvalidOperationException("Status: " + lookupIcon + " not yet implemented in StatusIconPathLookup(string lookupIcon)");
            }
            return result;
        }

        /// <summary>
        /// Enter a value into a textbox
        /// </summary>
        /// <param name="val">Value to enter into the textbox</param>
        /// <param name="additionalData">If the textbox has a unit dictionary, select from the unit dictionary using additional data</param>
        protected void EnterTextBoxValue(string val, string additionalData = "")
        {
            ReadOnlyCollection<Textbox> textboxes = FieldDataSpecific.Textboxes();
            SendTextWithCommands(textboxes[0], val);

            List<IWebElement> dropdowns = FieldDataSpecific.FindElements(By.TagName("select")).ToList();
            if (!String.IsNullOrEmpty(additionalData))
                new SelectElement(dropdowns[0]).SelectByText(additionalData);
        }

        /// <summary>
        /// This method is just for backward compatibility.
        /// 
        /// </summary>
        /// <param name="val"></param>
        protected void EnterValueGuessControlType(string text)
        {
            var textboxes = FieldDataSpecific.Textboxes();
            var dropdowns = FieldDataSpecific.FindElements(By.TagName("select")).ToList();

            //this dropdown does count
            var dataEntyErrorDropdown = dropdowns.FirstOrDefault(x =>
            {
                var options = new SelectElement(x).Options;
                return options.Count == 1 && (options[0].Text == "Data Entry Error" || options[0].Text == "Entry Error");
            });

            if (dataEntyErrorDropdown != null)
                dropdowns.Remove(dataEntyErrorDropdown);

            if (textboxes.Count == 2 && dropdowns.Count == 1)//date field  .format: dd MM yyyy
            {
                string[] dateParts = text.Split(' ');
                if (dateParts.Length != 3)
                {
                    throw new Exception("wrong datetime format");
                }
                //assign 3 parts of the date format
                textboxes[0].SetText(dateParts[0]);
                new SelectElement(dropdowns[0]).SelectByValue(dateParts[1]);
                textboxes[1].SetText(dateParts[2]);
            }
            else if (textboxes.Count == 5 && dropdowns.Count == 1)//date field format: dd MMM yyyy hh:nn rr
            {
                string[] dateParts = text.Split(' ');
                if (dateParts.Length != 6)
                {
                    throw new Exception("wrong datetime format");
                }
                //assign 6 parts of the date format
                textboxes[0].SetText(dateParts[0]);
                new SelectElement(dropdowns[0]).SelectByValue(dateParts[1]);
                textboxes[1].SetText(dateParts[2]);
                textboxes[2].SetText(dateParts[3]);
                textboxes[3].SetText(dateParts[4]);
                textboxes[4].SetText(dateParts[5]);
            }
            else if (textboxes.Count == 1 && dropdowns.Count == 0) //normal text filed
            {
                textboxes[0].SetText(text);
            }
            else if (textboxes.Count == 0 && dropdowns.Count == 1)
            {
                new SelectElement(dropdowns[0]).SelectByText(text);
            }
            else
            {
                throw new Exception("Not sure what kind of datapoint is this.");
            }
        }

        /// <summary>
        /// Refresh the control on a page after a change has been made to invalidate it.
        /// We do this by getting the current field and setting the stale object's properties/fields to the fresh object's properties/fields
        /// </summary>
        public void RefreshControl()
        {
            BaseEDCFieldControl currentFieldControl = (BaseEDCFieldControl)Page.As<CRFPage>().FindField(FieldName);
            Type type = this.GetType();
            PropertyInfo[] properties = type.GetProperties(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);
            FieldInfo[] fields = type.GetFields(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);

            foreach (PropertyInfo property in properties)
                if (property.CanWrite && property.CanRead)
                    property.SetValue(this, property.GetValue(currentFieldControl, null), null);

            foreach (FieldInfo field in fields)
                field.SetValue(this, field.GetValue(currentFieldControl));
        }

        public void PlaceMarking(string responder, string text, MarkingType responseType, string pdClass = null, string pdCode = null)
        {
            IWebElement markingButton = FieldDataGeneric.TryFindElementByPartialID("MarkingButton");
            markingButton.Click();

            RefreshControl();
            bool fieldDropdownExists = FieldDropdownExists();
            SelectResponseType(responseType, fieldDropdownExists);
            RefreshControl();
            if (responseType == MarkingType.Query || responseType == MarkingType.Sticky)
                if(!fieldDropdownExists)
                    QueryArea.TryFindElementBy(By.XPath(".//select[2]")).EnhanceAs<Dropdown>().SelectByText(responder);
                else
                    QueryArea.TryFindElementBy(By.XPath(".//select[3]")).EnhanceAs<Dropdown>().SelectByText(responder);
            RefreshControl();
            QueryArea.TryFindElementBy(By.XPath(".//textarea")).EnhanceAs<Textbox>().SetText(text);
            if (responseType == MarkingType.ProtocolDeviation)
                SelectAdditionalProtocolDeviationInfo(pdClass, pdCode, fieldDropdownExists);
        }

        /// <summary>
        /// If the markingType dropdown is not the first dropdown, the field dropdown must be. 
        /// This field dropdown occurs when landscape fields are the first fields on a page
        /// </summary>
        /// <returns>True if the field dropdown exists, false if it does not</returns>
        private bool FieldDropdownExists()
        {
            Dropdown reponseTypeDropdown = QueryArea
                .TryFindElementBy(By.XPath(".//select/option[@value='p' or @value='s' or @value='q']/.."), isWait: false).EnhanceAs<Dropdown>();
            if (reponseTypeDropdown.TryFindElementBy(By.XPath("preceding-sibling::select"), isWait: false) != null)
                return true;

            return false;
        }

        public void SelectResponseType(MarkingType responseType, bool fieldDropdownExists)
        {
            int responseTypeDropdownXpathIndex = !fieldDropdownExists ? 1 : 2;
            Dropdown reponseTypeDropdown = QueryArea.TryFindElementBy(By.XPath(".//select[" + responseTypeDropdownXpathIndex + "]"), isWait: false).EnhanceAs<Dropdown>();

            switch (responseType)
            {
                case MarkingType.Sticky:
                    reponseTypeDropdown.SelectByText("Place Sticky");
                    break;
                case MarkingType.Query:
                    reponseTypeDropdown.SelectByText("Open Query");
                    break;
                case MarkingType.ProtocolDeviation:
                    reponseTypeDropdown.SelectByText("Protocol Deviation");
                    break;
            }
        }

        /// <summary>
        /// Add a Protocol Deviation
        /// </summary>
        /// <param name="pdClass">Protocol Deviation class</param>
        /// <param name="pdCode">Protocol Deviation code</param>
        /// <param name="text">Protocol Deviation text</param>
        public void SelectAdditionalProtocolDeviationInfo(string pdClass, string pdCode, bool fieldDropdownExists)
        {
            if (pdCode != null)
            {
                int pdCodeXpathIndex = !fieldDropdownExists ? 2 : 3;
                QueryArea.TryFindElementBy(By.XPath(".//select[" + pdCodeXpathIndex + "]")).EnhanceAs<Dropdown>().SelectByText(pdCode);
            }
            if (pdClass != null)
            {
                int pdClassXpathIndex = !fieldDropdownExists ? 3 : 4;
                QueryArea.TryFindElementBy(By.XPath(".//select[" + pdClassXpathIndex + "]")).EnhanceAs<Dropdown>().SelectByText(pdClass);
            }
        }

        private void SendTextWithCommands(Textbox placeToInputText, string inputString)
        {
            Regex lookaheadLookbehindRegex = new Regex(@"((?<=\[cmd:.*\])|(?=\[cmd:.*\]))", RegexOptions.IgnoreCase);

            List<string> cmdSplitStrings = lookaheadLookbehindRegex.Split(inputString).ToList();
            StringBuilder stringToSet = new StringBuilder();

            foreach (string stringParsed in cmdSplitStrings)
            {
                if (stringParsed.Equals("[cmd:enter]"))
                    stringToSet.Append(Keys.Enter);
                else if (stringParsed.Equals("[cmd:shift+enter]"))
                    stringToSet.Append(Keys.Shift + Keys.Enter + Keys.Shift);
                else
                    stringToSet.Append(stringParsed);
            }

            placeToInputText.SetText(stringToSet.ToString());
        }

        public IWebElement FindResponse(ResponseSearchModel filter, MarkingType responseType)
        {
            switch (responseType)
            {
                case MarkingType.Query:
                    return FindQuery((QuerySearchModel)filter, ResponseTables);
                default:
                    return FindNonQueryMarking((ResponseSearchModel)filter, ResponseTables);
            }
            throw new ArgumentOutOfRangeException(String.Format("\"{0}\" is an unsupported response type", responseType));
        }

        public IWebElement FindQuery(QuerySearchModel filter, IEnumerable<IWebElement> responseTables)
        {
            foreach (IWebElement tmpQueryTable in responseTables)
            {
                QueryElement query = new QueryElement(tmpQueryTable);
                //If the filter has a specific QueryMessage, 
                //the existence of that message becomes a required condition
                if (filter.Message != null && !tmpQueryTable.Text.Contains(filter.Message))
                    continue;

                if (filter.Closed.HasValue && filter.Closed.Value != QueryIsClosed(query))
                    continue;

                if (filter.Response.HasValue && filter.Response.Value != query.HasReplyTextbox.Value)
                    continue;

                //having the dropdown means requires manual close
                if (filter.ManualClose.HasValue && filter.ManualClose.Value != query.HasDropdown)
                    continue;

                if (filter.Answered.HasValue && filter.Answered.Value == String.IsNullOrEmpty(query.AnswerText))
                    continue;

                if (filter.Answer != null && String.Equals(filter.Answer, query.AnswerText, StringComparison.InvariantCulture))
                    continue;

                return tmpQueryTable;
            }

            return null;
        }

        private bool QueryIsClosed(QueryElement queryTableToTest)
        {
            return !queryTableToTest.HasDropdown.Value && !queryTableToTest.HasCancelCheckbox.Value && !queryTableToTest.HasReplyTextbox.Value;
        }

        public bool IsSignatureRequired()
        {
            var fieldStatusElement = FieldDataSpecific.FindElement(
                By.XPath("../..//td[@class='crf_dataPointCell'][2]/table/tbody/tr/td[1]/a/img"));

            var src = fieldStatusElement.GetAttribute("src");
            return src.Contains("dp_sg.gif");
        }
        #endregion
    }
}
