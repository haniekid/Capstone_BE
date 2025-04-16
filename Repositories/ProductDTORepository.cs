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
			string query = @"
		SELECT 
			p.ProductID,
			p.Name,
			p.Type,
			p.Description,
			p.ImageURL,
			pp.Price,
			pp.Quantity,
			ps.SalePrice,
			ps.SaleStartDate,
			ps.SaleEndDate,
			pi.ImageURL AS AdditionalImage
		FROM Products p
		JOIN ProductPrices pp ON p.ProductID = pp.ProductID
		LEFT JOIN ProductSales ps ON 
			ps.ProductPriceID = pp.ProductPriceID 
			AND GETDATE() BETWEEN ps.SaleStartDate AND ps.SaleEndDate
		LEFT JOIN ProductImages pi ON p.ProductID = pi.ProductID
		ORDER BY p.ProductID";

			var productDict = new Dictionary<int, ProductDTO>();

			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				using (SqlCommand myCommand = new SqlCommand(query, myCon))
				using (SqlDataReader reader = myCommand.ExecuteReader())
				{
					while (reader.Read())
					{
						int productId = reader.GetInt32(reader.GetOrdinal("ProductID"));

						if (!productDict.ContainsKey(productId))
						{
							var dto = new ProductDTO(
								productId,
								reader["Name"].ToString(),
								reader["Type"].ToString(),
								reader["Description"].ToString(),
								reader["ImageURL"].ToString(),
								reader.GetDecimal(reader.GetOrdinal("Price")),
								reader.GetInt32(reader.GetOrdinal("Quantity")),
								new List<string>(),
								reader.IsDBNull(reader.GetOrdinal("SalePrice")) ? (decimal?)null : reader.GetDecimal(reader.GetOrdinal("SalePrice")),
								reader.IsDBNull(reader.GetOrdinal("SaleStartDate")) ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("SaleStartDate")),
								reader.IsDBNull(reader.GetOrdinal("SaleEndDate")) ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("SaleEndDate"))
							);

							productDict[productId] = dto;
						}

						// Add additional images
						if (!reader.IsDBNull(reader.GetOrdinal("AdditionalImage")))
						{
							string additionalImage = reader["AdditionalImage"].ToString();
							if (!productDict[productId].ListImageURL.Contains(additionalImage))
							{
								productDict[productId].ListImageURL.Add(additionalImage);
							}
						}
					}
				}
				myCon.Close();
			}

			return productDict.Values;
		}

		ProductDTO IRepository<ProductDTO>.GetById(int id)
		{
			throw new NotImplementedException();
		}

	}
}
