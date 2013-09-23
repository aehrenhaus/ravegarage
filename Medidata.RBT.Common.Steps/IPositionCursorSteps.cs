using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT;


namespace Medidata.RBT.Common.Steps
{
    [Binding]
    public class IPositionCursorSteps: BrowserStepsBase
    {
        /// <summary>
        /// step that allows to position cursor at the start of a matching message in the specified area
        /// </summary>
        /// <param name="message"></param>
        /// <param name="areaIdentifier"></param>
        [StepDefinition(@"I position cursor at message ""([^""]*)"" in ""([^""]*)""")]
        public void GivenIPositionCursorAtMessageIn(string message, string areaIdentifier)
        {
            CurrentPage.As<IPositionCursor>().PositionCursorAtStart(message, areaIdentifier);
        }

        /// <summary>
        /// Steps that allows to position cursor at the end of a matching message in the specified area
        /// </summary>
        /// <param name="message"></param>
        /// <param name="areaIdentifier"></param>
        [StepDefinition(@"I position cursor after message ""([^""]*)"" in ""([^""]*)""")]
        public void WhenIPositionCursorAfterMessageIn(string message, string areaIdentifier)
        {
            CurrentPage.As<IPositionCursor>().PositionCursorAtEnd(message, areaIdentifier);
        }

    }
}
