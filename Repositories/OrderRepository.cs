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
            return null;
            /* string query = @"SELECT OrderID, DateTime, TotalPrice, Status, UserID FROM ORDERS";

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
             return orders;*/
        }

        public List<Order> GetById(int userId)
        {
            return null;
            /*string query = @"SELECT OrderID, DateTime, TotalPrice, Status, UserID FROM ORDERS WHERE UserID = @UserID";

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

            return orders;*/
        }


        public int Add2(OrderDTO orderDTO)
        {
            string orderQuery = @"INSERT INTO Orders 
(DateTime, Note, ShippingMethod, PaymentMethod, VnpayOption,
 DiscountCode, ShippingFee, Subtotal, FinalTotal, Status, UserID)
OUTPUT INSERTED.OrderID 
VALUES 
(@DateTime, @Note, @ShippingMethod, @PaymentMethod, @VnpayOption,
 @DiscountCode, @ShippingFee, @Subtotal, @FinalTotal, @Status, @UserID)";

            string orderItemQuery = @"INSERT INTO OrderItems 
(OrderID, ProductName, Quantity, Price, TotalPrice) 
VALUES 
(@OrderID, @ProductName, @Quantity, @Price, @TotalPrice)";

            string shippingAddressQuery = @"INSERT INTO ShippingAddress
(OrderId, Province, DistrictId, DistrictName, WardCode, WardName, AddressDetail)
VALUES 
(@OrderId, @Province, @DistrictId, @DistrictName, @WardCode, @WardName, @AddressDetail)";
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

                            // Insert Order
                            using (SqlCommand orderCommand = new SqlCommand(orderQuery, myCon, transaction))
                            {
                                orderDTO.Order.DateTime = DateTime.Now;

                                orderCommand.Parameters.AddWithValue("@DateTime", orderDTO.Order.DateTime);
                                orderCommand.Parameters.AddWithValue("@Note", orderDTO.Order.Note ?? (object)DBNull.Value);
                                orderCommand.Parameters.AddWithValue("@ShippingMethod", orderDTO.Order.ShippingMethod ?? (object)DBNull.Value);
                                orderCommand.Parameters.AddWithValue("@PaymentMethod", orderDTO.Order.PaymentMethod ?? (object)DBNull.Value);
                                orderCommand.Parameters.AddWithValue("@VnpayOption", orderDTO.Order.VnpayOption ?? (object)DBNull.Value);
                                orderCommand.Parameters.AddWithValue("@DiscountCode", string.IsNullOrWhiteSpace(orderDTO.Order.DiscountCode)
                                                                                                ? (object)DBNull.Value
                                                                                                : orderDTO.Order.DiscountCode);
                                orderCommand.Parameters.AddWithValue("@ShippingFee", orderDTO.Order.ShippingFee);
                                orderCommand.Parameters.AddWithValue("@Subtotal", orderDTO.Order.Subtotal);
                                orderCommand.Parameters.AddWithValue("@FinalTotal", orderDTO.Order.FinalTotal);
                                orderCommand.Parameters.AddWithValue("@Status", orderDTO.Order.Status);
                                orderCommand.Parameters.AddWithValue("@UserID", orderDTO.Order.UserID);

                                newOrderId = (int)orderCommand.ExecuteScalar();
                            }

                            // Insert OrderItems
                            foreach (var item in orderDTO.OrderItems)
                            {
                                using (SqlCommand itemCommand = new SqlCommand(orderItemQuery, myCon, transaction))
                                {
                                    itemCommand.Parameters.AddWithValue("@OrderID", newOrderId);
                                    itemCommand.Parameters.AddWithValue("@ProductName", item.ProductName ?? (object)DBNull.Value);
                                    itemCommand.Parameters.AddWithValue("@Quantity", item.Quantity);
                                    itemCommand.Parameters.AddWithValue("@Price", item.Price);
                                    itemCommand.Parameters.AddWithValue("@TotalPrice", item.TotalPrice);

                                    itemCommand.ExecuteNonQuery();
                                }
                            }

                            // Insert ShippingAddress
                            if (orderDTO.ShippingAddress != null)
                            {
                                using (SqlCommand addressCommand = new SqlCommand(shippingAddressQuery, myCon, transaction))
                                {
                                    addressCommand.Parameters.AddWithValue("@OrderId", newOrderId);
                                    addressCommand.Parameters.AddWithValue("@Province", orderDTO.ShippingAddress.Province ?? (object)DBNull.Value);
                                    addressCommand.Parameters.AddWithValue("@DistrictId", orderDTO.ShippingAddress.DistrictId ?? (object)DBNull.Value);
                                    addressCommand.Parameters.AddWithValue("@DistrictName", orderDTO.ShippingAddress.DistrictName ?? (object)DBNull.Value);
                                    addressCommand.Parameters.AddWithValue("@WardCode", orderDTO.ShippingAddress.WardCode ?? (object)DBNull.Value);
                                    addressCommand.Parameters.AddWithValue("@WardName", orderDTO.ShippingAddress.WardName ?? (object)DBNull.Value);
                                    addressCommand.Parameters.AddWithValue("@AddressDetail", orderDTO.ShippingAddress.AddressDetail ?? (object)DBNull.Value);

                                    addressCommand.ExecuteNonQuery();
                                }
                            }

                            transaction.Commit();
                            return newOrderId;
                        }
                        catch (Exception e)
                        {
                            transaction.Rollback();
                            return 0;
                        }
                    }
                }
            }
            catch
            {
                return 0;
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
