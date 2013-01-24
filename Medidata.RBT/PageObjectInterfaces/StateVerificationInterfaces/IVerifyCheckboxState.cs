
using TechTalk.SpecFlow;
using OpenQA.Selenium;

namespace Medidata.RBT.StateVerificationInterfaces
{
    /// <summary>
    /// Can verify a checkboxes' state
    /// </summary>
    public interface IVerifyCheckboxState
    {
        /// <summary>
        /// Verify the state of a checkbox
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        /// <param name="isChecked">Whether the checkbox should be checked or not</param>
        /// <param name="areaIdentifier">The area the checkbox exists in</param>
        /// <returns>True if the checkbox state matches the isChecked value, otherwise false</returns>
        bool VerifyCheckboxState(string identifier, bool isChecked, string areaIdentifier = null);
    }
}
