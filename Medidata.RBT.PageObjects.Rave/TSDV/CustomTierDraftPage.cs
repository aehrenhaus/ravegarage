using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.PageObjects.Rave
{
    public class CustomTierDraftPage : BlockPlansPageBase
    {

        public override string URL
        {
            get
            {
                return "Modules/Reporting/TSDV/DraftCustomTier.aspx";
            }
        }

        /// <summary>
        /// Creat a new draft with specified tier name and decription
        /// </summary>
        /// <param name="tierName"></param>
        /// <param name="description"></param>
        /// <param name="cstTierModel"></param>
        /// <returns></returns>
        public IPage CreateCustomTierDraft(string tierName, string description, IEnumerable<CustomTierModel> cstTierModels)
        {
            Textbox tierNamebox = Browser.TryFindElementById("TierName").EnhanceAs<Textbox>();
            tierNamebox.SetText(tierName);

            Textbox tierDescBox = Browser.TryFindElementById("TierDescription").EnhanceAs<Textbox>();
            tierDescBox.SetText(description);

            Browser.ImageBySrc("../../../Img/i_ccheck.gif").Click();
        
            var elems = Browser.FindElementsByPartialId("FormNameLabel");

            if (elems.Count > 0)
            {
                //Select the forms specified for TSDV custom tier
                foreach (var cstTierModel in cstTierModels)
                {
                    var elem = elems.FirstOrDefault(p =>
                        {
                            bool foundForm = false;
                            if (p.Text.Length >= cstTierModel.Form.Length)
                                foundForm = p.Text.Substring(0, cstTierModel.Form.Length).Equals(cstTierModel.Form);

                            return foundForm;
                        });
                    if (elem != null)
                    {
                        var parentElem = elem.Parent().Parent().Parent();
                        var selectionCheckbox = parentElem.FindElementsByPartialId("FormSelectedCheckbox").FirstOrDefault<EnhancedElement>()
                            .EnhanceAs<Checkbox>();

                        if (selectionCheckbox != null)
                        {
                            if (cstTierModel.Selected.ToLower().Equals("true"))
                                selectionCheckbox.Check();
                            else if (cstTierModel.Selected.ToLower().Equals("false"))
                                selectionCheckbox.Uncheck();
                        }
                    }
                }
                
                this.ClickButton("SaveForms");
                Browser.WaitForElement(b =>
                {
                    var pubBtn = Browser.TryFindElementById("PublishButton");
                    if (pubBtn == null || !pubBtn.Enabled)
                        return null;
                    return pubBtn;
                });
                this.ClickButton("PublishButton");
                //confirmation to publish the draft
				Browser.WaitForElement(b => Browser.TryFindElementById("_ctl0_Content__ctl10_PublishDraft"));

                this.ClickButton("_ctl0_Content__ctl10_PublishDraft");
				Browser.WaitForElement(b => Browser.TryFindElementById("TiersDiv"));
            }
          
            return this;
        }

    }
}
