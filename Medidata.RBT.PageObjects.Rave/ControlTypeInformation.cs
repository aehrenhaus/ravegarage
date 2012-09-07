using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Medidata.RBT.PageObjects.Rave
{
	/// <summary>
	/// Defines a high level Rave EDC field type component
	/// </summary>
	public enum ControlType
	{
		Default,//must be the first one. This option is for those unknow type of control

		[Description("checkbox"), Suffix("CRFControlC")]
		CheckBox,

		[Description("datetime"), Suffix("")]
		Datetime,

		[Description("dropdown"), Suffix("DD")]
		DropDownList,

        [Description("dynamic search list"), Suffix("C_CRFSL")]
		DynamicSearchList,

		[Description("browser file upload button"), Suffix("CRFFileUpload")]
		FileUpload,

		[Description("long text"), Suffix("")]  //TODO : Check Suffix on this type if used in future implementation
		LongText,

		[Description("radiobutton"), Suffix("RadioBtnList")]
		RadioButton,

		[Description("radiobutton vertical"), Suffix("RadioBtnList")]   //TODO : Check Suffix on this type if used in future implementation
		RadioButtonVertical,

		[Description("search list"), Suffix("")]    //TODO : Check Suffix on this type if used in future implementation
		SearchList,

		[Description("signature"), Suffix("")]  //TODO : Check Suffix on this type if used in future implementation
		Signature,

		[Description("textbox"), Suffix("Text")]
		Text,

		[Description("specify textbox"), Suffix("specifyTB")]
		SpecifyTextbox,

		[Description("unit dictionary"), Suffix("U")]
		UnitDictionary,

		[Description("link"), Suffix("")]   //TODO : Check Suffix on this type if used in future implementation
		Link,

		[Description("esigpage"), Suffix("TwoPart")]
		ESigPage,

		[Description("button"), Suffix("")] //TODO : Check Suffix on this type if used in future implementation
		Button
	}


	[AttributeUsage(AttributeTargets.Field, AllowMultiple = false)]
	internal class SuffixAttribute : Attribute
	{
		private readonly string m_suffix;

		public SuffixAttribute(string suffix)
		{
			m_suffix = suffix;
		}

		public string Suffix { get { return m_suffix; } }
		public override string ToString() { return this.m_suffix; }
	}

    public class ControlTypeInformation
    {
        
        /// <summary>
        /// Used to find an string which will be used by XPath to find the low level element representing
        /// the high level Rave EDC element defined by ControlType parameter.
        /// </summary>
        /// <param name="controlType">The high level Rave EDC element type</param>
        /// <param name="positionInRow">Ordinal of the element in the composite field</param>
        /// <returns>suffix using in XPath</returns>
        public static string GetSuffixByControlType(ControlType controlType, int? positionInRow = null)
        {
            if (positionInRow == null)
            {
                if (controlType == ControlType.FileUpload)
                    return ":" + GetSuffix(controlType);
                else
                    return "_" + GetSuffix(controlType);
            }
            else if (controlType == ControlType.UnitDictionary)
            {
                if (positionInRow == 0)
                    return "_" + GetSuffix(ControlType.Text);
                else
                    return "_" + GetSuffix(controlType);
            }
            else if (controlType == ControlType.ESigPage)
            {
                if (positionInRow == 0)
                    return "_" + GetSuffix(controlType);
                else
                    return "_" + GetSuffix(ControlType.Text);
            }
            else if (controlType == ControlType.Datetime)
                return GetSuffix(controlType) + "_" + positionInRow;
            else
                return "_" + GetSuffix(controlType) + "_" + positionInRow;
        }
        
        private static string GetSuffix(Enum enm)
        {
            var type = enm.GetType();
            var suffix = Attribute.GetCustomAttribute(
                type.GetMember(enm.ToString()).FirstOrDefault(),
                typeof(SuffixAttribute)) as SuffixAttribute;

            return suffix != null
                ? suffix.Suffix
                : string.Empty;
        }


    }

}
