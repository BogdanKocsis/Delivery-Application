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
    /// Interaction logic for ItemCategory.xaml
    /// </summary>
    public partial class ItemCategory : UserControl
    {

        private int id;

        public ItemCategory(int id, string name)
        {
            InitializeComponent();

            BitmapImage image = new BitmapImage(new Uri("/BogdiEats;component/Image/category/category (" + id + ").png", UriKind.Relative));
            LblCategrory.Content = name;
            ImageCategory.Source = image;

            this.id = id;

            unselect();
        }




        public void unselect()
        {
            btnBg.Background = Brushes.Transparent;
        }

        public void select()
        {

            btnBg.Background = new SolidColorBrush(Color.FromArgb(20, 0, 0, 0));
        }

        public int getId()
        {
            return id;
        }
    }
}
