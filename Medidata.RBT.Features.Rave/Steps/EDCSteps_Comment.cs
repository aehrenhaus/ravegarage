using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.TableModels;


namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to EDC
    /// </summary>
	public partial class EDCSteps
    {
        /// <summary>
        /// Verify sticky is placed on field
        /// </summary>
        /// <param name="message">The message the sticky displays</param>
        /// <param name="fieldName">The name of the field which contains the sticky</param>
        [StepDefinition(@"I verify Comment with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
        public void IVerifyCommentWithMessage____IsDisplayedOnField____(string message, string fieldName)
        {
            var page = CurrentPage.As<CRFPage>();
            var filter = new ResponseSearchModel { Field = fieldName, Message = message };
            bool canFind = page.CanFindMarking(filter, MarkingType.Comment);
            Assert.IsTrue(canFind, "Can't find comment!");
        }

        /// <summary>
        /// Add comment on the query page
        /// </summary>
        /// <param name="message">The message the sticky displays</param>
        /// <param name="fieldName">The name of the field which contains the sticky</param>
        [StepDefinition(@"I add comment ""([^""]*)""")]
        public void IAddComment____(string comment)
        {
            var page = CurrentPage.As<AuditsPage>();
            page.AddComment(comment);
        }

	}
}
