using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Internal;
using OpenQA.Selenium.Support.UI;
using System.Text.RegularExpressions;

namespace Medidata.RBT.SeleniumExtension
{
	public static partial class ISearchContextExtend
	{
		private static T SelectExtendElementByPartialID<T>(ISearchContext context, string tag, string partialID, bool nullable,bool? wait = null)
			where T : EnhancedElement, new()
		{
			var ele = context.TryFindElementBy(By.XPath(".//" + tag + "[contains(@id,'" + partialID + "')]"), wait);

			if (ele == null)
			{
				if (nullable)
					return null;
				else
					throw new NoSuchElementException("Can't find element by partialID:" + partialID);
			}
			return ele.EnhanceAs<T>();
		}
		
		private static ReadOnlyCollection<T> CastReadOnlyCollection<T>(this ReadOnlyCollection<IWebElement> coll)
			where T : EnhancedElement, new()
		{
			return new ReadOnlyCollection<T>(coll.Select(x => x.EnhanceAs<T>()).ToList());
		}
  

		#region Table

		public static ReadOnlyCollection<HtmlTable> Tables(this ISearchContext context, bool allLevel = true)
		{
			string xpath = allLevel ? ".//table" : "./table";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<HtmlTable>();
		}

		public static ReadOnlyCollection<HtmlTable> Tables(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<HtmlTable>();
		}

		public static HtmlTable Table(this ISearchContext context, string partialID, bool nullable=false)
		{
			return SelectExtendElementByPartialID<HtmlTable>(context,"table", partialID, nullable);
		}

		#endregion

		#region Textbox

		public static Textbox TextboxById(this ISearchContext context, string partialID, bool nullable=false)
		{
			return SelectExtendElementByPartialID<Textbox>(context,"input", partialID, nullable);
		}
		public static Textbox TextareaById(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElementByPartialID<Textbox>(context, "textarea", partialID, nullable);
		}
        /// <summary>
        /// Select a textbox by the type
        /// </summary>
        /// <param name="context">The context to search</param>
        /// <param name="type">The type of textbox to search for</param>
        /// <param name="nullable"></param>
        /// <returns></returns>
        public static Textbox TextboxByType(this ISearchContext context, string type)
        {
            return context.FindElement(By.XPath(".//input[@type='" + type + "']")).EnhanceAs<Textbox>();
        }

		public static ReadOnlyCollection<Textbox> Textboxes(this ISearchContext context, bool allLevel = true, bool? isWait = null)
		{
			string xpath = allLevel ? ".//input[@type='text'] | .//textarea" : "./input[@type='text'] | ./textarea";
			var result = context.TryFindElementsBy(By.XPath(xpath), isWait)
                ?? new ReadOnlyCollection<IWebElement>(new List<IWebElement>());
            return result.CastReadOnlyCollection<Textbox>();
		}

		public static ReadOnlyCollection<Textbox> Textboxes(this ISearchContext context,string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Textbox>();
		}

		#endregion

		#region Checkbox


		public static Checkbox CheckboxByID(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElementByPartialID<Checkbox>(context,"input", partialID, nullable);
		}


		public static ReadOnlyCollection<Checkbox> Checkboxes(this ISearchContext context, bool allLevel = true)
        {
			string xpath = allLevel ? ".//input[@type='checkbox']" : "./input[@type='checkbox']";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
        }

        public static ReadOnlyCollection<Checkbox> Checkboxes(this ISearchContext context, string xpath, string partialID = null)
        {
            return (partialID == null) ? context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>() :
                                        context.FindElements(By.XPath(xpath + "[contains(@id,'" + partialID + "')]")).CastReadOnlyCollection<Checkbox>();
        }

		#endregion

		#region Dropdown

		public static Dropdown DropdownById(this ISearchContext context, string partialID, bool nullable=false)
		{
			return SelectExtendElementByPartialID<Dropdown>(context,"select", partialID, nullable);
		}


