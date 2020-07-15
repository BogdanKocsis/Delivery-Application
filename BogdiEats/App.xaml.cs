using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace BogdiEats
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    /// 

    public class CartItem
    {
        public int id_menu;
        public string name;
        public string foto;
        public int price;
        public int qty;
        public string description;
    }

    public static class CartitemList
    {
        public static List<CartItem> Content = new List<CartItem>();
    }


    public partial class App : Application
    {

    }
}
