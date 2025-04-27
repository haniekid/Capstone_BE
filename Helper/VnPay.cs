using VNPAY.NET;
using VNPAY.NET.Models;

namespace backend.Helper
{
    public class VnPay : IVnpay
    {
        public PaymentResult GetPaymentResult(IQueryCollection parameters)
        {
            throw new NotImplementedException();
        }

        public string GetPaymentUrl(PaymentRequest request)
        {
            throw new NotImplementedException();
        }

        public void Initialize(string tmnCode, string hashSecret, string baseUrl, string callbackUrl, string version = "2.1.0", string orderType = "other")
        {
            throw new NotImplementedException();
        }
    }
}
