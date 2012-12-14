using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to lab unit conversion
    /// </summary>
    [Binding]
    public partial class LabUnitConversionSteps : BrowserStepsBase
    {
        /// <summary>
        /// Add new unit conversion data
        /// </summary>
        /// <param name="table">The new conversion data to add</param>
        [StepDefinition(@"I add new unit conversion data")]
        public void IAddNewUnitConversionData(Table table)
        {
            CurrentPage.As<UnitConversionsPage>().AddNewConversion(table.CreateInstance<UnitConversionModel>());
        }
        
        /// <summary>
        /// Edit unit conversion data
        /// </summary>
        /// <param name="table">The unit conversion data to edit</param>
        [StepDefinition(@"I edit unit conversion data")]
        public void IEditUnitConversionData(Table table)
        {
            CurrentPage.As<UnitConversionsPage>().EditConversion(table.CreateInstance<UnitConversionModel>());
        }

        /// <summary>
        /// Delete unit conversion data
        /// </summary>
        /// <param name="table">The unit conversion data to delete</param>
        [StepDefinition(@"I delete unit conversion data")]
        public void IEditDeleteConversionData(Table table)
        {
            CurrentPage.As<UnitConversionsPage>().DeleteConversion(table.CreateInstance<UnitConversionModel>());
        }


    }
}