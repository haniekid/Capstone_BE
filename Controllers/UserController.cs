using backend.Helper;
using backend.Models;
using backend.Repositories;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	[EnableCors("_myAllowSpecificOrigins")]

	public class UserController : ControllerBase
	{
		private readonly IConfiguration _configuration;
		private readonly IRepository<User> _userRepository;
		private readonly PasswordHelper _passwordHelper;
		private readonly EmailService _emailService;

		public UserController(IConfiguration configuration, IRepository<User> userRepository, PasswordHelper passwordHelper, EmailService emailService)
		{
			_configuration = configuration;
			_userRepository = userRepository;
			_passwordHelper = passwordHelper;
			_emailService = emailService;
		}

		[HttpGet]
		public IActionResult Get()
		{
			IEnumerable<User> users = _userRepository.GetAll();
			return Ok(users);
		}

		[HttpGet("{userId}")]
		public IActionResult Get(int userId)
		{
			var user = _userRepository.GetById(userId);
			if (user == null)
			{
				return NotFound();
			}
			return Ok(user);
		}

		[HttpPost]
		public IActionResult Post(User newUser)
		{
			//duplicated user
			var oldUser = _userRepository.GetAll().FirstOrDefault(x => x.Email.ToLower() == newUser.Email.ToLower());
			if (oldUser != null && string.IsNullOrWhiteSpace(oldUser.ActivationToken))
			{
				return BadRequest("Email này đã tồn tại, hãy đăng kí với email khác");
			}
			if (oldUser != null)
			{
				oldUser.ActivationToken = Guid.NewGuid().ToString();
				var activationLinkUpdate = $"{Request.Scheme}://{Request.Host}/api/user/activate?token={oldUser.ActivationToken}";
				_userRepository.Update(oldUser);
				_emailService.Send(newUser.Email, "Activate your account", GenerateActivationEmail(activationLinkUpdate));
				return Ok();
			}
			newUser.Password = _passwordHelper.HashPassword(newUser.Password);
			newUser.ActivationToken = Guid.NewGuid().ToString();
			bool added = _userRepository.Add(newUser);
			if (!added)
			{
				return BadRequest("Failed to add user");
			}
			var activationLink = $"{Request.Scheme}://{Request.Host}/api/user/activate?token={newUser.ActivationToken}";
			_emailService.Send(newUser.Email, "Activate your account", GenerateActivationEmail(activationLink));
			return Ok();
		}

		[HttpPost("register")]
		public IActionResult Register(User newUser)
		{
			newUser.Password = _passwordHelper.HashPassword(newUser.Password);
			newUser.ActivationToken = Guid.NewGuid().ToString();
			bool added = _userRepository.Add(newUser);
			if (!added)
			{
				return BadRequest("Failed to add user");
			}
			var activationLink = $"{Request.Scheme}://{Request.Host}/api/user/activate?token={newUser.ActivationToken}";
			_emailService.Send(newUser.Email, "Activate your account", GenerateActivationEmail(activationLink));
			return Ok();
		}

		[HttpDelete("{userId}")]
		public IActionResult Delete(int userId)
		{
			bool deleted = _userRepository.Delete(userId);
			if (deleted)
			{
				return Ok();
			}
			else
			{
				return NotFound();
			}
		}

		[HttpPost("login")]
		public IActionResult Login(UserLoginRequest loginRequest)
		{
			var user = _userRepository.GetAll().FirstOrDefault(u => u.Email == loginRequest.Email);
			var isValid = _passwordHelper.HashPassword(loginRequest.Password) == user?.Password;
			if (user == null || !isValid)
			{
				return Unauthorized("Invalid username or password");
			}
			if (!string.IsNullOrWhiteSpace(user.ActivationToken))
			{
				return Unauthorized("Please check your email to active the activation");
			}
			var jwtService = new JwtService(_configuration);
			var token = jwtService.GenerateJwtToken(user);

			return Ok(new { Token = token });
		}

		[HttpGet("activate")]
		public ContentResult Activate(string token)
		{
			var user = _userRepository.GetAll().FirstOrDefault(u => u.ActivationToken == token);

			if (user == null)
			{
				return new ContentResult
				{
					Content = "<h2 style='color:red;'>Invalid activation token.</h2>",
					ContentType = "text/html"
				};
			}

			user.IsActivated = true;
			user.ActivationToken = string.Empty;
			bool updated = _userRepository.Update(user);

			if (!updated)
			{
				return new ContentResult
				{
					Content = "<h2 style='color:red;'>Something went wrong. Please try again.</h2>",
					ContentType = "text/html"
				};
			}

			var html = $@"
				<!DOCTYPE html>
				<html lang='en'>
				<head>
					<meta charset='UTF-8'>
					<title>Activation Successful</title>
					<style>
						body {{
							background-color: #f8f9fa;
							font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
							display: flex;
							align-items: center;
							justify-content: center;
							height: 100vh;
							margin: 0;
						}}
						.card {{
							background-color: white;
							padding: 40px;
							border-radius: 8px;
							box-shadow: 0 4px 12px rgba(0,0,0,0.1);
							text-align: center;
							max-width: 500px;
						}}
						img {{
							max-width: 150px;
							margin-bottom: 20px;
						}}
						h1 {{
							color: #28a745;
							margin-bottom: 10px;
						}}
						p {{
							font-size: 16px;
							color: #333;
						}}
						a {{
							margin-top: 20px;
							display: inline-block;
							text-decoration: none;
							color: white;
							background-color: #28a745;
							padding: 10px 20px;
							border-radius: 5px;
							font-weight: bold;
						}}
						a:hover {{
							background-color: #218838;
						}}
					</style>
				</head>
				<body>
					<div class='card'>
						<img src='https://videos.openai.com/vg-assets/assets%2Ftask_01jtmbt1che8fr2ttcftj9sr1y%2F1746587736_img_3.webp?st=2025-05-07T01%3A44%3A25Z&se=2025-05-13T02%3A44%3A25Z&sks=b&skt=2025-05-07T01%3A44%3A25Z&ske=2025-05-13T02%3A44%3A25Z&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skoid=aa5ddad1-c91a-4f0a-9aca-e20682cc8969&skv=2019-02-02&sv=2018-11-09&sr=b&sp=r&spr=https%2Chttp&sig=yk27FpAKldub0CL1UYBgDIwvLf1tRiHvB0O5KBkHKFA%3D&az=oaivgprodscus' alt='HA FOOD Logo' />
						<h1>Account Activated!</h1>
						<p>Your account has been successfully activated. You can now log in to the system.</p>
						<a href='http://localhost:3000/authentication'>Go to Login</a>
					</div>
				</body>
				</html>";

			return new ContentResult
			{
				Content = html,
				ContentType = "text/html"
			};
		}

		[HttpPost("forgot-password")]
		public IActionResult ForgotPassword(string email)
		{
			var user = _userRepository.GetAll().FirstOrDefault(u => u.Email == email);
			if (user == null)
				return NotFound("Email không tồn tại.");

			user.ResetPasswordToken = Guid.NewGuid().ToString();
			user.ResetTokenExpiry = DateTime.UtcNow.AddHours(1);
			_userRepository.Update(user);

			var resetLink = $"http://localhost:3000/reset-password?token={user.ResetPasswordToken}";
			_emailService.Send(user.Email, "Reset your password", GenerateResetPasswordEmail(resetLink));

			return Ok("Link đặt lại mật khẩu đã được gửi qua email.");
		}

		[HttpPost("reset-password")]
		public IActionResult ResetPassword([FromBody] ResetPasswordRequest request)
		{
			var user = _userRepository.GetAll().FirstOrDefault(u =>
				u.ResetPasswordToken == request.Token &&
				u.ResetTokenExpiry > DateTime.UtcNow);

			if (user == null)
				return BadRequest("Token không hợp lệ hoặc đã hết hạn.");

			user.Password = _passwordHelper.HashPassword(request.NewPassword);
			user.ResetPasswordToken = string.Empty;
			user.ActivationToken = string.Empty;
			user.ResetTokenExpiry = null;
			_userRepository.Update(user);

			return Ok("Mật khẩu đã được thay đổi thành công.");
		}

        [HttpPut("update-user")]
        public IActionResult UpdateUser([FromBody] User user)
        {
            var result = _userRepository.Update(user);
			if (result)
			{
				return Ok();
			}
			return BadRequest();
        }
        [HttpPut("change-password")]
        public IActionResult ChangePassword([FromBody] ChangePasswordRequest req)
        {
			var currentUser = _userRepository.GetById(req.UserId);
			if (currentUser.Password != _passwordHelper.HashPassword(req.OldPassword))
			{
				return BadRequest("Mật khẩu hiện tại không đúng");
			}
            currentUser.Password = _passwordHelper.HashPassword(req.NewPassword);
            var result = _userRepository.Update(currentUser);
            if (result)
            {
                return Ok();
            }
            return BadRequest();
        }
        private string GenerateResetPasswordEmail(string resetLink)
		{
			return $@"
					<!DOCTYPE html>
					<html lang='en'>
					<head>
						<meta charset='UTF-8'>
						<style>
							body {{
								font-family: Arial, sans-serif;
								background-color: #f4f4f4;
								padding: 20px;
							}}
							.container {{
								background-color: white;
								padding: 20px;
								border-radius: 8px;
								max-width: 600px;
								margin: auto;
								box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
							}}
							.btn {{
								display: inline-block;
								margin-top: 20px;
								padding: 10px 20px;
								background-color: #007bff;
								color: white;
								text-decoration: none;
								border-radius: 4px;
							}}
							.footer {{
								margin-top: 20px;
								font-size: 12px;
								color: #888;
							}}
						</style>
					</head>
					<body>
						<div class='container'>
							<h2>Reset Your HA FOOD Password</h2>
							<p>You have requested to reset your password. Click the button below to proceed:</p>
							<a href='{resetLink}' class='btn'>Reset Password</a>
							<div class='footer'>
								<p>If you did not request this, you can safely ignore this email.</p>
							</div>
						</div>
					</body>
					</html>";
		}

		private string GenerateActivationEmail(string activationLink)
		{
			return $@"
			<!DOCTYPE html>
			<html lang='en'>
			<head>
				<meta charset='UTF-8'>
				<style>
					body {{
						font-family: Arial, sans-serif;
						background-color: #f4f4f4;
						padding: 20px;
					}}
					.container {{
						background-color: white;
						padding: 20px;
						border-radius: 8px;
						max-width: 600px;
						margin: auto;
						box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
					}}
					.btn {{
						display: inline-block;
						margin-top: 20px;
						padding: 10px 20px;
						background-color: #28a745;
						color: white;
						text-decoration: none;
						border-radius: 4px;
					}}
					.footer {{
						margin-top: 20px;
						font-size: 12px;
						color: #888;
					}}
				</style>
			</head>
			<body>
				<div class='container'>
					<h2>Activate Your HA FOOD Account</h2>
					<p>Thank you for registering. Please click the button below to activate your account:</p>
					<a href='{activationLink}' class='btn'>Activate Account</a>
					<div class='footer'>
						<p>If you didn’t request this email, you can safely ignore it.</p>
					</div>
				</div>
			</body>
			</html>";
		}

	}
}
