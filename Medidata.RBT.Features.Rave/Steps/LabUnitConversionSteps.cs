using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave
{
    [Binding]
    public partial class LabUnitConversionSteps : BrowserStepsBase
    {
        [StepDefinition(@"I add new unit conversion data")]
        public void IAddNewUnitConversionData(Table table)
        {
            CurrentPage.As<UnitConversionsPage>().AddNewConversion(table.CreateInstance<UnitConversionModel>());
        }

        [StepDefinition(@"I edit unit conversion data")]
        public void IEditUnitConversionData(Table table)
        {
            CurrentPage.As<UnitConversionsPage>().EditConversion(table.CreateInstance<UnitConversionModel>());
        }

        [StepDefinition(@"I delete unit conversion data")]
        public void IEditDeleteConversionData(Table table)
        {
            CurrentPage.As<UnitConversionsPage>().DeleteConversion(table.CreateInstance<UnitConversionModel>());
        }


    }
}