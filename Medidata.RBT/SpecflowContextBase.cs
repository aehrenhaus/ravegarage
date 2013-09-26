using System;
using System.Diagnostics;
using System.Collections;
using TechTalk.SpecFlow.Configuration;
using System.Configuration;

namespace Medidata.RBT
{
#if DebugBindingDetails
#else
	[DebuggerStepThrough]
#endif
	public abstract class SpecflowContextBase
	{
        ConfigurationSectionHandler m_specflowSectionHandler;
        public ConfigurationSectionHandler SpecflowSectionHandler
        {
            get
            {
                return m_specflowSectionHandler;
            }
        }

		public SpecflowContextBase()
		{
			Storage = new Hashtable();
            m_specflowSectionHandler = (ConfigurationSectionHandler)ConfigurationManager.GetSection("specFlow");
		}

		private MultipleStreamWriter consoleWriter;


		public Hashtable Storage { get; set; }
		public DateTime? CurrentScenarioStartTime { get; protected set; }
		public DateTime? CurrentFeatureStartTime { get; protected set; }
		public string CurrentScenarioName { get; protected set; }


		public virtual void BeforeTestRun()
		{

		}


		public virtual void AfterTestRun()
		{
		}



	
		public virtual void BeforeFeature()
		{
		}



	
		public virtual void AfterFeature()
		{
		}



		public virtual void BeforeScenario()
		{ 
            #if DEBUG
            if (!SpecflowSectionHandler.UnitTestProvider.Name.Contains("SpecRun") 
                && SpecflowSectionHandler.UnitTestProvider.Name.Contains("MsTest"))
                SetOutput();
            #endif
		}


	
		public virtual void AfterScenario()
		{

		}

		
		public virtual void BeforeStep()
		{

		}

	
		public virtual void AfterStep()
		{

		}

		/// <summary>
		/// This method is hacky
		/// specflow hijacks the standard output to it's own output, before every scenario begins
		/// We want to output to the regular console too, that's why we need MultipleStreamWriter
		/// And we need to call this method to hijack the standard output back to our own use.
		/// 
		/// Old version of the method
		/// </summary>
		private void SetOutput()
		{
			if (consoleWriter == null)
			{
				consoleWriter = new MultipleStreamWriter();
				ExtraConsoleWriterSetup.OpenConsole();
				var extraConsole = ExtraConsoleWriterSetup.GetConsoleWriter();
				consoleWriter.AddStreamWriter(new FilteredWriter(extraConsole));

				//the previous Console.Out has already been redirect to MSTest output, add it back to multiple output writer, so we still see results from MSTest
			}
			if (consoleWriter.InnerWriters.Count == 2)
				consoleWriter.InnerWriters.RemoveAt(1);
			consoleWriter.AddStreamWriter(Console.Out);
			Console.SetOut(consoleWriter);
		}


		public abstract void TrySaveScreenShot();
	}
}
