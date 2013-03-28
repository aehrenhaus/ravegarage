using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels
{
	public class FtpModel
	{
		public string FileNames { set; get; }
		public string SourceDirectory { set; get; }
		public string FtpDirectory { set; get; }
		public string FtpMode { get; set; }
	}
}
