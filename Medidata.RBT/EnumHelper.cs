using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Medidata.RBT
{
	public static class EnumHelper
	{
		/// <summary>
		/// Returns an Enum instance of specific type T where the Enum field is decorated with DescriptionAttribute
		/// and the DescrptionAttribute.Description property is equal to the desc parameter.
		/// </summary>
		/// <typeparam name="T">TYpe of the Enum we are interested in obtaining. Should be an Enum type</typeparam>
		/// <param name="desc">The description with which DescriptionAttribute was instantiated. Cannot be null</param>
		/// <returns>The specific Enum or the default(T) if description was found</returns>
		public static T GetEnumByDescription<T>(string desc) 
		{
			T result = default(T);
			if (desc == null)
				return result;
			desc = desc.Trim().ToLower();

			foreach (var field in typeof(T).GetFields())
			{
				var attribute = Attribute.GetCustomAttribute(field,
					typeof(DescriptionAttribute)) as DescriptionAttribute;
				if (attribute == null)
					continue;

				if (attribute.Description == desc)
				{
					result = (T)field.GetValue(null);
					break;
				}
			}

			return result;
		}
	}
}
