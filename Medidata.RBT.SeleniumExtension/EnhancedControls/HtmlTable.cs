﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using OpenQA.Selenium;
using TechTalk.SpecFlow;

namespace Medidata.RBT.SeleniumExtension
{
	public class HtmlTable :EnhancedElement
	{

		/// <summary>
		/// This will find the html rows(tr) that match the data in the Specflow.Table
		/// 
		/// TODO:Performance issue:
		/// 
		/// If dataTable has N rows and htmlTable has M rows and dataTable has X columns
		/// this method will scann N * M * X times .
		/// BE SURE to use on small tables.
		/// </summary>
		/// <param name="dataTable"></param>
		/// <param name="htmlTable"></param>
		/// <returns></returns>
		public ReadOnlyCollection<IWebElement> FindMatchRows(Table dataTable)
		{
			//TODO:here could be th instead of td 
			var ths = this.FindElements(By.XPath("./tbody/tr[position()=1]/td"));

			//data rows
			var trs = this.FindElements(By.XPath("./tbody/tr[position()>1]"));

			//key=column name of htmlTable, value = index of htmlTable
			var indexMapping = new Dictionary<string, int>();
			for (int i = 0; i < ths.Count; i++)
			{
				indexMapping[ths[i].Text] = i;
			}

			int maxTdCounts = 0;
			var matchTrs = trs.Where(tr =>
			{
				var tds = tr.FindElements(By.TagName("td"));

				//skip the trs that have less tds, these trs are not data rows usually.
				maxTdCounts = Math.Max(tds.Count, maxTdCounts);
				if (tds.Count != maxTdCounts)
					return false;

				//Is there ***ANY*** datarow that ***ALL*** columns match the html row's columns

				return dataTable.Rows.Any(dr =>
				{
					return dr.All(x => x.Value == tds[indexMapping[x.Key]].Text);
				});

			});


			return new ReadOnlyCollection<IWebElement>(matchTrs.ToList());
		}



		public ReadOnlyCollection<IWebElement> Rows()
		{
			return this.FindElements(By.XPath("./tbody/tr"));
		}

	}
}
