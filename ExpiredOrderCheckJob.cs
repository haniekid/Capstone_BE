using backend.Models;
using backend.Repositories;
using Microsoft.Extensions.DependencyInjection;

namespace backend
{
    public class ExpiredOrderCheckJob : BackgroundService
    {
        private readonly IServiceScopeFactory _scopeFactory;
        private readonly ILogger<ExpiredOrderCheckJob> _logger;

        public ExpiredOrderCheckJob(IServiceScopeFactory scopeFactory, ILogger<ExpiredOrderCheckJob> logger)
        {
            _scopeFactory = scopeFactory;
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                await CheckAndRestoreExpiredOrders();
                await Task.Delay(TimeSpan.FromMinutes(5), stoppingToken); // chạy mỗi 5 phút
            }
        }

        private async Task CheckAndRestoreExpiredOrders()
        {
            using var scope = _scopeFactory.CreateScope();
            var orderRepo = scope.ServiceProvider.GetRequiredService<IOrderProcessingRepository>();
            var orderRepo2 = scope.ServiceProvider.GetRequiredService<IListRepository<Order>>();
            var productPriceRepo = scope.ServiceProvider.GetRequiredService<IListRepository<ProductPrice>>();
            var orderItemRepo = scope.ServiceProvider.GetRequiredService<IListRepository<OrderItem>>();
            var expiredOrders = orderRepo.GetProcessingOrdersOlderThanMinutes(15);
            foreach (var order in expiredOrders)
            {
                var orderItems = orderItemRepo.GetById(order.OrderID);

                foreach (var item in orderItems)
                {
                    if (item.ProductId.HasValue)
                    {
                        var productPrice = productPriceRepo.GetObjById(item.ProductId.Value);

                        if (productPrice != null)
                        {
                            productPrice.Quantity += item.Quantity;
                            productPriceRepo.Update(productPrice);
                        }
                    }
                }

                order.Status = OrderStatus.Cancelled;
                orderRepo2.Update(order); 
            }
        }
    }
}
