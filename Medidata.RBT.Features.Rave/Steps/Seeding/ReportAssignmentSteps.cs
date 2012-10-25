using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps that set reporting assignments
    /// </summary>
    [Binding]
    public class ReportAssignmentSteps : BrowserStepsBase
    {
        /// <summary>
        /// This method iterates through the report assignment table to assign
        /// selected reports to selected users
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"following Report assignments exist")]
        public void FollowingReportAssignmentsExist(Table table)
        {
            var reportAssignments = table.CreateSet<ReportAssignmentModel>();
            TestContext.CurrentPage = new HomePage().NavigateToSelf();
            CurrentPage = CurrentPage.NavigateTo("Report Administration");
            CurrentPage = CurrentPage.NavigateTo("Report Assignment");

            foreach (var reportAssignment in reportAssignments)
            {
                User user = TestContext.GetExistingFeatureObjectOrMakeNew(reportAssignment.User, () => new User(reportAssignment.User));
                if (!user.ReportAssignmentsExists(reportAssignment.Report))
                {
                    CurrentPage.As<ReportAssignmentPage>().SelectReportAssignment(reportAssignment.Report, user);
                }
            }

            TestContext.CurrentPage = new HomePage().NavigateToSelf();
        }

    }
}
