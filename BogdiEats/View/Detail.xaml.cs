using System.Windows;
using System.Windows.Controls;
using System.Data;

namespace BogdiEats.View
{

    /// <summary>
    /// Interaction logic for Detail.xaml
    /// </summary>
    public partial class Detail : Page
    {

        private Controller.DetailController cDetail;

        public Detail(DataRow dataDetail, View.Home vHome)
        {
            InitializeComponent();

            this.cDetail = new Controller.DetailController(this, dataDetail, vHome);
            if (Globals.isInStock)
            {
                btnAdd.IsEnabled = true;
                Disponibility.Text = "";
            }
            else
            {
                btnAdd.IsEnabled = false;
                Disponibility.Text = "Unavailable";
            }

        }


        private void BtnPlus_Click(object sender, RoutedEventArgs e)
        {
            if (int.Parse(lblQty.Content.ToString()) < 10)
                cDetail.AddQty();
        }

        private void BtnMinus_Click(object sender, RoutedEventArgs e)
        {
            if (int.Parse(lblQty.Content.ToString()) > 1)
                cDetail.SubQty();
        }

   
        //add to cart function
        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            cDetail.AddToCart();
        }

        private void ClearSelection_Click(object sender, RoutedEventArgs e)
        {
            cDetail.RefreshFrame();
        }
    }
}
