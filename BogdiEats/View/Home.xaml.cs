using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Navigation;
using System.Windows.Media.Animation;
using BogdiEats.View.Module;

namespace BogdiEats.View
{
    /// <summary>
    /// Interaction logic for Home.xaml
    /// </summary>
    public partial class Home : Page
    {

        //declare object controller
        private Controller.HomeController cHome;

        private int id = 1;
        public Home()
        {
            InitializeComponent();
            cHome = new Controller.HomeController(this);
            if(!Globals.isOk)
                history.Visibility = Visibility.Hidden;
            if (!Globals.isAdmin)
            { 
                historyAdmin.Visibility = Visibility.Hidden;
                stock.Visibility = Visibility.Hidden;
                edit.Visibility = Visibility.Hidden;
            }
            UpdateCartLabel();
        }

        private void UpdateCartLabel()
        {
            int priceTotal = 0;
            int itemTotal = 0;
            foreach (CartItem item in CartitemList.Content)
            {
                itemTotal += item.qty;
                priceTotal += (item.price * item.qty);
            }

            lblTotal.Content = itemTotal + " item (Lei " + priceTotal + ")";
        }

        void MenuClick(object sender, RoutedEventArgs e)
        {
            View.Module.ItemMenu src = sender as View.Module.ItemMenu;

            // load from database
            cHome.LoadMenuDetail(src.getId());

            // display popup
            OpenPopup();
        }

        public void UpdateCartLabel(int qty, int total)
        {
            string label = qty + " item (Lei " + total + ")";
            lblTotal.Content = label;
        }

        public void ActivateMenu()
        {
            UIElementCollection menuList = gridMenu.Children;

            foreach (UIElement child in menuList)
            {
                child.MouseDown += new MouseButtonEventHandler(MenuClick);
            }

        }

        public void ActivateCategory()
        {
            UIElementCollection categoryList = gridCategory.Children;

            foreach (UIElement child in categoryList)
            {
                child.MouseDown += new MouseButtonEventHandler(CategoryClick);
            }
        }

        void CategoryClick(object sender, RoutedEventArgs e)
        {

            // Reset all color
            UIElementCollection childrenList = gridCategory.Children;
            foreach (View.Module.ItemCategory child in childrenList)
            {
                child.unselect();
            }

            // Change clicked element color
            View.Module.ItemCategory src = sender as View.Module.ItemCategory;
            src.select();
            id = src.getId();
            // Load the menu
            cHome.ShowMenu(id);
        }

        private void BorderClose_MouseDown(object sender, MouseButtonEventArgs e)
        {
            ClosePopup();
        }

        private void Sb_Completed(object sender, EventArgs e)
        {
            // close overlay window
            overlay.Visibility = Visibility.Hidden;
        }

        public void OpenPopup()
        {
            // open overlay window
            overlay.Visibility = Visibility.Visible;

            // make easing function
            ElasticEase easing = new ElasticEase
            {
                EasingMode = EasingMode.EaseOut,
                Oscillations = 2,
                Springiness = 10
            };

            // animate it
            DoubleAnimation fadeIn = new DoubleAnimation(0, 1, TimeSpan.FromSeconds(0.3), FillBehavior.HoldEnd);
            DoubleAnimation bounce = new DoubleAnimation(50, 350, TimeSpan.FromSeconds(1), FillBehavior.HoldEnd);
            fadeIn.BeginTime = TimeSpan.FromSeconds(0);
            bounce.BeginTime = TimeSpan.FromSeconds(0);
            bounce.EasingFunction = easing;

            Storyboard sb = new Storyboard();
            Storyboard.SetTarget(fadeIn, overlay);
            Storyboard.SetTarget(bounce, borderDetail);
            Storyboard.SetTargetProperty(fadeIn, new PropertyPath("(Opacity)"));
            Storyboard.SetTargetProperty(bounce, new PropertyPath("(Height)"));
            sb.Children.Add(fadeIn);
            sb.Children.Add(bounce);
            this.Resources.Clear();
            this.Resources.Add("MyEffect", sb);

            sb.Begin();
        }


        public void ClosePopup()
        {
            DoubleAnimation fadeOut = new DoubleAnimation(1, 0, TimeSpan.FromSeconds(0.3), FillBehavior.HoldEnd)
            {
                BeginTime = TimeSpan.FromSeconds(0)
            };

            Storyboard sb = new Storyboard();
            Storyboard.SetTarget(fadeOut, overlay);
            Storyboard.SetTargetProperty(fadeOut, new PropertyPath("(Opacity)"));
            sb.Children.Add(fadeOut);
            this.Resources.Clear();
            this.Resources.Add("MyEffect", sb);
            sb.Completed += Sb_Completed;

            sb.Begin();
        }


        private void Rectangle_MouseDown(object sender, MouseButtonEventArgs e)
        {
            Window parent = Window.GetWindow(this);
            parent.DragMove();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Cart());


        }

        private void Search_Click(object sender, RoutedEventArgs e)
        {


            cHome.ShowMenu(id, search.Text);

        }

        private void Allergen_Click(object sender, RoutedEventArgs e)
        {
            cHome.ShowMenu(id, "", allergen.Text);
        }

        private void SignIn_Click(object sender, RoutedEventArgs e)
        {
            Window window = new Window
            {

                Content = new LogIn(),
                Width = 350,
                Height = 500,
                WindowStartupLocation = System.Windows.WindowStartupLocation.CenterScreen,
                ResizeMode = System.Windows.ResizeMode.NoResize,
                WindowStyle = System.Windows.WindowStyle.None

            };

            window.ShowDialog();

            if (Globals.isOk)
            {
                history.Visibility = Visibility.Visible;
                SignIn.IsEnabled = false;
                SignUp.IsEnabled = false;
            }
            if (Globals.isAdmin)
            {
                historyAdmin.Visibility = Visibility.Visible;
                stock.Visibility = Visibility.Visible;
                edit.Visibility = Visibility.Visible;
            }
        }

        private void SignUp_Click(object sender, RoutedEventArgs e)
        {



            Register registerForm = new Register();
            registerForm.Show();


        }

        private void History_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new History());
        }

        private void HistoryAdmin_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new AdminHistory());
        }

        private void Stock_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Stock());
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new EditDatabase());

        }

        private void Close_Click(object sender, RoutedEventArgs e)
        {
            Window.GetWindow(this).Close();
        }
    }
}
