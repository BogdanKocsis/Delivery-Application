using System.Data.SqlClient;


namespace BogdiEats.Model
{
    class UserDAL
    {
        private SqlConnection conn;
        private SqlCommand command;

        public UserDAL()
        {
            conn = Connection.GetConnection();
        }

        public void AddUser(User user)
        {

            try
            {
                conn.Open();
                command = new SqlCommand("InsertUser", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@name", user.Name);
                SqlParameter param2 = new SqlParameter("@phoneNo", user.PhoneNo);
                SqlParameter param3 = new SqlParameter("@address", user.Address);
                SqlParameter param4 = new SqlParameter("@email", user.Email);
                SqlParameter param5 = new SqlParameter("@password", user.Password);
                command.Parameters.Add(param1);
                command.Parameters.Add(param2);
                command.Parameters.Add(param3);
                command.Parameters.Add(param4);
                command.Parameters.Add(param5);

                command.ExecuteNonQuery();
  


                conn.Close();
            }
            catch (SqlException)
            {


            }


        }
    }
}
