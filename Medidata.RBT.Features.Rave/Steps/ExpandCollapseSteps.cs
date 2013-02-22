using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.Architect;
using Medidata.RBT.PageObjects.Rave;

namespace Medidata.RBT.Features.Rave.Steps
{
    /// <summary>
    /// Steps pertaining to expanding or collapsing areas
    /// </summary>
    [Binding]
    public class ExpandCollapseSteps : BrowserStepsBase
    {
        /// <summary>
        /// Expand an element on a page
        /// </summary>
        /// <param name="identifier">The identifier of the object to expand</param>
        [StepDefinition(@"I expand ""([^""]*)""")]
        public void IExpand____(string identifier)
        {
            CurrentPage.As<IExpand>().Expand(identifier);
        }

        /// <summary>
        /// Expand an object of a specific type, used when you need to get the UniqueName
        /// </summary>
        /// <param name="objectType">The type of the object (e.g. Project, Version, etc.)</param>
        /// <param name="identifier">The identifier (feature name) of the object</param>
        [StepDefinition(@"I expand ""(.*)"" ""(.*)""")]
        public void WhenIExpand(string objectType, string identifier)
        {
            IExpand____(RavePageBase.ReplaceSeedableObjectName(objectType, identifier));
        }

        /// <summary>
        /// Expand an element on a page in a specific area
        /// </summary>
        /// <param name="identifier">The identifier of the object to expand</param>
        /// <param name="areaIdentifier">The area to the object to expand exists in</param>
        [StepDefinition(@"I expand ""([^""]*)"" in area ""([^""]*)""")]
        public void IExpand____(string identifier, string areaIdentifier)
        {
            CurrentPage.As<IExpand>().Expand(identifier, areaIdentifier);
        }

        /// <summary>
        /// Step definition to expand Display multiple log lines per page
        /// This is an old method, refrain from doing expands this way as it is not extensible
        /// </summary>
        [StepDefinition(@"I expand Display multiple log lines per page")]
        public void IExpandDisplayMultipleLogLinesPerPage()
        {
            CurrentPage.As<FileRequestPage>().ExpandDisplayMultipleLogLines();
        }

        /// <summary>
        /// Expand a header in Task Summary area on Subject page.
        /// This is an old method, refrain from doing expands this way as it is not extensible
        /// </summary>
        /// <param name="header"></param>
        [StepDefinition(@"I expand ""([^""]*)"" in Task Summary")]
        public void IExpand____InTaskSummary(string header)
        {
            CurrentPage.As<SubjectPage>().ExpandTask(header);
        }


        /// <summary>
        /// Expand the task summary box
        /// This is an old method, refrain from doing expands this way as it is not extensible
        /// </summary>
        [Given(@"I expand Task Summary")]
        public void GivenIExpandTaskSummary()
        {
            CurrentPage.As<ITaskSummaryContainer>()
                .GetTaskSummary()
                .Expand();
        }
    }
}
