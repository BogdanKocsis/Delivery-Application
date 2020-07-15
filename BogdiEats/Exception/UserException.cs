using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BogdiEats.Exception
{
    class UserExceptions : ApplicationException
    {
        public UserExceptions(string message)
            : base(message)
        {
        }
    }
}
