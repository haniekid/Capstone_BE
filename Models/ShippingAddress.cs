namespace backend.Models
{
    public class ShippingAddress
    {
        public int ShippingAddressId { get; set; }
        public int OrderId { get; set; }
        public string Province { get; set; }
        public string DistrictId { get; set; }
        public string DistrictName { get; set; }
        public string WardCode { get; set; }
        public string WardName { get; set; }
        public string AddressDetail { get; set; }

        public ShippingAddress(int shippingAddressId, int orderId, string province, string districtId, string districtName, string wardCode, string wardName, string addressDetail)
        {
            ShippingAddressId = shippingAddressId;
            OrderId = orderId;
            Province = province;
            DistrictId = districtId;
            DistrictName = districtName;
            WardCode = wardCode;
            WardName = wardName;
            AddressDetail = addressDetail;
        }

        public ShippingAddress()
        {
        }
    }
}
