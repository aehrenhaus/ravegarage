using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SeleniumExtension
{
    public class TextArea: EnhancedElement
    {
        /// <summary>
        /// position cursor after at the specified offset relative to matching message found in text area
        /// </summary>
        /// <param name="message"></param>
        /// <param name="offset"></param>
        public void PositionCursorAt(string message, int offset = 0)
        {
            var id = this.GetAttribute("ID");

            var script =
                @"
				var qeTextArea = $('#{0}');
				var index = qeTextArea.text().indexOf('{1}');
				index = index + {2};
				qeTextArea[0].focus();
				qeTextArea[0].selectionStart = index;
				qeTextArea[0].selectionEnd = index;
				qeTextArea.trigger('keyup');
				";

            script = string.Format(script, id, message, offset);

            this.Brower().ExecuteScript(script);
        }
    }
}
