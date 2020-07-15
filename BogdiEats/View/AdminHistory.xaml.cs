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
    /// Interaction logic for AdminHistory.xaml
    /// </summary>
    public partial class AdminHistory : Page
    {
        private SqlConnection conn;
        private SqlCommand command, command1;
        public string _stateString = "Is Preparing";
        public AdminHistory()
        {


            InitializeComponent();

            conn = Connection.GetConnection();
            Binddatagrid();
            Binddatagrid1();


        }

        //display all order with status 'deliveres' or 'canceled' from database for admin
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
                command = new SqlCommand("GetHistory", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                command.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter(command);
                da.Fill(dataset, "Menu");
                da.Fill(dt);

                g1.ItemsSource = dt.DefaultView;
                dt.Columns.Add("Products", typeof(String));

                foreach (DataTable table1 in dataset.Tables)
                {
                    foreach (DataRow row1 in table1.Rows)
                    {
                        int idorder = int.Parse(row1["IDOrder"].ToString());


                        command1 = new SqlCommand("GetProducts", conn)
                        {
                            CommandType = System.Data.CommandType.StoredProcedure
                        };
                        SqlParameter param2 = new SqlParameter("@idorder", idorder);
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
                dt.Columns.Add("Delivery_Fee", typeof(int));
                dt.Columns.Add("Delivery_Time", typeof(String));


                int i = 0;
                foreach (DataRow row in dt.Rows)
                {
                    //need to set value to NewColumn column
                    row["Products"] = productsOrder[i];
                    i++;// or set it to some other value
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
        //display all active orders for admin
        private void Binddatagrid1()
        {

            DataSet dataset = new DataSet();
            DataTable dt = new DataTable("Orders");
            try
            {
                conn.Open();

                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("GetActiveOrdersForAdmin", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                command.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter(command);
                da.Fill(dataset, "Menu");
                da.Fill(dt);

                g2.ItemsSource = dt.DefaultView;
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


        //save status for order
        private void BtnStatus_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                conn.Open();
                DataRowView dataRowView = (DataRowView)((System.Windows.Controls.Button)e.Source).DataContext;
                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("UpdateStatus", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                SqlParameter param1 = new SqlParameter("@idorder", int.Parse(dataRowView[0].ToString()));
                SqlParameter param2 = new SqlParameter("@state", _stateString);
                command.Parameters.Add(param1);
                command.Parameters.Add(param2);
                command.ExecuteNonQuery();

                conn.Close();
                Binddatagrid();
                Binddatagrid1();
            }
            catch (SqlException)
            {
                conn.Close();
            }


        }

        private void Combo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedItem = sender as System.Windows.Controls.ComboBox;
            _stateString = selectedItem.SelectedItem as String;
        }

        private void ComboBox_Loaded(object sender, RoutedEventArgs e)
        {
            List<String> data = new List<string>
            {
                "Is Preparing",
                "Left to Customer",
                "Delivered"
            };



            var combo = sender as System.Windows.Controls.ComboBox;
            combo.ItemsSource = data;
            combo.SelectedIndex = 0;


        }

        private void BtnBackToHome_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }


    }

}

