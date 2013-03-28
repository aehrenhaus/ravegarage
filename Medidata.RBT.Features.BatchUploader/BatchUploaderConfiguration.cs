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

		[ConfigurationProperty("BatchUploadMaxWaitMinutes", DefaultValue = "10")]
		public int BatchUploadMaxWaitMinutes
		{
			get { return (int)this["BatchUploadMaxWaitMinutes"]; }
			set { this["BatchUploadMaxWaitMinutes"] = value; }
		}

		[ConfigurationProperty("BatchUploadMaxFileAgeDays", DefaultValue = "10")]
		public int BatchUploadMaxFileAgeDays
		{
			get { return (int)this["BatchUploadMaxFileAgeDays"]; }
			set { this["BatchUploadMaxFileAgeDays"] = value; }
		}
	}
}
