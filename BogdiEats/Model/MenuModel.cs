using System;
using System.Data;
using System.Data.SqlClient;

namespace BogdiEats.Model
{
    class MenuModel
    {
        //object class Connection
        private SqlConnection conn;
        private SqlCommand command, command1, command2;



        //constructor 
        public MenuModel()
        {
            conn = Connection.GetConnection();
        }

        //declare attribute
        private String allergens = " ";





        // The function displays all products by category
        public DataSet SelectMenu(int id_category, String searchField = "", String allergenField = "")
        {
            DataSet daftarmenu = new DataSet();
            try
            {
                conn.Open();
                if (searchField.Length > 0)
                {
                    command = new SqlCommand("GetMenuWithSearch", conn)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    SqlParameter paramId = new SqlParameter("@IDCategory", id_category);
                    SqlParameter param2 = new SqlParameter("@SearchField", searchField);
                    command.Parameters.Add(paramId);
                    command.Parameters.Add(param2);
                    command.ExecuteNonQuery();

                }
                else
                if (allergenField.Length > 0)
                {
                    command = new SqlCommand("GetProductWithoutAllergen", conn)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    SqlParameter paramId = new SqlParameter("@IDCategory", id_category);
                    SqlParameter param2 = new SqlParameter("@AllergenFiend", allergenField);
                    command.Parameters.Add(paramId);
                    command.Parameters.Add(param2);
                    command.ExecuteNonQuery();
                }
                else
                {
                    command = new SqlCommand("GetMenu", conn)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    SqlParameter paramId = new SqlParameter("@IDCategory", id_category);
                    command.Parameters.Add(paramId);
                    command.ExecuteNonQuery();

                }

                SqlDataAdapter sda = new SqlDataAdapter(command);
                sda.Fill(daftarmenu, "Menu");
                conn.Close();
            }
            catch (SqlException)
            {

            }
            return daftarmenu;
        }

        // The function displays the product details

        public DataSet SelectDetailMenu(int id_menu)
        {
            DataSet detailmenu = new DataSet();
            DataSet allergensTable = new DataSet();
            try
            {
                conn.Open();


                SqlDataAdapter sda = new SqlDataAdapter(command1);
                command1 = new SqlCommand("GetAllergens", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                SqlParameter param = new SqlParameter("@IDProduct", id_menu);
                command1.Parameters.Add(param);
                command1.ExecuteNonQuery();
                sda = new SqlDataAdapter(command1);
                sda.Fill(allergensTable, "Menu");

                foreach (DataTable table1 in allergensTable.Tables)
                {
                    foreach (DataRow row1 in table1.Rows)
                    {

                        allergens = allergens + row1["Name"].ToString() + ",";
                    }



                }
                command2 = new SqlCommand("SetAllergens", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                SqlParameter param1 = new SqlParameter("@IDMenu", id_menu);
                SqlParameter param2 = new SqlParameter("@allergens", allergens);

                command2.Parameters.Add(param1);
                command2.Parameters.Add(param2);
                command2.ExecuteNonQuery();
                allergens = "";
                command = new SqlCommand("SelectDetailProduct", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                SqlParameter paramId = new SqlParameter("@IDProduct", id_menu);
                command.Parameters.Add(paramId);
                command.ExecuteNonQuery();
                sda = new SqlDataAdapter(command);

                sda.Fill(detailmenu, "Menu");


                conn.Close();
            }
            catch (SqlException)
            {

            }
            return detailmenu;
        }

       


    }
}
