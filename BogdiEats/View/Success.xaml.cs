using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Navigation;


namespace BogdiEats.View
{
    /// <summary>
    /// Interaction logic for Success.xaml
    /// </summary>
    public partial class Success : Page
    {
        public Success()
        {
            InitializeComponent();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            Task.Delay(5000).ContinueWith(_ =>
            {
                this.Dispatcher.Invoke(() =>
                {
                    NavigationService.Navigate(new View.Home());
                });
            }
            );
        }

        private void Rectangle_MouseDown(object sender, MouseButtonEventArgs e)
        {
            Window parent = Window.GetWindow(this);
            parent.DragMove();
        }
    }
}
