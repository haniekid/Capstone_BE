using backend.Models;
using System.Data;
using System.Data.SqlClient;

namespace backend.Repositories
{
    public class ProductPriceRepository : IListRepository<ProductPrice>
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public ProductPriceRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("UserAppCon");
        }

        public IEnumerable<ProductPrice> GetAll()
        {
            string query = @"SELECT ProductPriceID, Price, Quantity, ProductID FROM ProductPriceS";

            DataTable table = new DataTable();
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            var ProductPrices = new List<ProductPrice>();
            foreach (DataRow row in table.Rows)
            {
                ProductPrices.Add(new ProductPrice(
                    (int)row["ProductPriceID"],
                    (decimal)row["Price"],
                    (int)row["Quantity"],
                    (int)row["ProductID"]
                ));
            }
            return ProductPrices;
        }

        public ProductPrice GetObjById(int productId)
        {
            string query = @"SELECT * FROM dbo.ProductPrices WHERE ProductID = @ProductID";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ProductID", productId);

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        ProductPrice productPrice = new ProductPrice(
                            reader.GetInt32(reader.GetOrdinal("ProductPriceID")), // Cột ProductPriceID
                            reader.GetDecimal(reader.GetOrdinal("Price")),        // Cột Price
                            reader.GetInt32(reader.GetOrdinal("Quantity")),       // Cột Quantity
                            reader.GetInt32(reader.GetOrdinal("ProductID"))       // Cột ProductID
                        );

                        reader.Close();
                        return productPrice;
                    }
                    else
                    {
                        reader.Close();
                        return null; // Hoặc ném ra exception nếu cần
                    }
                }
            }
        }

        public List<ProductPrice> GetById(int productId)
        {
            string query = @"SELECT * FROM dbo.ProductPrices WHERE ProductID = @ProductID";

            List<ProductPrice> productPrices = new List<ProductPrice>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ProductID", productId);

                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        ProductPrice productPrice = new ProductPrice(
                            reader.GetInt32(reader.GetOrdinal("ProductPriceID")), // Cột ProductPriceID
                            reader.GetDecimal(reader.GetOrdinal("Price")),        // Cột Price
                            reader.GetInt32(reader.GetOrdinal("Quantity")),       // Cột Quantity
                            reader.GetInt32(reader.GetOrdinal("ProductID"))       // Cột ProductID
                        );

                        productPrices.Add(productPrice);
                    }

                    reader.Close();
                }

                connection.Close();
            }

            return productPrices;
        }

        public bool Add(ProductPrice ProductPrice)
        {
            string query = @"INSERT INTO dbo.PRODUCT_SIZE 
                             (Size, Price, Quantity, ProductID) 
                             VALUES (@Size, @Price, @Quantity, @ProductID)";

            try
            {
                using (SqlConnection myCon = new SqlConnection(_connectionString))
                {
                    myCon.Open();
                    using (SqlCommand myCommand = new SqlCommand(query, myCon))
                    {
                        myCommand.Parameters.AddWithValue("@Price", ProductPrice.Price);
                        myCommand.Parameters.AddWithValue("@Quantity", ProductPrice.Quantity);
                        myCommand.Parameters.AddWithValue("@ProductID", ProductPrice.ProductID);
                        myCommand.ExecuteNonQuery();
                        myCon.Close();
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public bool Update(ProductPrice productPrice)
        {
            string query = @"UPDATE dbo.ProductPrices 
                     SET Price = @Price, Quantity = @Quantity
                     WHERE ProductPriceID = @ProductPriceID;";

            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@ProductPriceID", productPrice.ProductPriceID);
                    myCommand.Parameters.AddWithValue("@Price", productPrice.Price);
                    myCommand.Parameters.AddWithValue("@Quantity", productPrice.Quantity);

                    int rowsAffected = myCommand.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        public bool Delete(int ProductPriceID)
        {
            string query = @"DELETE FROM dbo.PRODUCT_SIZE WHERE ProductPriceID = @ProductPriceID";

            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@ProductPriceID", ProductPriceID);

                    int rowsAffected = myCommand.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        public int Add2(ProductPrice item)
        {
            throw new NotImplementedException();
        }

        public bool Update2(List<ProductPrice> item)
        {
            throw new NotImplementedException();
        }

        public bool Update3(List<ProductPrice> item)
        {
            throw new NotImplementedException();
        }
    }
}

