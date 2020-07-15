using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;
using System.Windows.Media.Animation;

namespace BogdiEats.View.Module
{
    /// <summary>
    /// Interaction logic for ItemMenu.xaml
    /// </summary>
    public partial class ItemMenu : UserControl
    {
        private int id;

        public ItemMenu(int id, string name, float price, string foto)
        {
            InitializeComponent();

            BitmapImage image = new BitmapImage(new Uri("/BogdiEats;component/Image/menu/" + foto, UriKind.Relative));

            lblMenu.Content = name;
            imageMenu.Source = image;
            lblPrice.Content = "Lei " + price.ToString();

            this.id = id;

            animate();
        }

        public void animate()
        {
            // animate it
            DoubleAnimation fadeIn = new DoubleAnimation(0, 1, TimeSpan.FromSeconds(0.3), FillBehavior.HoldEnd);
            fadeIn.BeginTime = TimeSpan.FromSeconds(0);

            Storyboard sb = new Storyboard();
            Storyboard.SetTarget(fadeIn, borderMenu);
            Storyboard.SetTargetProperty(fadeIn, new PropertyPath("(Opacity)"));
            sb.Children.Add(fadeIn);
            this.Resources.Clear();
            this.Resources.Add("MyEffect", sb);

            sb.Begin();
        }

        public int getId()
        {
            return id;
        }
    }
}
