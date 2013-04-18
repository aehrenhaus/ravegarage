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

            var audits = Audits.Load(site);
            Assert.IsTrue(audits.Count > 0);

            ScenarioContext.Current.Set(audits, "audits");
        }

        [Then(@"I should see the study has audits in the Rave database")]
        public void ThenIShouldSeeTheStudyHasAuditsInTheRaveDatabase()
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            var audits = Audits.Load(study);
            Assert.IsTrue(audits.Count > 0);

            ScenarioContext.Current.Set(audits, "audits");
        }

        [Then(@"I should see the user has audits in the Rave database")]
        public void ThenIShouldSeeTheUserHasAuditsInTheRaveDatabase()
        {
            var user = ScenarioContext.Current.Get<User>("user");

            var audits = Audits.Load(user);
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

        [Then(@"I should see the following audits?")]
        public void ThenIShouldSeeAnAuditForPropertyWithValue(Table table)
        {
            var audits = ScenarioContext.Current.Get<Audits>("audits");

            foreach (var row in table.Rows)
            {
                var property = row["Property"];
                var value = row["Value"];
                var type = row["ActionType"];

                var auditMatch = false;
                var auditValue = string.Format("{0}|{1}", property, value);

                for (var i = 0; i < audits.Count; i++)
                {
                    if (audits[i].Value != auditValue
                        || audits[i].SubCategory.ToString() != type)
                    {
                        if (!audits[i].Value.StartsWith("LastExternalUpdateDate|") ||
                            !property.Equals("LastExternalUpdateDate")) continue;

                        var dbTime = DateTime.Parse(audits[i].Value.Split('|')[1]);
                        var scenarioTime = DateTime.Parse(value);
                        if (!dbTime.Equals(scenarioTime)) continue;
                    }

                    auditMatch = true;
                    break;
                }

                Assert.IsTrue(auditMatch, "Property: '{0}' - Value: '{1}' - Action Type: '{2}' not found",
                    property, value, type);
            }
        }

    }
}
