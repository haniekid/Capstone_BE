using backend.Models;

namespace backend.DTOs
{
	public class OrderDTO
	{
		public OrderDTO()
		{
		}

		public OrderDTO(Order order, ShippingAddress shippingAddress, List<OrderItem> orderItems)
		{
			Order = order;
			ShippingAddress = shippingAddress;
			OrderItems = orderItems;
		}

		public Order Order { get; set; }
		public ShippingAddress ShippingAddress { get; set; }
		public List<OrderItem> OrderItems { get; set; }


	}
}
