using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml.Linq;

namespace Mediata.RBT.Documents
{

	public class AssemblyDocReader
	{
		public AssemblyCommentInfo ReadAssemblyCommentInfo(string assemblyFile)
		{
			var assm = Assembly.LoadFrom(assemblyFile);
			string xmlDocPath = assemblyFile.Replace(".dll", ".xml");
			XElement xmlDoc = null;
			if (System.IO.File.Exists(xmlDocPath))
				xmlDoc = XElement.Load(xmlDocPath);

			return ReadAssemblyCommentInfo(assm, xmlDoc);

		}

		private List<MemberDoc> ReadDoc(XElement docxml)
		{
			var xMembers = docxml.Descendants("member").ToList();
			List<MemberDoc> memberDocs = new List<MemberDoc>();
			foreach (var xMember in xMembers)
			{
				MemberDoc doc = new MemberDoc();

				var rawNameParts = xMember.Attribute("name").Value.Split(new char[] { ':', '(', ')' });


				doc.Params = xMember.Elements().Where(x => x.Name == "param").Select(x => new MemeberParam { Name = x.Attribute("name").Value, Content = x.Value }).ToArray();
				
				doc.ArgumentTypes = rawNameParts.Length==3? rawNameParts[2].Split(','):new string[0];
				doc.DocMemberType = rawNameParts[0];
				doc.DocName = rawNameParts[1];
				var xSummary = xMember.Element("summary");

				if (xSummary != null)
				{
					doc.Summary = xSummary.Value.Trim();
				}

				memberDocs.Add(doc);
			}
			return memberDocs;
		}
		private List<MemberDoc> memberDocs;

		public AssemblyCommentInfo ReadAssemblyCommentInfo(Assembly assembly, XElement docxml = null)
		{
			if(docxml!=null)
				memberDocs = ReadDoc(docxml);
			else
				memberDocs = new List<MemberDoc>();

			AssemblyCommentInfo assem = new AssemblyCommentInfo();
			assem.Assembly = assembly;
			assem.Doc.DocMemberType = "A";
			assem.Types = assem.Assembly.GetTypes().Select(x => ReadTypeInfo(x)).ToList();

			return assem;

		}

		private TypeCommentInfo ReadTypeInfo(Type type)
		{
			TypeCommentInfo typeInfo =new TypeCommentInfo();
			var firstOrDefault = memberDocs.FirstOrDefault(x => x.DocName == type.FullName && x.DocMemberType == "T");
			if (firstOrDefault != null)
				typeInfo.Doc = firstOrDefault;
			typeInfo.Type = type;
			
			typeInfo.Methods = type
				.GetMethods(BindingFlags.Public | BindingFlags.Instance | BindingFlags.FlattenHierarchy)
				.Where( x=>x.DeclaringType==type)
				.Select(x => ReadMethodInfo(x, typeInfo))
				.ToList();
			
			return typeInfo;
		}


		private MethodCommentInfo ReadMethodInfo(MethodInfo method, TypeCommentInfo parentTypeInfo)
		{
			MethodCommentInfo methodInfo = new MethodCommentInfo();
			var firstOrDefault = memberDocs.FirstOrDefault(x => parentTypeInfo.Type.FullName + "." + method.Name == x.DocName && x.DocMemberType == "M");
			if (firstOrDefault != null)
				methodInfo.Doc = firstOrDefault;
			methodInfo.Method = method;
	
			return methodInfo;
		}

	
	}
}
