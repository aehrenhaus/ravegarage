using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.Configuration;
using Medidata.RBT.PageObjects.Rave.Configuration.Models;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.TableModels;


namespace Medidata.RBT.Features.Rave.Steps
{
    /// <summary>
    /// Steps pertaining to configuration
    /// </summary>
    [Binding]
    public class ConfigurationSteps : BrowserStepsBase
    {
        /// <summary>
        /// Check if the URL has coder enabled
        /// </summary>
        [StepDefinition(@"the URL has ""([^""]*)"" installed")]
        public void TheURLHas____Installed()
        {
            bool isCoderEnabled = DbHelper.ExecuteStoredProcedureRetBool("spUrlUsingCoder");
            Assert.IsTrue(isCoderEnabled);
        }

        /// <summary>
        /// Step definition to create the specified pdf configuration if it doesn't exist
        /// </summary>
        /// <param name="table">The PDF configuration profiles to create</param>
        [StepDefinition(@"following Global Configurations exist")]
        public void FollowingPDFConfigurationProfileSettingsExist(Table table)
        {
            IEnumerable<GlobalConfigurationModel> globalConfigurationList = table.CreateSet<GlobalConfigurationModel>();

            foreach (GlobalConfigurationModel globalConfigurationModel in globalConfigurationList)
                SeedingContext.GetExistingFeatureObjectOrMakeNew(globalConfigurationModel.Name, () => new GlobalConfiguration(globalConfigurationModel.Name));
        }

        /// <summary>
        /// Enter the passed in data into coder configuration
        /// </summary>
        /// <param name="table">The data to enter into coder configuration</param>
        [StepDefinition(@"I enter data in ""Coder Configuration"" and save")]
        public void IEnterDataInCoderConfiguration(Table table)
        {
            var page = CurrentPage.As<CoderConfigurationPage>();

            page.FillData(table.CreateSet<CoderConfigurationModel>());
            page.Save();
        }

		/// <summary>
		/// Fill the table on CodingColumnSetting.aspx
		/// </summary>
		/// <param name="table"></param>
		[StepDefinition(@"I enter data in Coding Settings")]
		public void IEnterDataInCodingSettings(Table table)
		{
			var page = CurrentPage.As<CodingColumnSettingPage>();

			page.EnterData(table.CreateSet<CodingColumnModel>());
			page.Save();
		}


		/// <summary>
		/// Upload file on ConfigurationLoader.aspx
		/// </summary>
		[StepDefinition(@"I upload configuration settings file")]
		public void IUploadConfigurationSettingsFile()
		{
			var page = CurrentPage.As<ConfigurationLoaderPage>();

			page.UploadFile(WebTestContext.FileToUpload.FullName);

	
		}


        /// <summary>
        /// Check that the passed in configuration settings exist
        /// </summary>
        /// <param name="table">The settings to check</param>
		[StepDefinition(@"following Configuration Settings Exist")]
		public void FollowingConfigurationSettingsExist(Table table)
		{
			var page = new WorkflowConfigPage().NavigateToSelf().ClickLink("Other Settings").As<ConfigurationSettingsPage>();
			bool bOk = page.VerifyRowWithValuesExists(table.CreateSet<ConfigurationSettingsModel>());
			Assert.IsTrue(bOk);
			CurrentPage = new HomePage().NavigateToSelf();
		}

        /// <summary>
        /// Set the amount of lines displayed per page for a specified user
        /// </summary>
        /// <param name="linesPerPage">The number of lines to display</param>
        /// <param name="userName">The user to edit the line display for</param>
		[StepDefinition(@"I set lines per page to (.*) for User ""(.*)""")]
		public void ISetLinesPerPageTo____ForUser____(int linesPerPage, string userName)
		{
			User user = SeedingContext.GetExistingFeatureObjectOrMakeNew(userName, () =>new User(userName));
			user.SetLinesPerPage(linesPerPage);
		}

