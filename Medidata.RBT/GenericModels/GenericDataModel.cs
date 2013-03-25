using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.GenericModels
{
    /// <summary>
    /// This is a generic model that can be used for 
    /// any data type. To be used to create set out of single 
    /// column tables in specflow. Note the table header should 
    /// be named 'Data' but the content can be of any primitive type
    /// readily parsed by specflow
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class GenericDataModel<T>
    {
        /// <summary>
        /// 
        /// </summary>
        public T Data { get; set; } 
    }
}
