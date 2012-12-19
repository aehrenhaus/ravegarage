using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mediata.RBT.Documents
{
	public class Feature
	{
		public Feature()
		{
			BackgroudSteps = new List<Step>();
			Scenarios = new List<Scenario>();
			Tags = new List<string>();
		}

		public List<Step> BackgroudSteps { get; set; }

		public string FilePath { get; set; }

		public string Title { get; set; }

		public List<string> Tags { get; set; }

		public List<Scenario> Scenarios { get; set; }

		public bool Ignored
		{
			get
			{
				return Tags != null && Tags.Contains("@ignore");
			}
		}
	}

	public class Scenario
	{
		public Feature Feature { get; set; }

		public Scenario()
		{
			Steps = new List<Step>();
			Tags = new List<string>();
		}

		public List<string> Tags { get; set; }
		public List<Step> Steps { get; set; }
		public string Title { get; set; }

		public bool Ignored
		{
			get
			{
				return Tags != null && Tags.Contains("@ignore");
			}
		}
	}

	public class Step
	{

		public Scenario Scenario { get; set; }
		public int LineNum { get; set; }
		public string Title { get; set; }
		public string TableString { get; set; }
		public string LiteralVerb { get; set; }
		public string CalculatdVerb { get; set; }

		public bool Unmatched { get; set; }
	}
}
