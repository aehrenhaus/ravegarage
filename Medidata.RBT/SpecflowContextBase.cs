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
