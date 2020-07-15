using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace BogdiEats.Controller
{
    class ConnectionController
    {
        private Model.Connection connectionModel;


        public ConnectionController()
        {
            connectionModel = new Model.Connection();
        }
    }
}
