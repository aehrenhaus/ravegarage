using System;
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
		public ReadOnlyCollection<IWebElement> FindMatchRows(Table dataTable, Func<IWebElement, string> tdTextSelector = null)
		{
			if (tdTextSelector == null)
				tdTextSelector = td => td.Text.Trim();


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
					//use trim because there could be spaces 
					return dr.All(x => x.Value.Trim() ==tdTextSelector( tds[indexMapping[x.Key]]));
				});

			});


			return new ReadOnlyCollection<IWebElement>(matchTrs.ToList());
		}

		/// <summary>
		/// for content ,contentRow starts from 1. 
		/// contentRow is 0 for header
		/// </summary>
		/// <param name="contentRow"></param>
		/// <param name="columnName"></param>
		/// <returns></returns>
		public IWebElement Cell(int contentRow, string columnName)
		{
			//TODO:here could be th instead of td 
			var ths = this.FindElements(By.XPath("./tbody/tr[position()=1]/td"));

			//data rows
			var tr = this.FindElements(By.XPath("./tbody/tr[position()="+(contentRow+1)+"]"));

			//key=column name of htmlTable, value = index of htmlTable
			var indexMapping = new Dictionary<string, int>();
			for (int i = 0; i < ths.Count; i++)
			{
				indexMapping[ths[i].Text] = i;
			}

			var cell = tr[0].FindElements(By.TagName("td"))[indexMapping[columnName]];
			return cell;
		}

		public ReadOnlyCollection<IWebElement> Rows()
		{
			return this.FindElements(By.XPath("./tbody/tr"));
		}

	}
}
