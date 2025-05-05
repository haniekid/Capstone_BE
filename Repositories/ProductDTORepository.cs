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

		public bool Add(ProductDTO productDto)
		{
			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				SqlTransaction transaction = myCon.BeginTransaction();

				try
				{
					// 1. Insert into Products
					string insertProductQuery = @"
				INSERT INTO Products (Name, Type, Description, ImageURL, IsDelete)
				OUTPUT INSERTED.ProductID
				VALUES (@Name, @Type, @Description, @ImageURL, 0)";

					int productId;
					using (SqlCommand cmd = new SqlCommand(insertProductQuery, myCon, transaction))
					{
						cmd.Parameters.AddWithValue("@Name", productDto.Name);
						cmd.Parameters.AddWithValue("@Type", productDto.Type);
						cmd.Parameters.AddWithValue("@Description", productDto.Description);
						cmd.Parameters.AddWithValue("@ImageURL", productDto.ImageURL);
						productId = (int)cmd.ExecuteScalar();
					}

					// 2. Insert into ProductPrices
					string insertPriceQuery = @"
				INSERT INTO ProductPrices (Price, Quantity, ProductID)
				VALUES (@Price, @Quantity, @ProductID)";
					using (SqlCommand cmd = new SqlCommand(insertPriceQuery, myCon, transaction))
					{
						cmd.Parameters.AddWithValue("@Price", productDto.Price);
						cmd.Parameters.AddWithValue("@Quantity", productDto.Quantity);
						cmd.Parameters.AddWithValue("@ProductID", productId);
						cmd.ExecuteNonQuery();
					}

					// 3. Insert into ProductSales (if applicable)
					if (productDto.SalePrice.HasValue)
					{
						string insertSaleQuery = @"
					INSERT INTO ProductSales (ProductPriceID, SalePrice, SaleStartDate, SaleEndDate)
					VALUES (
						(SELECT TOP 1 ProductPriceID FROM ProductPrices WHERE ProductID = @ProductID ORDER BY ProductPriceID DESC),
						@SalePrice, @SaleStartDate, @SaleEndDate)";
						using (SqlCommand cmd = new SqlCommand(insertSaleQuery, myCon, transaction))
						{
							cmd.Parameters.AddWithValue("@ProductID", productId);
							cmd.Parameters.AddWithValue("@SalePrice", productDto.SalePrice);
							cmd.Parameters.AddWithValue("@SaleStartDate", (object)productDto.SaleStartDate ?? DBNull.Value);
							cmd.Parameters.AddWithValue("@SaleEndDate", (object)productDto.SaleEndDate ?? DBNull.Value);
							cmd.ExecuteNonQuery();
						}
					}

					// 4. Insert into ProductImages
					if (productDto.ListImageURL != null)
					{
						foreach (var imageUrl in productDto.ListImageURL)
						{
							string insertImageQuery = @"INSERT INTO ProductImages (ProductID, ImageURL) VALUES (@ProductID, @ImageURL)";
							using (SqlCommand cmd = new SqlCommand(insertImageQuery, myCon, transaction))
							{
								cmd.Parameters.AddWithValue("@ProductID", productId);
								cmd.Parameters.AddWithValue("@ImageURL", imageUrl);
								cmd.ExecuteNonQuery();
							}
						}
					}

					transaction.Commit();
					return true;
				}
				catch
				{
					transaction.Rollback();
					return false;
					throw;
				}
			}
		}

		public bool Update(ProductDTO productDto)
		{
			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				SqlTransaction transaction = myCon.BeginTransaction();

				try
				{
					// 1. Update Products
					string updateProductQuery = @"
				UPDATE Products 
				SET Name = @Name, Type = @Type, Description = @Description, ImageURL = @ImageURL
				WHERE ProductID = @ProductID";
					using (SqlCommand cmd = new SqlCommand(updateProductQuery, myCon, transaction))
					{
						cmd.Parameters.AddWithValue("@ProductID", productDto.ProductID);
						cmd.Parameters.AddWithValue("@Name", productDto.Name);
						cmd.Parameters.AddWithValue("@Type", productDto.Type);
						cmd.Parameters.AddWithValue("@Description", productDto.Description);
						cmd.Parameters.AddWithValue("@ImageURL", productDto.ImageURL);
						cmd.ExecuteNonQuery();
					}

					// 2. Update ProductPrices
					string updatePriceQuery = @"
				UPDATE ProductPrices 
				SET Price = @Price, Quantity = @Quantity 
				WHERE ProductID = @ProductID";
					using (SqlCommand cmd = new SqlCommand(updatePriceQuery, myCon, transaction))
					{
						cmd.Parameters.AddWithValue("@Price", productDto.Price);
						cmd.Parameters.AddWithValue("@Quantity", productDto.Quantity);
						cmd.Parameters.AddWithValue("@ProductID", productDto.ProductID);
						cmd.ExecuteNonQuery();
					}

					// 3. Update or Insert ProductSales
					string upsertSaleQuery = @"
				MERGE ProductSales AS target
				USING (
					SELECT TOP 1 ProductPriceID 
					FROM ProductPrices 
					WHERE ProductID = @ProductID 
					ORDER BY ProductPriceID DESC
				) AS source
				ON target.ProductPriceID = source.ProductPriceID
				WHEN MATCHED THEN
					UPDATE SET SalePrice = @SalePrice, SaleStartDate = @SaleStartDate, SaleEndDate = @SaleEndDate
				WHEN NOT MATCHED THEN
					INSERT (ProductPriceID, SalePrice, SaleStartDate, SaleEndDate)
					VALUES (source.ProductPriceID, @SalePrice, @SaleStartDate, @SaleEndDate);";
					using (SqlCommand cmd = new SqlCommand(upsertSaleQuery, myCon, transaction))
					{
						cmd.Parameters.AddWithValue("@ProductID", productDto.ProductID);
						cmd.Parameters.AddWithValue("@SalePrice", (object)productDto.SalePrice ?? DBNull.Value);
						cmd.Parameters.AddWithValue("@SaleStartDate", (object)productDto.SaleStartDate ?? DBNull.Value);
						cmd.Parameters.AddWithValue("@SaleEndDate", (object)productDto.SaleEndDate ?? DBNull.Value);
						cmd.ExecuteNonQuery();
					}

					// 4. Clear and re-insert ProductImages
					string deleteImagesQuery = @"DELETE FROM ProductImages WHERE ProductID = @ProductID";
					using (SqlCommand cmd = new SqlCommand(deleteImagesQuery, myCon, transaction))
					{
						cmd.Parameters.AddWithValue("@ProductID", productDto.ProductID);
						cmd.ExecuteNonQuery();
					}

					if (productDto.ListImageURL != null)
					{
						foreach (var imageUrl in productDto.ListImageURL)
						{
							string insertImageQuery = @"INSERT INTO ProductImages (ProductID, ImageURL) VALUES (@ProductID, @ImageURL)";
							using (SqlCommand cmd = new SqlCommand(insertImageQuery, myCon, transaction))
							{
								cmd.Parameters.AddWithValue("@ProductID", productDto.ProductID);
								cmd.Parameters.AddWithValue("@ImageURL", imageUrl);
								cmd.ExecuteNonQuery();
							}
						}
					}

					transaction.Commit();
					return true;
				}
				catch (Exception e)
				{
					transaction.Rollback();
					return false;
				}
			}
		}
		bool IRepository<ProductDTO>.Delete(int productId)
		{
			try
			{
				using (SqlConnection myCon = new SqlConnection(_connectionString))
				{
					string deleteQuery = "UPDATE Products SET IsDelete = 1 WHERE ProductID = @ProductID";
					using (SqlCommand cmd = new SqlCommand(deleteQuery, myCon))
					{
						cmd.Parameters.AddWithValue("@ProductID", productId);
						myCon.Open();
						cmd.ExecuteNonQuery();
						myCon.Close();
					}
				}
				return true;
			}
			catch (Exception)
			{
				return false; ;
				throw;
			}

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
						p.IsDelete,
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
					WHERE p.ProductID NOT IN (
						SELECT DISTINCT AddOnProductID FROM ProductAddOns
					)
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
								reader.IsDBNull(reader.GetOrdinal("SaleEndDate")) ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("SaleEndDate")),
								reader.IsDBNull(reader.GetOrdinal("IsDelete")) ? (bool?)null : reader.GetBoolean(reader.GetOrdinal("IsDelete"))
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
			string query = @"
							SELECT 
						p.ProductID,
						p.Name,
						p.Type,
						p.Description,
						p.ImageURL,
						p.IsDelete,
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
		WHERE ISNULL(p.IsDelete, 0) != 1 AND p.ProductID = @ProductID";

			ProductDTO product = null;

			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				using (SqlCommand myCommand = new SqlCommand(query, myCon))
				{
					myCommand.Parameters.AddWithValue("@ProductID", id);

					using (SqlDataReader reader = myCommand.ExecuteReader())
					{
						while (reader.Read())
						{
							if (product == null)
							{
								product = new ProductDTO(
									reader.GetInt32(reader.GetOrdinal("ProductID")),
									reader["Name"].ToString(),
									reader["Type"].ToString(),
									reader["Description"].ToString(),
									reader["ImageURL"].ToString(),
									reader.GetDecimal(reader.GetOrdinal("Price")),
									reader.GetInt32(reader.GetOrdinal("Quantity")),
									new List<string>(),
									reader.IsDBNull(reader.GetOrdinal("SalePrice")) ? (decimal?)null : reader.GetDecimal(reader.GetOrdinal("SalePrice")),
									reader.IsDBNull(reader.GetOrdinal("SaleStartDate")) ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("SaleStartDate")),
									reader.IsDBNull(reader.GetOrdinal("SaleEndDate")) ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("SaleEndDate")),
									reader.IsDBNull(reader.GetOrdinal("IsDelete")) ? (bool?)null : reader.GetBoolean(reader.GetOrdinal("IsDelete"))
								);
							}

							if (!reader.IsDBNull(reader.GetOrdinal("AdditionalImage")))
							{
								string image = reader["AdditionalImage"].ToString();
								if (!product.ListImageURL.Contains(image))
								{
									product.ListImageURL.Add(image);
								}
							}
						}
					}
				}
				myCon.Close();
			}

			return product;
		}

		public IEnumerable<ProductDTO> GetById2(int id)
		{
			var result = new List<ProductDTO>();

			string query = @"
						SELECT 
							p.ProductID,
							p.Name,
							p.Type,
							p.Description,
							p.ImageURL,
							p.IsDelete,
							pa.AddOnPrice AS Price,
							pa.AddOnQuantity AS Quantity,
							NULL AS SalePrice,
							NULL AS SaleStartDate,
							NULL AS SaleEndDate,
							pi.ImageURL AS AdditionalImage
						FROM ProductAddOns pa
						JOIN Products p ON pa.AddOnProductID = p.ProductID
						LEFT JOIN ProductImages pi ON p.ProductID = pi.ProductID
						WHERE pa.ProductID = @ProductId
					";

			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				using (SqlCommand myCommand = new SqlCommand(query, myCon))
				{
					myCommand.Parameters.AddWithValue("@ProductId", id);

					using (SqlDataReader reader = myCommand.ExecuteReader())
					{
						var productDict = new Dictionary<int, ProductDTO>();

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
									null,
									null,
									null,
									reader.IsDBNull(reader.GetOrdinal("IsDelete")) ? (bool?)null : reader.GetBoolean(reader.GetOrdinal("IsDelete"))
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

						result.AddRange(productDict.Values);
					}
				}
				myCon.Close();
			}

			return result;
		}
	}
}
