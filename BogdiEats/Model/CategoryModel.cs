using System.Data;
using System.Data.SqlClient;

namespace BogdiEats.Model
{
    class CategoryModel
    {
        //object class Connection
        private SqlConnection conn;
        private SqlCommand command;

        //constructor 
        public CategoryModel()
        {
            conn = Connection.GetConnection();
        }

        //function displays categories
        public DataSet SelectCategory()
        {
            DataSet category = new DataSet();
            try
            {
                conn.Open();
                command = new SqlCommand("GetCategories", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter(command);
                sda.Fill(category, "Category");
                conn.Close();
            }
            catch (SqlException)
            {
                conn.Close();
            }
            return category;
        }



    }
}
