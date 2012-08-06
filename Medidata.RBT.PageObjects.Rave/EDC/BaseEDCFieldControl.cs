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

		//returns the dom container that contains the field controls
		protected abstract IWebElement GetFieldControlContainer();

		public virtual void EnterData(string text, ControlType controlType)
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


				default:
					throw new Exception("Not supported control type:"+controlType);
			}
		}

		/// <summary>
		/// This method is just for backward compatibility.
		/// 
		/// </summary>
		/// <param name="val"></param>
		protected virtual void EnterValueGuessControlType(string text)
		{
			IWebElement datapointTable = GetFieldControlContainer();
			var textboxes = datapointTable.Textboxes();
			var dropdowns = datapointTable.FindElements(By.TagName("select")).ToList();

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
			IWebElement datapointTable = GetFieldControlContainer();
			var textboxes = datapointTable.Textboxes();
			textboxes[0].SetText(val);
		}

		protected virtual void EnterDatetimeValue(string val)
		{

			IWebElement datapointTable = GetFieldControlContainer();

			//if(controlType== ControlType

			var textboxes = datapointTable.Textboxes();
			var dropdowns = datapointTable.FindElements(By.TagName("select")).ToList();

			if (textboxes.Count == 2 && dropdowns.Count == 1)//date field  .format: dd MM yyyy
			{
				string[] dateParts = val.Split(' ');
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
		}

		protected virtual void EnterRadiobuttonValue(string val)
		{
			IWebElement datapointTable = GetFieldControlContainer();
			HtmlTable table = datapointTable.Table("_RadioBtnList");
			var optionTDs = table.FindElements(By.XPath("./tbody/tr/td"));
			var td = optionTDs.FirstOrDefault(x=>x.Text.Trim()==val);
			td.RadioButtons()[0].Set();
	
		}


		protected virtual void EnterDropdownValue(string val)
		{

			IWebElement datapointTable = GetFieldControlContainer();

			var dropdowns = datapointTable.FindElements(By.TagName("select")).ToList();

			new SelectElement(dropdowns[0]).SelectByText(val);
		}

		protected virtual void EnterDynamicSearchListValue(string val)
		{

			IWebElement datapointTable = GetFieldControlContainer();
			var dslContainer = datapointTable.TryFindElementBy(By.XPath(".//td[@style='padding-left:4px;']"));
			var dsl = new CompositeDropdown(this.Page, "DSL", dslContainer);

			dsl.TypeAndSelect(val);
		}

		public abstract AuditsPage ClickAudit();

		public virtual IWebElement FindQuery(QuerySearchModel filter)
		{
			throw new NotImplementedException();
		}

		public virtual void AnswerQuery(QuerySearchModel filter)
		{
			throw new NotImplementedException();
		}

		public virtual void CloseQuery(QuerySearchModel filter)
		{
			throw new NotImplementedException();
		}

		public virtual void CancelQuery(QuerySearchModel filter)
		{
			throw new NotImplementedException();
		}

		public virtual void Check(string checkName)
		{
			throw new NotImplementedException();
		}

		public virtual void Uncheck(string checkName)
		{
			throw new NotImplementedException();
		}
	}
}
