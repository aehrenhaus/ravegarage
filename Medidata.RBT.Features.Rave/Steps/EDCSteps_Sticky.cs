using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.TableModels;


namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to EDC
    /// </summary>
	public partial class EDCSteps
    {
        /// <summary>
        /// Place a sticky against a field
        /// </summary>
        /// <param name="table">The field information to place the sticky against and the sticky information</param>
        [StepDefinition(@"I place stickies")]
        public void ThenIPlaceStickies(Table table)
        {
            List<StickyModel> stickyInfo = table.CreateSet<StickyModel>().ToList();
            CurrentPage.As<CRFPage>().PlaceStickies(stickyInfo);
        }
	}
}
