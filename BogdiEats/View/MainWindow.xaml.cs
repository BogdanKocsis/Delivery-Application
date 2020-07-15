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
using System.Windows.Media.Animation;
using System.Windows.Threading;

namespace BogdiEats
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : NavigationWindow
    {

        public MainWindow()
        {
            InitializeComponent();
            NavigationService.Navigate(new View.Splash());
        }

        private void NavigationWindow_Navigating(object sender, NavigatingCancelEventArgs e)
        {

            var ta = new ThicknessAnimation();
            ta.Duration = TimeSpan.FromSeconds(0.3);
            ta.DecelerationRatio = 1;
            ta.To = new Thickness(0, 0, 0, 0);
            if (e.NavigationMode == NavigationMode.New)
            {
                ta.From = new Thickness(50, 0, -50, 0);
            }
            else if (e.NavigationMode == NavigationMode.Back)
            {
                ta.From = new Thickness(-50, 0, 50, 0);
            }

            if (e.Content as Page != null)
            {
                (e.Content as Page).BeginAnimation(MarginProperty, ta);
            }


            DoubleAnimation fadeIn = new DoubleAnimation(0, 1, TimeSpan.FromSeconds(0.5), FillBehavior.HoldEnd);
            fadeIn.BeginTime = TimeSpan.FromSeconds(0);

            Storyboard sb = new Storyboard();
            Storyboard.SetTarget(fadeIn, e.Content as Page);
            Storyboard.SetTargetProperty(fadeIn, new PropertyPath("(Opacity)"));
            sb.Children.Add(fadeIn);
            this.Resources.Clear();
            this.Resources.Add("MyEffect", sb);

            sb.Begin();

        }

        private void NavigationWindow_Loaded(object sender, RoutedEventArgs e)
        {
            Task.Delay(3000).ContinueWith(_ =>
            {
                this.Dispatcher.Invoke(() =>
                {
                    NavigationService.Navigate(new View.Home());
                });
            });

        }
    }
}
