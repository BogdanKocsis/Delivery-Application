using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace BogdiEats.View.Module
{

    /// <summary>
    /// Interaction logic for ItemCart.xaml
    /// </summary>
    public partial class ItemCart : UserControl
    {

        private int qty;
        private int index = 0;
        public ItemCart(int index)
        {
            InitializeComponent();
            this.index = index;
        }

        public void setQty(int qty)
        {
            lblQty.Content = qty.ToString();
            this.qty = qty;
        }

        public void updateCart()
        {
            // update cart total
            CartitemList.Content[index].qty = this.qty;

            // update the parent label
            Window parentWindow = Window.GetWindow(this);
            (parentWindow.Content as View.Cart).UpdateTotal();
        }

        private void cmdUp_Click(object sender, RoutedEventArgs e)
        {
            setQty(++qty);
            updateCart();
        }

        private void cmdDown_Click(object sender, RoutedEventArgs e)
        {
            setQty(--qty);
            updateCart();


            if (qty == 0)
            {
                CartitemList.Content.RemoveAt(index);

                Window parentWindow = Window.GetWindow(this);
                (parentWindow.Content as View.Cart).UpdateCart();
            }
        }

        
    }
}
