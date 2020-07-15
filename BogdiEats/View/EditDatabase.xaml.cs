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
    /// Interaction logic for EditDatabase.xaml
    /// </summary>
    public partial class EditDatabase : Page
    {
        private SqlConnection conn;
        private SqlCommand command, command1;
        public string _categoryString = "Noodles";
        public string _allergenString = "None";
        public EditDatabase()
        {
            InitializeComponent();
            conn = Connection.GetConnection();
        }

        // back to home
        private void BtnBackToHome_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Home()); 
        }

        //add allergen function
        private void AddAllergen_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("InsertAllergen", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter param1;
                if (String.IsNullOrEmpty(txtAllergen.Text))
                {
                    param1 = new SqlParameter("@name", DBNull.Value);
                }
                else
                {
                    param1 = new SqlParameter("@name", txtAllergen.Text);
                }
                command.Parameters.Add(param1);
                command.ExecuteNonQuery();

                conn.Close();
                MessageBox.Show("Data Introduced");
                txtAllergen.Text = "";
            }
            catch (SqlException)
            {
                conn.Close();
            }
        }

        //delete allergen function
        private void DeleteAllergen_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("DeleteAllergen", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@name", txtAllergen.Text);
                command.Parameters.Add(param1);
                command.ExecuteNonQuery();

                conn.Close();
                MessageBox.Show("Data Deleted");
                txtAllergen.Text = "";
            }
            catch (SqlException)
            {
                conn.Close();
            }

        }

        //delete category function
        private void DeleteCategory_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("DeleteCategory", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@name", txtCategory.Text);
                command.Parameters.Add(param1);
                command.ExecuteNonQuery();

                conn.Close();
                MessageBox.Show("Data Deleted");
                txtCategory.Text = "";

            }
            catch (SqlException)
            {
                conn.Close();
            }

        }

        //add category function
        private void AddCategory_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("InsertCategory", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1;
                if (String.IsNullOrEmpty(addCategory.Content.ToString()))
                {
                    param1 = new SqlParameter("@name", DBNull.Value);
                }
                else
                {
                    param1 = new SqlParameter("@name", txtCategory.Text);
                }

                command.Parameters.Add(param1);
                command.ExecuteNonQuery();

                conn.Close();
                MessageBox.Show("Data Introduced");
                txtCategory.Text = "";

            }
            catch (SqlException)
            {
                conn.Close();
            }

        }

        //add product function
        private void AddProduct_Click(object sender, RoutedEventArgs e)
        {



            try
            {
                conn.Open();
                SqlDataAdapter sda1 = new SqlDataAdapter(command1);
                command1 = new SqlCommand("GetCategory", conn);
                command1.CommandType = System.Data.CommandType.StoredProcedure;


                SqlParameter param;

                param = new SqlParameter("@name", _categoryString);

                command1.Parameters.Add(param);
                SqlParameter paramIdCategory = new SqlParameter("@idcategory", SqlDbType.Int);
                paramIdCategory.Direction = ParameterDirection.Output;

                command1.Parameters.Add(paramIdCategory);
                command1.ExecuteNonQuery();
                int? idcategory = paramIdCategory.Value as int?;

                conn.Close();
                conn.Open();

                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("InsertProduct", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter param1, param2, param3, param4, param5, param6, param7, param8;
                if (String.IsNullOrEmpty(txtProduct.Text))
                {
                    param1 = new SqlParameter("@name", DBNull.Value);
                }
                else
                {
                    param1 = new SqlParameter("@name", txtProduct.Text);
                }
                param2 = new SqlParameter("@imagepath", imageName.Text);
                param3 = new SqlParameter("@description", description.Text);
                if (String.IsNullOrEmpty(Price.Text))
                {
                    param4 = new SqlParameter("@price", DBNull.Value);
                }
                else
                {
                    param4 = new SqlParameter("@price", float.Parse(Price.Text));
                }
                if (String.IsNullOrEmpty(TotalQty.Text))
                {
                    param5 = new SqlParameter("@totalqty", DBNull.Value);
                }
                else
                {
                    param5 = new SqlParameter("@totalqty", int.Parse(TotalQty.Text));
                }

                if (String.IsNullOrEmpty(PortionQty.Text))
                {
                    param6 = new SqlParameter("@portionqty", DBNull.Value);
                }
                else
                {
                    param6 = new SqlParameter("@portionqty", int.Parse(PortionQty.Text));
                }



                param7 = new SqlParameter("@category", (int)idcategory);


                if (String.IsNullOrEmpty(MealQty.Text))
                {
                    param8 = new SqlParameter("@mealqty", DBNull.Value);
                }
                else
                {
                    param8 = new SqlParameter("@mealqty", int.Parse(MealQty.Text));
                }

                SqlParameter paramIDProduct = new SqlParameter("@idproduct", SqlDbType.Int);
                paramIDProduct.Direction = ParameterDirection.Output;

                command.Parameters.Add(param1);
                command.Parameters.Add(param2);
                command.Parameters.Add(param3);
                command.Parameters.Add(param4);
                command.Parameters.Add(param5);
                command.Parameters.Add(param6);
                command.Parameters.Add(param7);
                command.Parameters.Add(param8);
                command.Parameters.Add(paramIDProduct);


                command.ExecuteNonQuery();
                int? idproduct = paramIDProduct.Value as int?;
                conn.Close();
                if (_allergenString == "None")
                {
                    //param9 = new SqlParameter("@mealqty", DBNull.Value);
                }
                else
                {
                    try
                    {
                        conn.Open();

                        sda = new SqlDataAdapter(command);
                        command = new SqlCommand("GetAllergenID", conn);
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlParameter paramName = new SqlParameter("@name", _allergenString);
                        SqlParameter paramIdAllergen = new SqlParameter("@id", SqlDbType.Int);
                        paramIdAllergen.Direction = ParameterDirection.Output;
                        command.Parameters.Add(paramName);
                        command.Parameters.Add(paramIdAllergen);
                        command.ExecuteNonQuery();

                        int? idallergen = paramIdAllergen.Value as int?;
                        conn.Close();

                        conn.Open();

                        sda = new SqlDataAdapter(command);
                        command = new SqlCommand("InsertProductAllergen", conn);
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlParameter paramID1 = new SqlParameter("@idproduct", (int)idproduct);
                        SqlParameter paramID2 = new SqlParameter("@idallergen", (int)idallergen);
                        command.Parameters.Add(paramID1);
                        command.Parameters.Add(paramID2);
                        command.ExecuteNonQuery();
                        conn.Close();
                    }
                    catch (SqlException)
                    {
                        conn.Close();
                    }
                }
                MessageBox.Show("Data Inserted");

            }
            catch (SqlException)
            {
                conn.Close();
            }


        }

        //edit product function (Price or Total Qty)
        private void EditProduct_Click(object sender, RoutedEventArgs e)
        {
            try
            {


                if (!String.IsNullOrEmpty(Price.Text))
                {
                    conn.Open();
                    SqlParameter param = new SqlParameter("@price", float.Parse(Price.Text));
                    SqlParameter paramId = new SqlParameter("@name", txtProduct.Text);
                    SqlDataAdapter sda = new SqlDataAdapter(command);
                    command = new SqlCommand("UpdatePrice", conn);
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    command.Parameters.Add(param);
                    command.Parameters.Add(paramId);
                    command.ExecuteNonQuery();
                    conn.Close();
                }
                else

                if (!String.IsNullOrEmpty(TotalQty.Text))
                {
                    conn.Open();
                    SqlParameter param = new SqlParameter("@qty", int.Parse(TotalQty.Text));
                    SqlParameter paramId = new SqlParameter("@name", txtProduct.Text);
                    SqlDataAdapter sda = new SqlDataAdapter(command);
                    command = new SqlCommand("UpdateTotalQuantity", conn);
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    command.Parameters.Add(param);
                    command.Parameters.Add(paramId);
                    command.ExecuteNonQuery();
                    conn.Close();
                }

                MessageBox.Show("Data Edited");

            }
            catch (SqlException)
            {
                conn.Close();
            }



        }

        //create meal function
        private void AddMeal_Click(object sender, RoutedEventArgs e)
        {

            conn.Open();
            SqlDataAdapter sda = new SqlDataAdapter(command);
            command = new SqlCommand("GetIDProduct", conn);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@name", txtProduct.Text);
            SqlParameter paramIdProduct = new SqlParameter("@id", SqlDbType.Int);
            paramIdProduct.Direction = ParameterDirection.Output;

            command.Parameters.Add(param1);
            command.Parameters.Add(paramIdProduct);
            command.ExecuteNonQuery();
            int? idproduct = paramIdProduct.Value as int?;

            conn.Close();

            if (!String.IsNullOrEmpty(product1.Text) && !String.IsNullOrEmpty(product2.Text))
            {
                conn.Open();
                SqlParameter param = new SqlParameter("@idmeal", (int)idproduct);
                SqlParameter paramId = new SqlParameter("@name", product1.Text);
                sda = new SqlDataAdapter(command);
                command = new SqlCommand("CreateMeal", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add(param);
                command.Parameters.Add(paramId);
                command.ExecuteNonQuery();
                conn.Close();
                conn.Open();

                param = new SqlParameter("@idmeal", (int)idproduct);
                paramId = new SqlParameter("@name", product2.Text);
                sda = new SqlDataAdapter(command);
                command = new SqlCommand("CreateMeal", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add(param);
                command.Parameters.Add(paramId);
                command.ExecuteNonQuery();
                conn.Close();
            }
            MessageBox.Show("Meal Created");

        }

        //delete product function
        private void DeleteProduct_Click(object sender, RoutedEventArgs e)
        {

            try
            {
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(command);
                command = new SqlCommand("DeleteProduct", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter param1;
                if (String.IsNullOrEmpty(txtProduct.Text))
                {
                    param1 = new SqlParameter("@name", DBNull.Value);
                }
                else
                {
                    param1 = new SqlParameter("@name", txtProduct.Text);
                }
                command.Parameters.Add(param1);
                command.ExecuteNonQuery();

                conn.Close();
                MessageBox.Show("Data Deleted");

            }
            catch (SqlException)
            {
                conn.Close();
            }


        }
        private void Combo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedItem = sender as System.Windows.Controls.ComboBox;
            _categoryString = selectedItem.SelectedItem as String;
        }
        private void ComboBox_Loaded(object sender, RoutedEventArgs e)
        {
            List<String> data = new List<string>();
            DataSet _set = new DataSet();

            conn.Open();

            SqlDataAdapter sda = new SqlDataAdapter(command1);
            command1 = new SqlCommand("GetCategories", conn)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };

            command1.ExecuteNonQuery();
            sda = new SqlDataAdapter(command1);
            sda.Fill(_set, "Categories");

            foreach (DataTable table1 in _set.Tables)
            {
                foreach (DataRow row1 in table1.Rows)
                {

                    data.Add(row1["Name"].ToString());
                }


            }
            conn.Close();


            var combo = sender as System.Windows.Controls.ComboBox;
            combo.ItemsSource = data;
            combo.SelectedIndex = 0;


        }
        private void Combo_SelectionChanged1(object sender, SelectionChangedEventArgs e)
        {
            var selectedItem = sender as System.Windows.Controls.ComboBox;
            _allergenString = selectedItem.SelectedItem as String;
        }
        private void ComboBox_Loaded1(object sender, RoutedEventArgs e)
        {
            List<String> data = new List<string>();
            DataSet _set = new DataSet();
            data.Add("None");
            conn.Open();

            SqlDataAdapter sda = new SqlDataAdapter(command1);
            command1 = new SqlCommand("GetAllAlergens", conn)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };

            command1.ExecuteNonQuery();
            sda = new SqlDataAdapter(command1);
            sda.Fill(_set, "Allergens");

            foreach (DataTable table1 in _set.Tables)
            {
                foreach (DataRow row1 in table1.Rows)
                {

                    data.Add(row1["Name"].ToString());
                }


            }
            conn.Close();


            var combo1 = sender as System.Windows.Controls.ComboBox;
            combo1.ItemsSource = data;
            combo1.SelectedIndex = 0;


        }
    }
}
