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
        /// Place a sticky against a field
        /// </summary>
        /// <param name="table">The field information to place the sticky against and the sticky information</param>
        [StepDefinition(@"I add stickies")]
        public void ThenIAddStickies(Table table)
        {
            List<MarkingModel> stickyInfo = table.CreateSet<MarkingModel>().ToList();
            CurrentPage.As<CRFPage>().PlaceMarkings(stickyInfo, MarkingType.Sticky);
        }

        /// <summary>
        /// Verify sticky is placed on field
        /// </summary>
        /// <param name="message">The message the sticky displays</param>
        /// <param name="fieldName">The name of the field which contains the sticky</param>
        [StepDefinition(@"I verify Sticky with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
        public void IVerifyStickyWithMessage____IsDisplayedOnField____(string message, string fieldName)
        {
            var page = CurrentPage.As<CRFPage>();
            var filter = new ResponseSearchModel { Field = fieldName, Message = message };
            bool canFind = page.CanFindMarking(filter, MarkingType.Sticky);
            Assert.IsTrue(canFind, "Can't find sticky!");
        }
	}
}
