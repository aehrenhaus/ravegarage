using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.PageObjects.Rave.TSDV
{
	public sealed class TsdvDao : IRemoveableObject
	{
        private static readonly Lazy<TsdvDao> m_Instance = new Lazy<TsdvDao>(() => new TsdvDao());

        private TsdvDao() { }

        public static TsdvDao Instance
        {
            get
            {
                return m_Instance.Value;
            }
        }

        private bool m_TSDVEnabled = false;

        public bool TSDVEnabled
        {
            get
            {
                return m_TSDVEnabled;
            }
            set
            {
                SpTSDVGlobalSwitch(value);
                m_TSDVEnabled = value;
            }
        }

		private void SpTSDVGlobalSwitch(bool turnOnOffSwitch)
		{
			DbHelper.ExecuteScalarStoredProcedure("spTSDVGlobalSwitch",
				new Dictionary<string, object>() { { "@TurnOnOffSwitch", turnOnOffSwitch } });
            if (!Factory.ScenarioObjectsForDeletion.Contains(this))
                Factory.ScenarioObjectsForDeletion.Add(this);
		}

        public void DeleteSelf()
        {
            if (TSDVEnabled)
            {
                TSDVEnabled = false;
                CacheFlushPage.PerformCacheFlush("Medidata.Core.Objects.Configuration");
            }
        }
	}
}
