using backend.Models;

namespace backend.DTOs
{
    public class OrderDTO
    {
        public Order Order { get; set; }
        public List<OrderItem> OrderItems { get; set; }

        public OrderDTO(Order order, List<OrderItem> orderItems)
        {
            Order = order;
            OrderItems = orderItems;
        }
    }
}
