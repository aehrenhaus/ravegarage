using TechTalk.SpecFlow;
using OpenQA.Selenium;

namespace Medidata.RBT
{
    /// <summary>
    /// Interface to expand elements on a page
    /// </summary>
    public interface IExpand
    {
        /// <summary>
        /// Expand an element. Basically, if it has the plus/arrow next to it, click that
        /// </summary>
        /// <param name="objectToExpand">Identifier of the object to expand</param>
        /// <param name="areaIdentifier">The area the object to expand exists in</param>
        void Expand(string objectToExpand, string areaIdentifier = null);
    }
}
