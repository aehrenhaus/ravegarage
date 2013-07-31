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
        /// Add a Protocol Deviation on the field
        /// </summary>
        /// <param name="table">The field information to add Protocol Deviation on and the Protocol Deviation information</param>
        [StepDefinition(@"I add protocol deviations")]
        public void IAddProtocolDeviation(Table table)
        {
            List<MarkingModel> pdInfo = table.CreateSet<MarkingModel>().ToList();
            CurrentPage.As<CRFPage>().PlaceMarkings(pdInfo, MarkingType.ProtocolDeviation);
        }

        /// <summary>
        /// Verify Protocol Deviation class/code does not exist in CRF
        /// </summary>
        /// <param name="pdComponent">Protocol Deviation component (class/code)</param>
        /// <param name="value">Value of the Protocol Deviation component (class/code value)</param>
        [StepDefinition(@"I verify deviation ""([^""]*)"" with value ""([^""]*)"" does not exist in CRF")]
        public void IVerifyDeviationDoesNotExistInCRF(string pdComponent, string value)
        {
            Assert.IsTrue(CurrentPage.As<CRFPage>().VerifyDeviation(pdComponent, value, false));
        }

        /// <summary>
        /// Verify Protocol Deviation class/code exists in CRF
        /// </summary>
        /// <param name="pdComponent">Protocol Deviation component (class/code)</param>
        /// <param name="value">Value of the Protocol Deviation component (class/code value)</param>
        [StepDefinition(@"I verify deviation ""([^""]*)"" with value ""([^""]*)"" exists in CRF")]
        public void IVerifyDeviationExistsInCRF(string pdComponent, string value)
        {
            Assert.IsTrue(CurrentPage.As<CRFPage>().VerifyDeviation(pdComponent, value, true));
        }

        /// <summary>
        /// Verify sticky is placed on field
        /// </summary>
        /// <param name="message">The message the sticky displays</param>
        /// <param name="fieldName">The name of the field which contains the sticky</param>
        [StepDefinition(@"I verify Protocol Deviation with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
        public void IVerifyProtocolDeviationWithMessage____IsDisplayedOnField____(string message, string fieldName)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            ResponseSearchModel filter = new ResponseSearchModel { Field = fieldName, Message = message };
            bool canFind = page.CanFindMarking(filter, MarkingType.ProtocolDeviation);
            Assert.IsTrue(canFind, "Can't find Protocol Deviation!");
        }
    }
}
