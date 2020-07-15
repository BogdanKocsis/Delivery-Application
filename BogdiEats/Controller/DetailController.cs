using System;
using System.Data;
using System.Windows.Media.Imaging;

namespace BogdiEats.Controller
{
  

    class DetailController
    {
        private View.Detail vDetail;
        private View.Home vHome;


        private int id_menu;
        private string name;
        private string description;
        private int price;
        private string foto;
        private int qty = 1;
        private string category;
        private string quantity;
        private string quantity_meal;
        private int total_quantity;
        private string allergens;
            

        public DetailController(View.Detail vDetail, DataRow detailData, View.Home vHome)
        {


            this.vHome = vHome;

            this.vDetail = vDetail;
            this.id_menu = int.Parse(detailData["IDProduct"].ToString());
            this.name = detailData["Name"].ToString();
            this.price = int.Parse(detailData["Price"].ToString());
            this.foto = detailData["ImagePath"].ToString();
            this.category = detailData["Category"].ToString();
            this.description = detailData["Description"].ToString();
            this.quantity = detailData["Portion_Quantity"].ToString();
            this.quantity_meal = detailData["Meal_Quantity"].ToString();
            this.total_quantity = int.Parse(detailData["Total_Quantity"].ToString());
            this.allergens = detailData["Allergens"].ToString();

            BitmapImage image = new BitmapImage(new Uri("/BogdiEats;component/Image/menu/" + foto , UriKind.Relative));


            // display the detail
            vDetail.lblName.Content = this.name;
            vDetail.lblDescription.Text = this.description;
            vDetail.lblCategory.Content = this.category;
            vDetail.lblQty.Content = this.qty; 
            if(this.name.StartsWith("Menu"))
                vDetail.lblQuantity.Content = vDetail.lblQuantity.Content + this.quantity_meal.Remove(this.quantity_meal.Length-1) + " grams/product";
            else
                vDetail.lblQuantity.Content = vDetail.lblQuantity.Content + this.quantity+ " grams";
            vDetail.imageMenu.Source = image;
            if(this.allergens.Length>1)
                vDetail.lblAllergens.Content += this.allergens.Remove(this.allergens.Length - 1);
            
            if (this.total_quantity <= 100)
                Globals.isInStock = false;
            else
                Globals.isInStock = true;

            

            // update subtotal
            UpdateSubtotal();
        }

       
        public void AddToCart()
        {
            CartItem item = new CartItem
            {
                id_menu = id_menu,
                price = price,
                foto = foto,
                qty = this.qty,
                name = name,
                description = quantity
            };

            CartitemList.Content.Add(item);

            // calculate total
            int totalPrice = 0;
            int count = 0;
            foreach (CartItem i in CartitemList.Content)
            {
                totalPrice += (i.price * i.qty);
                count += i.qty;
            }


            vHome.UpdateCartLabel(count, totalPrice);

            // hide
            vHome.ClosePopup();
        }

        public void AddQty()
        {
            this.qty++;
            UpdateSubtotal();
        }

        public void SubQty()
        {
            this.qty--;
            UpdateSubtotal();
        }

        public void UpdateSubtotal()
        {
            int subtotal = price * qty;
            string label = qty + " item (Lei " + subtotal + ")";

            vDetail.lblQty.Content = qty;
            vDetail.lblSubtotal.Content = label;
        }

    

        public void RefreshFrame()
        {
            vHome.frmDetail.Refresh();
        }


    }
}
