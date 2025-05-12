namespace backend.Models
{
    public enum OrderStatus
    {
        Cancelled, 
        Processing, 
        Accepted,
        Paid,
        HalfPaid,
        Preparing, 
        Shipping, 
        Shipped, 
    }

    public class Order
    {
        public int OrderID { get; set; }
        public OrderStatus Status { get; set; }
        public int UserID { get; set; }
        public string DiscountCode { get; set; }
        public string ShippingMethod { get; set; }
        public decimal ShippingFee { get; set; }
        public string PaymentMethod { get; set; }
        public string VnpayOption { get; set; }
        public decimal Subtotal { get; set; }
        public decimal FinalTotal { get; set; }
        public DateTime DateTime { get; set; }
        public string Note {  get; set; }

        public Order(int orderID, OrderStatus status, int userID, string discountCode, string shippingMethod, decimal shippingFee, string paymentMethod, string vnpayOption, decimal subtotal, decimal finalTotal, DateTime dateTime, string note)
        {
            OrderID = orderID;
            Status = status;
            UserID = userID;
            DiscountCode = discountCode;
            ShippingMethod = shippingMethod;
            ShippingFee = shippingFee;
            PaymentMethod = paymentMethod;
            VnpayOption = vnpayOption;
            Subtotal = subtotal;
            FinalTotal = finalTotal;
            DateTime = dateTime;
            Note = note;
        }
        public Order()
        {
        }
    }
}
