﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace Mediata.RBT.Documents
{

	public class MemberDoc
	{
		public string DocMemberType { get; set; }
		public string DocName { get; set; }
		public string[] ArgumentTypes { get; set; }
		public MemeberParam[] Params { get; set; }
		public string Summary { get; set; }
	}

	public class MemeberParam
	{
		public string Name { get; set; }
		public string Content { get; set; }
	}


	public abstract class CommentedObject
	{
		public CommentedObject()
		{
			Doc = new MemberDoc();
			AdditinoalInfo = new Hashtable();
		}

		public MemberDoc Doc { get; set; }
		public Hashtable AdditinoalInfo { get; set; }

		public override string ToString()
		{
			return this.Doc.DocMemberType + ":" + this.Name;
		}

		public abstract string Name { get; }
	}

	public class AssemblyCommentInfo : CommentedObject
	{
		public List<TypeCommentInfo> Types { get; set; }
		public Assembly Assembly { get; set; }
		public override string Name
		{
			get { return Assembly.FullName; }
		}
	}

	public class TypeCommentInfo : CommentedObject
	{
		public List<MethodCommentInfo> Methods { get; set; }
		public Type Type { get; set; }
		public override string Name
		{
			get { return Type.Name; }
		}
	}

	public class MethodCommentInfo : CommentedObject
	{
		public MethodInfo Method { get; set; }
	

		public override string Name
		{
			get { return Method.Name; }
		}

	}
}
