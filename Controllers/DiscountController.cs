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

    public class DiscountController : ControllerBase
    {
        private readonly IListRepository<Discount> _discountRepository;

        public DiscountController(IListRepository<Discount> discountRepository)
        {
            _discountRepository = discountRepository;
        }

        [HttpGet]
        public IActionResult Get()
        {
            IEnumerable<Discount> discounts = _discountRepository.GetAll();
            return Ok(discounts);
        }


        [HttpGet("discount/{id}")]
        public IActionResult GetById(int id)
        {
            var discount = _discountRepository.GetAll().FirstOrDefault(x => x.DiscountId == id);
            return Ok(discount);
        }

        [HttpGet("discount/code/{code}")]
        public IActionResult GetByCode(string code)
        {
            var discount = _discountRepository.GetAll().FirstOrDefault(x => x.Code.ToLower() == code.ToLower());
            return Ok(discount);
        }
        [HttpPost]
        public IActionResult Post(Discount newDiscount)
        {
            bool added = _discountRepository.Add(newDiscount);
            if (!added)
            {
                return BadRequest("Failed to add discount");
            }

            return Ok();
        }

        [HttpDelete("{discountId}")]
        public IActionResult Delete(int discountId)
        {
            bool deleted = _discountRepository.Delete(discountId);
            if (deleted)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

        [HttpPut("{discountId}")]
        public IActionResult Put(Discount discount)
        {
            bool updated = _discountRepository.Update(discount);
            if (updated)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

    }
}
