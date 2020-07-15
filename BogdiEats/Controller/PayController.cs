using System;


namespace BogdiEats.Controller
{
    class PayController
    {
      
        private Model.TransactionModel mTransaction;
        private Model.ItemTransactionModel mItemRTransaction;

        private string paymentMethod;


        public PayController()
        {
          
            this.mTransaction = new Model.TransactionModel();
            this.mItemRTransaction = new Model.ItemTransactionModel();
        }

        public void SetPaymentMethod(string metode)
        {
            this.paymentMethod = metode;
        }

        public void SubmitTransaction()
        {

            // count 
            
            int total = 0;
            foreach(CartItem item in CartitemList.Content)
            {
                total += item.price * item.qty;

            }

            // create new transaction
            mTransaction.SetMetode(paymentMethod);
            mTransaction.SetDate(DateTime.Now);
            mTransaction.SetTotal(total);


            int id_transaksi = mTransaction.InsertTransaction();

            // create the item
            foreach (CartItem item in CartitemList.Content)
            {
                //addt in basket 
                mItemRTransaction.SetId_transanction(id_transaksi);
                mItemRTransaction.SetId_menu(item.id_menu);
                mItemRTransaction.SetQty(item.qty);


           ;
                mItemRTransaction.InsertItemTransaksi();
            }

            // clear the item
            CartitemList.Content.Clear();

        }
    }
}
