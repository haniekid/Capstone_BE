using backend.Models;
using System.Data.SqlClient;

namespace backend.Repositories
{
	public class ProductTypeRepository : IRepository<ProductType>
	{
		private readonly IConfiguration _configuration;
		private readonly string _connectionString;

		public ProductTypeRepository(IConfiguration configuration)
		{
			_configuration = configuration;
			_connectionString = _configuration.GetConnectionString("UserAppCon");
		}
		public bool Add(ProductType item)
		{
			throw new NotImplementedException();
		}

		public bool Add2(ProductType item, int id)
		{
			throw new NotImplementedException();
		}

		public bool Delete(int id)
		{
			throw new NotImplementedException();
		}

		public bool Delete2(ProductType item)
		{
			throw new NotImplementedException();
		}

		public IEnumerable<ProductType> GetAll()
		{
			var types = new List<ProductType>();
			string query = @"
		SELECT DISTINCT Type 
		FROM Products 
		WHERE IsDelete IS NULL OR IsDelete = 0";

			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				using (SqlCommand myCommand = new SqlCommand(query, myCon))
				{
					using (SqlDataReader reader = myCommand.ExecuteReader())
					{
						while (reader.Read())
						{
							types.Add(new ProductType(reader["Type"].ToString()));
						}
					}
				}
				myCon.Close();
			}

			return types;
		}

		public ProductType GetById(int id)
		{
			throw new NotImplementedException();
		}

		public IEnumerable<ProductType> GetById2(int id)
		{
			throw new NotImplementedException();
		}

		public bool Update(ProductType item)
		{
			throw new NotImplementedException();
		}
	}
}
