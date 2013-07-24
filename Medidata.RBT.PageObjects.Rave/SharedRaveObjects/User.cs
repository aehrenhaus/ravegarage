using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using System.IO;
using System.Xml;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
using Medidata.RBT.SharedObjects;
using Medidata.RBT.SharedRaveObjects;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific User. It is seedable. 
    ///These sit in Uploads/Users.
    ///</summary>
    public class User : BaseRaveSeedableObject, IRemoveableObject
    {
        private string FileName { get; set; }
        private string ActivationCode { get; set; }
        private string UniquePin { get; set; }
        private int? m_UserID;

        public List<StudyAssignment> StudyAssignments { get; set; }
        public List<ModuleAssignment> ModuleAssignments { get; set; }
        public List<ReportAssignment> ReportAssignments { get; set; }
        public string Password { get; private set; }
        public int UserID
        {
            get
            {
                if (m_UserID == null)
                {
                    //Get it from the user that matches that name in the DB
                    m_UserID = GetUserID(UniqueName);
                }
                return m_UserID.Value;
            }
        }

        /// <summary>
        /// The uploaded user constructor. This uploads users using the user uploader.
        /// It will also activate the created user.
        /// You may call this constuctor with "SUPER USER 'N'" where "N" is an integer.
        /// This will upload a unique version of the source controlled "SUPERUSER.xml" and tie it to that name.
        /// </summary>
        /// <param name="userUploadName">The feature defined name of the user</param>
        /// <param name="seed">Bool determining whether you want to seed the object if it is not in the FeatureObjects dictionary</param>
		public User(string userUploadName)
        {
	        UniqueName = userUploadName;
            Password = RaveConfigurationGroup.Default.DefaultUserPassword;
        }

	    /// <summary>
        /// sets lines per page number for a given user.  
        /// </summary>
        /// <param name="linesPerPage">lines per page setting</param>
        public void SetLinesPerPage(int linesPerPage)
        {
            if (linesPerPage < 1)
                return;

            var sql = string.Format(@"  update us
                                        set us.value = {0}, updated = getUTCDate()
                                        from userSettings us
	                                        join users u
		                                        on u.userID = us.userID
                                        where tag = 'pageSize' and login = '{1}'
                                    ", linesPerPage, UniqueName);

            DbHelper.ExecuteDataSet(sql);
        }

        /// <summary>
        /// Activate the user created by this object
        /// </summary>
        private void ActivateUser()
        {
    
            //Activate the User
            WebTestContext.CurrentPage = new UserAdministrationPage().NavigateToSelf();
            WebTestContext.CurrentPage.As<UserAdministrationPage>().SearchUser(
                new Medidata.RBT.PageObjects.Rave.UserAdministrationPage.SearchByModel() { Login = UniqueName }
                );
            WebTestContext.CurrentPage = WebTestContext.CurrentPage.As<UserAdministrationPage>().ClickActivated(UniqueName);
            ActivationCode = WebTestContext.CurrentPage.As<UserActivationPage>().GetActivationCode().Text;
            WebTestContext.CurrentPage.ClickLink("Logout");
            WebTestContext.CurrentPage = new LoginPage().NavigateToSelf();
            WebTestContext.CurrentPage.As<LoginPage>().ClickLink("Activate New Account");
            WebTestContext.CurrentPage.As<ActivatePage>().Pin.EnhanceAs<Textbox>().SetText(UniquePin);
            WebTestContext.CurrentPage.As<ActivatePage>().ActivationCode.EnhanceAs<Textbox>().SetText(ActivationCode);
            WebTestContext.CurrentPage.As<ActivatePage>().ClickButton("ActivateButton");

            //Set New Password
            this.Password = RaveConfigurationGroup.Default.DefaultUserPassword;
            WebTestContext.CurrentPage.As<PasswordPage>().NewPasswordBox.EnhanceAs<Textbox>().SetText(this.Password);
            WebTestContext.CurrentPage.As<PasswordPage>().ConfirmPasswordBox.EnhanceAs<Textbox>().SetText(this.Password);
            WebTestContext.CurrentPage.As<PasswordPage>().ClickButton("Save Password and Continue");
            WebTestContext.CurrentPage.As<PasswordChangedPage>().ClickLink("Click here to continue...");

            //this is important because after continue, will login as the new user.
            WebTestContext.CurrentUser = this.UniqueName;
        }

        /// <summary>
        /// Navigate to the user upload page.
        /// </summary>
		protected override void NavigateToSeedPage()
        {
            WebTestContext.CurrentPage.ClickLink("User Administration");
            WebTestContext.CurrentPage.ClickLink("Upload Users");
        }

        /// <summary>
        /// Upload the unique version of the User. Mark it for deletion after scenario completion.
        /// </summary>
		protected override void CreateObject()
        {
            WebTestContext.CurrentPage.As<UploadUserPage>().UploadFile(UniqueFileLocation);
            Factory.FeatureObjectsForDeletion.Add(this);

            ActivateUser();
        }

        /// <summary>
        /// Load the xml to upload. Replace the user name with a unique version of it with a TID at the end.
        /// </summary>
		protected override void MakeUnique()
        {

			if (UniqueName.StartsWith("SUPER USER"))
				FileName = "SUPERUSER.xml";
			else
				FileName = UniqueName + ".xml";

			FileLocation = RBTConfiguration.Default.UploadPath + @"\Users\" + FileName;

			using (var excel = new ExcelWorkbook(FileLocation))
			{
				var usersTable = excel.OpenTableForEdit("Users");
	
				//make login unique
				var oldUserName = usersTable[1, "Login"];
				UniqueName = oldUserName + TID;
				usersTable[1, "Login"] = UniqueName;

				//make pin unique
				var oldPin = usersTable[1, "PIN"];
				UniquePin = oldPin + TID;
				usersTable[1, "PIN"] = UniquePin;


				//Create a unique version of the file to upload
				UniqueFileLocation = MakeFileLocationUnique(FileLocation);

				excel.SaveAs(UniqueFileLocation);
			}
        }

        /// <summary>
        /// Delete the unique User created by seeding
        /// </summary>
        public void DeleteSelf()
        {
            File.Delete(UniqueFileLocation);
        }

        /// <summary>
        /// Check if there is a study assignment for this user
        /// </summary>
        /// <param name="roleName">The UID of the role assigned</param>
        /// <param name="projectUID">The UID of the project assigned</param>
        /// <param name="siteName">The UID of the site assigned</param>
        /// <returns></returns>
		public bool StudyAssignmentExists(string roleName, string projectName, string siteName, string environment)
        {
            if (StudyAssignments != null)
            {
                foreach (StudyAssignment sa in StudyAssignments)
					if (sa.ProjectName == projectName && sa.RoleName == roleName && sa.SiteName == siteName && sa.Environment==environment)
                        return true;
            }
            return false;
        }

        /// <summary>
        /// Check if there is a module assignment for this user
        /// </summary>
        /// <param name="projectName">Name of the project</param>
        /// <param name="securityRoleName">Name of the security role</param>
        /// <returns></returns>
        public bool ModuleAssignmentExists(string projectName, string securityRoleName)
        {
            if(ModuleAssignments != null)
            {
            foreach (ModuleAssignment ma in ModuleAssignments)
                if (ma.ProjectName.Equals(projectName) && ma.SecurityRole.Equals(securityRoleName))
                    return true;
                }
            return false;
        }

        /// <summary>
        /// Check if thre is a report assignment for this user
        /// </summary>
        /// <param name="reportName">name of the report</param>
        /// <returns></returns>
        public bool ReportAssignmentsExists(string reportName)
        {
            if (ReportAssignments != null && ReportAssignments.Exists(p => p.ReportName.Equals(reportName)))
                return true;
            else
                return false;
        }

        #region SQL STRINGS

        private static int GetUserID(string login)
        {
            string sql = string.Format(User.GET_USER_FROM_DB, login);

            return (int)DbHelper.ExecuteDataSet(sql).GetFirstRow()["UserID"];
        }

        #region GET_USER_FROM_DB
        private const string GET_USER_FROM_DB =
            @"
            select * from Users where Login = '{0}'
            ";
        #endregion
        #endregion
    }
}