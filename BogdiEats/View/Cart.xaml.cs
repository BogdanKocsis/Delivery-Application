using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media.Animation;
using System.Windows.Navigation;


namespace BogdiEats.View
{
    /// <summary>
    /// Interaction logic for Pay.xaml
    /// </summary>
    public partial class Cart : Page
    {


        //declare object controller
        private Controller.CartController cCart;

        public Cart()
        {
            InitializeComponent();
            cCart = new Controller.CartController(this);
        }

        public void UpdateTotal()
        {
            cCart.UpdateTotal();
           
        }

        public void UpdateCart()
        {
            cCart.UpdateCart();
        }

        private void BtnBackToHome_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }

        private void Rectangle_MouseDown(object sender, MouseButtonEventArgs e)
        {
            Window parent = Window.GetWindow(this);
            parent.DragMove();
        }
        void AnimatePaymentPopup()
        {
            // open overlay window
            overlay.Visibility = Visibility.Visible;

            // make easing function
            ElasticEase easing = new ElasticEase();
            easing.EasingMode = EasingMode.EaseOut;
            easing.Oscillations = 2;
            easing.Springiness = 10;

            // animate it
            DoubleAnimation fadeIn = new DoubleAnimation(0, 1, TimeSpan.FromSeconds(0.3), FillBehavior.HoldEnd);
            DoubleAnimation bounce = new DoubleAnimation(50, 350, TimeSpan.FromSeconds(1), FillBehavior.HoldEnd);
            fadeIn.BeginTime = TimeSpan.FromSeconds(0);
            bounce.BeginTime = TimeSpan.FromSeconds(0);
            bounce.EasingFunction = easing;

            Storyboard sb = new Storyboard();
            Storyboard.SetTarget(fadeIn, overlay);
            Storyboard.SetTarget(bounce, overlay);
            Storyboard.SetTargetProperty(fadeIn, new PropertyPath("(Opacity)"));
            Storyboard.SetTargetProperty(bounce, new PropertyPath("(Height)"));
            sb.Children.Add(fadeIn);
            sb.Children.Add(bounce);
            this.Resources.Clear();
            this.Resources.Add("MyEffect", sb);

            sb.Begin();
        }

        private void BtnGotoPay_Click(object sender, RoutedEventArgs e)
        {
   
            
            if (Globals.isOk)
            {
                overlay.Visibility = Visibility.Hidden;
                NavigationService.Navigate(new Pay());
            }
            else
            {
                frmPay.Content = new Module.LogIn();
                AnimatePaymentPopup();
            }

       


        }

        private void Sb_Completed(object sender, EventArgs e)
        {
            // close overlay window
            overlay.Visibility = Visibility.Hidden;
        }
        private void BorderClose_MouseDown(object sender, MouseButtonEventArgs e)
        {
            // animate it
            DoubleAnimation fadeOut = new DoubleAnimation(1, 0, TimeSpan.FromSeconds(0.3), FillBehavior.HoldEnd);
            fadeOut.BeginTime = TimeSpan.FromSeconds(0);

            Storyboard sb = new Storyboard();
            Storyboard.SetTarget(fadeOut, overlay);
            Storyboard.SetTargetProperty(fadeOut, new PropertyPath("(Opacity)"));
            sb.Children.Add(fadeOut);
            this.Resources.Clear();
            this.Resources.Add("MyEffect", sb);
        
               

            sb.Begin();
        }
    }
}
