using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.PageObjects.Rave.TableModels;

namespace Medidata.RBT.PageObjects.Rave
{
	public class QueryElement
	{
        private bool? m_HasDropdown;
        private bool? m_HasCancelCheckbox;
        private bool? m_HasReplyTextbox;
        private string m_AnswerText;
        private readonly IWebElement m_QueryWebElement;

        public QueryElement(IWebElement queryWebElement)
        {
            m_QueryWebElement = queryWebElement;
        }

        public bool? HasDropdown
        {
            get
            {
                if(!m_HasDropdown.HasValue)
                    m_HasDropdown = m_QueryWebElement.Dropdowns().Count == 1;
                return m_HasDropdown;
            }
        }
        public bool? HasCancelCheckbox
        {
            get
            {
                if (!m_HasCancelCheckbox.HasValue)
                    m_HasCancelCheckbox = m_QueryWebElement.Checkboxes().Count == 1;
                return m_HasCancelCheckbox;
            }
        }
        public bool? HasReplyTextbox
        {
            get
            {
                if (!m_HasReplyTextbox.HasValue)
                    m_HasReplyTextbox = m_QueryWebElement.Textboxes().Count == 1;
                return m_HasReplyTextbox;
            }
        }

        public string AnswerText
        {
            get
            {
                if (m_AnswerText == null)
                {
                    IWebElement answerTD = m_QueryWebElement.TryFindElementBy(By.XPath("./tbody/tr[2]/td[2]"), isWait: false);
                    if (answerTD == null)
                        return null;
                    else
                        m_AnswerText = answerTD.Text.Trim();
                }
                return m_AnswerText;
            }
        }
    }
}
