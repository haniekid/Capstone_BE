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

        public OrderController(IListRepository<Order> orderRepo, IListRepository<OrderDTO> orderDTORepository)
        {
            _orderRepository = orderRepo;
            _orderDTORepository = orderDTORepository;
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
        [HttpGet("{userId}")]
        public IActionResult Get(int userId)
        {
            var orders = _orderRepository.GetById(userId);
            if (orders == null)
            {
                return NotFound();
            }
            return Ok(orders);
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
    }
}
