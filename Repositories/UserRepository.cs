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
						u.PasswordHash, u.Address, u.City, u.PostalCode, u.ActivationToken, u.IsActivated,
						r.RoleName 
					 FROM [Users] u
					 LEFT JOIN [Roles] r ON u.RoleID = r.RoleID";

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

			var users = new List<User>();
			foreach (DataRow row in table.Rows)
			{
				users.Add(new User(
					(int)row["UserID"],
					row["FirstName"].ToString(),
					row["LastName"].ToString(),
					row["Email"].ToString(),
					row["Phone"].ToString(),
					row["PasswordHash"].ToString(),
					row["Address"] != DBNull.Value ? row["Address"].ToString() : null,
					row["City"] != DBNull.Value ? row["City"].ToString() : null,
					row["PostalCode"] != DBNull.Value ? row["PostalCode"].ToString() : null,
					row["RoleName"] != DBNull.Value ? row["RoleName"].ToString() : null ,
					row["ActivationToken"] != DBNull.Value ? row["ActivationToken"].ToString() : null 
				));
			}
			return users;
		}

		public User GetById(int userId)
		{
			string query = @"SELECT 
						u.UserID, u.FirstName, u.LastName, u.Email, u.Phone, 
						u.PasswordHash, u.Address, u.City, u.PostalCode, 
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

					SqlDataReader reader = command.ExecuteReader();

					if (reader.Read())
					{
						user = new User(
							reader.GetInt32(0),    // UserID
							reader.GetString(1),   // FirstName
							reader.GetString(2),   // LastName
							reader.GetString(3),   // Email
							reader.GetString(4),   // Phone
							reader.GetString(5),   // PasswordHash
							reader["Address"] != DBNull.Value ? reader.GetString(6) : null,
							reader["City"] != DBNull.Value ? reader.GetString(7) : null,
							reader["PostalCode"] != DBNull.Value ? reader.GetString(8) : null,
							reader["RoleName"] != DBNull.Value ? reader.GetString(9) : null 
						);
					}

					reader.Close();
				}

				connection.Close();
			}

			return user;
		}

		public bool Add(User user)
		{
			string query = @"
		INSERT INTO USERS
		(FirstName, LastName, Email, Phone, PasswordHash, Address, City, PostalCode, RoleId, ActivationToken, IsActivated) 
		VALUES 
		(@FirstName, @LastName, @Email, @Phone, @Password, @Address, @City, @PostalCode, @RoleId, @ActivationToken, @IsActivated)";

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
						myCommand.Parameters.AddWithValue("@Address", user.Address ?? (object)DBNull.Value);
						myCommand.Parameters.AddWithValue("@City", user.City ?? (object)DBNull.Value);
						myCommand.Parameters.AddWithValue("@PostalCode", user.PostalCode ?? (object)DBNull.Value);
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
			string query = @"UPDATE USERS
					 SET FirstName = @FirstName,
						 LastName = @LastName,
						 Email = @Email,
						 Phone = @Phone,
						 Address = @Address,
						 City = @City,
						 PostalCode = @PostalCode,
						 IsActivated = @IsActivated,
						 ActivationToken = @ActivationToken
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
					myCommand.Parameters.AddWithValue("@Address", user.Address);
					myCommand.Parameters.AddWithValue("@City", user.City);
					myCommand.Parameters.AddWithValue("@PostalCode", user.PostalCode);
					myCommand.Parameters.AddWithValue("@ActivationToken", user.ActivationToken);
					myCommand.Parameters.AddWithValue("@IsActivated", user.IsActivated.HasValue ? (object)user.IsActivated.Value : DBNull.Value);

					int rowsAffected = myCommand.ExecuteNonQuery();
					myCon.Close();

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
	}
}

