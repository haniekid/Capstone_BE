using backend.Models;
using System.Data.SqlClient;

namespace backend.Repositories
{
	public class AddOnProductRepository : IRepository<ProductDTO>
	{
		private readonly IConfiguration _configuration;
		private readonly string _connectionString;

		public AddOnProductRepository(IConfiguration configuration)
		{
			_configuration = configuration;
			_connectionString = _configuration.GetConnectionString("UserAppCon");
		}
		public bool Add(ProductDTO item)
		{
			throw new NotImplementedException();
		}

		public bool Add2(int productId, int addOnProductId)
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
					NULL AS SalePrice,
					NULL AS SaleStartDate,
					NULL AS SaleEndDate,
					pi.ImageURL AS AdditionalImage
				FROM ProductAddOns pa
				JOIN Products p ON pa.AddOnProductID = p.ProductID
				JOIN ProductPrices pp ON pp.ProductID = p.ProductID
				LEFT JOIN ProductImages pi ON p.ProductID = pi.ProductID
				WHERE pa.ProductID = @ProductId";

			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				using (SqlCommand myCommand = new SqlCommand(query, myCon))
				{
					myCommand.Parameters.AddWithValue("@ProductID", productId);
					myCommand.Parameters.AddWithValue("@AddOnProductID", addOnProductId);

					try
					{
						int rowsAffected = myCommand.ExecuteNonQuery();
						return rowsAffected > 0;
					}
					catch (SqlException ex)
					{
						Console.WriteLine(ex.Message);
						return false;
					}
				}
			}
		}

		public bool Delete(int id)
		{
			throw new NotImplementedException();
		}

		public IEnumerable<ProductDTO> GetAll()
		{
			throw new NotImplementedException();
		}

		public ProductDTO GetById(int id)
		{
			throw new NotImplementedException();
		}

		public IEnumerable<ProductDTO> GetById2(int id)
		{
			throw new NotImplementedException();
		}

		public bool Update(ProductDTO item)
		{
			throw new NotImplementedException();
		}
	}
}
