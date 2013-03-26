using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Medidata.RBT.Features.BatchUploader
{
	class BatchUploaderConfiguration : ConfigurationSection
	{
        public static BatchUploaderConfiguration Default { get; private set; }

		static BatchUploaderConfiguration()
        {
			Default = (BatchUploaderConfiguration)System.Configuration.ConfigurationManager.GetSection("BatchUploaderConfiguration");
        }

		[ConfigurationProperty("BatchUploadMaxWaitTime", DefaultValue = "10")]
		public int BatchUploadMaxWaitTime
		{
			get { return (int)this["BatchUploadMaxWaitTime"]; }
			set { this["BatchUploadMaxWaitTime"] = value; }
		}
	}
}
