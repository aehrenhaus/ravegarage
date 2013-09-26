using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;
namespace Medidata.RBT
{
#if DebugBindingDetails
#else
	[DebuggerStepThrough]
#endif
	public class MultipleStreamWriter:TextWriter
	{
		public override Encoding Encoding
		{
			get { return System.Text.Encoding.Default; }
		}
		public override void Flush()
		{
		
			foreach (var sw in innerWriters)
			{
				sw.Flush();
			}
		}
		public override void Close()
		{

			foreach (var sw in innerWriters)
			{
				sw.Close();
			}
		}


		private List<TextWriter> innerWriters = new List<TextWriter>();

		public List<TextWriter> InnerWriters {
			get { return innerWriters; }
		}

		public void AddStreamWriter(TextWriter sw)
		{
			innerWriters.Add(sw);
		}
		public override void WriteLine()
		{
			foreach (var sw in innerWriters)
			{
				sw.WriteLine();
			}
		}

		public override void WriteLine(string str)
		{
			foreach (var sw in innerWriters)
			{
				sw.WriteLine(str);
			}
		}

		public override void WriteLine(string str, object arg0)
		{
			foreach (var sw in innerWriters)
			{
				sw.WriteLine(str, arg0);
			}
		}


		public override void WriteLine(string str, params object[] arg)
		{
			foreach (var sw in innerWriters)
			{
				sw.WriteLine(str, arg);
			}
		}



		public override void Write(string str)
		{
			foreach (var sw in innerWriters)
			{
				sw.Write(str);
			}
		}

		public override void Write(string str, object arg0)
		{
			foreach (var sw in innerWriters)
			{
				sw.Write(str, arg0);
			}
		}
		public override void Write(string str, params object[] arg)
		{
			foreach (var sw in innerWriters)
			{
				sw.Write(str, arg);
			}
		}
	}
}
