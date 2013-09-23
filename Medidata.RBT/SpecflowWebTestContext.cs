using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedObjects;
using TechTalk.SpecFlow;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using System.Collections.Specialized;
using System.Collections;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT
{
	public class SpecflowWebTestContext : SpecflowContextBase
	{

		public WebTestContext WebTestContext { get; set; }

		public int ScreenshotIndex { get; private set; }



		public override void AfterTestRun()
		{
			//do clean up both before and after test run :)
			WebTestContext.ClearTempFiles();
			WebTestContext.ClearDownloads();

            if (!SpecflowSectionHandler.UnitTestProvider.Name.Contains("SpecRun")
                && SpecflowSectionHandler.UnitTestProvider.Name.Contains("MsTest"))
                GenerateReport();
		}

		public override void BeforeTestRun()
		{
			WebTestContext = new RBT.WebTestContext();

			//do clean up both before and after test run :)
			WebTestContext.ClearTempFiles();

			SpecialStringHelper.Replaced += new Action<string, string>((input, output) =>
			{
				Console.WriteLine("-> replace --> " + input + " --> " + output);
			});
		}

		public override void BeforeFeature()
		{
			Storage.Clear();
			CurrentFeatureStartTime = DateTime.Now;
            WebTestContext.LastLoadedPDF = null;
			DraftCounter.ResetCounter();
			
		}

		public override void AfterFeature()
		{
            Factory.DeleteObjectsMarkedForFeatureDeletion();
            SeedingContext.SeedableObjects.Clear();
		}

		public override void BeforeScenario()
		{
			base.BeforeScenario();

            WebTestContext.CurrentUser = null;
            WebTestContext.CurrentUserPassword = null;
            WebTestContext.CurrentPage = null;
            Storage.Clear();

            WebTestContext.OpenBrowser();

            WebTestContext.ClearDownloads();

			//start time
			CurrentScenarioStartTime = DateTime.Now;

			//reset the screenshot counter
			ScreenshotIndex = 1;

			//set scenario name with tag that starts with PB_
			CurrentScenarioName = ScenarioContext.Current.ScenarioInfo.Tags.FirstOrDefault(x => x.StartsWith(RBTConfiguration.Default.ScenarioNamePrefix));
			if (CurrentScenarioName == null)
				CurrentScenarioName = "Scenario_" + DateTime.Now.Ticks.ToString();

			Console.WriteLine("-------------> Scenario:" + CurrentScenarioName);
			Console.WriteLine();
		}

		public override void AfterScenario()
		{
            try //if a web driver exception with inner exception on HTTP Response has happen then this step will fail preventing a cleanup hence a try block is required
            {
                //take a snapshot after every scenario
                TrySaveScreenShot(); 
            }
            catch (OpenQA.Selenium.WebDriverException ex)
            {
                Console.WriteLine(string.Format("Web driver failed and snap-shot attempt did not work. Exception: [{0}]", ex.Message));
            }
            finally
            {
                Factory.DeleteObjectsMarkedForScenarioDeletion();
                WebTestContext.CloseBrowser();

                if (ScenarioContext.Current.TestError != null)
                {
                    CreateScenarioFailureFile();
                }
                
            }
		}

		public override void AfterStep()
		{
			if (RBTConfiguration.Default.TakeScreenShotsEveryStep)
			{
				TrySaveScreenShot();
			}
		}

		public override void TrySaveScreenShot()
		{
			Image img = WebTestContext.TrySaveScreenShot();

            if (img != null)
            {
                ScreenshotIndex++;

                string resultPath = RBTConfiguration.Default.TestResultPath;

                var fileName = ScreenshotIndex.ToString();
                fileName = CurrentScenarioName + "_" + fileName + ".jpg";

                Console.WriteLine("img->" + fileName);
                Console.WriteLine("->" + WebTestContext.Browser.Url);
                //file path
                string screenshotPath = Path.Combine(resultPath, fileName);

                Directory.CreateDirectory(new FileInfo(screenshotPath).DirectoryName);
                img.Save(screenshotPath, ImageFormat.Jpeg);
            }
		}

		private void GenerateReport()
		{

            const string scriptPath = @"..\..\..\reportGen.ps1";

		    const string projectPath = @"Medidata.RBT.Features.Rave\Medidata.RBT.Features.Rave.csproj";

            var arguments = string.Format("-executionpolicy unrestricted -file \"{0}\" \"{1}\"", scriptPath, projectPath);

			System.Diagnostics.Process p = new System.Diagnostics.Process();

            p.StartInfo = new System.Diagnostics.ProcessStartInfo(
                @"powershell.exe",
                arguments
            );

            p.StartInfo.UseShellExecute = false;
            p.StartInfo.RedirectStandardOutput = true;

            p.Start();
		}

        private void CreateScenarioFailureFile()
        {
            StringBuilder failedScenarioPathBuilder = new StringBuilder();
            failedScenarioPathBuilder.Append("flags\\");
            failedScenarioPathBuilder.Append(FeatureContext.Current.FeatureInfo.Tags.
                FirstOrDefault(tag => tag.StartsWith("FT_")));
            failedScenarioPathBuilder.Append("_");
            failedScenarioPathBuilder.Append(CurrentScenarioName);
            failedScenarioPathBuilder.Append(".failure");

            string failedScenarioPath = failedScenarioPathBuilder.ToString();

            if (!File.Exists(failedScenarioPath))
            {
                FileStream fs = null;
                try
                {
                    FileInfo fInfo = new FileInfo(failedScenarioPath);
                    if (!Directory.Exists(fInfo.DirectoryName))
                        Directory.CreateDirectory(fInfo.DirectoryName);
                    fs = File.Create(failedScenarioPath);
                }
                catch (UnauthorizedAccessException)
                {
                    Console.WriteLine(string.Format(
                        "An attempt was made to create or access scenario failure file [{0}] concurrently.", failedScenarioPath));
                }
                finally
                {
                    if (fs != null)
                        fs.Close();
                }
            }
        }

	}
}
