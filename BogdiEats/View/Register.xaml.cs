using System;
using System.Windows;
using BogdiEats.Model;
using BogdiEats.Exception;

namespace BogdiEats.View
{
    /// <summary>
    /// Interaction logic for Register.xaml
    /// </summary>
    public partial class Register : Window
    {


        UserDAL userDAL = new UserDAL();

        public Register()
        {
            InitializeComponent();



        }
        //close window function
        private void Close_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        //extract data from register form and create an user
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            User user = new User();

            if (String.IsNullOrEmpty(name.Text))
            {
                throw new UserExceptions("Name must be mentioned");
            }
            if (String.IsNullOrEmpty(address.Text))
            {
                throw new UserExceptions("Address must be mentioned");
            }
            if (String.IsNullOrEmpty(phoneNo.Text))
            {
                throw new UserExceptions("Phone Number must be mentioned");
            }
            if (String.IsNullOrEmpty(email.Text))
            {
                throw new UserExceptions("Email must be mentioned");
            }
            if (String.IsNullOrEmpty(passwordfield.Password))
            {
                throw new UserExceptions("Password must be mentioned");
            }
            user.Name = name.Text;
            user.Address = address.Text;
            user.PhoneNo = phoneNo.Text;
            user.Email = email.Text;
            user.Password = passwordfield.Password;

            userDAL.AddUser(user);
            succeed.Content = "Successful Registration";
        }
    }
}
