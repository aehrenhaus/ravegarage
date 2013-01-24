using TechTalk.SpecFlow;
using OpenQA.Selenium;

namespace Medidata.RBT.StateVerificationInterfaces
{
    /// <summary>
    /// Verify that a control
    /// </summary>
    public interface IVerifyControlEnabledState
	{
        /// <summary>
        /// Verify the enabled or disabled state of a checkbox
        /// </summary>
        /// <param name="identifier">The identifier of the control</param>
        /// <param name="isEnabled">Whether the checkbox should be enabled or not</param>
        /// <param name="areaIdentifier">The area the control exists in</param>
        /// <returns>True if the control state matches the isEnabled value, otherwise false</returns>
        bool VerifyControlEnabledState(string identifier, bool isEnabled, string areaIdentifier = null);
	}
}
