using System;
using System.Windows.Media.Imaging;
using System.Windows;

namespace BogdiEats.Controller
{
    class CartController
    {

        private View.Cart vCart;

        public CartController(View.Cart vCart)
        {
            this.vCart = vCart;

            UpdateCart();
        }
        public void UpdateTotal()
        {
            int total = 0;

            foreach (CartItem item in CartitemList.Content)
            {
                total += (item.price * item.qty);
            }

            // update total
            vCart.lblTotal.Content = "Lei " + total;
            if (total < 100)
                vCart.DeliveryFee.Content = "Lei" + 15;
            else
                vCart.DeliveryFee.Content = "Lei"+0;

            if (total > 200)
            {
                vCart.DiscountPercent.Visibility = Visibility.Visible;
                vCart.Discount.Visibility = Visibility.Visible;
                vCart.DiscountPercent.Content = "%" + 15;

            }
            else
            {
                vCart.DiscountPercent.Visibility = Visibility.Hidden;
                vCart.Discount.Visibility = Visibility.Hidden;
            }

        }

        public void UpdateCart()
        {
            // clear the cart
            vCart.spCart.Children.Clear();

            int total = 0;
            int index = 0;
            foreach (CartItem item in CartitemList.Content)
            {
                BitmapImage image = new BitmapImage(new Uri("/BogdiEats;component/Image/menu/" + item.foto, UriKind.Relative));
                View.Module.ItemCart iCart = new View.Module.ItemCart(index);
                iCart.lblPrice.Content = "Lei" + item.price;
                iCart.lblName.Content = item.name;
               
                iCart.imageMenu.Source = image;
                iCart.setQty(item.qty);


                total += (item.price * item.qty);

                vCart.spCart.Children.Add(iCart);
                vCart.spCart.Height += 110;

                index++;
            }

            UpdateTotal();

            if (total == 0)
            {
                vCart.viever.Visibility = Visibility.Hidden;
                vCart.gridBottom.Visibility = Visibility.Hidden;
                vCart.imgEmpty.Visibility = Visibility.Visible;
            }
            else
            {
                vCart.viever.Visibility = Visibility.Visible;
                vCart.gridBottom.Visibility = Visibility.Visible;
                vCart.imgEmpty.Visibility = Visibility.Hidden;
            }

        }
    }
}
