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
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.ConfigurationHandlers;
using System.Xml.Linq;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    ///This is a rave specific User. It is seedable. 
    ///These sit in Uploads/Users.
    ///</summary>
    public class User : RWSSeededPostObject, IRemoveableObject
    {
        private string FileName { get; set; }
        private string ActivationCode { get; set; }
        private string UniquePin { get; set; }
        private int? m_UserID;

        public List<StudyAssignment> StudyAssignments { get; set; }
        public List<ModuleAssignment> ModuleAssignments { get; set; }
        public List<ReportAssignment> ReportAssignments { get; set; }
        public string Password { get; private set; }
        public string FirstName { get; private set; }
        public string LastName { get; private set; }
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
        public User(string userUploadName, bool uploadAfterMakingUnique = true) 
            : base(uploadAfterMakingUnique)
        {
            PartialRaveWebServiceUrl = "private/users/" + RaveConfigurationGroup.Default.DefaultUser;
	        UniqueName = userUploadName;
            Password = RaveConfigurationGroup.Default.DefaultUserPassword;
            FirstName = "Default";
            LastName = "User";
        }

        protected override void SetBodyData()
        {
            XElement userXElement = new XElement("user");
            userXElement.Add(new XElement("login") { Value = UniqueName });
            userXElement.Add(new XElement("password") { Value = Password });
            userXElement.Add(new XElement("firstname") { Value = FirstName });
            userXElement.Add(new XElement("lastname") { Value = LastName });

            BodyData = Encoding.UTF8.GetBytes(userXElement.ToString());
        }

        protected override void TakeActionAsAResultOfRWSCall()
        {
            Factory.FeatureObjectsForDeletion.Add(this);
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
            this.Password = RaveConfigurationGroup.Default.DefaultUserPassword;
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
            if (ModuleAssignments != null)
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