		public static ReadOnlyCollection<Dropdown> Dropdowns(this ISearchContext context, bool allLevel = true)
		{
			string xpath = allLevel ? ".//select" : "./select";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Dropdown>();
		}

		public static ReadOnlyCollection<Dropdown> Dropdowns(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Dropdown>();
		}

		#endregion

		#region Button

		public static IWebElement ButtonByText(this ISearchContext context, string text, bool nullable = false, bool isWait = true)
		{
			var element = context.TryFindElementBy(By.XPath("//button[normalize-space(text())='" + text + "']"), isWait);
			if (element == null)
                element = context.TryFindElementBy(By.XPath("//input[normalize-space(@value)='" + text + "']"), isWait);

			if (!nullable && element == null)
				throw new Exception("Can't find button by text "+text);

			return element;
		}

        public static IWebElement ButtonByID(this ISearchContext context, string partialID, bool nullable = false, bool isWait = true)
        {
            var element = SelectExtendElementByPartialID<EnhancedElement>(context, "input", partialID,true,false);
       
            if (element == null)
				element = SelectExtendElementByPartialID<EnhancedElement>(context, "button", partialID, true, false);
            if (element == null)
				element = SelectExtendElementByPartialID<EnhancedElement>(context, "select", partialID, true, false);
            


            if (!nullable && element == null)
                throw new Exception("Can't find button by id " + partialID);

            return element;
        }

		public static ReadOnlyCollection<IWebElement> Buttons(this ISearchContext context)
		{
		
			var elements1 = context.FindElements(By.XPath("//button"));
			
			var	elements2 = context.FindElements(By.XPath("//input[@type='button']"));

			return new ReadOnlyCollection<IWebElement>(elements1.Union(elements2).ToList());
		}


		#endregion

        #region Hyperlink

        public static Hyperlink LinkByID(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElementByPartialID<Hyperlink>(context, "a", partialID, nullable);
		}


		public static Hyperlink Link(this ISearchContext context, string linktext)
		{
            IWebElement ele;
            //If the element is separated by a bullet it gets translated into <li></li><br> so special consideration must be taken
            if (linktext.Contains("•"))
                ele = FindLinkWithBulletPoint(context, linktext);
            else
				ele = context.TryFindElementBy(By.LinkText(linktext));

			if (ele == null)
				ele = context.TryFindElementBy(By.XPath("//span[normalize-space(text())='" + linktext + "']"));

			//DOTO: !!!!!! This 2 lines should not be here, this is a great performance drop and make no sense to treat a div as a link
            if(ele == null)
                ele = context.TryFindElementBy(By.XPath("//div[normalize-space(text())='" + linktext + "']"));

			if (ele == null)
				throw new Exception("Can't find hyperlink by text:" + linktext);
			return ele.EnhanceAs<Hyperlink>();
		}

        /// <summary>
        /// If the link has a bullet point you need to search for the text before the bullet point.
        /// Then you look for the text after to see if it matches up with the part after the bullet point
        /// </summary>
        /// <param name="context">The context to find the link in</param>
        /// <param name="linkText">The text of the link</param>
        /// <returns>The link with the bullet point</returns>
        public static IWebElement FindLinkWithBulletPoint(ISearchContext context, string linkText)
        {
            string linkTextBeforeBulletPoint = linkText.Substring(0, linkText.IndexOf("•"));
            string linkTextInSelenium = ReplaceSpecialCharactersWithEscapeCharacters(linkText);

            List<IWebElement> linksWhichStartWithPreBulletText = context.FindElements(By.XPath("//a[text()[contains(.,'" + linkTextBeforeBulletPoint + "')]]")).ToList();
            foreach (IWebElement link in linksWhichStartWithPreBulletText)
                if (ReplaceTagsWithEscapedCharacters(link.GetInnerHtml()).Equals(linkTextInSelenium))
                    return link;

            return null;
        }


