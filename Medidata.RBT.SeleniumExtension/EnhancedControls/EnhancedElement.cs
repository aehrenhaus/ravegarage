using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using OpenQA.Selenium.Internal;

namespace Medidata.RBT.SeleniumExtension
{
	/// <summary>
	/// This class use decoration pattern to decorate IWebElement, also enhance it by adding new methods and properties.
	/// Base on this class, many subclasses will be derived to represent differnt controls in DOM.
	/// 
	/// 
	/// </summary>
	public class EnhancedElement:IWebElement
	{
		#region Private 

		private IWebElement ele; // the inner element
		public IWebElement Element
		{
			get
			{
				IWebElement e = ele;
				if (e is EnhancedElement)
					e = (e as EnhancedElement).Element;
				return e;
			}
		}
	
		#endregion

		/// <summary>
		/// This is a typical method of 'decoration pattern' to set the inner element to decorate
		/// </summary>
		/// <typeparam name="T"></typeparam>
		/// <param name="ele"></param>
		/// <returns></returns>
		public T SetComponent<T>(IWebElement ele) where T:EnhancedElement
		{

			this.ele = ele;
			return this as T;
		}

		public EnhancedElement()
		{
		}

		public EnhancedElement(IWebElement ele)
		{
			this.ele = ele;
		}

		#region Enhanced Properties

		public string Id
		{
			get
			{
				return this.GetAttribute("id");
			}
	
		}

		public string Style
		{
			get
			{
				return this.GetAttribute("style");
			}
			set
			{
				if (value == null)
					this.RemoveAttribute("style");
				else
					this.SetAttribute("style", value);
			}
		}

		public string Class
		{
			get
			{
				return this.GetAttribute("class");
			}
			set
			{
				if (value == null)
					this.RemoveAttribute("class");
				else
				this.SetAttribute("class", value);
			}
		}

		public string Value
		{
			get
			{
				return  this.GetAttribute("value");
			}
			set
			{
				
				if(value==null)
					this.RemoveAttribute("value");
				else
					this.SetAttribute("value", value);
			}
		}

		#endregion

		#region Enhanced Methods

	

		public EnhancedElement Parent()
		{
			return (this as IWebElement).Parent().EnhanceAs < EnhancedElement>();
		}
		public EnhancedElement Ancestor(string name)
		{
			return (this as IWebElement).Ancestor(name).EnhanceAs<EnhancedElement>();
		}
		

		#endregion

		#region IWebElement

		public void Clear()
		{
			ele.Clear();
		}

		public void Click()
		{
			ele.Click();
		}

		public bool Displayed
		{
			get { return ele.Displayed; }
		}

		public bool Enabled
		{
			get { return ele.Enabled; }
		}

		public string GetAttribute(string attributeName)
		{
			return ele.GetAttribute(attributeName);
		}

		public string GetCssValue(string propertyName)
		{
			return ele.GetCssValue(propertyName);
		}

		public System.Drawing.Point Location
		{
			get { return ele.Location; }
		}

		public bool Selected
		{
			get { return ele.Selected; }
		}

		public void SendKeys(string text)
		{
			ele.SendKeys(text);
		}

		public System.Drawing.Size Size
		{
			get { return ele.Size; }
		}

		public void Submit()
		{
			ele.Submit();
		}

		public string TagName
		{
			get {return ele.TagName; }
		}

		public string Text
		{
			get { return ele.Text; }
		}

		public IWebElement FindElement(By by)
		{
			return ele.FindElement(by);
		}

		public ReadOnlyCollection<IWebElement> FindElements(By by)
		{
			return ele.FindElements(by);
		}

		#endregion


	}
}
