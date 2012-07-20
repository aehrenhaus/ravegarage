using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT
{
	/// <summary>
	/// Represent a composite control
	/// For example, in Rave, search list is a composite control that appears on many pages.
	/// In this case, having class represent the control is easier to use 
	/// </summary>
	public interface IControl
	{
		/// <summary>
		/// The page that control belongs to
		/// </summary>
		IPage Page { get; }
	}
}
