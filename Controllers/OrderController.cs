using backend.Models;
using backend.Repositories;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;

namespace backend.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	[EnableCors("_myAllowSpecificOrigins")]
	public class OrderController : ControllerBase
	{
		private readonly IListRepository<Order> _orderRepository;

		public OrderController(IListRepository<Order> orderRepo)
		{
			_orderRepository = orderRepo;
		}

		[HttpGet]
		public IActionResult Get()
		{
			IEnumerable<Order> orders = _orderRepository.GetAll();
			return Ok(orders);
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

		[HttpPost]
		public IActionResult Post(Order newOrder)
		{
			bool added = _orderRepository.Add(newOrder);
			if (!added)
			{
				return BadRequest("Failed to create Order");
			}
			var paymentUrl = GenerateVnpayUrl(newOrder);
			return Ok(new { paymentUrl });
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

		private string GenerateVnpayUrl(Order order)
		{
			string vnp_ReturnUrl = "https://localhost:7089/api/vnpay/confirm";
			string vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
			string vnp_TmnCode = "8M1E79QS";
			string vnp_HashSecret = "PMNWYOJCIG2YHK5Q5OY7M1J9TDE5GLC8";

			var vnpayData = new SortedDictionary<string, string>
			{
				{ "vnp_Version", "2.1.0" },
				{ "vnp_Command", "pay" },
				{ "vnp_TmnCode", vnp_TmnCode },
				{ "vnp_Amount", ((int)(order.TotalPrice * 100)).ToString() }, // VNPAY uses smallest currency unit
				{ "vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss") },
				{ "vnp_CurrCode", "VND" },
				{ "vnp_IpAddr", HttpContext.Connection.RemoteIpAddress.ToString() },
				{ "vnp_Locale", "vn" },
				{ "vnp_OrderInfo", $"Thanh toan don hang {order.OrderID}" },
				{ "vnp_OrderType", "other" },
				{ "vnp_ReturnUrl", vnp_ReturnUrl },
				{ "vnp_TxnRef", order.OrderID.ToString() }
			};

			string queryString = string.Join("&", vnpayData
				.OrderBy(k => k.Key)
				.Select(kvp => $"{kvp.Key}={Uri.EscapeDataString(kvp.Value)}"));

			string signData = string.Join("&", vnpayData
				.OrderBy(k => k.Key)
				.Select(kvp => $"{kvp.Key}={kvp.Value}"));

			string secureHash = CreateSHA256(vnp_HashSecret + signData);

			string paymentUrl = $"{vnp_Url}?{queryString}&vnp_SecureHashType=SHA256&vnp_SecureHash={secureHash}";
			return paymentUrl;
		}
		private string CreateSHA256(string input)
		{
			using var sha256 = SHA256.Create();
			var bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(input));
			return string.Concat(bytes.Select(b => b.ToString("x2")));
		}
	}
}
