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
using Medidata.RBT.PageObjects.Rave.TableModels;
using Medidata.RBT.PageObjects.Rave.TSDV;

namespace Medidata.RBT.PageObjects.Rave.TSDV
{
    public class CustomTierPage : BlockPlansPageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/Reporting/TSDV/CustomTier.aspx";
            }
        }

        /// <summary>
        /// Selects the fields custom tier draft.
        /// </summary>
        /// <param name="formFieldsModel">The form fields model.</param>
        /// <param name="verify">if set to <c>true</c> [verify].</param>
        /// <param name="publish">if set to <c>true</c> [publish].</param>
        /// <returns></returns>
        public bool SelectFieldsCustomTierDraft(IEnumerable<TSDVFormFieldsModel> formFieldsModel, bool verify = false,  bool publish = false)
        {
            bool returnSelection = true;
            foreach (var model in formFieldsModel)
            {

                var fieldFormsTable = Browser.FindElementById("FieldFormsSelection");



                if (fieldFormsTable != null)
                {
                    var elemSpan = fieldFormsTable.FindElementsByPartialId("_FormNameLabel")
                                                  .FirstOrDefault(
                                                      el =>
                                                          {
                                                              bool foundForm = false;
                                                              foundForm = el.Text == model.Form;
                                                              return foundForm;
                                                          });
                    if (elemSpan != null)
                    {
                        var idElements = elemSpan.Id.Split('_');
                        var imageLoookupPrefix = idElements[idElements.Count() - 2];

                        var image =
                            fieldFormsTable.FindElementsByPartialId(imageLoookupPrefix + "_image_")
                                           .FirstOrDefault();
                        if (image != null) image.Click();

                        var fieldsDiv =
                            fieldFormsTable.FindElementsByPartialId(imageLoookupPrefix + "_FieldsDetailsDiv")
                                           .FirstOrDefault();

                        if (fieldsDiv != null)
                        {
                            var trs =
                                fieldsDiv.Tables()[0].Rows();
                            var i = 0;
                            IWebElement el = null;
                            for (i = 0; i < trs.Count; i++)
                            {
                                var childRows = trs[i].Children()[1].Tables()[0].Rows();
                                foreach (var row in childRows)
                                {
                                    if (row.Children().FirstOrDefault(r => r.Text == model.Field) != null)
                                    {
                                        el = (IWebElement) row;
                                        break;
                                    }
                                }
                                if (el != null) break;
                            }

                            var ch = el.Checkboxes()[0].EnhanceAs<Checkbox>();
                            if (!verify)
                            {
                                if ((bool) model.Selected.Value == true)
                                {
                                    ch.Check();
                                }
                                else
                                {
                                    ch.Uncheck();
                                }
                            }
                            else
                            {
                                if (returnSelection) returnSelection = model.Selected == ch.Checked;
                            }
                        }

                    }
                }
                ;

                if (!verify)
                {
                    this.ClickButton("SaveForms");
                }

                if (publish)
                {

                    Browser.TryFindElementBy(b =>
                        {
                            var pubBtn = Browser.TryFindElementById("PublishButton");
                            if (pubBtn == null || !pubBtn.Enabled)
                                return null;
                            return pubBtn;
                        });
                    this.ClickButton("PublishButton");
                    
                    //make sure that dialog box has loaded before attempting to click publish button
                    Browser.TryFindElementBy(b =>
                        {
                            IWebElement pubDialog = b.TryFindElementById("dialog");

                            if (pubDialog != null && pubDialog.GetCssValue("opacity").Equals("1") &&
                                pubDialog.GetCssValue("display").Equals("block"))
                            {
                                return pubDialog;
                            }

                            return null;
                        });
        
                    //confirmation to publish the draft
                    this.ClickButton("_ctl0_Content__ctl10_PublishDraft");
                }
            }

            return returnSelection;
        }
    }
}
