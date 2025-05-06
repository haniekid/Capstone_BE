using backend.Models;
using System.Data.SqlClient;

namespace backend.Repositories
{
	public class AddOnProductRepository : IRepository<AddOnProductRequest>
	{
		private readonly IConfiguration _configuration;
		private readonly string _connectionString;

		public AddOnProductRepository(IConfiguration configuration)
		{
			_configuration = configuration;
			_connectionString = _configuration.GetConnectionString("UserAppCon");
		}

		public bool Add(AddOnProductRequest product)
		{
			string query = @"
		IF NOT EXISTS (
			SELECT 1 FROM ProductAddOns 
			WHERE ProductID = @ProductID AND AddOnProductID = @AddOnProductID
		)
		BEGIN
			INSERT INTO ProductAddOns (ProductID, AddOnProductID)
			VALUES (@ProductID, @AddOnProductID)
		END";

			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				using (SqlCommand myCommand = new SqlCommand(query, myCon))
				{
					myCommand.Parameters.AddWithValue("@ProductID", product.ProductId);
					myCommand.Parameters.AddWithValue("@AddOnProductID", product.AddOnProductId);

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

		public bool Delete2(AddOnProductRequest item)
		{
			string query = @"
		DELETE FROM ProductAddOns
		WHERE ProductID = @MainProductId AND AddOnProductID = @AddOnProductId";

			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				using (SqlCommand myCommand = new SqlCommand(query, myCon))
				{
					myCommand.Parameters.AddWithValue("@MainProductId", item.ProductId);
					myCommand.Parameters.AddWithValue("@AddOnProductId", item.AddOnProductId);

					int rowsAffected = myCommand.ExecuteNonQuery();
					return rowsAffected > 0;
				}
			}
		}

		public IEnumerable<AddOnProductRequest> GetAll()
		{
			throw new NotImplementedException();
		}

		public AddOnProductRequest GetById(int id)
		{
			throw new NotImplementedException();
		}

		public IEnumerable<AddOnProductRequest> GetById2(int id)
		{
			throw new NotImplementedException();
		}

		public bool Update(AddOnProductRequest item)
		{
			throw new NotImplementedException();
		}
	}
}
