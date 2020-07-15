using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Media;
using System.Windows.Navigation;
using BogdiEats.Model;

namespace BogdiEats.View.Module
{
    /// <summary>
    /// Interaction logic for LogIn.xaml
    /// </summary>
    public partial class LogIn : UserControl
    {
        private SqlConnection conn;
        private SqlCommand command;
        public LogIn()
        {
            InitializeComponent();
            Register.Inlines.Clear();

            Hyperlink hyperlink = new Hyperlink()
            {
                NavigateUri = new Uri("https://github.com/BogdanKocsis")
            };

            hyperlink.Inlines.Add("    Don't have an account? Register");
            hyperlink.RequestNavigate += Hyperlink_RequestNavigate;
            Register.Inlines.Add(hyperlink);

            conn = Connection.GetConnection();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            

            Globals.username = email.Text;
            String password = passwordfield.Password;

            try
            {
                conn.Open();
                command = new SqlCommand("LogIn", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@Username", Globals.username);
                SqlParameter param2 = new SqlParameter("@Password", password);
                SqlParameter paramIsAdmin = new SqlParameter("@isadmin", SqlDbType.Int);
                paramIsAdmin.Direction = ParameterDirection.Output;
                SqlParameter paramIsTrue = new SqlParameter("@isTrue", SqlDbType.Int);
                paramIsTrue.Direction = ParameterDirection.Output;
                command.Parameters.Add(param1);
                command.Parameters.Add(param2);
                command.Parameters.Add(paramIsAdmin);
                command.Parameters.Add(paramIsTrue);
                command.ExecuteNonQuery();
              
                // sda = new SqlDataAdapter(command);
                //sda.Fill(daftarmenu, "Menu");
                int? isTrue = paramIsTrue.Value as int?;
                int? isAdmin = paramIsAdmin.Value as int?;
                if ((int)isTrue==1)
                {
                    incorrect.Content = "LoggIn Success";
                    var converter = new System.Windows.Media.BrushConverter();
                    var myBrush = (Brush)converter.ConvertFromString("#FF008000");
                    
                    incorrect.Foreground = myBrush;
                    Globals.isOk = true;
                    if ((int)(isAdmin) == 1)
                        Globals.isAdmin = true;
                    
                }
                else
                {
                    var converter = new System.Windows.Media.BrushConverter();
                    var myBrush = (Brush)converter.ConvertFromString("#FFFF0000");
                    incorrect.Foreground = myBrush;
                    incorrect.Content = "Incorrect Username or Password";
                }


                conn.Close();
            }
            catch (SqlException)
            {
                

            }
           
          
        }

        private void Hyperlink_RequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            System.Diagnostics.Process.Start(e.Uri.ToString());
        }

        private void Close_Click(object sender, RoutedEventArgs e)
        {
            Window.GetWindow(this).Close();
        }
    }
}
