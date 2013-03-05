using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Medidata.RBT
{
	[Binding]
	public static class SpecflowStaticBindings
	{
		public static SpecflowContextBase Current {get;set;}

		static SpecflowStaticBindings()
		{
			//TODO: use some other way to initialize( stuff like DI )
			Current = new SpecflowWebTestContext();
		}

		[BeforeTestRun]
		public static void BeforeTestRun()
		{
			Current.BeforeTestRun();
		}

		[AfterTestRun]
		public static void AfterTestRun()
		{
			Current.AfterTestRun();
		}



		[BeforeFeature()]
		public static void BeforeFeature()
		{
			Current.BeforeFeature();
		}



		[AfterFeature()]
		public static void AfterFeature()
		{
			Current.AfterFeature();
		}


		[BeforeScenario()]
		public static void BeforeScenario()
		{
			Current.BeforeScenario();
		}


		[AfterScenario]
		public static void AfterScenario()
		{
			Current.AfterScenario();
		}

		[BeforeStep()]
		public static void BeforeStep()
		{
			Current.BeforeStep();
		}

		[AfterStep()]
		public static void AfterStep()
		{
			Current.AfterStep();
		}

	}
}
