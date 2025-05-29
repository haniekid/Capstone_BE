using backend.Models;
using backend.Repositories;
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using static Org.BouncyCastle.Math.EC.ECCurve;


namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("_myAllowSpecificOrigins")]

    public class ProductController : ControllerBase
    {
        private readonly IRepository<Product> _productRepository;
        private readonly IRepository<ProductDTO> _productDTORepository;
        private readonly IRepository<ProductType> _productTypeRepository;
        private readonly IRepository<AddOnProductRequest> _addOnProductRepository;
        private readonly IRepository<ProductCategory> _productCategory;
        private readonly Cloudinary _cloudinary;
        public ProductController(IRepository<Product> productRepository, IRepository<ProductDTO> productDTORepository, IRepository<ProductType> productTypeRepository,
            IRepository<AddOnProductRequest> addOnProductRepository, IRepository<ProductCategory> productCategory, IOptions<CloudinarySettings> config)
        {
            _productRepository = productRepository;
            _productDTORepository = productDTORepository;
            _productTypeRepository = productTypeRepository;
            _addOnProductRepository = addOnProductRepository;
            _productCategory = productCategory;
            var acc = new Account(
            config.Value.CloudName,
            config.Value.ApiKey,
            config.Value.ApiSecret
        );

            _cloudinary = new Cloudinary(acc);
        }

        [HttpGet]
        public IActionResult Get()
        {
            IEnumerable<Product> products = _productRepository.GetAll();
            return Ok(products);
        }

        [HttpGet("{productId}")]
        public IActionResult Get(int productId)
        {
            var product = _productRepository.GetById(productId);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(product);
        }

        [HttpPost]
        public IActionResult Post(ProductDTO product)
        {
            _productDTORepository.Add(product);
            return Ok();
        }


        [HttpPut("{productId}")]
        public IActionResult Put(ProductDTO updatedProduct)
        {
            bool updated = _productDTORepository.Update(updatedProduct);
            if (updated)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

        [HttpDelete("{productId}")]
        public IActionResult Delete(int productId)
        {
            bool deleted = _productRepository.Delete(productId);
            if (deleted)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet("GetProductsForAdminDashboard")]
        public IActionResult GetProductsForAdminDashboard()
        {
            IEnumerable<ProductDTO> products = _productDTORepository.GetAll();
            return Ok(products);
        }

        [HttpGet("GetProductsForAdminDashboard/{productId}")]
        public IActionResult GetProductByIdForAdminDashboard(int productId)
        {
            var product = _productDTORepository.GetById(productId);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(product);
        }

        [HttpPost("AddProductsForAdminDashboard")]
        public IActionResult AddProductsForAdminDashboard(ProductDTO product)
        {
            _productDTORepository.Add(product);
            return Ok();
        }


        [HttpPut("EditProductsForAdminDashboard/{productId}")]
        public IActionResult EditProductsForAdminDashboard(ProductDTO updatedProduct)
        {
            bool updated = _productDTORepository.Update(updatedProduct);
            if (updated)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

        [HttpDelete("DeleteProductsForAdminDashboard/{productId}")]
        public IActionResult DeleteProductsForAdminDashboard(int productId)
        {
            bool deleted = _productDTORepository.Delete(productId);
            if (deleted)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet("GetProductTypesForAdminDashboard")]
        public IActionResult GetProductTypesForAdminDashboard()
        {
            var products = _productCategory.GetAll();
            return Ok(products);
        }


        [HttpGet("GetAddOnProductByProductId/{productId}")]
        public IActionResult GetAddOnProductByProductId(int productId)
        {
            var product = _productDTORepository.GetById2(productId);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(product);
        }

        [HttpPost("InsertAddOnProductByProductId")]
        public IActionResult InsertAddOnProductByProductId(AddOnProductRequest product)
        {
            bool result = _addOnProductRepository.Add(product);
            if (!result)
                return BadRequest();

            return Ok();
        }

        [HttpGet("GetAllAddOnProduct")]
        public IActionResult GetAllAddOnProduct()
        {
            var products = _productDTORepository.GetAll();
            return Ok(products);
        }
        [HttpPost("DeleteAddOnProductByProductId")]
        public IActionResult DeleteAddOnProductByProductId(AddOnProductRequest product)
        {
            bool result = _addOnProductRepository.Delete2(product);
            if (!result)
                return BadRequest();

            return Ok();
        }

        [HttpPost("upload-image")]
        public async Task<IActionResult> UploadImage([FromForm] IFormFile file)
        {
            if (file == null || file.Length == 0)
                return BadRequest("No file uploaded.");

            await using var stream = file.OpenReadStream();
            var uploadParams = new ImageUploadParams
            {
                File = new FileDescription(file.FileName, stream),
                Folder = "your-folder" // tùy chọn
            };

            var uploadResult = await _cloudinary.UploadAsync(uploadParams);

            return Ok(new { imageUrl = uploadResult.SecureUrl });
        }
    }
}
