using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
    public static class TemporalID
    {
        public static string GetTID()
        {
            return "|" + DateTime.UtcNow.ToString() + "||" + DraftCounter.Counter.ToString();
        }
    }

    public static class DraftCounter
    {
        [ThreadStatic]
        private static int m_Counter = -1; //Made this -1 so indexing starts from 0
        public static int Counter
        {
            get
            {
                m_Counter++;
                return m_Counter;
            }
        }

        public static void ResetCounter()
        {
            m_Counter = 0;
        }
    }
}
