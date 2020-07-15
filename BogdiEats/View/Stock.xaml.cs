using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using BogdiEats.Model;

namespace BogdiEats.View
{
    /// <summary>
    /// Interaction logic for Stock.xaml
    /// </summary>
    public partial class Stock : Page
    {
        private SqlConnection conn;
        private SqlCommand command;
        int minimumQty = Convert.ToInt32(ConfigurationManager.AppSettings["MinimumQuantity"]);
        public Stock()
        {
            InitializeComponent();
            conn = Connection.GetConnection();
            binddatagrid();
        }

        //display product with quantity unded minimumQty
        private void binddatagrid()
        {
           
            DataSet dataset = new DataSet();
            DataTable dt = new DataTable("Orders");
                     try
            {
                conn.Open();

                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("GetProductStock", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@value", minimumQty); 
                command.Parameters.Add(param1);
                command.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter(command);
                da.Fill(dataset, "Menu");
                da.Fill(dt);

                g1.ItemsSource = dt.DefaultView;



                conn.Close();
            }
            catch (SqlException)
            {
                conn.Close();
            }

        }
        private void btnBackToHome_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }

    }
}
