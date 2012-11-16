using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
	public abstract class AbstractPaginiationControl : ControlBase, ICanPaginate
	{
		public AbstractPaginiationControl(IPage page)
			: base(page)
		{

		}


		public virtual int CurrentPageNumber
		{
			get { throw new NotImplementedException(); }
		}

		public virtual bool GoNextPage(string areaIdentifier)
		{
			throw new NotImplementedException();
		}

		public virtual bool GoPreviousPage(string areaIdentifier)
		{
			throw new NotImplementedException();
		}

		public virtual bool GoToPage(string areaIdentifier, int page)
		{
			throw new NotImplementedException();
		}

		public virtual bool CanPaginate(string areaIdentifier)
		{
			return true;
		}
	}
}
