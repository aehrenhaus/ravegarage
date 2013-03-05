using System;
using System.Linq;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectFolderFormsPage : ArchitectBasePage
	{
		public override string URL
		{
			get
			{
                return "Modules/Architect/FolderForms.aspx";
			}
		}
	}
}
