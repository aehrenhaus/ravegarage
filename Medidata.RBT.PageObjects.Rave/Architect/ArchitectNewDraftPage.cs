using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectNewDraftPage : ArchitectBasePage
	{

		public override string URL
		{
			get
			{
				return "Modules/Architect/NewDraft.aspx";
			}
		}
	
	}
}
