namespace backend.Models
{
    public class ProductPrice
    {
        public int ProductPriceID { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public int ProductID { get; set; }

        public ProductPrice(int productPriceID, decimal price, int quantity, int productID )
        {
            ProductPriceID = productPriceID;
            Price = price;
            Quantity = quantity;
            ProductID = productID;
        }
    }
}