        /// <summary>
        /// Assign the user to various project assignments
        /// </summary>
        /// <param name="table">Privileges to assign a user to and the user to assign those privileges to</param>
        [StepDefinition(@"following Project assignments exist")]
        public void FollowingProjectAssignmentsExist(Table table)
        {
			using (var session = new LoginSession(WebTestContext, restoreOriginalUser:false))
			{

				List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
				foreach (ConfigurationCreationModel configuration in configurations)
				{
					User user = SeedingContext.GetExistingFeatureObjectOrMakeNew(configuration.User, () => new User(configuration.User));

					Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(configuration.Role, () => new Role(configuration.Role));
					SecurityRole securityRole = SeedingContext.GetExistingFeatureObjectOrMakeNew
						(configuration.SecurityRole, () => new SecurityRole(configuration.SecurityRole));

					Site site = SeedingContext.GetExistingFeatureObjectOrMakeNew(configuration.Site, () => new Site(configuration.Site));
					Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew(configuration.Project,
					                                                                () => new Project(configuration.Project));
                    //Create an external system
                    project.AssignExternalSystem(configuration.ExternalSystem);


					bool studyAssignmentExists = user.StudyAssignmentExists(role.UniqueName, project.UniqueName, site.UniqueName,configuration.Environment);
					bool moduleAssignmentExists = user.ModuleAssignmentExists("All Projects", securityRole.UniqueName);
					if (!studyAssignmentExists || !moduleAssignmentExists)
					{
						string loggedInUserBeforeAssignments = WebTestContext.CurrentUser;
						LoginPage.LoginToHomePageIfNotAlready(WebTestContext);

						CurrentPage = new UserAdministrationPage().NavigateToSelf();
						CurrentPage = CurrentPage.As<UserAdministrationPage>().SearchUser(new UserAdministrationPage.SearchByModel()
							                                                                  {
								                                                                  Login = user.UniqueName
							                                                                  });
						CurrentPage = CurrentPage.As<UserAdministrationPage>().ClickUser(user.UniqueName);
						if (!moduleAssignmentExists)
							CurrentPage.As<UserEditPage>().AssignUserToSecurityRole(user, securityRole);
						if (!studyAssignmentExists)
							CurrentPage.As<UserEditPage>().AssignUserToPermissions(user, project, role, configuration.Environment, site);

                        //assign globallibrary role
                        if (!String.IsNullOrEmpty(configuration.GlobalLibraryRole))
                        {
                            CurrentPage.As<UserEditPage>().AssignUserToGlobalLibraryRole();
                        }
					}
				}

				session.RestoreOriginalUser = true;
			}

			Browser.WaitForDocumentLoad();
        }

        /// <summary>
        /// Assign the user to a security role
        /// </summary>
        /// <param name="userFeature">The user to assign the role to</param>
        /// <param name="securityRoleFeature">The security role to assign to the user</param>
        [StepDefinition(@"I assign user ""([^""]*)"" to security role ""([^""]*)""")]
        public void FollowingProjectAssignmentsExist(string userFeature, string securityRoleFeature)
        {

			using (var session = new LoginSession(WebTestContext, restoreOriginalUser: false))
            {
                User user = SeedingContext.GetExistingFeatureObjectOrMakeNew(userFeature, () => new User(userFeature));
                SecurityRole securityRole = SeedingContext.GetExistingFeatureObjectOrMakeNew
                            (securityRoleFeature, () => new SecurityRole(securityRoleFeature));
                if (!user.ModuleAssignmentExists("All Projects", securityRole.UniqueName))
                {
                    CurrentPage = new UserAdministrationPage().NavigateToSelf();
                    CurrentPage = CurrentPage.As<UserAdministrationPage>().SearchUser(new UserAdministrationPage.SearchByModel()
                    {
                        Login = user.UniqueName
                    });
                    CurrentPage = CurrentPage.As<UserAdministrationPage>().ClickUser(user.UniqueName);
                    CurrentPage.As<UserEditPage>().AssignUserToSecurityRole(user, securityRole);
                }
				session.RestoreOriginalUser = true;
            }
        }

