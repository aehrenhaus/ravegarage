using System.Collections;
using Medidata.Core.Objects;
using Medidata.Core.Objects.Reporting;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class ReportingSteps
    {
        [Given(@"the internal user is assigned to the Audit Trail report")]
        public void GivenTheUserIsAssignedToTheAuditTrailReport()
        {
            var user = ScenarioContext.Current.Get<User>("user");
            var auditTrailReport = new Report(SystemInteraction.Use(), "AUDITTRAIL");

            auditTrailReport.ResetUserRoleAssignments(new ArrayList(), new ArrayList { user.ID.ToString() });
        }

        [Then(@"the iMedidata User should have the Audit Trail report assigned")]
        public void ThenTheIMedidataUserShouldHaveTheAuditTrailReportAssigned()
        { 
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use());
            var auditTrailReport = new Report(SystemInteraction.Use(), "AUDITTRAIL");

            foreach (var user in users)
            {
                if(user.ID == externalUser.ConnectedRaveUserID) continue;
                Assert.IsTrue(auditTrailReport.IsUserAssignedToReport(user.ID));
            }
        }

        [Then(@"the iMedidata User should not have the Audit Trail report assigned")]
        public void ThenTheIMedidataUserShouldNotHaveTheAuditTrailReportAssigned()
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use());
            var auditTrailReport = new Report(SystemInteraction.Use(), "AUDITTRAIL");

            foreach (var user in users)
            {
                if (user.ID == externalUser.ConnectedRaveUserID) continue;
                Assert.IsFalse(auditTrailReport.IsUserAssignedToReport(user.ID));
            }
        }

    }
}