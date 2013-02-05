using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Objects.Integration.Helpers;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class StudyInvitationSteps
    {
        [Given(@"the current User is assigned to the current Study with current Role")]
        public void CurrentUserAssignedToCurrentStudyWithCurrentRole()
        {
            StudyInvitationHelper.AssignUserToStudy();
        }
    }
}
