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
					u.PasswordHash, u.Address, u.City, u.PostalCode, 
					u.ActivationToken, u.IsActivated, u.ResetPasswordToken, u.ResetTokenExpiry,
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
				users.Add(new User(
					userId: (int)row["UserID"],
					firstName: row["FirstName"].ToString(),
					lastName: row["LastName"].ToString(),
					email: row["Email"].ToString(),
					phone: row["Phone"].ToString(),
					password: row["PasswordHash"].ToString(),
					address: row["Address"] != DBNull.Value ? row["Address"].ToString() : null,
					city: row["City"] != DBNull.Value ? row["City"].ToString() : null,
					postalCode: row["PostalCode"] != DBNull.Value ? row["PostalCode"].ToString() : null,
					roleName: row["RoleName"] != DBNull.Value ? row["RoleName"].ToString() : null,
					activationToken: row["ActivationToken"] != DBNull.Value ? row["ActivationToken"].ToString() : null,
					isActivated: row["IsActivated"] != DBNull.Value ? (bool)row["IsActivated"] : false,
					resetPasswordToken: row["ResetPasswordToken"] != DBNull.Value ? row["ResetPasswordToken"].ToString() : null,
					resetTokenExpiry: row["ResetTokenExpiry"] != DBNull.Value ? (DateTime?)row["ResetTokenExpiry"] : null
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
				PasswordHash = @PasswordHash,
				Address = @Address,
				City = @City,
				PostalCode = @PostalCode,
				IsActivated = @IsActivated,
				ActivationToken = @ActivationToken,
				ResetPasswordToken = @ResetPasswordToken,
				ResetTokenExpiry = @ResetTokenExpiry
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
					myCommand.Parameters.AddWithValue("@Address", (object)user.Address ?? DBNull.Value);
					myCommand.Parameters.AddWithValue("@City", (object)user.City ?? DBNull.Value);
					myCommand.Parameters.AddWithValue("@PostalCode", (object)user.PostalCode ?? DBNull.Value);
					myCommand.Parameters.AddWithValue("@ActivationToken", (object)user.ActivationToken ?? DBNull.Value);
					myCommand.Parameters.AddWithValue("@IsActivated", user.IsActivated.HasValue ? (object)user.IsActivated.Value : DBNull.Value);
					myCommand.Parameters.AddWithValue("@ResetPasswordToken", (object)user.ResetPasswordToken ?? DBNull.Value);
					myCommand.Parameters.AddWithValue("@ResetTokenExpiry", user.ResetTokenExpiry.HasValue ? (object)user.ResetTokenExpiry.Value : DBNull.Value);

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

