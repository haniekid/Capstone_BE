using backend.Controllers;
using backend.DTOs;
using backend.Helper;
using backend.Models;
using backend.Repositories;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Serilog;
using VNPAY.NET;

namespace backend
{
	public class Program
	{
		public static void Main(string[] args)
		{

			var builder = WebApplication.CreateBuilder(args);

			var MyAllowSpecificOrigins = "_myAllowSpecificOrigins";


			// Add services to the container.
			builder.Services.AddCors(options =>
			{
				options.AddPolicy(name: MyAllowSpecificOrigins,
								  policy =>
								  {
									  policy.AllowAnyOrigin()
											.AllowAnyHeader()
											.AllowAnyMethod();
								  });
			});
            builder.Services.AddScoped<IVnpay, Vnpay>();
            builder.Services.AddScoped<IRepository<User>, UserRepository>();
			builder.Services.AddScoped<IRepository<Product>, ProductRepository>();
			builder.Services.AddScoped<IRepository<ProductDTO>, ProductDTORepository>();
			builder.Services.AddScoped<IRepository<ProductType>, ProductTypeRepository>();

			builder.Services.AddScoped<IListRepository<Order>, OrderRepository>();
			builder.Services.AddScoped<IListRepository<OrderDTO>, OrderRepository>();
			builder.Services.AddScoped<IListRepository<ProductPrice>, ProductPriceRepository>();
			builder.Services.AddScoped<IListRepository<OrderItem>, OrderItemRepository>();
			builder.Services.AddScoped<IListRepository<Discount>, DiscountRepository>();
			builder.Services.AddScoped<PasswordHelper>();
			builder.Services.AddScoped<EmailService>();

			builder.Services.AddControllers();
			// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
			builder.Services.AddEndpointsApiExplorer();
			builder.Services.AddSwaggerGen();

			var app = builder.Build();

			// Configure the HTTP request pipeline.
			if (app.Environment.IsDevelopment())
			{
				app.UseSwagger();
				app.UseSwaggerUI();
			}

			app.UseCors("_myAllowSpecificOrig   ins");

			app.UseHttpsRedirection();

			app.UseAuthorization();


			app.MapControllers();

			app.Run();
		}
	}
}