﻿using System;
using System.Collections;
using System.Data;
using System.Linq;
using System.Web;
using Medidata.Core.Common.Utilities;
using Medidata.Core.Objects;
using Medidata.Core.Objects.Reporting;
using Medidata.Core.Objects.eLearning;
using Medidata.Data;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class eLearningSteps
    {
       
            

        [Given(@"an eLearning Course with name ""(.*)"" exists and is assigned to the user with current study and role")]
        public void GivenAnELearningCourseExistsAndIsAssignedToTheUserWithCurrentStudyAndRole(string courseName)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            var study = ScenarioContext.Current.Get<Study>("study");
            var role = ScenarioContext.Current.Get<Role>("role");

            var course = new Course { Name = courseName };
            course.Save();
            
            var courseStudyRole = new CourseStudyRole(course, study, role, SystemInteraction.Use());
            courseStudyRole.Save();

            course.StudyRoles.Add(courseStudyRole);
            course.Save();

            eLearningHelper.SaveCourseFile(course.ID, System.Text.Encoding.Unicode.GetBytes("this is an eLearning file"));

            var userCourse = new UserCourse(SystemInteraction.Use())
                                 {
                                     Course = course, 
                                     CourseId = course.ID,
                                     CourseStatus = CourseStatusEnum.NotStarted,
                                     User = user,
                                     UserId = user.ID
                                 };
            userCourse.Save();

            ScenarioContext.Current.Add("course", course);
            ScenarioContext.Current.Add("userCourse", userCourse);
        }

        [Given(@"the user did not complete the eLearning Course")]
        public void GivenTheUserDidNotCompleteTheELearningCourse()
        {
            var userCourse = ScenarioContext.Current.Get<UserCourse>("userCourse");
            userCourse.IsStarted = true;
            userCourse.StartedDateTime = DateTime.UtcNow;
            userCourse.CourseStatus = CourseStatusEnum.Incomplete;
            userCourse.Save();
        }

        [Given(@"the user did not start the eLearning Course")]
        public void GivenTheUserDidNotStartTheELearningCourse()
        {
            var userCourse = ScenarioContext.Current.Get<UserCourse>("userCourse");
            userCourse.CourseStatus = CourseStatusEnum.NotStarted;
            userCourse.Save();
        }

        [Given(@"the user completed the eLearning Course")]
        public void GivenTheUserCompletedTheELearningCourse()
        {
            var userCourse = ScenarioContext.Current.Get<UserCourse>("userCourse");
            userCourse.IsStarted = true;
            userCourse.IsSigned = true;
            userCourse.CourseStatus = CourseStatusEnum.Completed;
            userCourse.UpdateTimeStamps(DateTime.UtcNow, DateTime.UtcNow);
            userCourse.Save();
        }

        [Then(@"the iMedidata user with EDC Role ""(.*)"" should be assigned to the eLearning Course")]
        public void ThenTheIMedidataUserWithEDCRole____ShouldBeAssignedToTheELearningCourse(string roleName)
        {
            var role = Roles.GetAllRoles().FindByName(roleName);
            ScenarioContext.Current.Set(role, "courseRole");

            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use())
                .Where(x => (x.ID != externalUser.ConnectedRaveUserID)
                            && (x.EdcRole == role));
            var course = ScenarioContext.Current.Get<Course>("course");

            var courses = CourseCollection.GetCoursesForUser(users.First(), SystemInteraction.Use(), false, false);

            Assert.IsNotNull(courses.GetById(course.ID));
        }
        
        [Then(@"the iMedidata user with EDC Role ""(.*)"" should not be assigned to the eLearning Course")]
        public void ThenTheIMedidataUserWithEDCRole____ShouldNotBeAssignedToTheELearningCourse(string roleName)
        {
            var role = Roles.GetAllRoles().FindByName(roleName);
            ScenarioContext.Current.Set(role, "courseRole");

            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use())
                .Where(x => (x.ID != externalUser.ConnectedRaveUserID)
                            && (x.EdcRole == role));
            Assert.AreEqual(users.Count(), 1);

            var course = ScenarioContext.Current.Get<Course>("course");

            var courses = CourseCollection.GetCoursesForUser(users.First(), SystemInteraction.Use(), false, false);

            Assert.IsNull(courses.GetById(course.ID));
        }

        [Then(@"the course should be marked as ""(.*)"" for the iMedidata user")]
        public void ThenTheCourseShouldBeMarkedAs____ForTheIMedidataUser(string courseStatus)
        {
            var role = ScenarioContext.Current.Get<Role>("courseRole");
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use())
                .Where(x => (x.ID != externalUser.ConnectedRaveUserID)
                            && (x.EdcRole == role));
            Assert.AreEqual(users.Count(), 1);

            var course = ScenarioContext.Current.Get<Course>("course");

            var userCourse = UserCourse.FetchByUserAndCourse(users.First().ID, course.ID, SystemInteraction.Use());

            switch(courseStatus.ToLowerInvariant())
            {
                case "completed":
                    Assert.IsTrue(userCourse.CourseStatus == CourseStatusEnum.Completed);
                    break;
                case "not started":
                    Assert.IsTrue(userCourse == null || userCourse.CourseStatus == CourseStatusEnum.NotStarted);
                    break;
                case "incomplete":
                    Assert.IsTrue(userCourse.CourseStatus == CourseStatusEnum.Incomplete);
                    break;
                case "overridden":
                    Assert.IsTrue(userCourse.Override);
                    break;
            }  
        }

        [Given(@"the eLearning course assignment is overridden")]
        public void GivenTheELearningCourseAssignmentIsOverridden()
        {
            var userCourse = ScenarioContext.Current.Get<UserCourse>("userCourse");
            userCourse.Override = true;
            userCourse.Save();
        }

        [Then(@"the course should be marked overridden")]
        public void ThenTheCourseShouldBeMarkedOverridden()
        {
            var userCourse = ScenarioContext.Current.Get<UserCourse>("userCourse");
            Assert.IsTrue(userCourse.Override);
        }

    }
}