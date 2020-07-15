using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using BogdiEats.Model;
using System.Collections.ObjectModel;
using BogdiEats.Model.BusinessLogicLayer;
using BogdiEats.ViewModels.Commands;

namespace BogdiEats.ViewModels
{
    class UserVM : BasePropertyChanged
    {
        UserBLL userBLL = new UserBLL();


        private ICommand addCommand;
        public ICommand AddCommand
        {
            get
            {
                if (addCommand == null)
                {
                    addCommand = new RelayCommand<User>(userBLL.AddUser);
                }
                return addCommand;
            }
        }
    }
}
