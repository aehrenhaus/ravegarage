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

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific User. It is seedable. 
    ///These sit in Uploads/Users.
    ///</summary>
    public class User : SeedableObject, IRemoveableObject
    {
        public string FileName { get; set; }
        public string ActivationCode { get; set; }
        public string UniquePin { get; set; }

        /// <summary>
        /// The uploaded user constructor. This uploads users using the user uploader.
        /// It will also activate the created user.
        /// You may call this constuctor with "SUPER USER 'N'" where "N" is an integer.
        /// This will upload a unique version of the source controlled "SUPERUSER.xml" and tie it to that name.
        /// </summary>
        /// <param name="userUploadName">The feature defined name of the user</param>
        /// <param name="seed">Bool determining whether you want to seed the object if it is not in the FeatureObjects dictionary</param>
        public User(string userUploadName, bool seed = false)
            :base(userUploadName)
        {
            if (!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = userUploadName;
                if (seed)
                {
                    if (userUploadName.StartsWith("SUPER USER"))
                        FileName = "SUPERUSER.xml";
                    else
                        FileName = userUploadName;

                    FileLocation = TestContext.UploadPath + @"\Users\" + FileName;
                    Seed();

                    IPage pageBeforeActivation = TestContext.CurrentPage;
                    ActivateUser();
                    TestContext.CurrentPage = pageBeforeActivation.NavigateToSelf();
                }
            }
        }
        
        /// <summary>
        /// Activate the user created by this object
        /// </summary>
        private void ActivateUser()
        {
            IPage pageBeforeActivation = TestContext.CurrentPage;

            //Activate the User
            TestContext.CurrentPage = new UserAdministrationPage().NavigateToSelf();
            TestContext.CurrentPage.As<UserAdministrationPage>().SearchUser(
                new Medidata.RBT.PageObjects.Rave.UserAdministrationPage.SearchByModel() { Login = UniqueName }
                );
            TestContext.CurrentPage = TestContext.CurrentPage.As<UserAdministrationPage>().ClickActivated(UniqueName);
            ActivationCode = TestContext.CurrentPage.As<UserActivationPage>().GetActivationCode().Text;
            TestContext.CurrentPage.ClickLink("Logout");
            TestContext.CurrentPage = new LoginPage().NavigateToSelf();
            TestContext.CurrentPage.As<LoginPage>().ClickLink("Activate New Account");
            TestContext.CurrentPage.As<ActivatePage>().Pin.EnhanceAs<Textbox>().SetText(UniquePin);
            TestContext.CurrentPage.As<ActivatePage>().ActivationCode.EnhanceAs<Textbox>().SetText(ActivationCode);
            TestContext.CurrentPage.As<ActivatePage>().ClickButton("ActivateButton");

            //Set New Password
            string newPassword = RaveConfiguration.Default.DefaultUserPassword;
            TestContext.CurrentPage.As<PasswordPage>().NewPasswordBox.EnhanceAs<Textbox>().SetText(newPassword);
            TestContext.CurrentPage.As<PasswordPage>().ConfirmPasswordBox.EnhanceAs<Textbox>().SetText(newPassword);
            TestContext.CurrentPage.As<PasswordPage>().ClickButton("_ctl0_Content_SavePasswordButton");
            TestContext.CurrentPage.As<PasswordChangedPage>().ClickLink("Click here to continue...");

            TestContext.CurrentPage = pageBeforeActivation.NavigateToSelf();
        }

        /// <summary>
        /// Navigate to the user upload page.
        /// </summary>
        public override void NavigateToSeedPage()
        {
            LoginPage.LoginUsingDefaultUserFromAnyPage();
            TestContext.CurrentPage.As<HomePage>().ClickLink("User Administration");
            TestContext.CurrentPage.As<UserAdministrationPage>().ClickLink("Upload Users");
        }

        /// <summary>
        /// Upload the unique version of the User. Mark it for deletion after scenario completion.
        /// </summary>
        public override void CreateObject()
        {
            TestContext.CurrentPage.As<UploadUserPage>().UploadFile(UniqueFileLocation);
            TestContext.FeatureObjects.Add(Name, this);
            Factory.FeatureObjectsForDeletion.Add(this);
        }

        /// <summary>
        /// Load the xml to upload. Replace the user name with a unique version of it with a TID at the end.
        /// </summary>
        public override void MakeUnique()
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(FileLocation);
            List<XmlNode> worksheets = new List<XmlNode>(xmlDoc.GetElementsByTagName("Worksheet").Cast<XmlNode>());
            XmlNode userWorksheet = worksheets.FirstOrDefault(x => x.Attributes["ss:Name"].Value.ToLower() == "users");
            XmlNode table = (userWorksheet.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "table").FirstOrDefault();
            List<XmlNode> rows = (table.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "row").ToList();
            List<XmlNode> firstRowCells = new List<XmlNode>(rows[0].ChildNodes.Cast<XmlNode>());
            List<XmlNode> secondRowCells = new List<XmlNode>(rows[1].ChildNodes.Cast<XmlNode>());

            //Make the user name unique
            int loginCell = firstRowCells.FindIndex(x => x.InnerText.ToLower() == "login");
            string oldUserName = secondRowCells[loginCell].ChildNodes[0].InnerText;
            string uniqueUserName = oldUserName + TID;
            secondRowCells[loginCell].ChildNodes[0].InnerText = uniqueUserName;
            UniqueName = uniqueUserName;

            //Make the pin unique
            int pinTitleCell = firstRowCells.FindIndex(x => x.InnerText.ToLower() == "pin") + 1; //Add 1, because the index in the XML is 1 indexed, not 0 indexed
            List<XmlNode> secondRowCellsWithIndexAttr = secondRowCells.Where(x => x.Attributes["ss:Index"] != null).ToList();
            string oldPin = secondRowCellsWithIndexAttr.FirstOrDefault(x => x.Attributes["ss:Index"].Value == pinTitleCell.ToString()).ChildNodes[0].InnerText;
            int secondRowPinIndex = secondRowCells.FindIndex(x => x.ChildNodes[0].InnerText == oldPin);
            UniquePin = oldPin + TID;
            secondRowCells[secondRowPinIndex].ChildNodes[0].InnerText = UniquePin;

            //Create a unique version of the file to upload
            UniqueFileLocation = FileLocation.Substring(0, FileLocation.LastIndexOf(".xml")) + UID + ".xml";

            xmlDoc.Save(UniqueFileLocation);
        }

        /// <summary>
        /// Delete the unique User created by seeding
        /// </summary>
        public void DeleteSelf()
        {
            File.Delete(UniqueFileLocation);
        }
    }
}