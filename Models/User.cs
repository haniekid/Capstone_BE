namespace backend.Models
{
	public class User
	{
		public User() { }
		public int UserID { get; set; }
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string Email { get; set; }
		public string Phone { get; set; }
		public string Password { get; set; }

		public string Address { get; set; }
		public string City { get; set; }
		public string PostalCode { get; set; }
		public string RoleName { get; set; }
		public bool? IsActivated { get; set; } = false;
		public string ActivationToken { get; set; }
		public string ResetPasswordToken { get; set; }         
		public DateTime? ResetTokenExpiry { get; set; }

		public User(int userId, string firstName, string lastName, string email, string phone, string password,
					string address = null, string city = null, string postalCode = null, string roleName = null,
					string activationToken = null, bool isActivated = false, string resetPasswordToken = null, DateTime? resetTokenExpiry = null)
		{
			UserID = userId;
			FirstName = firstName;
			LastName = lastName;
			Email = email;
			Phone = phone;
			Password = password;
			Address = address;
			City = city;
			PostalCode = postalCode;
			RoleName = roleName;
			ActivationToken = activationToken;
			IsActivated = isActivated;
			ResetPasswordToken = resetPasswordToken;
			ResetTokenExpiry = resetTokenExpiry;
		}
	}
}
