using backend.Models;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace backend.Repositories
{
	public class UserRepository : IRepository<User>
	{
		private readonly IConfiguration _configuration;
		private readonly string _connectionString;

		public UserRepository(IConfiguration configuration)
		{
			_configuration = configuration;
			_connectionString = _configuration.GetConnectionString("UserAppCon");
		}

        public IEnumerable<User> GetAll()
        {
            string query = @"SELECT 
		u.UserID, u.FirstName, u.LastName, u.Email, u.Phone, 
		u.PasswordHash,	u.ActivationToken, u.IsActivated, u.ResetPasswordToken, u.ResetTokenExpiry,
		u.DistrictID, u.WardCode, u.AddressDetail,
		r.RoleName 
	FROM [Users] u
	LEFT JOIN [Roles] r ON u.RoleID = r.RoleID";

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

            var users = new List<User>();
            foreach (DataRow row in table.Rows)
            {
                var user = new User
                {
                    UserID = (int)row["UserID"],
                    FirstName = row["FirstName"].ToString(),
                    LastName = row["LastName"].ToString(),
                    Email = row["Email"].ToString(),
                    Phone = row["Phone"].ToString(),
                    Password = row["PasswordHash"].ToString(),
                    RoleName = row["RoleName"] != DBNull.Value ? row["RoleName"].ToString() : null,
                    ActivationToken = row["ActivationToken"] != DBNull.Value ? row["ActivationToken"].ToString() : null,
                    IsActivated = row["IsActivated"] != DBNull.Value ? (bool)row["IsActivated"] : false,
                    ResetPasswordToken = row["ResetPasswordToken"] != DBNull.Value ? row["ResetPasswordToken"].ToString() : null,
                    ResetTokenExpiry = row["ResetTokenExpiry"] != DBNull.Value ? (DateTime?)row["ResetTokenExpiry"] : null,
                    DistrictID = row["DistrictID"] != DBNull.Value ? (int?)Convert.ToInt32(row["DistrictID"]) : null,
                    WardCode = row["WardCode"].ToString(),
                    AddressDetail = row["AddressDetail"] != DBNull.Value ? row["AddressDetail"].ToString() : null
                };
                users.Add(user);
            }
            return users;
        }

        public User GetById(int userId)
        {
            string query = @"
		SELECT 
			u.UserID, u.FirstName, u.LastName, u.Email, u.Phone, 
			u.PasswordHash, u.ActivationToken, u.IsActivated, 
			u.ResetPasswordToken, u.ResetTokenExpiry,
			u.DistrictID, u.WardCode, u.AddressDetail,
			r.RoleName
		FROM [Users] u
		LEFT JOIN [Roles] r ON u.RoleID = r.RoleID
		WHERE u.UserID = @UserID";

            User user = null;

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserID", userId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            user = new User
                            {
                                UserID = reader.GetInt32(0),
                                FirstName = reader.GetString(1),
                                LastName = reader.GetString(2),
                                Email = reader.GetString(3),
                                Phone = reader.GetString(4),
                                Password = reader.GetString(5),
                                ActivationToken = reader.IsDBNull(6) ? null : reader.GetString(6),
                                IsActivated = reader.IsDBNull(7) ? false : reader.GetBoolean(7),
                                ResetPasswordToken = reader.IsDBNull(8) ? null : reader.GetString(8),
                                ResetTokenExpiry = reader.IsDBNull(9) ? (DateTime?)null : reader.GetDateTime(9),
                                DistrictID = reader.IsDBNull(10) ? (int?)null : reader.GetInt32(10),
                                WardCode = reader.GetString(11),
                                AddressDetail = reader.IsDBNull(12) ? null : reader.GetString(12),
                                RoleName = reader.IsDBNull(13) ? null : reader.GetString(13)
                            };
                        }
                    }
                }
            }

            return user;
        }

        public bool Add(User user)
		{
			string query = @"
		INSERT INTO USERS
		(FirstName, LastName, Email, Phone, PasswordHash, RoleId, ActivationToken, IsActivated) 
		VALUES 
		(@FirstName, @LastName, @Email, @Phone, @Password, @RoleId, @ActivationToken, @IsActivated)";

			try
			{
				using (SqlConnection myCon = new SqlConnection(_connectionString))
				{
					myCon.Open();
					using (SqlCommand myCommand = new SqlCommand(query, myCon))
					{
						myCommand.Parameters.AddWithValue("@FirstName", user.FirstName);
						myCommand.Parameters.AddWithValue("@LastName", user.LastName);
						myCommand.Parameters.AddWithValue("@Email", user.Email);
						myCommand.Parameters.AddWithValue("@Phone", user.Phone);
						myCommand.Parameters.AddWithValue("@Password", user.Password);
						myCommand.Parameters.AddWithValue("@RoleId", 2);
						myCommand.Parameters.AddWithValue("@ActivationToken", user.ActivationToken);
						myCommand.Parameters.AddWithValue("@IsActivated", user.IsActivated);

						myCommand.ExecuteNonQuery();
					}
				}
				return true;
			}
			catch (Exception ex)
			{
				// Optional: Log the error here
				return false;
			}
		}

        public bool Update(User user)
        {
            string query = @"
		UPDATE Users
		SET FirstName = @FirstName,
			LastName = @LastName,
			Email = @Email,
			Phone = @Phone,
			PasswordHash = @PasswordHash,
			IsActivated = @IsActivated,
			ActivationToken = @ActivationToken,
			ResetPasswordToken = @ResetPasswordToken,
			ResetTokenExpiry = @ResetTokenExpiry,
			DistrictID = @DistrictID,
			WardCode = @WardCode,
			AddressDetail = @AddressDetail
		WHERE UserID = @UserID";

            using (SqlConnection myCon = new SqlConnection(_connectionString))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@UserID", user.UserID);
                    myCommand.Parameters.AddWithValue("@FirstName", user.FirstName);
                    myCommand.Parameters.AddWithValue("@LastName", user.LastName);
                    myCommand.Parameters.AddWithValue("@Email", user.Email);
                    myCommand.Parameters.AddWithValue("@Phone", user.Phone);
                    myCommand.Parameters.AddWithValue("@PasswordHash", user.Password);
                    myCommand.Parameters.AddWithValue("@ActivationToken", (object?)user.ActivationToken ?? DBNull.Value);
                    myCommand.Parameters.AddWithValue("@IsActivated", user.IsActivated.HasValue ? (object)user.IsActivated.Value : DBNull.Value);
                    myCommand.Parameters.AddWithValue("@ResetPasswordToken", (object?)user.ResetPasswordToken ?? DBNull.Value);
                    myCommand.Parameters.AddWithValue("@ResetTokenExpiry", user.ResetTokenExpiry.HasValue ? (object)user.ResetTokenExpiry.Value : DBNull.Value);
                    myCommand.Parameters.AddWithValue("@DistrictID", user.DistrictID.HasValue ? (object)user.DistrictID.Value : DBNull.Value);
                    myCommand.Parameters.AddWithValue("@WardCode", user.WardCode);
                    myCommand.Parameters.AddWithValue("@AddressDetail", (object?)user.AddressDetail ?? DBNull.Value);

                    int rowsAffected = myCommand.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        public bool Delete(int userId)
		{
			string query = @"DELETE FROM dbo.[USER] 
							 WHERE UserID = @UserID";

			using (SqlConnection myCon = new SqlConnection(_connectionString))
			{
				myCon.Open();
				using (SqlCommand myCommand = new SqlCommand(query, myCon))
				{
					myCommand.Parameters.AddWithValue("@UserID", userId);
					int rowsAffected = myCommand.ExecuteNonQuery();
					myCon.Close();

					return rowsAffected > 0;
				}
			}
		}

		public IEnumerable<User> GetById2(int id)
		{
			throw new NotImplementedException();
		}

		public bool Add2(User item, int id)
		{
			throw new NotImplementedException();
		}

		public bool Delete2(User item)
		{
			throw new NotImplementedException();
		}
	}
}

