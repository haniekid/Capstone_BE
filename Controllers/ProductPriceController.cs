using backend.Models;
using backend.Repositories;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("_myAllowSpecificOrigins")]
    public class ProductPriceController : ControllerBase
    {
        private readonly IListRepository<ProductPrice> _psRepository;

        public ProductPriceController(IListRepository<ProductPrice> ProductPriceRepo)
        {
            _psRepository = ProductPriceRepo;
        }

        [HttpGet]
        public IActionResult Get()
        {
            IEnumerable<ProductPrice> productPrices = _psRepository.GetAll();
            return Ok(productPrices);
        }

        [HttpGet("{productId}")]
        public IActionResult Get(int productId)
        {
            var productPrices = _psRepository.GetById(productId);
            if (productPrices == null)
            {
                return NotFound();
            }
            return Ok(productPrices);
        }

        [HttpGet("{id}/price")]
        public IActionResult GetProductPriceById(int id)
        {
            var productPrices = _psRepository.GetObjById(id);
            if (productPrices == null)
            {
                return NotFound();
            }
            return Ok(productPrices);
        }

        [HttpPost]
        public IActionResult Post(ProductPrice newProductPrice)
        {
            bool added = _psRepository.Add(newProductPrice);
            if (!added)
            {
                return BadRequest("Failed to add Product Size");
            }

            return Ok();
        }

        [HttpPut("{ProductPriceId}")]
        public IActionResult Put(ProductPrice updatedProductPrice)
        {
            bool updated = _psRepository.Update(updatedProductPrice);
            if (updated)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

        [HttpDelete("{ProductPriceId}")]
        public IActionResult Delete(int ProductPriceId)
        {
            bool deleted = _psRepository.Delete(ProductPriceId);
            if (deleted)
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
