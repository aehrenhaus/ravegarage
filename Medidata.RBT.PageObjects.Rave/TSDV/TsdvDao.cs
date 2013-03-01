using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TSDV
{
	public class TsdvDao
	{
		public static void EnableTsdv() 
		{
			SpTSDVGlobalSwitch(true);
		}

		public static void DisableTsdv() 
		{
			SpTSDVGlobalSwitch(false);
		}

		private static void SpTSDVGlobalSwitch(bool turnOnOffSwitch)
		{
			DbHelper.ExecuteScalarStoredProcedure("spTSDVGlobalSwitch",
				new Dictionary<string, object>() { { "@TurnOnOffSwitch", turnOnOffSwitch } });
		}
	}
}
