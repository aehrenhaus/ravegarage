using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class AuditSteps
    {
        [Then(@"I should see the site has audits in the Rave database")]
        public void ThenIShouldSeeTheSiteHasAuditsInTheRaveDatabase()
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Audits audits = Audits.Load(site);
            Assert.IsTrue(audits.Count > 0);

            ScenarioContext.Current.Set(audits, "audits");
        }

        [Then(@"I should see the study has audits in the Rave database")]
        public void ThenIShouldSeeTheStudyHasAuditsInTheRaveDatabase()
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Audits audits = Audits.Load(study);
            Assert.IsTrue(audits.Count > 0);

            ScenarioContext.Current.Set(audits, "audits");
        }


        [Then(@"I should see the audits were performed by user ""(.*)""")]
        public void ThenIShouldSeeTheAuditsWerePerformedBy____(string userType)
        {
            var audits = ScenarioContext.Current.Get<Audits>("audits");

            Assert.AreEqual(audits[audits.Count - 1].AuditUser, userType);
        }


        [Then(@"I should see the audit action type ""(.*)""")]
        public void ThenIShouldSeeTheAuditActionType____(string auditActionType)
        {
            var audits = ScenarioContext.Current.Get<Audits>("audits");
            bool auditMatch = false;

            for (int i = 0; i < audits.Count; i++)
            {
                if (audits[i].SubCategory.ToString() != auditActionType) continue;
                auditMatch = true;
                break;
            }

            Assert.IsTrue(auditMatch);
        }

        [Then(@"I should see the audit action ""(.*)""")]
        public void ThenIShouldSeeTheAuditAction____(string auditAction)
        {
            var audits = ScenarioContext.Current.Get<Audits>("audits");
            bool auditMatch = false;

            for (int i = 0; i < audits.Count; i++)
            {
                if (audits[i].Readable != auditAction) continue;
                auditMatch = true;
                break;
            }

            Assert.IsTrue(auditMatch);
        }
    }
}
