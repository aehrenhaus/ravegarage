using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    public class CoderLocale : BaseRaveSeedableObject
    {
        public int CoderDictionaryId { get; set; }
        public string CoderDictionaryName { get; set; }
        public string Locale { get; set; }

        /// <summary>
        /// To seed the coder locale for coding dictionary that is already seeded
        /// Currently only supports backend seeding
        /// </summary>
        /// <param name="locale"></param>
        /// <param name="coderDictionaryName"></param>
        public CoderLocale(string locale, string coderDictionaryName)
		{
            this.CoderDictionaryName = coderDictionaryName;
            this.Locale = locale;
            this.CoderDictionaryId = 0;
            this.UniqueName = string.Format("{0} + {1}", CoderDictionaryName, Locale);
		}

        public override void Seed()
        {
            base.Seed();
            string sql = string.Format(CoderLocale.CREATE_CODING_LOCALE_SQL, this.CoderDictionaryId,
                this.CoderDictionaryName, this.Locale);

            DbHelper.ExecuteDataSet(sql);
        }

        #region CREATE_CODING_LOCALE
        private const string CREATE_CODING_LOCALE_SQL =
            @"insert into CoderLocale (CoderDictionaryId, CoderDictionaryName, Locale, Created, Updated)
			values ({0}, '{1}', '{2}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        #endregion


    }
}
