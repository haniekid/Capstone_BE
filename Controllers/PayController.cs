using backend.DTOs;
using backend.Models;
using backend.Repositories;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using System.Text.RegularExpressions;
using VNPAY.NET;
using VNPAY.NET.Enums;
using VNPAY.NET.Models;
using VNPAY.NET.Utilities;
namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("_myAllowSpecificOrigins")]

    public class PayController : ControllerBase
    {
        private readonly IVnpay _vnpay;
        private readonly IConfiguration _configuration;
        private readonly IListRepository<OrderDTO> _orderDTORepository;
        private readonly IListRepository<Order> _orderRepository;
        private readonly IRepository<Product> _productRepository;

        public PayController(IVnpay vnpay, IConfiguration configuration, IListRepository<OrderDTO> orderDTORepository, IListRepository<Order> orderRepo, IRepository<Product> productRepository)
        {
            _configuration = configuration;
            _vnpay = vnpay;
            _vnpay.Initialize(_configuration["Vnpay:TmnCode"], _configuration["Vnpay:HashSecret"], _configuration["Vnpay:BaseUrl"], _configuration["Vnpay:ReturnUrl"]);
            _orderDTORepository = orderDTORepository;
            _orderRepository = orderRepo;
            _productRepository = productRepository;
        }

        [HttpPost("CreatePaymentUrl")]
        public ActionResult<PaymentResponseDto> CreatePaymentUrl([FromBody] OrderDTO newOrder)
        {
            try
            {
                var addedOrderID = _orderDTORepository.Add2(newOrder);

                var ipAddress = NetworkHelper.GetIpAddress(HttpContext);

                var request = new PaymentRequest
                {
                    PaymentId = DateTime.Now.Ticks,
                    Money = Decimal.ToDouble(newOrder.Order.TotalPrice),
                    Description = $"Paid for HaFood - OrderID:{addedOrderID}",
                    IpAddress = ipAddress,
                    BankCode = BankCode.ANY,
                    CreatedDate = DateTime.Now,
                    Currency = Currency.VND,
                    Language = DisplayLanguage.Vietnamese
                };
                foreach (var item in newOrder.OrderItems)
                {
                    var a = _productRepository.GetById(item.ProductPriceID);

                }
                var paymentUrl = _vnpay.GetPaymentUrl(request);

                var response = new PaymentResponseDto
                {
                    PaymentUrl = paymentUrl,
                    OrderId = addedOrderID
                };

                return Created(paymentUrl, response);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("confirm")]
        public ActionResult<string> Confirm()
        {
            if (Request.QueryString.HasValue)
            {
                try
                {
                    var query = HttpContext.Request.Query;

                    // Try to get "orderId" from the query string
                    if (query.TryGetValue("vnp_OrderInfo", out var orderInfo))
                    {
                        string orderInfoStr = orderInfo.ToString();
                        var match = Regex.Match(orderInfoStr, @"OrderID:(\d+)");
                        int orderId = int.Parse(match.Groups[1].Value);
                        var fakePaymentResult = new PaymentResult
                        {
                            IsSuccess = true,
                            PaymentResponse = new PaymentResponse
                            {
                                Description = "Thanh toán thành công"
                            },
                            TransactionStatus = new TransactionStatus
                            {
                                Description = "Giao dịch thành công"
                            }
                        };

                        var resultDescription = $"{fakePaymentResult.PaymentResponse.Description}. {fakePaymentResult.TransactionStatus.Description}. OrderID: {orderId}";

                        if (fakePaymentResult.IsSuccess)
                        {
                            var order = _orderRepository.GetAll().FirstOrDefault(x => x.OrderID == orderId);
                            order.Status = OrderStatus.Paid;
                            _orderRepository.Update(order);
                            return Ok(resultDescription);
                        }

                        return BadRequest(resultDescription);
                    }
                    else
                    {
                        return BadRequest("Missing orderId in the query.");
                    }
                }
                catch (Exception ex)
                {
                    return BadRequest($"Lỗi: {ex.Message}");
                }
            }

            return NotFound("Không tìm thấy thông tin thanh toán.");
        }
    }

}
