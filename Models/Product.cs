namespace backend.Models
{
    public class Product
    {
        public int ProductID { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Description { get; set; }
        public string ImageURL { get; set; }

        public Product(int productID, string name, string type, string description, string imageURL)
        {
            ProductID = productID;
            Name = name;
            Type = type;
            Description = description;
            ImageURL = imageURL;
        }
    }
}