        /// <summary>
        /// Make review groups active
        /// </summary>
        /// <param name="numbers">The numbers of the review groups to make active</param>
        [StepDefinition(@"review group number ""<Numbers>"" is active")]
        public void ReviewGroupNumber____IsActive(Table numbers)
        {
            string loggedInUserBeforeAssignments = WebTestContext.CurrentUser;
            LoginPage.LoginToHomePageIfNotAlready(WebTestContext);

            CurrentPage = new WorkflowConfigPage().NavigateToSelf();

            List<int> reviewGroupsToDeactivate = new List<int>();

            foreach (TableRow tableRow in numbers.Rows)
            {
                string stringNumber = tableRow["Numbers"];
                int parsedNumber;
                Int32.TryParse(stringNumber, out parsedNumber);
                reviewGroupsToDeactivate.Add(parsedNumber);
                CurrentPage.As<WorkflowConfigPage>().SetReviewGroup(parsedNumber, true);
            }

            LoginPage page = new LoginPage();
            page.NavigateToSelf();
            CurrentPage = page.Login(loggedInUserBeforeAssignments, RaveConfiguration.Default.DefaultUserPassword);
            CurrentPage = new WorkflowConfigPage().NavigateToSelf();
        }
 
        /// <summary>
        /// Build Clinical Views for passed in project
        /// </summary>
        /// <param name="projectName">The name of the project</param>
        [StepDefinition(@"Clinical Views exist for project ""([^""]*)""")]
        public void ClinicalViewsExistForProject____(string projectName)
        {
            Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew(projectName, () => new Project(projectName));
            if (!EDCSteps.ClinicalViewsExistForProject(project.UniqueName))
            {
                WebTestContext.CurrentPage = new ConfigurationClinicalViewsPage().NavigateToSelf();
                WebTestContext.CurrentPage.As<ConfigurationClinicalViewsPage>().BuildClinicalViews(project.UniqueName);
            }
        }

        /// <summary>
        /// Verify the column name
        /// </summary>
        /// <param name="value">The column name</param>
        /// <param name="area">The configuration page area</param>
        [StepDefinition(@"I verify ""([^""]*)"" column name for ""([^""]*)""")]
        public void IVerifyColumnNameFor(string value, string area)
        {
            Assert.IsTrue(CurrentPage.As<DeviationPage>().VerifySomethingExist(area, value));
        }

        /// <summary>
        /// Select the edit icon
        /// </summary>
        /// <param name="rowIdentifier">The configuration setting value to edit</param>
        /// <param name="area">The configuration page area</param>
        [StepDefinition(@"I select edit for ""([^""]*)"" in ""([^""]*)""")]
        public void ISelectEditFor(string rowIdentifier, string area)
        {
            CurrentPage.As<DeviationPage>().RowSelectedForEdit(rowIdentifier, area);
        }

        /// <summary>
        /// Verify the checkbox checked
        /// </summary>
        /// <param name="cbName">The checkbox name</param>
        /// <param name="rowIdentifier">The configuration setting value to edit</param>
        /// <param name="area">The configuration page area</param>
        [StepDefinition(@"I verify checkbox ""([^""]*)"" checked for ""([^""]*)"" in ""([^""]*)""")]
        public void IVerifyCheckedFor(string cbName, string rowIdentifier, string area)
        {
            Assert.IsTrue(CurrentPage.As<DeviationPage>().VerifyRowChecked(cbName, rowIdentifier, area));
        }

        /// <summary>
        /// Verify the checkbox unchecked
        /// </summary>
        /// <param name="cbName">The checkbox name</param>
        /// <param name="rowIdentifier">The configuration setting value to edit</param>
        /// <param name="area">The configuration page area</param>
        [StepDefinition(@"I verify checkbox ""([^""]*)"" unchecked for ""([^""]*)"" in ""([^""]*)""")]
        public void IVerifyUncheckedFor(string cbName, string rowIdentifier, string area)
        {
            Assert.IsFalse(CurrentPage.As<DeviationPage>().VerifyRowChecked(cbName, rowIdentifier, area));
        }

