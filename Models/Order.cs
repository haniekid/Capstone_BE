namespace backend.Models
{
    public enum OrderStatus
    {
        Pending,
        Processing,
        Shipped,
        Delivered,
        Cancelled,
        Paid
    }

    public class Order
    {
        public int OrderID { get; set; }
        public OrderStatus Status { get; set; }
        public int UserID { get; set; }
        public int DiscountId { get; set; }
        public string ShippingMethod { get; set; }
        public decimal ShippingFee { get; set; }
        public string PaymentMethod { get; set; }
        public string VnpayOption { get; set; }
        public decimal Subtotal { get; set; }
        public decimal FinalTotal { get; set; }
        public DateTime DateTime { get; set; }
        public string Note {  get; set; }

        public Order(int orderID, OrderStatus status, int userID, int discountId, string shippingMethod, decimal shippingFee, string paymentMethod, string vnpayOption, decimal subtotal, decimal finalTotal, DateTime dateTime, string note)
        {
            OrderID = orderID;
            Status = status;
            UserID = userID;
            DiscountId = discountId;
            ShippingMethod = shippingMethod;
            ShippingFee = shippingFee;
            PaymentMethod = paymentMethod;
            VnpayOption = vnpayOption;
            Subtotal = subtotal;
            FinalTotal = finalTotal;
            DateTime = dateTime;
            Note = note;
        }
    }
}
