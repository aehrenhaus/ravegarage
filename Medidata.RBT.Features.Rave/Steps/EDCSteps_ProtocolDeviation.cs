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
        [StepDefinition(@"I add Protocol Deviation")]
        public void IAddProtocolDeviation(Table table)
        {
            List<ProtocolDeviationModel> pdInfo = table.CreateSet<ProtocolDeviationModel>().ToList();
            CurrentPage.As<CRFPage>().AddProtocolDeviations(pdInfo);
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
    }
}
