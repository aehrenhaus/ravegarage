
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using Medidata.RBT.StateVerificationInterfaces;

namespace Medidata.RBT
{
    /// <summary>
    /// Interface to use when a page can verify multiple states of objects on the page, not just their existance
    /// </summary>
    public interface IVerifyState : IVerifyCheckboxState, IVerifyControlEnabledState
    {
    }
}
