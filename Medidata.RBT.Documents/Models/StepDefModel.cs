using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Medidata.RBT.Documents
{
	public class StepDefModel
	{
		public string Name { get; set; }
		public string Regex { get; set; }
		public string Comment { get; set; }
	}

	public class StepDefClassModel
	{
		public string Name { get; set; }
		public StepDefModel[] StepDefs { get; set; }
	}

	public class StepDefCategoryModel
	{
		public string Name { get; set; }
		public StepDefClassModel[] StepDefClasses { get; set; }
	}
}