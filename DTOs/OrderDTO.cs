using backend.Models;

namespace backend.DTOs
{
    public class OrderDTO
    {
        public Order Order { get; set; }
        public ShippingAddress ShippingAddress { get; set; }
        public List<OrderItem> OrderItems { get; set; }
    }
}
