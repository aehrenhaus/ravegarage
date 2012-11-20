using System;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectFormDesignerPage : ArchitectBasePage, IActivatePage, IVerifySomethingExists
	{
		#region IActivatePage

		public IPage Activate(string type, string identifierToActivate)
		{
			Activate(identifierToActivate, true);
			return this;
		}

		public IPage Inactivate(string type, string identifierToInactivate)
		{
			Activate(identifierToInactivate, false);
			return this;
		}
        
        public IPage EditField(string field)
        {
            ClickEditForField(field);
            return this;  
        }

        public IPage FillRangesForFieldEditChecks(IEnumerable<FieldModel> fields)
		{
            foreach (var field in fields)
                UpdateFieldEditCheckRanges(field.FieldEditCheck, field.Low, field.High);
			return this;
		}

      

        public bool VerifyRangesForFieldEditChecks(IEnumerable<FieldModel> fields)
        {
            foreach (var field in fields)
            {
                if (!VerifyFieldEditCheckRanges(field.FieldEditCheck, field.Low, field.High))
                    return false;
            }
            return true;
        }

        public IPage Save()
        {
            Browser.Tables()[10].FindImagebuttons()[0].Click();
            return this;
        }

    
        public IPage ExpandEditChecks(string field = "")
        {
            if (!field.Equals(""))
                ClickEditForField(field);

            ClickExpandForFieldEditChecks();
            return this;
        }


        private bool VerifyFieldEditCheckRanges(string editCheckType, string lowValue, string highValue)
        {
            int index = 0;
            if (editCheckType.Trim().Equals("Auto-Query for data out of range"))
            {
                //do nothing
            }
            else if (editCheckType.Trim().Equals("Mark non-conformant data out of range"))
            {
                index += 2;
            }
            else
            {
                throw new NotSupportedException(editCheckType + " not supported in UpdateFieldEditCheckRanges() in ArchitectFormDesigner.");
            }

            var table = Browser.Tables()[30];

            if ((!table.Textboxes()[index].Value.Equals(lowValue)) || (!table.Textboxes()[index + 1].Value.Equals(highValue)))
                return false;
            return true;
        }

        private void UpdateFieldEditCheckRanges(string editCheckType, string lowValue, string highValue)
        {
            int index = 0;
            if (editCheckType.Trim().Equals("Auto-Query for data out of range"))
            {
                //do nothing
            }
            else if (editCheckType.Trim().Equals("Mark non-conformant data out of range"))
            {
                index +=2;
            }
            else
            {
                throw new NotSupportedException(editCheckType + " not supported in UpdateFieldEditCheckRanges() in ArchitectFormDesigner.");
            }
            
            var table = Browser.Tables()[30];

            table.Textboxes()[index].SetText(lowValue);
            table.Textboxes()[index + 1].SetText(highValue);
        }

        private void ClickEditForField(string field)
        {
            var table = Browser.Table("_ctl0_Content_FieldsGrid");
			Table matchTable = new Table("Name");
            matchTable.AddRow(field);
            var rows = table.FindMatchRows(matchTable);

            if (rows.Count == 0)
                throw new Exception("Can't find target to see field for:" + field);

            rows[0].FindImagebuttons()[1].Click();
        }

        private void ClickExpandForFieldEditChecks()
        {
            Browser.Tables()[30].FindImagebuttons()[0].Click();
        }


		private void Activate(string identifier, bool activate)
		{
            throw new NotImplementedException("Activate method not implemented in ArchitectFormDesigner.cs.");
		}

		#endregion

		public override string URL
		{
			get
			{
                return "Modules/Architect/FormDesigner.aspx";
			}
		}

		#region IVerifySomethingExists

		bool IVerifySomethingExists.VerifySomethingExist(string areaIdentifier, string type, string identifier)
		{
			if (areaIdentifier == null)
			{
				if (Browser.FindElementByTagName("body").Text.Contains(identifier))
					return true;
				else
					return false;
			}
			throw new NotImplementedException();
		}

		#endregion
	}
}
