using backend.Helper;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

[ApiController]
[Route("api/[controller]")]
public class CartController : ControllerBase
{
    private readonly IHttpContextAccessor _httpContextAccessor;
    private readonly ILogger<CartController> _logger;

    public CartController(IHttpContextAccessor httpContextAccessor, ILogger<CartController> logger)
    {
        _httpContextAccessor = httpContextAccessor;
        _logger = logger;
    }

    private ISession Session => _httpContextAccessor.HttpContext!.Session;

    private string GetSessionKey(string userId) => $"Cart_{userId}";

    [HttpGet("{userId}")]
    public IActionResult GetCart(string userId)
    {
        try
        {
            _logger.LogInformation($"Getting cart for user {userId}");
            var cart = Session.GetObject<List<CartItem>>(GetSessionKey(userId)) ?? new List<CartItem>();
            _logger.LogInformation($"Cart items: {JsonSerializer.Serialize(cart)}");
            return Ok(cart);
        }
        catch (Exception ex)
        {
            _logger.LogError($"Error getting cart for user {userId}: {ex.Message}");
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpPost("{userId}")]
    public IActionResult SaveCart(string userId, [FromBody] List<CartItem> cart)
    {
        try
        {
            if (cart == null)
            {
                return BadRequest(new { message = "Cart data is required" });
            }

            _logger.LogInformation($"Saving cart for user {userId}: {JsonSerializer.Serialize(cart)}");
            Session.SetObject(GetSessionKey(userId), cart);
            return Ok(new { message = "Cart saved successfully" });
        }
        catch (Exception ex)
        {
            _logger.LogError($"Error saving cart for user {userId}: {ex.Message}");
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpDelete("{userId}")]
    public IActionResult DeleteCart(string userId)
    {
        try
        {
            _logger.LogInformation($"Deleting cart for user {userId}");
            Session.Remove(GetSessionKey(userId));
            return Ok(new { message = "Cart deleted successfully" });
        }
        catch (Exception ex)
        {
            _logger.LogError($"Error deleting cart for user {userId}: {ex.Message}");
            return BadRequest(new { message = ex.Message });
        }
    }
}