using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Windows.Controls;
using System.Windows;

using System.Windows.Navigation;
using System.Data.SqlClient;
using BogdiEats.Model;
using System.Configuration;

namespace BogdiEats.Controller
{
    class HomeController
    {
        //declar view dan model
        private SqlConnection conn;
        private SqlCommand command, command1;
        private View.Home vHome;
        private Model.CategoryModel mCategory;
        private Model.MenuModel mMenu;
        int mealDicount = Convert.ToInt32(ConfigurationManager.AppSettings["MealDiscount"]);

        //constructor
        public HomeController(View.Home vHome)
        {
            conn = Connection.GetConnection();
            // call model
            this.vHome = vHome;
            mCategory = new Model.CategoryModel();
            mMenu = new Model.MenuModel();

            // load categories and menu
            ShowCategory();
            ShowMenu(1);
        }

        public void ShowCategory()
        {

            DataSet dataSet = mCategory.SelectCategory();

            foreach (DataTable table in dataSet.Tables)
            {
                foreach (DataRow row in table.Rows)
                {
                    int id = int.Parse(row["IDCategory"].ToString());
                    string name = row["Name"].ToString();

                    View.Module.ItemCategory iCategory = new View.Module.ItemCategory(id, name);
                    Grid.SetColumn(iCategory, id-1);
                    vHome.gridCategory.Children.Add(iCategory);
                }
            }

            vHome.ActivateCategory();
        }

        public void ShowMenu(int id_category, String searchField = "", String allergenField = "")
        {
            DataSet dataSet;
            if (searchField.Length > 0)
                dataSet = mMenu.SelectMenu(id_category, searchField);
            else
                 if (allergenField.Length > 0)
                dataSet = mMenu.SelectMenu(id_category, "", allergenField);
            else
                dataSet = mMenu.SelectMenu(id_category);

            vHome.gridMenu.Children.Clear();

            foreach (DataTable table in dataSet.Tables)
            {
                int index = 0;
                foreach (DataRow row in table.Rows)
                {

                    int id = int.Parse(row["IDProduct"].ToString());
                    string name = row["Name"].ToString();
                    string foto = row["ImagePath"].ToString();
                    float price = 0;
                    String quantity = "";
                    if (id_category == 7)
                    {
                        DataSet daftarmenu = new DataSet();
                        conn.Open();
                        command = new SqlCommand("GetMealPrice_Quantity", conn);
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlParameter paramId = new SqlParameter("@IDMenu", id);
                        command.Parameters.Add(paramId);
                        command.ExecuteNonQuery();
                        SqlDataAdapter sda = new SqlDataAdapter(command);
                        sda.Fill(daftarmenu, "Menu");

                        foreach (DataTable table1 in daftarmenu.Tables)
                        {
                            
                           
                            foreach (DataRow row1 in table1.Rows)
                            {
                                price += float.Parse(row1["Price"].ToString());
                                price = price - mealDicount * price / 100;
                                quantity = quantity + row1["Meal_Quantity"].ToString() + ",";
                               

                            }
                            
                        }

                        command1 = new SqlCommand("SetMealPrice_Quantity", conn);
                        command1.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlParameter idmenu = new SqlParameter("@iditem", id);
                        SqlParameter value = new SqlParameter("@price", price);
                        SqlParameter quantities = new SqlParameter("@qty", quantity);
                        command1.Parameters.Add(idmenu);
                        command1.Parameters.Add(value);
                        command1.Parameters.Add(quantities);
                        command1.ExecuteNonQuery();
                        conn.Close();
                    }
                    else
                        price = int.Parse(row["Price"].ToString());

                    View.Module.ItemMenu iMenu = new View.Module.ItemMenu(id, name, price, foto);

                    int posisiColumn = index % 5;
                    double posisiBaris = index / 5;

                    Grid.SetColumn(iMenu, posisiColumn);
                    Grid.SetRow(iMenu, (int)posisiBaris);

                    vHome.gridMenu.Children.Add(iMenu);

                    index++;
                }
            }

            vHome.ActivateMenu();
        }

        public void LoadMenuDetail(int id_menu)
        {
            DataSet dataSet = mMenu.SelectDetailMenu(id_menu);
            DataRow row = dataSet.Tables[0].Rows[0];
            View.Detail menuDetail = new View.Detail(row, vHome);
            vHome.frmDetail.Content = menuDetail;
        }
    }
}
