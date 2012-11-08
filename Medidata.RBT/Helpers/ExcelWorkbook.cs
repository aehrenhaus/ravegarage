using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using Microsoft.Office.Interop.Excel;

namespace Medidata.RBT
{
	/// <summary>
	/// Accepts a 2 dimensional array, the first row will become header.
	/// Then this class let you to get a cell with a row number and column name
	/// 
	/// Row number is 1 based
	/// 
	/// Usage:
	/// var table = new ExcelTable(towDimensionObjectArray);
	/// var value = table[2,"some column"];
	/// 
	/// 
	/// CAUTION: If the row number or column name does not exist, will throw exception. 
	/// </summary>
	public class ExcelTable
	{
		internal object[,] _rawTable;
		private Dictionary<string, int> _columnPosMapping = new Dictionary<string, int>();

		public string SheetName { get; private set; }
		public string Range { get; private set; }
	
		public ExcelTable(object[,] table,string sheetName, string range = null)
		{
			SheetName = sheetName;
			Range = range;

			_rawTable = table;
			_columnPosMapping = new Dictionary<string, int>();


			int columnsCount = _rawTable.GetLength(1);

			for (int i = 1; i <= columnsCount; i++)
			{
				var headerCell = _rawTable[1, i];
				if (!string.IsNullOrWhiteSpace(headerCell as string))
				{
					//will throw up if the column name is already added
					//this is expected behavior
					_columnPosMapping.Add(headerCell.ToString().Trim(), i);
				}
			}

		}

		public int RowsCount
		{
			get { return _rawTable.GetLength(0) - 1; }
		}

		public int NamedColumnsCount
		{
			get { return _rawTable.GetLength(1); }
		}

		public string[] ColumnNames
		{
			get
			{
				string[] names = new string[_columnPosMapping.Keys.Count];
				 _columnPosMapping.Keys.CopyTo(names, 0);
				 return names;
			}
		}

	
		//Row is 1 based 
		public object this[int row, string column]
		{
			get
			{
				if (!_columnPosMapping.ContainsKey(column))
					throw new Exception("No such column: "+column);
				int columnNum = _columnPosMapping[column];
				var value = _rawTable[row + 1, columnNum];
				return value;
			}

			set
			{
				int columnNum = _columnPosMapping[column];
				_rawTable[row + 1, columnNum] = value;

				Modified = true;
		
			}
		}

		public bool Modified { get; private set; }
	}

	public class ExcelWorkbook : IDisposable
	{
		private readonly Application _excelApp;

		private readonly Workbook _workBook;

		private readonly List<ExcelTable> _openedTables = new List<ExcelTable>();

		public void Save()
		{
			foreach (var table in _openedTables)
			{
				if (table.Modified)
					SetWorksheetValueRange(table.SheetName, table._rawTable, table.Range);
			}

			_workBook.Save();
		}

		public void SaveAs(string filePath)
		{
			foreach (var table in _openedTables)
			{
				if (table.Modified)
					SetWorksheetValueRange(table.SheetName, table._rawTable, table.Range);
			}
			_workBook.SaveAs(filePath);
		}

		/// <summary>
		/// Initialize a new Excel reader. Must be integrated
		/// with an Excel interface object.
		/// </summary>
		public ExcelWorkbook(string thisFileName)
		{
			_excelApp = new Application();

			try
			{
				_workBook = _excelApp.Workbooks.Open(thisFileName);

			}
			catch
			{
				throw new Exception("Failed to open file as excel object: "+thisFileName);
			}
		}

		private void SetWorksheetValueRange(string sheetName, object[,] newValue, string range = null)
		{

			Worksheet sheet = (Worksheet)_workBook.Sheets[sheetName];
			sheet.Unprotect();
			//
			// Take the used range of the sheet. Finally, get an object array of all
			// of the cells in the sheet (their values). You can do things with those
			// values. See notes about compatibility.
			//
			Range excelRange = string.IsNullOrEmpty(range) ? sheet.UsedRange : sheet.Range[range];
			excelRange.set_Value(XlRangeValueDataType.xlRangeValueDefault, newValue);
		}


		public ExcelTable OpenTableForEdit(string sheetName, string range = null)
		{
			var raw = GetWorksheetValueRange(sheetName,range);
			var table = new ExcelTable(raw,sheetName,range);
			_openedTables.Add(table);
			return table;
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="sheetName"></param>
		/// <param name="range">
		/// Examlpe:  A1:B3
		/// Is left empty, will return used range
		/// </param>
		/// <returns></returns>
		private object[,] GetWorksheetValueRange(string sheetName, string range = null)
		{

			Worksheet sheet = (Worksheet)_workBook.Sheets[sheetName];

			//
			// Take the used range of the sheet. Finally, get an object array of all
			// of the cells in the sheet (their values). You can do things with those
			// values. See notes about compatibility.
			//
			Range excelRange = string.IsNullOrEmpty(range) ? sheet.UsedRange : sheet.Range[range];
			object[,] valueArray = (object[,])excelRange.get_Value(XlRangeValueDataType.xlRangeValueDefault);

			return valueArray;
		}

		public void Dispose()
		{
			if (_workBook != null)
			{

				_workBook.Close(false);
				Marshal.ReleaseComObject(_workBook);
				Marshal.ReleaseComObject(_excelApp);
			}
		}
	}
}