        /// <summary>
        /// Replace tags that exist in the inner html with the searchable version.
        /// </summary>
        /// <param name="originalString">The inner html in the area to search</param>
        /// <returns>The string with the tags replaced with elements that won't get split up</returns>
        public static string ReplaceTagsWithEscapedCharacters(string originalString)
        {
            Regex re = new Regex("<br/>|<br>|<li></li>|<b>|</b>", RegexOptions.IgnoreCase);

            string convertedString = re.Replace(originalString, delegate(Match m)
            {
                string value = m.Value;

                if (value.Equals("<br>", StringComparison.OrdinalIgnoreCase))
                {
                    return "\br";
                }
                else if (value.Equals("<li></li>", StringComparison.OrdinalIgnoreCase))
                {
                    return "•";
                }
                else if (value.Equals("<b>", StringComparison.OrdinalIgnoreCase))
                {
                    return "\\b";
                }
                else if (value.Equals("</b>", StringComparison.OrdinalIgnoreCase))
                {
                    return "\\/b";
                }
                else if (value.Equals("<br/>", StringComparison.OrdinalIgnoreCase))
                {
                    return "\br";
                }
                else
                {
                    return "";
                }
            });

            return convertedString;
        }

        /// <summary>
        /// Replace characters in the feature file string with the escaped version that matches the string from ReplaceTagsWithEscapedCharacters
        /// </summary>
        /// <param name="originalString">The string from the feature file</param>
        /// <returns>A string that matches the format returned from ReplaceTagsWithEscapedCharacters</returns>
        public static string ReplaceSpecialCharactersWithEscapeCharacters(string originalString)
        {
            Regex re = new Regex("&|\\\\<|\\\\>|<|>|\\\\r|\\\\br", RegexOptions.IgnoreCase);

            string convertedString = re.Replace(originalString, delegate(Match m)
            {
                string value = m.Value;

                if (value.Equals("&", StringComparison.OrdinalIgnoreCase))
                {
                    return "&amp;";
                }
                else if (value.Equals("<", StringComparison.OrdinalIgnoreCase))
                {
                    return "&lt;";
                }
                else if (value.Equals(">", StringComparison.OrdinalIgnoreCase))
                {
                    return "&gt;";
                }
                else if (value.Equals("\\r", StringComparison.OrdinalIgnoreCase))
                {
                    return "\r\n";
                }
                else if (value.Equals("\\br", StringComparison.OrdinalIgnoreCase))
                {
                    return "\br";
                }
                else
                {
                    return "•";
                }
            });

            return convertedString;
        }


        public static Hyperlink LinkByPartialText(this ISearchContext context, string linktext)
        {
            var ele = context.TryFindElementBy(By.PartialLinkText(linktext));
            if (ele == null)
                throw new Exception("Can't find hyperlink by paritial text:" + linktext);
            return ele.EnhanceAs<Hyperlink>();
        }

		public static Hyperlink LinkByText(this ISearchContext context, string linktext)
		{
			var ele = context.TryFindElementBy(By.LinkText(linktext));
			if (ele == null)
				throw new Exception("Can't find hyperlink by text:" + linktext);
			return ele.EnhanceAs<Hyperlink>();
		}

		public static ReadOnlyCollection<Hyperlink> Links(this ISearchContext context, bool allLevel= true)
		{
			string xpath = allLevel ? ".//a" : "./a";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Hyperlink>();
		}

		

		#endregion

        #region HiddenInput
        
        public static ReadOnlyCollection<EnhancedElement> HiddenInputs(this ISearchContext context)
        {
            return context.FindElements(By.XPath(".//input[@type='hidden']")).CastReadOnlyCollection<EnhancedElement>();
        }

        #endregion

		#region Img




		public static EnhancedElement ImageBySrc(this ISearchContext context, string src, bool? isWait = null)
		{
			return context.TryFindElementBy(By.XPath(".//img[contains(@src,'" + src  + "')]"), isWait).EnhanceAs<EnhancedElement>();
		}


