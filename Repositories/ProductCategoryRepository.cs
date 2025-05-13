using backend.Models;
using System.Data.SqlClient;

namespace backend.Repositories
{
    public class ProductCategoryRepository : IRepository<ProductCategory>
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public ProductCategoryRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("UserAppCon");
        }
        public bool Add(ProductCategory item)
        {
            string query = @"
        INSERT INTO ProductCategories (CategoryName, Description, IsActive)
        VALUES (@CategoryName, @Description, @IsActive)";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CategoryName", item.CategoryName);
                    command.Parameters.AddWithValue("@Description", item.Description);
                    command.Parameters.AddWithValue("@IsActive", item.IsActive);

                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        public bool Delete(int id)
        {
            string query = "UPDATE ProductCategories SET IsActive = 0 WHERE CategoryId = @CategoryId";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CategoryId", id);

                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        public bool Delete2(ProductCategory item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ProductCategory> GetAll()
        {
            var categories = new List<ProductCategory>();

            string query = @"
    SELECT CategoryId, CategoryName, Description, IsActive
    FROM ProductCategories
    ORDER BY CategoryId";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var category = new ProductCategory
                        {
                            CategoryId = reader.GetInt32(reader.GetOrdinal("CategoryId")),
                            CategoryName = reader["CategoryName"].ToString(),
                            Description = reader["Description"].ToString(),
                            IsActive = reader.GetBoolean(reader.GetOrdinal("IsActive"))
                        };

                        categories.Add(category);
                    }
                }

                connection.Close();
            }

            return categories;
        }

        public ProductCategory GetById(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ProductCategory> GetById2(int id)
        {
            throw new NotImplementedException();
        }

        public bool Update(ProductCategory item)
        {
            string query = @"
        UPDATE ProductCategories
        SET CategoryName = @CategoryName,
            Description = @Description,
            IsActive = @IsActive
        WHERE CategoryId = @CategoryId";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CategoryId", item.CategoryId);
                    command.Parameters.AddWithValue("@CategoryName", item.CategoryName);
                    command.Parameters.AddWithValue("@Description", item.Description);
                    command.Parameters.AddWithValue("@IsActive", item.IsActive);

                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }
    }
}
