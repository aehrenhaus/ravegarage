﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave;
using System.Text.RegularExpressions;

namespace Medidata.RBT.Features.Rave.Seeding
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

            foreach (ReportAssignmentModel reportAssignment in reportAssignments)
            {
                User user = null;
                if (!String.IsNullOrEmpty(reportAssignment.User))
                    user = TestContext.GetExistingFeatureObjectOrMakeNew(reportAssignment.User, () => new User(reportAssignment.User));

                Role role = null;
                if (!String.IsNullOrEmpty(reportAssignment.Role))
                    role = TestContext.GetExistingFeatureObjectOrMakeNew(reportAssignment.Role, () => new Role(reportAssignment.Role));

                if (user != null || role != null)
                {
                    string[] reportArgs = Regex.Split(reportAssignment.Report, " - ");
                    //Activate the report, require report name and report description to be able to activate the report
                    if (reportArgs.Length == 2)
                    {
                        CurrentPage = CurrentPage.NavigateTo("Report Manager");
                        CurrentPage.As<ReportManagerPage>().Activate(reportArgs[0], reportArgs[1]);
                    }
                    CurrentPage = CurrentPage.NavigateTo("Report Assignment");
                }

                if (user != null && !user.ReportAssignmentsExists(reportAssignment.Report))
                    CurrentPage.As<ReportAssignmentPage>().SelectReportAssignment(reportAssignment.Report, user);

                if (role != null && !role.ReportAssignmentsExists(reportAssignment.Report))
                    CurrentPage.As<ReportAssignmentPage>().SelectReportAssignment(reportAssignment.Report, role);
            }

            TestContext.CurrentPage = new HomePage().NavigateToSelf();
        }

    }
}
