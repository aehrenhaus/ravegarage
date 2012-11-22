
using TechTalk.SpecFlow;
using OpenQA.Selenium;

namespace Medidata.RBT
{
	public interface IVerifyConstrolDisabled
	{

		bool IsControlEnabled(string controlName);

	}
}
