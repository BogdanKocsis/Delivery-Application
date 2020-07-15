using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace BogdiEats.Model
{
    class TransactionModel
    {
        //object class Connection
        private SqlConnection conn;
        private SqlCommand command, command1;

        //declare variable
        int threshold = Convert.ToInt32(ConfigurationManager.AppSettings["DiscountThreshold"]);
        int discount = Convert.ToInt32(ConfigurationManager.AppSettings["Discount"]);
        int ordersNo = Convert.ToInt32(ConfigurationManager.AppSettings["OrdersNo"]);
        int deliverythreshold = Convert.ToInt32(ConfigurationManager.AppSettings["DeliveryThreshold"]);
        int deliveryfee = Convert.ToInt32(ConfigurationManager.AppSettings["DeliveryFee"]);
        DateTime startDate = Convert.ToDateTime(ConfigurationManager.AppSettings["StartDate"]);
        DateTime endDate = Convert.ToDateTime(ConfigurationManager.AppSettings["EndDate"]);

        //constructor 
        public TransactionModel()
        {
            conn = Connection.GetConnection();
        }


        private DateTime _date;
        private int total;
        private string payment_method;




        public void SetTotal(int data)
        {
            total = data;
        }


        public void SetMetode(string data)
        {
            payment_method = data;
        }
        public void SetDate(DateTime data)
        {
            _date = data;
        }


        public int InsertTransaction()
        {
            int id;
            int? nrOrders=0;
            DataSet transactions = new DataSet();
            DataSet ids = new DataSet();

            try
            {
                //add in  orders data table
                conn.Open();
                command = new SqlCommand("GetIDUser", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                SqlParameter param = new SqlParameter("@name", Globals.username);

                command.Parameters.Add(param);
                command.ExecuteNonQuery();
                SqlDataAdapter sda = new SqlDataAdapter(command);
                sda.Fill(ids, "Menu");
                int idUser = int.Parse(ids.Tables[0].Rows[0]["IDUser"].ToString());
                conn.Close();

                try
                {
                    conn.Open();
                    command = new SqlCommand("LoyalUsers", conn)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    SqlParameter param8 = new SqlParameter("@iduser", idUser);
                    SqlParameter date1 = new SqlParameter("@Start", startDate);
                    SqlParameter date2 = new SqlParameter("@End", endDate);
                    //SqlParameter param9 = new SqlParameter("@name", Globals.username); de adaugat datele din fis
                    SqlParameter countOrders = new SqlParameter("@users", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(param8);
                    command.Parameters.Add(date1);
                    command.Parameters.Add(date2);
                    command.Parameters.Add(countOrders);
                    command.ExecuteNonQuery();

                    nrOrders = countOrders.Value as int?;
                    conn.Close();
                }
                catch (SqlException)
                {
                }

                
                conn.Open();

                command1 = new SqlCommand("InsertOrder", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                SqlParameter param1 = new SqlParameter("@iduser", idUser);
                SqlParameter param2 = new SqlParameter("@date", _date.ToString("yyyy-MM-dd HH:mm:ss"));
                SqlParameter param3 = new SqlParameter("@status", "Registered");
                SqlParameter param4 = new SqlParameter("@payment", payment_method);


                if (total > threshold)
                    total -= discount / 100 * total;

                if (total < deliverythreshold)
                    total += deliveryfee;

                if ((int)nrOrders > ordersNo)
                {
                    total -= discount / 100 * total;
                }
                SqlParameter param5 = new SqlParameter("@total", total);

                SqlParameter paramIdOrder = new SqlParameter("@idorder", SqlDbType.Int)
                {
                    Direction = ParameterDirection.Output
                };
                command1.Parameters.Add(param1);
                command1.Parameters.Add(param2);
                command1.Parameters.Add(param3);
                command1.Parameters.Add(param4);
                command1.Parameters.Add(param5);
                command1.Parameters.Add(paramIdOrder);
                command1.ExecuteNonQuery();
                int? idorder = paramIdOrder.Value as int?;


                sda.Fill(transactions, "transaction");
                conn.Close();

                return (int)(idorder);
            }
            catch (SqlException)
            {
                id = 0;
            }
            return id;
        }

    }
}
