
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mediata.RBT.Documents
{
	public enum StepDefVerb
	{
		Given,
		When,
		Then,
		All
	}

	public class StepDef
	{
		public StepDefMethod Method;
		public StepDefVerb Verb;
		public string Regex;
		public string RegexWithArgName;
		public bool Unused;
	}

	public class StepDefClass
	{
		public string Name { get; set; }
		public string Comments { get; set; }
		public List<StepDefMethod> Methods { get; set; }

		public StepDefClass()
		{
			Methods = new List<StepDefMethod>();
		}
	}
	public class StepDefMethod
	{
		public string Name { get; set; }
		public string Comments { get; set; }
		public List<StepDef> StepDefs { get; set; }

		public StepDefMethod()
		{
			StepDefs = new List<StepDef>();
		}
	}
}
