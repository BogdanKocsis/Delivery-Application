using System;
using System.Data.SqlClient;


namespace BogdiEats.Model
{
    class Connection
    {
        private static SqlConnection conn;
       
        public static SqlConnection GetConnection()
        {
            try
            {
                conn = new SqlConnection("Data Source=DESKTOP-0HLIQPU\\SQLEXPRESS;" +
                "Initial Catalog=food;" +
                "Integrated Security=true");
                return conn;
            }
            catch (System.Exception err)
            {
                throw err;
            }
        }
    }
}
