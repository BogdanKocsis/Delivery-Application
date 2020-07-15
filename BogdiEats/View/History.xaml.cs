using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using BogdiEats.Model;

namespace BogdiEats.View
{
    /// <summary>
    /// Interaction logic for History.xaml
    /// </summary>
    public partial class History : Page
    {
        private SqlConnection conn;
        private SqlCommand command, command1;
        public History()
        {
            InitializeComponent();
            conn = Connection.GetConnection();
            Binddatagrid();
            Binddatagrid1();
        }

        //display orders which have as status 'delivered' or 'canceled'
        private void Binddatagrid()
        {
            DataSet products = new DataSet();
            DataSet dataset = new DataSet();
            DataTable dt = new DataTable("Orders");
            List<string> productsOrder = new List<string>();
            try
            {
                conn.Open();

                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("GetUserHistory", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@username", Globals.username);
                command.Parameters.Add(param1);
                command.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter(command);
                da.Fill(dataset, "Menu");
                da.Fill(dt);

                g1.ItemsSource = dt.DefaultView;
                dt.Columns.Add("Products", typeof(String));
                dt.Columns.Add("Delivery_Fee", typeof(int));

                dt.Columns.Add("Delivery_Time", typeof(String));
                foreach (DataTable table1 in dataset.Tables)
                {
                    foreach (DataRow row1 in table1.Rows)
                    {
                        int idorder = int.Parse(row1["IDOrder"].ToString());

                        command1 = new SqlCommand("GetUserProducts", conn);
                        command1.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlParameter param = new SqlParameter("@username", Globals.username);
                        SqlParameter param2 = new SqlParameter("@idorder", idorder);
                        command1.Parameters.Add(param);
                        command1.Parameters.Add(param2);
                        command1.ExecuteNonQuery();
                        sda = new SqlDataAdapter(command1);
                        sda.Fill(products, "Products");
                        string _products = "";

                        foreach (DataTable table2 in products.Tables)
                        {
                            foreach (DataRow row2 in table2.Rows)
                            {

                                _products = _products + row2["Name"].ToString() + "(" + row2["Quantity"].ToString() + ") ";

                            }



                        }
                        products.Clear();
                        productsOrder.Add(_products);
                        _products = "";
                    }



                }


                int i = 0;
                foreach (DataRow row in dt.Rows)
                {
                    //need to set value to NewColumn column
                    row["Products"] = productsOrder[i];
                    i++;
                    if (int.Parse(row["Total"].ToString()) < 100)
                        row["Delivery_Fee"] = 15;
                    else
                        row["Delivery_Fee"] = 0;
                    row["Delivery_Time"] = "45'";
                }

                conn.Close();
            }
            catch (SqlException)
            {
                conn.Close();
            }

        }
        //display active orders
        private void Binddatagrid1()
        {

            DataSet dataset = new DataSet();
            DataTable dt = new DataTable("Orders");
            try
            {
                conn.Open();

                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("GetActiveOrders", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@username", Globals.username);
                command.Parameters.Add(param1);
                command.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter(command);
                da.Fill(dataset, "Menu");
                da.Fill(dt);

                g2.ItemsSource = dt.DefaultView;
                dt.Columns.Add("Cancel Order", typeof(String));

                dt.Columns.Add("Delivery_Fee", typeof(int));
                dt.Columns.Add("Delivery_Time", typeof(String));

                foreach (DataRow row in dt.Rows)
                {
                    //need to set value to NewColumn column

                    if (int.Parse(row["Total"].ToString()) < 100)
                        row["Delivery_Fee"] = 15;
                    else
                        row["Delivery_Fee"] = 0;
                    row["Delivery_Time"] = "45'";
                }

                conn.Close();
            }
            catch (SqlException)
            {
                conn.Close();
            }


        }

        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                conn.Open();
                DataRowView dataRowView = (DataRowView)((Button)e.Source).DataContext;
                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("CancelOrder", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@idorder", int.Parse(dataRowView[0].ToString()));
                command.Parameters.Add(param1);
                command.ExecuteNonQuery();



                conn.Close();
                Binddatagrid1();
                Binddatagrid();
            }
            catch (SqlException)
            {
                conn.Close();
            }

        }

        private void btnBackToHome_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Home());
        }
    }



}
