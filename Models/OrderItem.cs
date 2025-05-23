﻿namespace backend.Models
{
    public class OrderItem
    {
        public int OrderItemId { get; set; }
        public int? ProductId { get; set; }
        public int OrderId { get; set; }

        public string ProductName { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public decimal TotalPrice { get; set; }

        public OrderItem(int orderItemId, int productId, int orderId, string productName, int quantity, decimal price, decimal totalPrice)
        {
            OrderItemId = orderItemId;
            ProductId = productId;
            OrderId = orderId;
            ProductName = productName;
            Quantity = quantity;
            Price = price;
            TotalPrice = totalPrice;
        }

        public OrderItem()
        {
        }
    }
}
