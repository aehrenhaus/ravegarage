﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.IO;

namespace Medidata.RBT
{

	/// <summary>
	/// create this class just to use as a filter to console output, so that steps are easy to see.
	/// </summary>
#if DebugBindingDetails
#else
	[DebuggerStepThrough]
#endif
	public class FilteredWriter:TextWriter
	{
		public override Encoding Encoding
		{
			get { return sw.Encoding; }
		}
		private TextWriter sw;
		bool skipNextToo;
		bool muted;

		public FilteredWriter(TextWriter writer)
		{
		
			this.sw = writer;
		}

		private bool SkipThis(string str)
		{
			if (muted)
				return true;

			if (str.StartsWith("img->"))
			{
				skipNextToo = true;
				return true;
			}
			if (str.StartsWith("-> done:"))
			{
				sw.WriteLine();
				return true;
			}
			if (str.StartsWith("-> error:") || str.StartsWith("-> pending:"))
			{
				sw.WriteLine(str);
				sw.WriteLine();
                if (str.StartsWith("-> error:"))
                    SpecflowStaticBindings.Current.TrySaveScreenShot();
				muted = true;
				return true;
			}
			return false;

		}

		public override void WriteLine(string str)
		{
			if (skipNextToo )
			{
				skipNextToo = false;
				return;
			}

			if (SkipThis(str))
				return;

			sw.WriteLine(str);
		}

		public override void WriteLine(string str, object arg0)
		{
			if (skipNextToo)
			{
				skipNextToo = false;
				return;
			}

			if (SkipThis(str))
				return;

			sw.WriteLine(str, arg0);
			
		}


		public override void WriteLine(string str, params object[] arg)
		{
			if (skipNextToo)
			{
				skipNextToo = false;
				return;
			}

			if (SkipThis(str))
				return;

			sw.WriteLine(str, arg);
			
		}

	}
}
