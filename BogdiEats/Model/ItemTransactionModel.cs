using System;
using System.Data;
using System.Data.SqlClient;

namespace BogdiEats.Model
{
    class ItemTransactionModel
    {
        //object class Connection
        private SqlConnection conn;
        private SqlCommand command;

        //declare variable

        private bool boolean;

        //constructor 
        public ItemTransactionModel()
        {
            conn = Connection.GetConnection();
        }

        //declare attribute

        private int id_menu;
        private int id_transaction;


        private int qty;

 
        public void SetId_menu(int data)
        {
            id_menu = data;
        }

        public void SetId_transanction(int data)
        {
            id_transaction = data;
        }



        public void SetQty(int data)
        {
            qty = data;
        }



      

        //insert in basket data table

        public Boolean InsertItemTransaksi()
        {
            try
            {



                conn.Open();
                command = new SqlCommand("InsertInBasket", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                SqlParameter param = new SqlParameter("@iduser", id_transaction);
                SqlParameter param1 = new SqlParameter("@idproduct", id_menu);
                SqlParameter param2 = new SqlParameter("@qty", qty);
                command.Parameters.Add(param);
                command.Parameters.Add(param1);
                command.Parameters.Add(param2);
                command.ExecuteNonQuery();
  
                conn.Close();
                UpdateItemTransaksi();
            }
            catch (SqlException err)
            {
                boolean = false;
                Console.WriteLine(err);
          
            }
            return boolean;
        }

        //update

        public Boolean UpdateItemTransaksi()
        {
            boolean = false;
            try
            {
                if (id_menu < 47)
                {
                    conn.Open();
                    command = new SqlCommand("UpdateQuantity", conn)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    SqlParameter param = new SqlParameter("@iditem", id_menu);
                    SqlParameter param5 = new SqlParameter("@total",qty);

                    // vedem daca gasim solutie mai buna
                    // de actualizat cantitatea cand e meniu


                    command.Parameters.Add(param);
                    command.Parameters.Add(param5);

                    command.ExecuteNonQuery();

                    conn.Close();
                }
                else
                {
                    DataSet daftarmenu = new DataSet();
                    conn.Open();
                    command = new SqlCommand("GetProductFromMenu", conn)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    SqlParameter param = new SqlParameter("@IDMenu", id_menu);
                 
                    command.Parameters.Add(param);

                    command.ExecuteNonQuery();
                    SqlDataAdapter sda = new SqlDataAdapter(command);
                    sda.Fill(daftarmenu, "Menu");
                    conn.Close();

                    int totalqty = 0;
                    foreach (DataTable table1 in daftarmenu.Tables)
                    {
                        foreach (DataRow row1 in table1.Rows)
                        {
                            int id = int.Parse(row1["IDProduct"].ToString());
                          
                            totalqty+= int.Parse(row1["Meal_Quantity"].ToString());
                            //int mealqty = int.Parse(row1["Meal_Quantity"].ToString());
                            conn.Open();
                            command = new SqlCommand("UpdateMealQuantity", conn)
                            {
                                CommandType = System.Data.CommandType.StoredProcedure
                            };
                            SqlParameter param1 = new SqlParameter("@iditem", id);
                            SqlParameter param6 = new SqlParameter("@total",qty);
                            // vedem daca gasim solutie mai buna
                            // de actualizat cantitatea cand e meniu


                            command.Parameters.Add(param1);
                            command.Parameters.Add(param6);
                            command.ExecuteNonQuery();

                            conn.Close();

                        }



                    }
                    conn.Open();
                    command = new SqlCommand("UpdateQuantity2", conn)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    SqlParameter param2 = new SqlParameter("@iditem", id_menu);
                    SqlParameter param3 = new SqlParameter("@qty", qty*totalqty);



                    command.Parameters.Add(param2);
                    command.Parameters.Add(param3);

                    command.ExecuteNonQuery();

                    conn.Close();
                }

            }
            catch (SqlException)
            {
                boolean = false;
            }
            return boolean;
        }



    }
}