        /// <summary>
        /// Verify the deviation class or code does not exist
        /// </summary>
        /// <param name="columnIdentifier">The protocol deviation setting (class or code)</param>
        /// <param name="rowIdentifier">The setting's value</param>
        [StepDefinition(@"I verify deviation ""([^""]*)"" with value ""([^""]*)"" does not exist")]
        public void IVerifyDeviation____DoesNotExist(string columnIdentifier, string rowIdentifier)
        {
            Assert.IsTrue(CurrentPage.As<ArchitectCheckPage>().VerifyDeviation(columnIdentifier, rowIdentifier, false));
        }

        /// <summary>
        /// Verify the deviation class or code does not exist
        /// </summary>
        /// <param name="columnIdentifier">The protocol deviation setting (class or code)</param>
        /// <param name="rowIdentifier">The setting's value</param>
        [StepDefinition(@"I verify deviation ""([^""]*)"" with value ""([^""]*)"" exists")]
        public void IVerifyDeviation____Exists(string columnIdentifier, string rowIdentifier)
        {
            Assert.IsTrue(CurrentPage.As<ArchitectCheckPage>().VerifyDeviation(columnIdentifier, rowIdentifier, true));
        }

        /// <summary>
        /// Revert a value of the flag Active for PD class or code
        /// </summary>
        /// <param name="type">deviation class/deviation code</param>
        /// <param name="identifier">The configuration setting value</param>
        /// <param name="action">Active/Inactive</param>
        [StepDefinition(@"I clean ""(.*)"" ""(.*)"" to ""(.*)""")]
        public void ICleanDeviationClass(string type, string identifier, string action)
        {
            CurrentPage = CurrentPage.NavigateTo("Home");
            CurrentPage = CurrentPage.NavigateTo("Configuration");
            CurrentPage = CurrentPage.NavigateTo("Other Settings");
            CurrentPage = CurrentPage.NavigateTo("Deviations");
            if (String.Compare(action, "active", StringComparison.CurrentCultureIgnoreCase) == 0)
            {
                CurrentPage.As<DeviationPage>().Activate(type, identifier);
            }
            else
            {
                CurrentPage.As<DeviationPage>().Inactivate(type, identifier);
            }
        }

        /// <summary>
        /// Add a Deviation Class
        /// </summary>
        /// <param name="table">The Protocol Deviation Class information</param>
        [StepDefinition(@"I add Deviation Class")]
        public void IAddDeviationClass(Table table)
        {
            List<ProtocolDeviationClassModel> pdInfo = table.CreateSet<ProtocolDeviationClassModel>().ToList();
            CurrentPage.As<DeviationPage>().AddDeviationClasses(pdInfo);
        }

        /// <summary>
        /// Delete the Deviation Class
        /// </summary>
        /// <param name="pdClass">The Protocol Deviation Class value</param>
        [StepDefinition(@"I delete Deviation Class ""([^""]*)""")]
        public void IDeleteDeviationClass____(string pdClass)
        {
            CurrentPage.As<DeviationPage>().DeleteDeviationClass(pdClass);
        }

        /// <summary>
        /// Add a Deviation Code
        /// </summary>
        /// <param name="table">The Protocol Deviation Code information</param>
        [StepDefinition(@"I add Deviation Code")]
        public void IAddDeviationCode(Table table)
        {
            List<ProtocolDeviationCodeModel> pdInfo = table.CreateSet<ProtocolDeviationCodeModel>().ToList();
            CurrentPage.As<DeviationPage>().AddDeviationCodes(pdInfo);
        }

        /// <summary>
        /// Delete the Deviation Code
        /// </summary>
        /// <param name="pdCode">The Protocol Deviation Code value</param>
        [StepDefinition(@"I delete Deviation Code ""([^""]*)""")]
        public void IDeleteDeviationCode____(string pdCode)
        {
            CurrentPage.As<DeviationPage>().DeleteDeviationCode(pdCode);
        }

