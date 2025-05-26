using backend.Models;

namespace backend.Repositories
{
    public interface IOrderProcessingRepository
    {
        List<Order> GetProcessingOrdersOlderThanMinutes(int minutes);
    }
}
