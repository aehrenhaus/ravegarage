using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace Medidata.RBT
{
	public abstract class SpecflowContextBase
	{
		public SpecflowContextBase()
		{
			Storage = new Hashtable();
		}

		private MultipleStreamWriter consoleWriter;

		public Hashtable Storage { get; set; } 

		public DateTime? CurrentScenarioStartTime
		{
			get
			{
				return Storage["CurrentScenarioStartTime"] as DateTime?;
			}
			set
			{
				Storage["CurrentScenarioStartTime"] = value;
			}
		}

		public string ScenarioName { get; protected set; }


		public DateTime? CurrentFeatureStartTime { get; set; }


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
			SetOutput();
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
		/// And we need to call this method to hijack the stand output back to our own use.
		/// </summary>
		private void SetOutput()
		{
			if (consoleWriter == null)
			{
				consoleWriter = new MultipleStreamWriter();
				ExtraConsoleWriterSetup.OpenConsole();
			}

			if (Console.Out != consoleWriter)
			{
				consoleWriter.InnerWriters.Clear();
				var extraConsole = ExtraConsoleWriterSetup.GetConsoleWriter();
				consoleWriter.AddStreamWriter(new FilteredWriter(extraConsole));
				consoleWriter.AddStreamWriter(Console.Out);
				Console.SetOut(consoleWriter);
			}
		}


		public abstract void TrySaveScreenShot();
	}
}