        #region Steps pertaining to manipulating or verifying the configuration settings via database

        /// <summary>
        /// Verify that analyterange audit exists.
        /// </summary>
        /// <param name="table">The table.</param>
        [StepDefinition(@"I verify Protocol Deviation configuration audits exist")]
        public void IVerifyProtocolDeviationConfigurationAuditsExist__(Table table)
        {
            //SpecialStringHelper.ReplaceTableColumn(table, "ProtocolDeviation");
            string sql = GetProtocolDeviationConfigurationAuditSql(table.CreateInstance<ProtocolDeviationAuditModel>());
            var dataTable = DbHelper.ExecuteDataSet(sql).Tables[0];
            Assert.IsTrue((int)dataTable.Rows.Count > 0, "Protocol Deviation Configuration Audit does not exist");
        }

        private static string GetProtocolDeviationConfigurationAuditSql(ProtocolDeviationAuditModel model)  //string ObjectName, string ObjectType, string AuditName
        {
            string objectType = String.Empty;

            switch (model.ObjectType)
            {
                case "Class":
                    objectType = "Medidata.Core.Objects.ProtocolDeviationClassR";
                    break;
                case "Code":
                    objectType = "Medidata.Core.Objects.ProtocolDeviationCodeR";
                    break;
                default:
                    throw new NotImplementedException(String.Format("Unknown Object Type: {0}", model.ObjectType));
            }

            return String.Format("declare @ObjectName nvarchar(2000) = '{0}' " +
                                "declare @ObjectType varchar(100) = '{1}' " +
                                "declare @AuditName nvarchar(100) = '{2}' " +
                                "select a1.AuditID " +
                                "from (	select a.AuditID, a.ObjectTypeID, a.ObjectID " +
                                "		from Audits a " +
                                "		inner join ObjectTypeR ot on ot.ObjectTypeID = a.ObjectTypeID " +
                                "		inner join AuditSubCategoryR sc on sc.ID = a.AuditSubCategoryID " +
                                "		left join ProtocolDeviationClassR class on class.ProtocolDeviationClass = a.ObjectID " +
                                "		left join ProtocolDeviationCodeR code on code.ProtocolDeviationCode = a.ObjectID " +
                                "		where ot.ObjectName = @ObjectType " +
                                "			and ((@ObjectType = 'Medidata.Core.Objects.ProtocolDeviationClassR' and dbo.fnLDS(class.ClassValueID,'eng') = @ObjectName) " +
                                "				or (@ObjectType = 'Medidata.Core.Objects.ProtocolDeviationCodeR' and dbo.fnLDS(code.CodeValueID,'eng') = @ObjectName)) " +
                                "			and sc.Name = @AuditName) a1 " +
                                "inner join (select top 1 a.AuditID, a.ObjectTypeID, a.ObjectID " +
                                "			from Audits a " +
                                "			inner join ObjectTypeR ot on ot.ObjectTypeID = a.ObjectTypeID " +
                                "			left join ProtocolDeviationClassR class on class.ProtocolDeviationClass = a.ObjectID " +
                                "			left join ProtocolDeviationCodeR code on code.ProtocolDeviationCode = a.ObjectID " +
                                "			where ot.ObjectName = @ObjectType " +
                                "				and ((@ObjectType = 'Medidata.Core.Objects.ProtocolDeviationClassR' and dbo.fnLDS(class.ClassValueID,'eng') = @ObjectName) " +
                                "					or (@ObjectType = 'Medidata.Core.Objects.ProtocolDeviationCodeR' and dbo.fnLDS(code.CodeValueID,'eng') = @ObjectName)) " +
                                "			order by a.AuditID desc) a2 on a2.AuditID = a1.AuditID",
                                model.ObjectName,
                                objectType,
                                model.AuditName);
        }

        #endregion Steps pertaining to manipulating or verifying the configuration settings via database
    }
}
