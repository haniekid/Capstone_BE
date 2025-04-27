using backend.DTOs;
using backend.Models;
using System.Data;
using System.Data.SqlClient;

namespace backend.Repositories
{
    public class OrderRepository : IListRepository<Order>, IListRepository<OrderDTO>
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public OrderRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("UserAppCon");
        }

        public IEnumerable<Order> GetAll()
        {
            string query = @"SELECT OrderID, DateTime, TotalPrice, Status, UserID FROM ORDERS";

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

            var orders = new List<Order>();
            foreach (DataRow row in table.Rows)
            {
                OrderStatus orderStatus = (OrderStatus)Enum.Parse(typeof(OrderStatus), row["Status"].ToString());
                orders.Add(new Order(
                    (int)row["OrderID"],
                    (DateTime)row["DateTime"],
                    (decimal)row["TotalPrice"],
                    orderStatus,
                    (int)row["UserID"]
                ));
            }
            return orders;
        }

        public List<Order> GetById(int userId)
        {
            string query = @"SELECT OrderID, DateTime, TotalPrice, Status, UserID FROM ORDERS WHERE UserID = @UserID";

            List<Order> orders = new List<Order>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserID", userId);

                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        Order order = new Order(
                            reader.GetInt32(0),
                            reader.GetDateTime(1),
                            reader.GetDecimal(2),
                            Enum.Parse<OrderStatus>(reader.GetString(3)),
                            reader.GetInt32(4)
                        );

                        orders.Add(order);
                    }

                    reader.Close();
                }

                connection.Close();
            }

            return orders;
        }


        public int Add2(OrderDTO orderDTO)
        {
            string orderQuery = @"INSERT INTO ORDERS 
                          (DateTime, TotalPrice, Status, UserID) 
                          OUTPUT INSERTED.OrderID 
                          VALUES (@DateTime, @TotalPrice, @Status, @UserID)";

            string orderItemQuery = @"INSERT INTO ORDERITEMS 
                              (Quantity, OrderID, ProductPriceID) 
                              VALUES (@Quantity, @OrderID, @ProductPriceID)";

            try
            {
                using (SqlConnection myCon = new SqlConnection(_connectionString))
                {
                    myCon.Open();

                    using (SqlTransaction transaction = myCon.BeginTransaction())
                    {
                        try
                        {
                            int newOrderId;
                            using (SqlCommand orderCommand = new SqlCommand(orderQuery, myCon, transaction))
                            {
                                orderDTO.Order.DateTime = DateTime.Now;

                                orderCommand.Parameters.AddWithValue("@DateTime", orderDTO.Order.DateTime);
                                orderCommand.Parameters.AddWithValue("@TotalPrice", orderDTO.Order.TotalPrice);
                                orderCommand.Parameters.AddWithValue("@Status", orderDTO.Order.Status.ToString());
                                orderCommand.Parameters.AddWithValue("@UserID", orderDTO.Order.UserID);

                                // Get the new OrderID
                                newOrderId = (int)orderCommand.ExecuteScalar();
                            }

                            foreach (var item in orderDTO.OrderItems)
                            {
                                using (SqlCommand itemCommand = new SqlCommand(orderItemQuery, myCon, transaction))
                                {
                                    itemCommand.Parameters.AddWithValue("@Quantity", item.Quantity);
                                    itemCommand.Parameters.AddWithValue("@OrderID", newOrderId);
                                    itemCommand.Parameters.AddWithValue("@ProductPriceID", item.ProductPriceID);

                                    itemCommand.ExecuteNonQuery();
                                }
                            }

                            transaction.Commit();

                            // ✅ Return the inserted OrderID
                            return newOrderId;
                        }
                        catch
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch
            {
                return 0; // return 0 if failed
            }
        }

        public bool Update(Order order)
        {
            string query = @"UPDATE ORDERS
                     SET Status = @Status,
                     UserID = @UserID
                     WHERE OrderID = @OrderID";

            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@OrderID", order.OrderID);
                    myCommand.Parameters.AddWithValue("@Status", order.Status.ToString());
                    myCommand.Parameters.AddWithValue("@UserID", order.UserID);

                    int rowsAffected = myCommand.ExecuteNonQuery();
                    myCon.Close();

                    return rowsAffected > 0;
                }
            }
        }

        public bool Delete(int orderId)
        {
            string query = @"DELETE FROM dbo.[ORDER] 
                     WHERE OrderID = @OrderID";

            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@OrderID", orderId);
                    int rowsAffected = myCommand.ExecuteNonQuery();
                    myCon.Close();

                    return rowsAffected > 0;
                }
            }
        }

        public Order GetObjById(int id)
        {
            throw new NotImplementedException();
        }

        IEnumerable<OrderDTO> IListRepository<OrderDTO>.GetAll()
        {
            throw new NotImplementedException();
        }

        List<OrderDTO> IListRepository<OrderDTO>.GetById(int id)
        {
            throw new NotImplementedException();
        }

        OrderDTO IListRepository<OrderDTO>.GetObjById(int id)
        {
            throw new NotImplementedException();
        }

        public bool Update(OrderDTO item)
        {
            throw new NotImplementedException();
        }

        public bool Add(Order item)
        {
            throw new NotImplementedException();
        }

        public int Add2(Order item)
        {
            throw new NotImplementedException();
        }

        bool IListRepository<OrderDTO>.Add(OrderDTO item)
        {
            throw new NotImplementedException();
        }
    }
}
