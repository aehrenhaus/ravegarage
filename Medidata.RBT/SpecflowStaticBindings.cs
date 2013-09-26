using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using System.Diagnostics;
using System.Reflection;
using System.ComponentModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT
{
	[Binding]
#if DebugBindingDetails
#else
	[DebuggerStepThrough]
#endif
	public static class SpecflowStaticBindings
	{
        private const string FEATURE_SETUP_TAG = "feature_setup";

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
            RunFeatureSetupScenarios();
		}

        /// <summary>
        /// Run the scenarios marked with feature_setup
        /// </summary>
        private static void RunFeatureSetupScenarios()
        {
            Type fixtureType = GetFeatureFileType();
            if (fixtureType == null)
                return;

            FeatureContext.Current["BeforeFeatureExecution"] = true;

            foreach (MethodInfo featureSetupMethod in fixtureType.GetMethods().Where(mi => IsTaggedWith(mi, FEATURE_SETUP_TAG)))
            {
                object fixtureInstance = Activator.CreateInstance(fixtureType);

                try
                {
                    featureSetupMethod.Invoke(fixtureInstance, null);
                }
                catch (Exception e)
                {
                    Assert.Fail(String.Format("Feature setup scenario \"{0}\" failed with the message: {1}", featureSetupMethod, e.InnerException.Message));
                }
                finally
                {
                    AfterScenario();
                    ((MethodInfo)fixtureType.GetMethods().FirstOrDefault(mi => mi.Name.Equals("ScenarioTearDown"))).Invoke(fixtureInstance, null);
                }
            }

            FeatureContext.Current["BeforeFeatureExecution"] = false;
        }

        /// <summary>
        /// Ignore the normal execution of scenarios marked with the "feature_setup" tag since they have been ran at the start of the feature file
        /// </summary>
        [BeforeScenario(FEATURE_SETUP_TAG)]
        public static void IgnoreNormalExecution()
        {
            // ignore the scenario if it was executed through the "normal" execution
            bool value;
            if (FeatureContext.Current.TryGetValue("BeforeFeatureExecution", out value) && value)
                return;

            // We want to make sure the test run doesn't end, 
            // and the feature setup scenario doesn't run again.
            // It has already run before the feature, shouldn't run as part of normal execution.
            Assert.Inconclusive("This is feature setup. Please add the \"@ignore\" tag wherever you have \"@feature_setup\"");
        }

        /// <summary>
        /// Get the currently running feature file.
        /// </summary>
        /// <returns>The type of the currently running feature file</returns>
        private static Type GetFeatureFileType()
        {
            StackFrame[] stackTrace = new StackTrace(false).GetFrames();
            if (stackTrace == null)
                return null;

            for (int frame = 0; frame < stackTrace.Length; frame++)
                if (stackTrace[frame].GetMethod().Name.Equals("OnFeatureStart"))
                    return stackTrace[frame + 2].GetMethod().DeclaringType;

            return null;
        }

        private static bool IsTaggedWith(MethodInfo mi, string tagName)
        {
            var attributes = mi.GetCustomAttributes(typeof(TestCategoryAttribute), false);

            return attributes != null && attributes.Cast<TestCategoryAttribute>().Any(a => a.TestCategories.Contains(tagName));
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