		public static ReadOnlyCollection<EnhancedElement> Images(this ISearchContext context, bool allLevel = true)
		{
			string xpath = allLevel ? ".//img" : "./img";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<EnhancedElement>();
		}

		public static ReadOnlyCollection<EnhancedElement> Images(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<EnhancedElement>();
		}

		#endregion

		#region Div


		public static Checkbox Div(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElementByPartialID<Checkbox>(context, "div", partialID, nullable);
		}


		public static ReadOnlyCollection<Checkbox> Divs(this ISearchContext context, bool allLevel = true)
		{
			string xpath = allLevel ? ".//div" : "./div";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
		}

		public static ReadOnlyCollection<Checkbox> Divs(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
		}

		#endregion

		#region Span


        public static IWebElement Span(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElementByPartialID<Checkbox>(context, "span", partialID, nullable);
		}


		public static ReadOnlyCollection<IWebElement> Spans(this ISearchContext context)
		{
            var result = context.TryFindElementsBy(By.XPath(".//span"));
            return result ?? new ReadOnlyCollection<IWebElement>(new List<IWebElement>());
		}

        public static ReadOnlyCollection<IWebElement> Selects(this ISearchContext context)
        {
            return context.TryFindElementsBy(By.XPath(".//select"));
        }

        public static ReadOnlyCollection<IWebElement> Options(this ISearchContext context)
        {
            return context.TryFindElementsBy(By.XPath(".//option"));
        }

        public static ReadOnlyCollection<IWebElement> Spans(this ISearchContext context, string xpath)
		{
            return context.TryFindElementsBy(By.XPath(xpath));
		}

		#endregion


		public static ReadOnlyCollection<IWebElement> Children(this ISearchContext context)
		{
			return context.FindElements(By.XPath("./*"));
		}


		#region RadioButton


		public static RadioButton RadioButton(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElementByPartialID<RadioButton>(context, "input", partialID, nullable);
		}


		public static ReadOnlyCollection<RadioButton> RadioButtons(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//input")).CastReadOnlyCollection<RadioButton>();
		}

		public static ReadOnlyCollection<RadioButton> RadioButtons(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<RadioButton>();
		}

		#endregion

        public static ReadOnlyCollection<EnhancedElement> FindElementsByPartialId(this ISearchContext context, string partialID)
        {
            return context.FindElements(By.XPath(".//*[contains(@id,'" + partialID + "')]")).CastReadOnlyCollection<EnhancedElement>();
        }


		public static ReadOnlyCollection<EnhancedElement> FindImagebuttons(this ISearchContext context)
		{
            return context.FindElements(By.XPath(".//input[@type='image']")).CastReadOnlyCollection<EnhancedElement>();
		}

        /// <summary>
        /// Returns imagebutton as EnhancedElement based on partial ID
        /// </summary>
        /// <param name="context"></param>
        /// <param name="partialID"></param>
        /// <returns></returns>
        public static EnhancedElement FindImagebuttonByPartialId(this ISearchContext context, string partialID)
        {
            return context.TryFindElementBy(By.XPath(
                string.Format(".//input[@type='image' and contains(@id, '{0}')]", partialID))).EnhanceAs<EnhancedElement>();
        }
		

        /// <summary>
        /// This method will return a collection of elements
        /// of type T, that have matching text
        /// </summary>
        /// <typeparam name="T">type of element</typeparam>
        /// <param name="context">context to be searched</param>
        /// <param name="text">text of the elements to be returned</param>
        /// <returns></returns>
        public static IEnumerable<IWebElement> FindElementsByText<T>(this ISearchContext context, string text)
            where T : IWebElement
        {
            //check text
            if ((context as IWebElement).Text.Equals(text))
                yield return (T)context;

            //then make a recursive call
            if ((context as IWebElement).Text.Contains(text))
            {
                foreach (var el in context.Children().OfType<T>())
                {
                    foreach (var el2 in el.FindElementsByText<T>(text))
                        yield return el2;
                }
            }
        }

	}
}
