using backend.Models;
using System.Data.SqlClient;

namespace backend.Repositories
{
    public class ProductDTORepository : IRepository<ProductDTO>
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public ProductDTORepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("UserAppCon");
        }

        public bool Add(ProductDTO product)
        {
            string productQuery = @"INSERT INTO dbo.Products (Name, Type, Description, ImageURL) 
                            OUTPUT INSERTED.ProductID 
                            VALUES (@Name, @Type, @Description, @ImageURL)";

            string priceQuery = @"INSERT INTO dbo.ProductPrices (ProductID, Price, Quantity) 
                          VALUES (@ProductID, @Price, @Quantity)";

            try
            {
                using (SqlConnection myCon = new SqlConnection(_connectionString))
                {
                    myCon.Open();
                    using (SqlCommand productCommand = new SqlCommand(productQuery, myCon))
                    {
                        productCommand.Parameters.AddWithValue("@Name", product.Name);
                        productCommand.Parameters.AddWithValue("@Type", product.Type);
                        productCommand.Parameters.AddWithValue("@Description", product.Description);
                        productCommand.Parameters.AddWithValue("@ImageURL", product.ImageURL);

                        int productId = (int)productCommand.ExecuteScalar(); // Get the inserted ProductID
                        product.ProductID = productId; // Assign it back to the object

                        using (SqlCommand priceCommand = new SqlCommand(priceQuery, myCon))
                        {
                            priceCommand.Parameters.AddWithValue("@ProductID", product.ProductID);
                            priceCommand.Parameters.AddWithValue("@Price", product.Price);
                            priceCommand.Parameters.AddWithValue("@Quantity", product.Quantity);
                            priceCommand.ExecuteNonQuery();
                        }
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public bool Update(ProductDTO product)
        {
            string productQuery = @"UPDATE dbo.Products 
                            SET Name = @Name, 
                                Type = @Type, 
                                Description = @Description, 
                                ImageURL = @ImageURL 
                            WHERE ProductID = @ProductID";

            string priceQuery = @"IF EXISTS (SELECT 1 FROM dbo.ProductPrices WHERE ProductID = @ProductID)
                          UPDATE dbo.ProductPrices 
                          SET Price = @Price, Quantity = @Quantity 
                          WHERE ProductID = @ProductID
                          ELSE
                          INSERT INTO dbo.ProductPrices (ProductID, Price, Quantity) 
                          VALUES (@ProductID, @Price, @Quantity)";

            try
            {
                using (SqlConnection myCon = new SqlConnection(_connectionString))
                {
                    myCon.Open();
                    using (SqlCommand productCommand = new SqlCommand(productQuery, myCon))
                    {
                        productCommand.Parameters.AddWithValue("@ProductID", product.ProductID);
                        productCommand.Parameters.AddWithValue("@Name", product.Name);
                        productCommand.Parameters.AddWithValue("@Type", product.Type);
                        productCommand.Parameters.AddWithValue("@Description", product.Description);
                        productCommand.Parameters.AddWithValue("@ImageURL", product.ImageURL);
                        productCommand.ExecuteNonQuery();
                    }

                    using (SqlCommand priceCommand = new SqlCommand(priceQuery, myCon))
                    {
                        priceCommand.Parameters.AddWithValue("@ProductID", product.ProductID);
                        priceCommand.Parameters.AddWithValue("@Price", product.Price);
                        priceCommand.Parameters.AddWithValue("@Quantity", product.Quantity);
                        priceCommand.ExecuteNonQuery();
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        bool IRepository<ProductDTO>.Delete(int id)
        {
            throw new NotImplementedException();
        }

        IEnumerable<ProductDTO> IRepository<ProductDTO>.GetAll()
        {
            throw new NotImplementedException();
        }

        ProductDTO IRepository<ProductDTO>.GetById(int id)
        {
            throw new NotImplementedException();
        }

    }
}
