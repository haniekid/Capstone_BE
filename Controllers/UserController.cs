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
			newUser.Password = _passwordHelper.HashPassword(newUser.Password);
			newUser.ActivationToken = Guid.NewGuid().ToString();
			bool added = _userRepository.Add(newUser);
			if (!added)
			{
				return BadRequest("Failed to add user");
			}
			var activationLink = $"{Request.Scheme}://{Request.Host}/api/account/activate?token={newUser.ActivationToken}";
			_emailService.Send(newUser.Email, "Activate your account", $"Please click the link to activate: <a href='{activationLink}'>Activate Account</a>");
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
			var activationLink = $"{Request.Scheme}://{Request.Host}/api/account/activate?token={newUser.ActivationToken}";
			_emailService.Send(newUser.Email, "Activate your account", $"Please click the link to activate: <a href='{activationLink}'>Activate Account</a>");
			return Ok();
		}
		[HttpPut("{userId}")]
		public IActionResult Put(User updatedUser)
		{
			updatedUser.Password = _passwordHelper.HashPassword(updatedUser.Password);
			bool updated = _userRepository.Update(updatedUser);
			if (updated)
			{
				return Ok();
			}
			else
			{
				return NotFound();
			}
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
		public IActionResult Activate(string token)
		{
			//TODO: validate trung email, neu trung throw mess ma active thi show mess, !active thi gan lai token de active
			var user = _userRepository.GetAll().FirstOrDefault(u => u.ActivationToken == token);

			if (user == null)
				return BadRequest("Invalid token.");

			user.IsActivated = true;
			user.ActivationToken = string.Empty;
			bool updated = _userRepository.Update(user);
			if (updated)
			{
				return Ok("Account activated successfully! You can now log in.");
			}
			else
			{
				return NotFound();
			}
		}


	}
}
