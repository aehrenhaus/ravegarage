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

namespace Medidata.RBT
{
	public class SpecflowWebTestContext : SpecflowContextBase
	{

		public WebTestContext WebTestContext { get; set; }

		public int ScreenshotIndex { get; private set; }



		public override void AfterTestRun()
		{
			base.AfterTestRun();

			WebTestContext.ClearTempFiles();
			WebTestContext.ClearDownloads();

			if (RBTConfiguration.Default.AutoCloseBrowser)
				WebTestContext.CloseBrower();

			GernerateReport();
		}

		public override void BeforeTestRun()
		{
			base.BeforeTestRun();

			WebTestContext = new RBT.WebTestContext();

			WebTestContext.OpenBrower();


			SeedingContext.DefaultSeedingOption = new SeedingOptions(
				RBTConfiguration.Default.EnableSeeding,
				RBTConfiguration.Default.SeedFromBackendClasses,
				 RBTConfiguration.Default.SuppressSeeding);

			SpecialStringHelper.Replaced += new Action<string, string>((input, output) =>
			{
				Console.WriteLine("-> replace --> " + input + " --> " + output);
			});
		}

		public override void BeforeFeature()
		{
			base.BeforeFeature();

			Storage.Clear();
			HandleFeatureTags();
			CurrentFeatureStartTime = DateTime.Now;
			DraftCounter.ResetCounter();
			
		}

		public override void AfterFeature()
		{
			base.AfterFeature();
			SeedingContext.FeatureSeedingOption = null;
			Factory.DeleteObjectsMarkedForFeatureDeletion();
			WebTestContext.ClearDownloads();
			SeedingContext.SeedableObjects.Clear();
		}

		public override void BeforeScenario()
		{
			base.BeforeScenario();
			WebTestContext.CurrentUser = null;

			Storage.Clear();

			//start time
			CurrentScenarioStartTime = DateTime.Now;

			//reset the screenshot counter
			ScreenshotIndex = 1;

			//set scenario name with tag that starts with PB_
			ScenarioName = ScenarioContext.Current.ScenarioInfo.Tags.FirstOrDefault(x => x.StartsWith(RBTConfiguration.Default.ScenarioNamePrefix));
			if (ScenarioName == null)
				ScenarioName = "Scenario_" + DateTime.Now.Ticks.ToString();

			Console.WriteLine("-------------> Scenario:" + ScenarioName);
			Console.WriteLine();
		}

		public override void AfterScenario()
		{
			base.AfterScenario();

			//take a snapshot after every scenario
			TrySaveScreenShot();

			Factory.DeleteObjectsMarkedForScenarioDeletion();
	
		}

		public override void AfterStep()
		{
			base.AfterStep();

			if (RBTConfiguration.Default.TakeScreenShotsEveryStep)
			{
				TrySaveScreenShot();
			}

		}


		private void HandleFeatureTags()
		{
			string backend = null;
			string suppress = null;
			bool enable = false;
			bool hasSettings = false;

			foreach (var featureTag in FeatureContext.Current.FeatureInfo.Tags)
			{
				string[] parts = featureTag.Split('=');
				if (parts.Length != 2)
					continue;

				if (parts[0] == "SeedFromBackendClasses")
				{
					backend = parts[1];
					hasSettings = true;
				}
				else if (parts[0] == "SuppressSeeding")
				{
					suppress = parts[1];
					hasSettings = true;
				}
				else if (parts[0] == "EnableSeeding")
				{
					bool.TryParse(parts[1], out enable);
					hasSettings = true;
				}
			}

			//Feature will use either all default settings from config , or all settings from feature tag.
			//there is no cascading here.
			//If there are any seeding settings on the feature, then feature will use feature level setting instead of global settings

			if (hasSettings)
				SeedingContext.FeatureSeedingOption = new SeedingOptions(enable, backend, suppress);
		}


		public override void TrySaveScreenShot()
		{
			Image img = WebTestContext.TrySaveScreenShot();


			string resultPath = RBTConfiguration.Default.TestResultPath;

			var fileName = ScreenshotIndex.ToString();
			fileName = ScenarioName + "_" + fileName + ".jpg";

			Console.WriteLine("img->" + fileName);
			Console.WriteLine("->" + WebTestContext.Browser.Url);
			//file path
			string screenshotPath = Path.Combine(resultPath, fileName);

			Directory.CreateDirectory(new FileInfo(screenshotPath).DirectoryName);
			img.Save(screenshotPath, ImageFormat.Jpeg);
		}

		private void GernerateReport()
		{

			System.Diagnostics.Process p = new System.Diagnostics.Process();

#if DEBUG
			p.StartInfo = new System.Diagnostics.ProcessStartInfo(
				@"powershell.exe",
			" ../../../reportGen.ps1");
			p.Start();
			//p.WaitForExit();
#else
				p.StartInfo = new System.Diagnostics.ProcessStartInfo(
				@"powershell.exe",
			"../../../reportGen.ps1");
			p.Start();
#endif



		}

	}
}
