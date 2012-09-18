using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
    public static class TemporalID
    {
        /// <summary>
        /// Used when getting a TID for the first time, it increments the counter
        /// </summary>
        /// <returns>Returns a TID string</returns>
        public static string GetNewTID()
        {
            string tid = "|" + DateTime.UtcNow.ToString() + "||" + DraftCounter.Counter.ToString();
            DraftCounter.IncrementCounter();
            return tid;
        }
    }

    public static class DraftCounter
    {
        private static int m_Counter;
        public static int Counter
        {
            get
            {
                return m_Counter;
            }
        }

        public static void ResetCounter()
        {
            m_Counter = 0;
        }

        public static void IncrementCounter()
        {
            m_Counter++;
        }

        public static void DecrementCounter()
        {
            m_Counter--;
        }
    }
}
