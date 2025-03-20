using System.Security.Cryptography;
using System.Text;

namespace backend.Helper
{
    public class PasswordHelper
    {
        private readonly IConfiguration _configuration;
        public PasswordHelper(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        public string HashPassword(string password)
        {
            var key = Encoding.ASCII.GetBytes(_configuration["StoredHash"]);
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }

        // Verifies if the entered password matches the stored hash
        public bool VerifyPassword(string enteredPassword, string storedHash)
        {
            var enteredHash = HashPassword(enteredPassword);
            return enteredHash == storedHash;
        }
    }
}
