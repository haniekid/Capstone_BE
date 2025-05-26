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
        private readonly IListRepository<OrderItem> _orderItemRepository;

        private readonly string ORDER_SUCCESS = "http://localhost:3000/order-success";

        public PayController(IVnpay vnpay, IConfiguration configuration, IListRepository<OrderDTO> orderDTORepository,
                             IListRepository<Order> orderRepo, IRepository<Product> productRepository, IListRepository<OrderItem> orderItemRepository)
        {
            _configuration = configuration;
            _vnpay = vnpay;
            _vnpay.Initialize(_configuration["Vnpay:TmnCode"], _configuration["Vnpay:HashSecret"], _configuration["Vnpay:BaseUrl"], _configuration["Vnpay:ReturnUrl"]);
            _orderDTORepository = orderDTORepository;
            _orderRepository = orderRepo;
            _productRepository = productRepository;
            _orderItemRepository = orderItemRepository;
        }

        [HttpPost("CreatePaymentUrl")]
        public ActionResult<PaymentResponseDto> CreatePaymentUrl([FromBody] OrderDTO newOrder)
        {
            try
            {
                if (newOrder.Order.ShippingFee == null)
                {
                    newOrder.Order.ShippingFee = 0;
                }
                newOrder.Order.Status = OrderStatus.Processing;
                var addedOrderID = _orderDTORepository.Add2(newOrder);
                var isUpdateQuantity = _orderItemRepository.Update2(newOrder.OrderItems);
                if (addedOrderID == 0)
                {
                    return BadRequest();
                }
                if (newOrder.Order.PaymentMethod == "cod")
                {
                    var responseSucess = new PaymentResponseDto
                    {
                        PaymentUrl = ORDER_SUCCESS,
                        OrderId = addedOrderID
                    };
                    return Created(ORDER_SUCCESS, responseSucess);
                }
                var ipAddress = NetworkHelper.GetIpAddress(HttpContext);
                var totalAmmount = newOrder.Order.FinalTotal;
                if (newOrder.Order.VnpayOption == "50")
                {
                    totalAmmount /= 2;
                }
                var request = new PaymentRequest
                {
                    PaymentId = DateTime.Now.Ticks,
                    Money = Decimal.ToDouble(totalAmmount),
                    Description = $"Paid for HaFood - OrderID:{addedOrderID}",
                    IpAddress = ipAddress,
                    BankCode = BankCode.ANY,
                    CreatedDate = DateTime.Now,
                    Currency = Currency.VND,
                    Language = DisplayLanguage.Vietnamese
                };

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
                            if (order != null)
                            {
                                order.Status = OrderStatus.Accepted;
                                _orderRepository.Update(order);
                                return Redirect(ORDER_SUCCESS);
                            }
                        }

                        return Redirect(ORDER_SUCCESS);
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
