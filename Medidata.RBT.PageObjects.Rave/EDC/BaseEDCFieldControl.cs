using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;


namespace Medidata.RBT.PageObjects.Rave
{
	public abstract class BaseEDCFieldControl : ControlBase, IEDCFieldControl
	{
		public BaseEDCFieldControl(IPage page)
			: base(page)
		{
		}

        public virtual bool HasDataEntered(string text)
        {
            return text.Equals(FieldControlContainer.Text);
        }


        public virtual string StatusIconPathLookup(string lookupIcon)
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
                default:
                    throw new InvalidOperationException("Status: " + lookupIcon + " not yet implemented in StatusIconPathLookup(string lookupIcon)");
            }
            return result;
        }

		public virtual void EnterData(string text, ControlType controlType = ControlType.Default) 
		{
			switch (controlType)
			{
				case ControlType.Default:
					EnterValueGuessControlType(text);
					break;

				case ControlType.Text:
				case ControlType.LongText:
					EnterTextBoxValue(text);
					break;



				case ControlType.Datetime:
					EnterDatetimeValue(text);
					break;

				case ControlType.RadioButton:
				case ControlType.RadioButtonVertical:
					EnterRadiobuttonValue(text);
					break;

				case ControlType.DynamicSearchList:
					EnterDynamicSearchListValue(text);
					break;

                case ControlType.CheckBox:
                    EnterCheckBox(bool.Parse(text));
                    break;

				default:
					throw new Exception("Not supported control type:"+controlType);
			}
		}

		public IWebElement FieldControlContainer { get; set; }

		/// <summary>
		/// This method is just for backward compatibility.
		/// 
		/// </summary>
		/// <param name="val"></param>
		protected virtual void EnterValueGuessControlType(string text)
		{
			var textboxes = FieldControlContainer.Textboxes();
			var dropdowns = FieldControlContainer.FindElements(By.TagName("select")).ToList();

			//this dropdown does count
			var dataEntyErrorDropdown = dropdowns.FirstOrDefault(x =>
			{
				var options = new SelectElement(x).Options;
				return options.Count == 1 && (options[0].Text == "Data Entry Error" || options[0].Text == "Entry Error");
			});
			//	int dataEntyErrorDropdownCount = dataEntyErrorDropdown == null ? 0 : 1;
			//int datapointDropdownCount =  dropdowns.Count - dataEntyErrorDropdownCount ;
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

		protected virtual void EnterTextBoxValue(string val)
		{
			var textboxes = FieldControlContainer.Textboxes();
			textboxes[0].SetText(val);
		}
	
        //new method
        protected virtual void EnterCheckBox(bool selected)		
        {
			var checkboxes = FieldControlContainer.Checkboxes();
            if (checkboxes[0].Selected != selected)
                checkboxes[0].Click();
		}

		protected virtual void EnterDatetimeValue(string val)
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

			var textboxes = FieldControlContainer.Textboxes();
			var dropdowns = FieldControlContainer.FindElements(By.TagName("select")).ToList();

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

		protected virtual void EnterRadiobuttonValue(string val)
		{
			HtmlTable table = FieldControlContainer.Table("_RadioBtnList");
			var optionTDs = table.FindElements(By.XPath("./tbody/tr/td"));
			var td = optionTDs.FirstOrDefault(x=>x.Text.Trim()==val);
			td.RadioButtons()[0].Set();
	
		}


		protected virtual void EnterDropdownValue(string val)
		{

			var dropdowns = FieldControlContainer.FindElements(By.TagName("select")).ToList();

			new SelectElement(dropdowns[0]).SelectByText(val);
		}

		protected virtual void EnterDynamicSearchListValue(string val)
		{

			var dslContainer = FieldControlContainer.TryFindElementBy(By.XPath(".//td[@style='padding-left:4px;']"));
			var dsl = new CompositeDropdown(this.Page, "DSL", dslContainer);

			dsl.TypeAndSelect(val);
		}

		public virtual AuditsPage ClickAudit()
		{
			var auditButton = FieldControlContainer.TryFindElementByPartialID("DataStatusHyperlink");
			auditButton.Click();
			return new AuditsPage();
		}


		public virtual IWebElement FindQuery(QuerySearchModel filter)
		{
			throw new NotImplementedException();
		}

		public virtual void AnswerQuery(QuerySearchModel filter)
		{
			string answer = filter.Answer;
			filter.Answer = null;
			FindQuery(filter).Textboxes()[0].SetText(answer);
		}

		public virtual void CloseQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Dropdowns()[0].SelectByText("Close Query");
		}

		public virtual void CancelQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Checkboxes()[0].Check();
		}

		public virtual void Check(string checkName)
		{
			IWebElement actionArea = FieldControlContainer;
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
			IWebElement actionArea = FieldControlContainer;
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

        public virtual void Click() { throw new NotImplementedException(); }

        public virtual bool IsDroppedDown() { throw new NotImplementedException(); }



		public virtual bool IsElementFocused(ControlType type, int position)
		{
			throw new NotImplementedException();
		}

		public virtual void FocusElement(ControlType type, int position)
		{
			throw new NotImplementedException();
		}

        public virtual bool IsVerificationRequired()
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Check if the field is inactive
        /// </summary>
        /// <param name="text">The text of the field to check</param>
        /// <returns>True if inactive, false if active</returns>
        public virtual bool IsInactive(string text)
        {
            throw new NotImplementedException();
        }

        public bool IsSignatureRequired()
        {
            var fieldStatusElement = FieldControlContainer.FindElement(
                By.XPath("../..//td[@class='crf_dataPointCell'][2]/table/tbody/tr/td[1]/a/img"));

            var src = fieldStatusElement.GetAttribute("src");
            return src.Contains("dp_sg.gif");
        }
    }
}
