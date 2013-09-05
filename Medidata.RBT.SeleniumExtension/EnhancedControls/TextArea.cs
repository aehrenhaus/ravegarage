using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SeleniumExtension
{
    public class TextArea: EnhancedElement
    {
        /// <summary>
        /// position cursor after the end of matching message in found in text area
        /// </summary>
        /// <param name="message"></param>
        public void PositionCursorAfter(string message)
        {
            var id = this.GetAttribute("ID");

            var script =
                @"
				var qeTextArea = $('#{0}');
				var index = qeTextArea.text().indexOf('{1}');
				index = index + '{1}'.length;
				qeTextArea[0].focus();
				qeTextArea[0].selectionStart = index;
				qeTextArea[0].selectionEnd = index;
				qeTextArea.trigger('keyup');
				";

            script = string.Format(script, id, message);

            this.Brower().ExecuteScript(script);
        }

        /// <summary>
        /// position cursor before the match messge found in text area
        /// </summary>
        /// <param name="message"></param>
        public void PostionCursorBefore(string message)
        {
            var id = this.GetAttribute("ID");

            var script =
                @"
				var qeTextArea = $('#{0}');
				var index = qeTextArea.text().indexOf('{1}');
				qeTextArea[0].focus();
				qeTextArea[0].selectionStart = index;
				qeTextArea[0].selectionEnd = index;
				qeTextArea.trigger('keyup');
				";

            script = string.Format(script, id, message);

            this.Brower().ExecuteScript(script);
        }
    }
}
