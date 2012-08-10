using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class UserEditPage : RavePageBase, ICanVerify
	{
		[FindsBy(How = How.Id, Using = "_ctl0_Content_TopSaveLnkBtn")]
		public IWebElement TopUpdate;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_SaveLnkBtn")]
		public IWebElement BottomUpdate;


		[FindsBy(How = How.Id, Using = "_ctl0_Content_ActiveChk")]
		public IWebElement Active;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_LoginBox")]
		public IWebElement LogIn;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_LockedOutChk")]
		public IWebElement Lockout;


		public bool ControlsAreDisabled(TechTalk.SpecFlow.Table table)
		{
			bool allDisabled = true;

			Dictionary<string, IWebElement> mapping = new Dictionary<string, IWebElement>();
			mapping["Top Update"] = TopUpdate;
			mapping["Bottom Update"] = BottomUpdate;
			mapping["Active"] = Active;
			mapping["Log In"] = LogIn;
			mapping["Locked Out"] = Lockout;
			

			foreach (var row in table.Rows)
			{
				if (mapping[row["Control"]].Enabled)
				{
					allDisabled = false;
					break;
				}
			}

			return allDisabled;
		}

		public override string URL
		{
			get
			{
				return "Modules/UserAdmin/UsersDetails.aspx";
			}
		}
	}
}
