using backend.Models;
using backend.Repositories;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;


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


		public ProductController(IRepository<Product> productRepository, IRepository<ProductDTO> productDTORepository, IRepository<ProductType> productTypeRepository)
		{
			_productRepository = productRepository;
			_productDTORepository = productDTORepository;
			_productTypeRepository = productTypeRepository;
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

		[HttpGet("GetProductTypesForAdminDashboard")]
		public IActionResult GetProductTypesForAdminDashboard()
		{
			var products = _productTypeRepository.GetAll();
			return Ok(products);
		}
	}
}
