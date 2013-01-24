using TechTalk.SpecFlow;

namespace Medidata.RBT
{
    /// <summary>
    /// Can enter values into an element
    /// </summary>
	public interface IEnterValues
	{
        /// <summary>
        /// Enter a value into a textbox
        /// </summary>
        /// <param name="identifier">The identifier of the textbox</param>
        /// <param name="valueToEnter">The value to enter into the textbox</param>
        void EnterIntoTextbox(string identifier, string valueToEnter);
	}
}
