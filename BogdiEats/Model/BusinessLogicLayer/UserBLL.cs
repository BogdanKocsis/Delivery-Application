using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BogdiEats.Exception;

namespace BogdiEats.Model.BusinessLogicLayer
{
    class UserBLL
    {
        UserDAL userDAL = new UserDAL();
        internal void AddUser(User user)
        {
            if (String.IsNullOrEmpty(user.Name))
            {
                throw new UserExceptions("Numele persoanei trebuie sa fie precizat");
            }
            userDAL.AddUser(user);
           
        }

    }
}
