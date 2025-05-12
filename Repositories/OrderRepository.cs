using backend.DTOs;
using backend.Models;
using MailKit.Search;
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
            var orders = new List<Order>();

            string query = "SELECT * FROM Orders";

            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                using (SqlDataReader reader = myCommand.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var order = new Order
                        {
                            OrderID = (int)reader["OrderID"],
                            Status = Enum.TryParse<OrderStatus>(reader["Status"].ToString(), out var status) ? status : OrderStatus.Processing,
                            UserID = (int)reader["UserID"],
                            DiscountCode = reader["DiscountCode"] as string,
                            ShippingMethod = reader["ShippingMethod"] as string,
                            ShippingFee = reader["ShippingFee"] != DBNull.Value ? (decimal)reader["ShippingFee"] : 0,
                            PaymentMethod = reader["PaymentMethod"] as string,
                            VnpayOption = reader["VnpayOption"] as string,
                            Subtotal = reader["Subtotal"] != DBNull.Value ? (decimal)reader["Subtotal"] : 0,
                            FinalTotal = reader["FinalTotal"] != DBNull.Value ? (decimal)reader["FinalTotal"] : 0,
                            DateTime = reader["DateTime"] != DBNull.Value ? (DateTime)reader["DateTime"] : DateTime.MinValue,
                            Note = reader["Note"] as string
                        };

                        orders.Add(order);
                    }
                }
            }

            return orders;
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
            string query = @"
        UPDATE Orders
        SET 
            Status = @Status,
            UserID = @UserID,
            DiscountCode = @DiscountCode,
            ShippingMethod = @ShippingMethod,
            ShippingFee = @ShippingFee,
            PaymentMethod = @PaymentMethod,
            VnpayOption = @VnpayOption,
            Subtotal = @Subtotal,
            FinalTotal = @FinalTotal,
            DateTime = @DateTime,
            Note = @Note
        WHERE OrderID = @OrderID";

            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@OrderID", order.OrderID);
                    myCommand.Parameters.AddWithValue("@Status", order.Status.ToString()); // Save enum as string
                    myCommand.Parameters.AddWithValue("@UserID", order.UserID);
                    myCommand.Parameters.AddWithValue("@DiscountCode", (object?)order.DiscountCode ?? DBNull.Value);
                    myCommand.Parameters.AddWithValue("@ShippingMethod", (object?)order.ShippingMethod ?? DBNull.Value);
                    myCommand.Parameters.AddWithValue("@ShippingFee", order.ShippingFee);
                    myCommand.Parameters.AddWithValue("@PaymentMethod", (object?)order.PaymentMethod ?? DBNull.Value);
                    myCommand.Parameters.AddWithValue("@VnpayOption", (object?)order.VnpayOption ?? DBNull.Value);
                    myCommand.Parameters.AddWithValue("@Subtotal", order.Subtotal);
                    myCommand.Parameters.AddWithValue("@FinalTotal", order.FinalTotal);
                    myCommand.Parameters.AddWithValue("@DateTime", order.DateTime);
                    myCommand.Parameters.AddWithValue("@Note", (object?)order.Note ?? DBNull.Value);

                    int rowsAffected = myCommand.ExecuteNonQuery();
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

        List<OrderDTO> IListRepository<OrderDTO>.GetById(int userId)
        {
            {
                var orderDTOs = new List<OrderDTO>();

                string orderQuery = @"SELECT * FROM Orders WHERE UserID = @UserID";
                string orderItemQuery = @"SELECT * FROM OrderItems WHERE OrderID = @OrderID";
                string shippingAddressQuery = @"SELECT * FROM ShippingAddress WHERE OrderId = @OrderID";

                using (SqlConnection myCon = new SqlConnection(_connectionString))
                {
                    myCon.Open();

                    using (SqlCommand orderCommand = new SqlCommand(orderQuery, myCon))
                    {
                        orderCommand.Parameters.AddWithValue("@UserID", userId);

                        using (SqlDataReader orderReader = orderCommand.ExecuteReader())
                        {
                            while (orderReader.Read())
                            {
                                var order = new Order
                                {
                                    OrderID = (int)orderReader["OrderID"],
                                    DateTime = (DateTime)orderReader["DateTime"],
                                    Note = orderReader["Note"] as string,
                                    ShippingMethod = orderReader["ShippingMethod"] as string,
                                    PaymentMethod = orderReader["PaymentMethod"] as string,
                                    VnpayOption = orderReader["VnpayOption"] as string,
                                    DiscountCode = orderReader["DiscountCode"] as string,
                                    ShippingFee = (decimal)orderReader["ShippingFee"],
                                    Subtotal = (decimal)orderReader["Subtotal"],
                                    FinalTotal = (decimal)orderReader["FinalTotal"],
                                    Status = Enum.TryParse<OrderStatus>(orderReader["Status"].ToString(), out var status)
                                                                            ? status
                                                                            : OrderStatus.Processing,
                                UserID = (int)orderReader["UserID"]
                                };

                                // Get OrderItems
                                var orderItems = new List<OrderItem>();
                                using (SqlCommand itemCommand = new SqlCommand(orderItemQuery, myCon))
                                {
                                    itemCommand.Parameters.AddWithValue("@OrderID", order.OrderID);
                                    using (SqlDataReader itemReader = itemCommand.ExecuteReader())
                                    {
                                        while (itemReader.Read())
                                        {
                                            orderItems.Add(new OrderItem
                                            {
                                                OrderItemId = (int)itemReader["OrderItemID"],
                                                OrderId = (int)itemReader["OrderID"],
                                                ProductName = itemReader["ProductName"] as string,
                                                Quantity = (int)itemReader["Quantity"],
                                                Price = (decimal)itemReader["Price"],
                                                TotalPrice = (decimal)itemReader["TotalPrice"]
                                            });
                                        }
                                    }
                                }

                                // Get ShippingAddress
                                ShippingAddress shippingAddress = null;
                                using (SqlCommand addressCommand = new SqlCommand(shippingAddressQuery, myCon))
                                {
                                    addressCommand.Parameters.AddWithValue("@OrderID", order.OrderID);
                                    using (SqlDataReader addressReader = addressCommand.ExecuteReader())
                                    {
                                        if (addressReader.Read())
                                        {
                                            shippingAddress = new ShippingAddress
                                            {
                                                ShippingAddressId = (int)addressReader["ShippingAddressID"],
                                                OrderId = (int)addressReader["OrderId"],
                                                Province = addressReader["Province"] as string,
                                                DistrictId = addressReader["DistrictId"] as string,
                                                DistrictName = addressReader["DistrictName"] as string,
                                                WardCode = addressReader["WardCode"] as string,
                                                WardName = addressReader["WardName"] as string,
                                                AddressDetail = addressReader["AddressDetail"] as string
                                            };
                                        }
                                    }
                                }

                                // Add to result
                                orderDTOs.Add(new OrderDTO(order, shippingAddress, orderItems));
                            }
                        }
                    }
                }

                return orderDTOs;
            }
        }

        OrderDTO IListRepository<OrderDTO>.GetObjById(int orderId)
        {
            OrderDTO orderDTO = null;

            string orderQuery = @"SELECT * FROM Orders WHERE OrderID = @OrderID";
            string orderItemQuery = @"SELECT * FROM OrderItems WHERE OrderID = @OrderID";
            string shippingAddressQuery = @"SELECT * FROM ShippingAddress WHERE OrderId = @OrderID";

            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();

                using (SqlCommand orderCommand = new SqlCommand(orderQuery, myCon))
                {
                    orderCommand.Parameters.AddWithValue("@OrderID", orderId);

                    using (SqlDataReader orderReader = orderCommand.ExecuteReader())
                    {
                        if (orderReader.Read())
                        {
                            var order = new Order
                            {
                                OrderID = (int)orderReader["OrderID"],
                                DateTime = (DateTime)orderReader["DateTime"],
                                Note = orderReader["Note"] as string,
                                ShippingMethod = orderReader["ShippingMethod"] as string,
                                PaymentMethod = orderReader["PaymentMethod"] as string,
                                VnpayOption = orderReader["VnpayOption"] as string,
                                DiscountCode = orderReader["DiscountCode"] as string,
                                ShippingFee = (decimal)orderReader["ShippingFee"],
                                Subtotal = (decimal)orderReader["Subtotal"],
                                FinalTotal = (decimal)orderReader["FinalTotal"],
                                Status = Enum.TryParse<OrderStatus>(orderReader["Status"].ToString(), out var status)
                                            ? status
                                            : OrderStatus.Processing,
                                UserID = (int)orderReader["UserID"]
                            };

                            // Get OrderItems
                            var orderItems = new List<OrderItem>();
                            using (SqlCommand itemCommand = new SqlCommand(orderItemQuery, myCon))
                            {
                                itemCommand.Parameters.AddWithValue("@OrderID", order.OrderID);
                                using (SqlDataReader itemReader = itemCommand.ExecuteReader())
                                {
                                    while (itemReader.Read())
                                    {
                                        orderItems.Add(new OrderItem
                                        {
                                            OrderItemId = (int)itemReader["OrderItemID"],
                                            OrderId = (int)itemReader["OrderID"],
                                            ProductName = itemReader["ProductName"] as string,
                                            Quantity = (int)itemReader["Quantity"],
                                            Price = (decimal)itemReader["Price"],
                                            TotalPrice = (decimal)itemReader["TotalPrice"]
                                        });
                                    }
                                }
                            }

                            // Get ShippingAddress
                            ShippingAddress shippingAddress = null;
                            using (SqlCommand addressCommand = new SqlCommand(shippingAddressQuery, myCon))
                            {
                                addressCommand.Parameters.AddWithValue("@OrderID", order.OrderID);
                                using (SqlDataReader addressReader = addressCommand.ExecuteReader())
                                {
                                    if (addressReader.Read())
                                    {
                                        shippingAddress = new ShippingAddress
                                        {
                                            ShippingAddressId = (int)addressReader["ShippingAddressID"],
                                            OrderId = (int)addressReader["OrderId"],
                                            Province = addressReader["Province"] as string,
                                            DistrictId = addressReader["DistrictId"] as string,
                                            DistrictName = addressReader["DistrictName"] as string,
                                            WardCode = addressReader["WardCode"] as string,
                                            WardName = addressReader["WardName"] as string,
                                            AddressDetail = addressReader["AddressDetail"] as string
                                        };
                                    }
                                }
                            }

                            orderDTO = new OrderDTO(order, shippingAddress, orderItems);
                        }
                    }
                }
            }

            return orderDTO;
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

        List<Order> IListRepository<Order>.GetById(int id)
        {
            throw new NotImplementedException();
        }
    }
}
