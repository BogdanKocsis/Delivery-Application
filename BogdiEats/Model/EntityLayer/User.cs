
namespace BogdiEats.Model
{
    class User : BasePropertyChanged
    {
        private int? IDUser;
        public int? _IDUser
        {
            get
            {
                return IDUser;
            }
            set
            {
                IDUser = value;
                NotifyPropertyChanged("_IDUser");
            }
        }
        private string name;
        public string Name
        {
            get
            {
                return name;
            }
            set
            {
                name = value;
                NotifyPropertyChanged("Name");
            }
        }
        private string address;
        public string Address
        {
            get
            {
                return address;
            }
            set
            {
                address = value;
                NotifyPropertyChanged("Address");
            }
        }
        private string phoneNo;
        public string PhoneNo
        {
            get
            {
                return phoneNo;
            }
            set
            {
                phoneNo = value;
                NotifyPropertyChanged("PhoneNo");
            }
        }
        private string email;
        public string Email
        {
            get
            {
                return email;
            }
            set
            {
                email = value;
                NotifyPropertyChanged("Email");
            }
        }
        private string password;
        public string Password
        {
            get
            {
                return password;
            }
            set
            {
                password = value;
                NotifyPropertyChanged("Password");
            }
        }
    }
}
