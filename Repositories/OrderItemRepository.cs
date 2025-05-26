using backend.Models;
using Org.BouncyCastle.Utilities;
using System.Data;
using System.Data.SqlClient;

namespace backend.Repositories
{
    public class OrderItemRepository : IListRepository<OrderItem>
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public OrderItemRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("UserAppCon");
        }

        public IEnumerable<OrderItem> GetAll()
        {
            string query = @"SELECT OrderItemID, ProductId, Quantity, Price, TotalPrice, OrderID, ProductName FROM dbo.OrderItems";

            DataTable table = new DataTable();
            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                using (SqlDataReader myReader = myCommand.ExecuteReader())
                {
                    table.Load(myReader);
                }
            }

            var orderItems = new List<OrderItem>();
            foreach (DataRow row in table.Rows)
            {
                orderItems.Add(new OrderItem
                {
                    OrderItemId = (int)row["OrderItemID"],
                    ProductId = row["ProductId"] == DBNull.Value ? (int?)null : (int)row["ProductId"],
                    Quantity = (int)row["Quantity"],
                    Price = (decimal)row["Price"],
                    TotalPrice = (decimal)row["TotalPrice"],
                    OrderId = (int)row["OrderID"],
                    ProductName = row["ProductName"] == DBNull.Value ? null : row["ProductName"].ToString()
                });
            }

            return orderItems;
        }
        public List<OrderItem> GetById(int orderId)
        {
            string query = @"SELECT OrderItemID, ProductId, Quantity, Price, TotalPrice, OrderID, ProductName 
                     FROM dbo.OrderItems 
                     WHERE OrderID = @OrderId";

            DataTable table = new DataTable();
            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@OrderId", orderId);

                    using (SqlDataReader myReader = myCommand.ExecuteReader())
                    {
                        table.Load(myReader);
                    }
                }
            }

            var orderItems = new List<OrderItem>();
            foreach (DataRow row in table.Rows)
            {
                orderItems.Add(new OrderItem
                {
                    OrderItemId = (int)row["OrderItemID"],
                    ProductId = row["ProductId"] == DBNull.Value ? (int?)null : (int)row["ProductId"],
                    Quantity = (int)row["Quantity"],
                    Price = (decimal)row["Price"],
                    TotalPrice = (decimal)row["TotalPrice"],
                    OrderId = (int)row["OrderID"],
                    ProductName = row["ProductName"] == DBNull.Value ? null : row["ProductName"].ToString()
                });
            }

            return orderItems;
        }


        public bool Add(OrderItem orderItem)
        {
            return true;
        }
        public bool Update(OrderItem orderItem)
        {
            return true;
            /* string query = @"UPDATE dbo.ORDER_ITEM
                              SET Quantity = @Quantity,
                              OrderID = @OrderID,
                              ProductPriceID = @ProductPriceID
                              WHERE OrderItemID = @OrderItemID";

             using (SqlConnection myCon = new SqlConnection(_connectionString))
             {
                 myCon.Open();
                 using (SqlCommand myCommand = new SqlCommand(query, myCon))
                 {
                     myCommand.Parameters.AddWithValue("@OrderItemID", orderItem.OrderItemID);
                     myCommand.Parameters.AddWithValue("@Quantity", orderItem.Quantity);
                     myCommand.Parameters.AddWithValue("@OrderID", orderItem.OrderID);
                     myCommand.Parameters.AddWithValue("@ProductPriceID", orderItem.ProductPriceID);
                     int rowsAffected = myCommand.ExecuteNonQuery();
                     return rowsAffected > 0;
                 }
             }*/
        }

        public bool Delete(int orderItemId)
        {
            string query = @"DELETE FROM dbo.ORDER_ITEM WHERE OrderItemID = @OrderItemID";

            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@OrderItemID", orderItemId);

                    int rowsAffected = myCommand.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        public OrderItem GetObjById(int id)
        {
            throw new NotImplementedException();
        }

        public int Add2(OrderItem item)
        {
            throw new NotImplementedException();
        }

        public bool Update2(List<OrderItem> items)
        {
            try
            {
                string query = @"
        UPDATE ProductPrices
        SET Quantity = Quantity - @OrderQuantity
        WHERE ProductID = @ProductId AND Quantity >= @OrderQuantity";

                using (SqlConnection myCon = new SqlConnection(_connectionString))
                {
                    myCon.Open();

                    foreach (var item in items)
                    {
                        using (SqlCommand myCommand = new SqlCommand(query, myCon))
                        {
                            myCommand.Parameters.AddWithValue("@ProductId", item.ProductId);
                            myCommand.Parameters.AddWithValue("@Price", item.Price);
                            myCommand.Parameters.AddWithValue("@OrderQuantity", item.Quantity);

                            int rowsAffected = myCommand.ExecuteNonQuery();
                        }
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        public bool Update3(List<OrderItem> items)
        {
            try
            {
                string query = @"
                        UPDATE ProductPrices
                        SET Quantity = Quantity + @OrderQuantity
                        WHERE ProductID = @ProductId AND Price = @Price";

                using (SqlConnection myCon = new SqlConnection(_connectionString))
                {
                    myCon.Open();

                    foreach (var item in items)
                    {
                        using (SqlCommand myCommand = new SqlCommand(query, myCon))
                        {
                            myCommand.Parameters.AddWithValue("@ProductId", item.ProductId);
                            myCommand.Parameters.AddWithValue("@Price", item.Price);
                            myCommand.Parameters.AddWithValue("@OrderQuantity", item.Quantity);

                            myCommand.ExecuteNonQuery();
                        }
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}

