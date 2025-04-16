namespace backend.Models
{
	public class ProductDTO
	{
		public int ProductID { get; set; }
		public string Name { get; set; }
		public string Type { get; set; }
		public string Description { get; set; }
		public string ImageURL { get; set; }
		public decimal Price { get; set; }
		public int Quantity { get; set; }
		public List<string> ListImageURL { get; set; }
		public decimal? SalePrice { get; set; }
		public DateTime? SaleStartDate { get; set; }
		public DateTime? SaleEndDate { get; set; }

		public ProductDTO(int productID, string name, string type, string description, string imageURL, decimal price, int quantity, List<string> listImageURL,
			decimal? salePrice, DateTime? saleStartDate, DateTime? saleEndDate)
		{
			ProductID = productID;
			Name = name;
			Type = type;
			Description = description;
			ImageURL = imageURL;
			Price = price;
			Quantity = quantity;
			ListImageURL = listImageURL;
			SalePrice = salePrice;
			SaleStartDate = saleStartDate;
			SaleEndDate = saleEndDate;
		}
	}
}