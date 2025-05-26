using backend.DTOs;
using backend.Models;
using backend.Repositories;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;
using VNPAY.NET;
using VNPAY.NET.Enums;
using VNPAY.NET.Models;
using VNPAY.NET.Utilities;

namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("_myAllowSpecificOrigins")]
    public class OrderController : ControllerBase
    {
        private readonly IListRepository<Order> _orderRepository;
        private readonly IListRepository<OrderDTO> _orderDTORepository;
        private readonly IListRepository<OrderItem> _orderItemRepository;
        private readonly IListRepository<ProductPrice> _productPriceRepository;

        public OrderController(IListRepository<Order> orderRepo, IListRepository<OrderDTO> orderDTORepository, IListRepository<OrderItem> orderItemRepository, IListRepository<ProductPrice> productPriceRepository)
        {
            _orderRepository = orderRepo;
            _orderDTORepository = orderDTORepository;
            _orderItemRepository = orderItemRepository;
            _productPriceRepository = productPriceRepository;
        }

        [HttpGet]
        public IActionResult Get()
        {
            IEnumerable<Order> orders = _orderRepository.GetAll();
            return Ok(orders);
        }

        [HttpGet("GetOrderById/{orderId}")]
        public IActionResult GetOrderById(int orderId)
        {
            var order = _orderRepository.GetAll().FirstOrDefault(x => x.OrderID == orderId);
            return Ok(order);
        }
        [HttpGet("user/{userId}")]
        public IActionResult GetOrderByUserId(int userId)
        {
            var orders = _orderDTORepository.GetById(userId);
            if (orders == null || !orders.Any())
            {
                return Ok();
            }
            return Ok(orders);
        }

        [HttpGet("order/{orderId}")]
        public IActionResult GetOrderByOrderId(int orderId)
        {
            var order = _orderDTORepository.GetObjById(orderId);
            if (order == null)
            {
                return NotFound();
            }
            return Ok(order);
        }
        [HttpPut("{orderId}")]
        public IActionResult Put(Order updatedOrder)
        {
            bool updated = _orderRepository.Update(updatedOrder);
            if (updated)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

        [HttpDelete("{orderId}")]
        public IActionResult Delete(int orderId)
        {
            bool deleted = _orderRepository.Delete(orderId);
            if (deleted)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

        [HttpPost]
        public IActionResult Post(OrderDTO newOrder)
        {
            bool added = _orderDTORepository.Add(newOrder);
            if (!added)
            {
                return BadRequest("Failed to create Order");
            }
            return Ok();
        }

        [HttpPut("{orderId}/status")]
        public IActionResult UpdateOrderStatus(int orderId, [FromBody] UpdateOrderStatusRequest request)
        {
            var existingOrder = _orderRepository.GetObjById(orderId);
            if (existingOrder == null)
            {
                return NotFound(new { error = "Không tìm thấy đơn hàng" });
            }

            if (existingOrder.Status == OrderStatus.Shipped || existingOrder.Status == OrderStatus.Cancelled)
            {
                return Conflict(new { error = "Không thể cập nhật đơn hàng Đã giao hoặc Đã hủy" });
            }

            if (!IsValidTransition(existingOrder.Status, request.NewStatus))
            {
                return Conflict(new { error = "Không thể cập nhật đơn hàng Đã giao hoặc Đã hủy" });
            }

            var previousStatus = existingOrder.Status;
            existingOrder.Status = request.NewStatus;

            bool updated = _orderRepository.Update(existingOrder);
            if (existingOrder.Status == OrderStatus.Cancelled)
            {
                var orderItems = _orderItemRepository.GetById(orderId);

                foreach (var item in orderItems)
                {
                    if (item.ProductId.HasValue)
                    {
                        var productPrice = _productPriceRepository.GetObjById(item.ProductId.Value);

                        if (productPrice != null)
                        {
                            productPrice.Quantity += item.Quantity;
                            _productPriceRepository.Update(productPrice);
                        }
                    }
                }

            }
            if (updated)
            {
                return Ok(new
                {
                    orderId = existingOrder.OrderID,
                    previousStatus,
                    newStatus = existingOrder.Status,
                    message = "Cập nhật trạng thái thành công!"
                });
            }
            else
            {
                return StatusCode(500, new { error = "Cập nhật thất bại." });
            }
        }

        private static readonly Dictionary<OrderStatus, OrderStatus[]> AllowedTransitions = new()
        {
            { OrderStatus.Processing, new[] { OrderStatus.Accepted, OrderStatus.Cancelled } },
            { OrderStatus.Accepted, new[] { OrderStatus.Processing, OrderStatus.Preparing, OrderStatus.Cancelled } },
            { OrderStatus.Preparing, new[] { OrderStatus.Accepted, OrderStatus.Shipping, OrderStatus.Cancelled } },
            { OrderStatus.Shipping, new[] { OrderStatus.Preparing, OrderStatus.Shipped, OrderStatus.Cancelled } },
            { OrderStatus.Shipped, new[] { OrderStatus.Shipping } }
        };
        private bool IsValidTransition(OrderStatus current, OrderStatus next)
        {
            return AllowedTransitions.TryGetValue(current, out var nextStatuses) &&
                   nextStatuses.Contains(next);
        }
    }
}
