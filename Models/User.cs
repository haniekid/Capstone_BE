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
		public string RoleName { get; set; }
		public bool? IsActivated { get; set; } = false;
		public string ActivationToken { get; set; }
		public string ResetPasswordToken { get; set; }         
		public DateTime? ResetTokenExpiry { get; set; }
		public int? DistrictID { get; set; }
		public string WardCode { get; set; }
		public string AddressDetail { get; set; }

        public User(int userID, string firstName, string lastName, string email, string phone, string password, string roleName, bool? isActivated, string activationToken, string resetPasswordToken, DateTime? resetTokenExpiry, int? districtID, string wardCode, string addressDetail)
        {
            UserID = userID;
            FirstName = firstName;
            LastName = lastName;
            Email = email;
            Phone = phone;
            Password = password;
            RoleName = roleName;
            IsActivated = isActivated;
            ActivationToken = activationToken;
            ResetPasswordToken = resetPasswordToken;
            ResetTokenExpiry = resetTokenExpiry;
            DistrictID = districtID;
            WardCode = wardCode;
            AddressDetail = addressDetail;
        }
    }
}
