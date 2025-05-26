using backend.Models;
using System.Data.SqlClient;

namespace backend.Repositories
{
    public class DiscountRepository : IListRepository<Discount>
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public DiscountRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("UserAppCon");
        }

        bool IListRepository<Discount>.Add(Discount discount)
        {
            {
                string query = @"INSERT INTO Discount (Code, Description, DiscountType, DiscountValue, 
                                          StartDate, EndDate, UsageLimit, UsedCount, IsActive, CreatedAt)
                     VALUES (@Code, @Description, @DiscountType, @DiscountValue, 
                             @StartDate, @EndDate, @UsageLimit, @UsedCount, @IsActive, @CreatedAt)";

                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Code", discount.Code);
                        command.Parameters.AddWithValue("@Description", (object?)discount.Description ?? DBNull.Value);
                        command.Parameters.AddWithValue("@DiscountType", discount.DiscountType);
                        command.Parameters.AddWithValue("@DiscountValue", discount.DiscountValue);
                        command.Parameters.AddWithValue("@StartDate", discount.StartDate);
                        command.Parameters.AddWithValue("@EndDate", (object?)discount.EndDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@UsageLimit", (object?)discount.UsageLimit ?? DBNull.Value);
                        command.Parameters.AddWithValue("@UsedCount", discount.UsedCount);
                        command.Parameters.AddWithValue("@IsActive", discount.IsActive);
                        command.Parameters.AddWithValue("@CreatedAt", discount.CreatedAt);

                        int rowsAffected = command.ExecuteNonQuery();

                        return rowsAffected > 0;
                    }
                }
            }
        }

        bool IListRepository<Discount>.Delete(int discountId)
        {
            string query = @"DELETE FROM Discount WHERE DiscountId = @DiscountId";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@DiscountId", discountId);

                    int rowsAffected = command.ExecuteNonQuery();

                    return rowsAffected > 0;
                }
            }
        }

        IEnumerable<Discount> IListRepository<Discount>.GetAll()
        {
            {
                string query = @"SELECT DiscountId, Code, Description, DiscountType, DiscountValue, 
                            StartDate, EndDate, UsageLimit, UsedCount, IsActive, CreatedAt
                     FROM Discount";

                List<Discount> discounts = new List<Discount>();

                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        SqlDataReader reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            Discount discount = new Discount
                            {
                                DiscountId = reader.GetInt32(0),
                                Code = reader.GetString(1),
                                Description = reader.IsDBNull(2) ? null : reader.GetString(2),
                                DiscountType = reader.GetString(3),
                                DiscountValue = reader.GetDecimal(4),
                                StartDate = reader.GetDateTime(5),
                                EndDate = reader.IsDBNull(6) ? (DateTime?)null : reader.GetDateTime(6),
                                UsageLimit = reader.IsDBNull(7) ? (int?)null : reader.GetInt32(7),
                                UsedCount = reader.GetInt32(8),
                                IsActive = reader.GetBoolean(9),
                                CreatedAt = reader.GetDateTime(10)
                            };

                            discounts.Add(discount);
                        }

                        reader.Close();
                    }

                    connection.Close();
                }

                return discounts;
            }
        }

        List<Discount> IListRepository<Discount>.GetById(int id)
        {
            string query = @"SELECT DiscountId, Code, Description, DiscountType, DiscountValue, 
                            StartDate, EndDate, UsageLimit, UsedCount, IsActive, CreatedAt
                     FROM Discount WHERE DiscountId = @DiscountId";

            List<Discount> discounts = new List<Discount>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@DiscountId", id);

                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        Discount discount = new Discount
                        {
                            DiscountId = reader.GetInt32(0),
                            Code = reader.GetString(1),
                            Description = reader.IsDBNull(2) ? null : reader.GetString(2),
                            DiscountType = reader.GetString(3),
                            DiscountValue = reader.GetDecimal(4),
                            StartDate = reader.GetDateTime(5),
                            EndDate = reader.IsDBNull(6) ? (DateTime?)null : reader.GetDateTime(6),
                            UsageLimit = reader.IsDBNull(7) ? (int?)null : reader.GetInt32(7),
                            UsedCount = reader.GetInt32(8),
                            IsActive = reader.GetBoolean(9),
                            CreatedAt = reader.GetDateTime(10)
                        };

                        discounts.Add(discount);
                    }

                    reader.Close();
                }

                connection.Close();
            }

            return discounts;
        }

        Discount IListRepository<Discount>.GetObjById(int id)
        {
            throw new NotImplementedException();
        }

        public bool Update(Discount discount)
        {
            string query = @"UPDATE Discount 
                     SET Code = @Code,
                         Description = @Description,
                         DiscountType = @DiscountType,
                         DiscountValue = @DiscountValue,
                         StartDate = @StartDate,
                         EndDate = @EndDate,
                         UsageLimit = @UsageLimit,
                         UsedCount = @UsedCount,
                         IsActive = @IsActive,
                         CreatedAt = @CreatedAt
                     WHERE DiscountId = @DiscountId";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@DiscountId", discount.DiscountId);
                    command.Parameters.AddWithValue("@Code", discount.Code);
                    command.Parameters.AddWithValue("@Description", (object?)discount.Description ?? DBNull.Value);
                    command.Parameters.AddWithValue("@DiscountType", discount.DiscountType);
                    command.Parameters.AddWithValue("@DiscountValue", discount.DiscountValue);
                    command.Parameters.AddWithValue("@StartDate", discount.StartDate);
                    command.Parameters.AddWithValue("@EndDate", (object?)discount.EndDate ?? DBNull.Value);
                    command.Parameters.AddWithValue("@UsageLimit", (object?)discount.UsageLimit ?? DBNull.Value);
                    command.Parameters.AddWithValue("@UsedCount", discount.UsedCount);
                    command.Parameters.AddWithValue("@IsActive", discount.IsActive);
                    command.Parameters.AddWithValue("@CreatedAt", discount.CreatedAt);

                    int rowsAffected = command.ExecuteNonQuery();

                    return rowsAffected > 0;
                }
            }
        }

        public int Add2(Discount item)
        {
            throw new NotImplementedException();
        }

        public bool Update2(List<Discount> item)
        {
            throw new NotImplementedException();
        }

        public bool Update3(List<Discount> item)
        {
            throw new NotImplementedException();
        }
    }
}
