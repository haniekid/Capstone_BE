using backend.DTOs;
using backend.Models;
using backend.Repositories;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("_myAllowSpecificOrigins")]
    public class ProductCategoryController : ControllerBase
    {
        private readonly IRepository<ProductCategory> _productCategory;
        public ProductCategoryController(IRepository<ProductCategory> productCategoryy)
        {
            _productCategory = productCategoryy;
        }
        [HttpGet]
        public IActionResult Get()
        {
            var cat = _productCategory.GetAll();
            return Ok(cat);
        }

        [HttpGet("GetCategoryById/{categoryId}")]
        public IActionResult GetCategoryById(int categoryId)
        {
            var order = _productCategory.GetAll().FirstOrDefault(x => x.CategoryId == categoryId);
            return Ok(order);
        }

        [HttpPost("DeleteCategoryById/{categoryId}")]
        public IActionResult DeleteCategoryById(int categoryId)
        {
            var current = _productCategory.GetAll().FirstOrDefault(x => x.CategoryId == categoryId);
            if (current.IsActive)
            {
                _productCategory.Delete(current.CategoryId);
            }
            _productCategory.Delete2(current);
            return Ok();
        }
        [HttpPut("{categoryId}")]
        public IActionResult Put(ProductCategory categoryId)
        {
            bool updated = _productCategory.Update(categoryId);
            if (updated)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }
        [HttpPost("AddCategory")]
        public IActionResult Add(ProductCategory categoryId)
        {
            _productCategory.Add(categoryId);
            return Ok();
        }
    }
}
