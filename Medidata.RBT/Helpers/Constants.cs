using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
    public class Constants
    {
        private enum NumberWord
        {
            first = 1,
            second = 2,
            third = 3,
            fourth = 4,
            fifth = 5,
            sixth = 6,
            seventh = 7,
            eighth = 8,
            ninth = 9,
            tenth = 10,
        };

        public static int GetNumberByWord(string numberWord)
        {
            if (Enum.IsDefined(typeof(Medidata.RBT.Constants.NumberWord), numberWord))
                return (int)(Medidata.RBT.Constants.NumberWord)Enum.Parse(typeof(Medidata.RBT.Constants.NumberWord), numberWord.ToLower(), true);
            else
                throw new Exception("No matching number word!");
        }
        public static int GetZeroBasedIndexByWord(string numberWord) 
        {
            return GetNumberByWord(numberWord) - 1; //Offset by one ('first' is actually the 0th element)
        }
    }
}
