using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
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

        protected override void SeedFromUI()
        {
            throw new NotSupportedException("Is not currently possible to create Coding Column from Rave UI");
        }

        protected override void SeedFromBackend()
        {
            this.CreateObject();
        }

        /// <summary>
        /// Override to base implementation of create object that execute sql
        /// </summary>
        protected override void CreateObject()
        {
            var sql = string.Format(CoderLocale.CREATE_CODING_LOCALE_SQL, this.CoderDictionaryId,
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
