using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Medidata.RBT.Documents
{


	public class GherkinParser
	{
		public Feature Parse(string filePath)
		{
			this.filePath = filePath;
			CurrentLineNum = 0;
			AllLines = File.ReadAllLines(filePath);
			Feature feature = ReadFeature();
			feature.FilePath = filePath;

			return feature;

		}

		private string filePath; //for debug convenience

		private string[] AllLines;

		private int CurrentLineNum;

		private Feature ReadFeature()
		{
			Feature f = new Feature();

			f.Tags = ReadTags();
			f.Title = ReadFeatureTitle();
			ReadBackgroundLine();
			f.BackgroundSteps = ReadSteps();
			f.Scenarios = ReadScenarios();

			foreach (var s in f.Scenarios)
				s.Feature = f;

			return f;
		}

		private string ReadBackgroundLine()
		{

			int lineNum = CurrentLineNum;
			string bg = "";

			while (CurrentLineNum<AllLines.Length)
			{
				string line = AllLines[CurrentLineNum].Trim();

				if (line.StartsWith("Scenario:") || line.StartsWith("@") ||line.StartsWith("Given ") || line.StartsWith("When ") || line.StartsWith("Then ") || line.StartsWith("And "))
				{
					return bg;
				}
				else
				{
					bg += line + "\r\n";
				}


				CurrentLineNum++;

			}
			return bg;
		}

		private string ReadFeatureTitle()
		{
			List<string> linesBuffer = new List<string>();
			int lineNum = CurrentLineNum;
			while (CurrentLineNum < AllLines.Length)
			{
				string line = AllLines[CurrentLineNum].Trim();

				if (line.StartsWith("#") || line == "")
				{
				}
				else if(line.StartsWith("Feature:"))
				{
					linesBuffer.Add(line.Substring(line.IndexOf(":")+1).Trim());
				}
				else if (line.StartsWith("Background:") || line.StartsWith("Scenario:") || line.StartsWith("@") )
				{
					return string.Join("\r\n", linesBuffer.ToArray());
				}
				else
				{
					linesBuffer.Add(line);
				}

				CurrentLineNum++;

			}

			return null;
		}

		private List<string> ReadTags()
		{
			List<string> tags = new List<string>();


			while (CurrentLineNum < AllLines.Length)
			{
				string line = AllLines[CurrentLineNum].Trim();

				if (line.StartsWith("@"))
				{
					tags.Add(line);
				}
				else
				{
					break;
				}

				CurrentLineNum++;
			}
			return tags;
		}

		private List<Scenario> ReadScenarios()
		{
			List<Scenario> scenarios = new List<Scenario>();


			while (CurrentLineNum < AllLines.Length)
			{
				string line = AllLines[CurrentLineNum].Trim();


				if (line.StartsWith("#") || line == "")
				{
					CurrentLineNum++;
				}
				else if (line.StartsWith("Scenario:") || line.StartsWith("@"))
				{
					scenarios.Add(ReadScenario());

				}
				else
				{
					break;
				}

				
			}
			return scenarios;
		}

		private Scenario ReadScenario()
		{
			Scenario s = new Scenario();
			s.Tags = ReadTags();
			s.Title = ReadScenarioTitle();
			s.Steps = ReadSteps();

			foreach (var step in s.Steps)
				step.Scenario = s;

			return s;
		}

		private string ReadScenarioTitle()
		{
			List<string> linesBuffer = new List<string>();
			int lineNum = CurrentLineNum;
			bool started	 = false;
			while (CurrentLineNum < AllLines.Length)
			{
				string line = AllLines[CurrentLineNum].Trim();

				if (line.StartsWith("Given ") || line.StartsWith("When ") || line.StartsWith("Then ") || line.StartsWith("And ") || line.StartsWith("@"))
				{
					return string.Join("\r\n", linesBuffer.ToArray());
				}
				else if (line.StartsWith("Scenario:"))
				{
					if (!started)
					{
						linesBuffer.Add(line.Substring(line.IndexOf(":") + 1).Trim());
						started = true;
					}
					else
					{
						return string.Join("\r\n", linesBuffer.ToArray());
					}
				
				}
				else
				{
					linesBuffer.Add(line);
				}

				CurrentLineNum++;

			}

			return null;
		}

		private List<Step> ReadSteps()
		{
			LastCalculatedVerb = "Given";
			List<Step> steps = new List<Step>();


			while (CurrentLineNum < AllLines.Length)
			{
				string line = AllLines[CurrentLineNum].Trim();


				if (line.StartsWith("#") || line=="")
				{
					CurrentLineNum++;
				}
				else if (line.StartsWith("Given ") || line.StartsWith("When ") || line.StartsWith("Then ") || line.StartsWith("And "))
				{
					steps.Add(ReadStep());
				}
				else
				{
					break;
				}

				
			}
			return steps;
		}

		private string LastCalculatedVerb = "";

		private Step ReadStep()
		{
		
			int lineNum = CurrentLineNum;
			Step step = null;

			while (CurrentLineNum < AllLines.Length)
			{
				string line = AllLines[CurrentLineNum].Trim();


				if (line.StartsWith("#") || line == "")
				{
					
					
				}
				else if(line.StartsWith("|"))
				{
					step.TableString = step.TableString ?? "";
					step.TableString += line;
				}
				else if (line.StartsWith("Given ") || line.StartsWith("When ") || line.StartsWith("Then ") || line.StartsWith("And ") || line.StartsWith("@") || line.StartsWith("Scenario:"))
				{
					if (step!=null)
						break;
					else
					{
						var parts =  line.Split(new char[]{' '},2);
						step = new Step();
						step.LineNum = lineNum;
						step.Title = parts[1];
						step.LiteralVerb = parts[0];
						step.CalculatdVerb = step.LiteralVerb == "And" ? LastCalculatedVerb : step.LiteralVerb;
						LastCalculatedVerb = step.CalculatdVerb;
					}
		
				}

				CurrentLineNum++;
		
			}
		
			return step;
		}
	}
}
