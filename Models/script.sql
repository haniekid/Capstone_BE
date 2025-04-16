USE [master]
GO
/****** Object:  Database [Demo_3]    Script Date: 17/4/2025 12:42:10 AM ******/
CREATE DATABASE [Demo_3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Demo_3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MAYAO\MSSQL\DATA\Demo_3.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Demo_3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MAYAO\MSSQL\DATA\Demo_3_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Demo_3] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Demo_3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Demo_3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Demo_3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Demo_3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Demo_3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Demo_3] SET ARITHABORT OFF 
GO
ALTER DATABASE [Demo_3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Demo_3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Demo_3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Demo_3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Demo_3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Demo_3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Demo_3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Demo_3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Demo_3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Demo_3] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Demo_3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Demo_3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Demo_3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Demo_3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Demo_3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Demo_3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Demo_3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Demo_3] SET RECOVERY FULL 
GO
ALTER DATABASE [Demo_3] SET  MULTI_USER 
GO
ALTER DATABASE [Demo_3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Demo_3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Demo_3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Demo_3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Demo_3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Demo_3] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Demo_3', N'ON'
GO
ALTER DATABASE [Demo_3] SET QUERY_STORE = OFF
GO
USE [Demo_3]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 17/4/2025 12:42:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[DiscountType] [varchar](20) NOT NULL,
	[DiscountValue] [decimal](10, 2) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[UsageLimit] [int] NULL,
	[UsedCount] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DiscountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 17/4/2025 12:42:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderItemID] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductPriceID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 17/4/2025 12:42:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[TotalPrice] [decimal](10, 2) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[UserID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 17/4/2025 12:42:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ImageURL] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductPrices]    Script Date: 17/4/2025 12:42:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPrices](
	[ProductPriceID] [int] IDENTITY(1,1) NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductPriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 17/4/2025 12:42:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Type] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[ImageURL] [nvarchar](500) NULL,
	[IsDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSales]    Script Date: 17/4/2025 12:42:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSales](
	[SaleID] [int] IDENTITY(1,1) NOT NULL,
	[ProductPriceID] [int] NOT NULL,
	[SalePrice] [decimal](10, 2) NOT NULL,
	[SaleStartDate] [datetime] NOT NULL,
	[SaleEndDate] [datetime] NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 17/4/2025 12:42:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 17/4/2025 12:42:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[City] [nvarchar](100) NULL,
	[PostalCode] [nvarchar](20) NULL,
	[RoleID] [int] NOT NULL,
	[ActivationToken] [nvarchar](50) NULL,
	[IsActivated] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Discount] ON 
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (1, N'Giam10pt', N'giam 10%', N'Percentage', CAST(10.00 AS Decimal(10, 2)), CAST(N'2000-01-01T00:00:00.000' AS DateTime), CAST(N'2030-01-01T00:00:00.000' AS DateTime), 100, 0, 1, CAST(N'2025-04-03T20:47:41.260' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (3, N'Giam50k', N'giam 50k', N'FixedAmount', CAST(50000.00 AS Decimal(10, 2)), CAST(N'2000-01-01T00:00:00.000' AS DateTime), CAST(N'2030-01-01T00:00:00.000' AS DateTime), 100, 0, 1, CAST(N'2025-04-03T20:48:17.017' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (6, N'SUMMER20', N'20% off summer sale', N'FixedAmount', CAST(20.00 AS Decimal(10, 2)), CAST(N'2025-05-30T00:00:00.000' AS DateTime), CAST(N'2025-08-29T00:00:00.000' AS DateTime), 100, 0, 1, CAST(N'2025-04-03T20:50:34.427' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (7, N'WELCOME10', N'10% off for new users', N'Percentage', CAST(12.00 AS Decimal(10, 2)), CAST(N'2024-12-31T00:00:00.000' AS DateTime), CAST(N'2025-12-30T00:00:00.000' AS DateTime), NULL, 0, 1, CAST(N'2025-04-03T20:50:34.427' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (9, N'FREESHIP', N'Free shipping on orders above $100', N'FixedAmount', CAST(10.00 AS Decimal(10, 2)), CAST(N'2025-01-01T00:00:00.000' AS DateTime), NULL, NULL, 15, 1, CAST(N'2025-04-03T20:50:34.427' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (10, N'BLACKFRIDAY', N'30% off on Black Friday', N'Percentage', CAST(31.00 AS Decimal(10, 2)), CAST(N'2025-11-28T00:00:00.000' AS DateTime), CAST(N'2025-11-28T00:00:00.000' AS DateTime), 500, 50, 1, CAST(N'2025-04-03T20:50:34.427' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (11, N'HOLIDAY25', N'25% off for the holiday season', N'Percentage', CAST(25.00 AS Decimal(10, 2)), CAST(N'2025-12-15T00:00:00.000' AS DateTime), CAST(N'2026-01-05T00:00:00.000' AS DateTime), 150, 0, 1, CAST(N'2025-04-03T20:50:34.427' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (12, N'string1', N'string1', N'Percentage', CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-04-03T14:20:32.323' AS DateTime), CAST(N'2025-04-03T14:20:32.323' AS DateTime), 100, 100, 1, CAST(N'2025-04-03T14:20:32.323' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (13, N'NEW_CODE', N'New discount description', N'Percentage', CAST(10.00 AS Decimal(10, 2)), CAST(N'2025-04-03T15:23:56.083' AS DateTime), CAST(N'2025-05-03T15:23:56.083' AS DateTime), 100, 0, 1, CAST(N'2025-04-03T22:23:56.093' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (19, N'disactive', N'aaaa', N'FixedAmount', CAST(10000.00 AS Decimal(10, 2)), CAST(N'2025-04-03T00:00:00.000' AS DateTime), CAST(N'2025-04-25T00:00:00.000' AS DateTime), NULL, 0, 0, CAST(N'2025-04-03T23:32:32.253' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (20, N'11111111', N'11111', N'Percentage', CAST(11.00 AS Decimal(10, 2)), CAST(N'2025-04-09T00:00:00.000' AS DateTime), CAST(N'2025-04-17T00:00:00.000' AS DateTime), 111, 0, 0, CAST(N'2025-04-10T22:56:14.087' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Discount] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItems] ON 
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [Quantity], [OrderID], [ProductPriceID]) VALUES (1, 1, 1, 1)
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [Quantity], [OrderID], [ProductPriceID]) VALUES (2, 1, 1, 2)
GO
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (1, CAST(N'2025-03-30T17:13:25.413' AS DateTime), CAST(1599.98 AS Decimal(10, 2)), N'Processing', 1)
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (3, 12, N'https://product.hstatic.net/1000141988/product/banh_snack_cua_xanh_kinh_do_29_g__i0015950__293edc9f144247c19f4032e930003b98.png')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (4, 12, N'https://product.hstatic.net/1000141988/product/banh_snack_cua_xanh_kinh_do_29_g__i0015950__293edc9f144247c19f4032e930003b98.png')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (5, 13, N'https://cachnau.vn/wp-content/uploads/2021/11/bun-rieu-thit-heo.jpg')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (6, 13, N'https://i-giadinh.vnecdn.net/2024/02/22/Buoc-8-Thanh-pham-1-8-3117-1708574962.jpg')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (7, 13, N'https://fullofplants.com/wp-content/uploads/2023/10/how-to-make-vegan-bun-rieu-chay-vietnamese-crab-noodle-soup-thumb.jpg')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (8, 14, N'https://images.unsplash.com/photo-1511910849309-0dffb8785146?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGhvfGVufDB8fDB8fHww')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (11, 6, N'https://kenh14cdn.com/2019/6/13/5-15604349732321143466519.jpg')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (12, 6, N'https://kenh14cdn.com/2019/6/13/4-1560434973220181092322.jpg')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (13, 15, N'string')
GO
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductPrices] ON 
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (1, CAST(999.99 AS Decimal(10, 2)), 10, 1)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (2, CAST(599.99 AS Decimal(10, 2)), 20, 2)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (3, CAST(2000.00 AS Decimal(10, 2)), 10, 4)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (4, CAST(20.00 AS Decimal(10, 2)), 10, 5)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (5, CAST(65000.00 AS Decimal(10, 2)), 100, 6)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (7, CAST(50000.00 AS Decimal(10, 2)), 100, 7)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (8, CAST(45000.00 AS Decimal(10, 2)), 100, 8)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (9, CAST(60000.00 AS Decimal(10, 2)), 100, 9)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (10, CAST(49000.00 AS Decimal(10, 2)), 490, 10)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (11, CAST(45000.00 AS Decimal(10, 2)), 100, 11)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (12, CAST(50000.00 AS Decimal(10, 2)), 50000, 12)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (13, CAST(50000.00 AS Decimal(10, 2)), 100, 13)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (14, CAST(49000.00 AS Decimal(10, 2)), 0, 14)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (15, CAST(0.00 AS Decimal(10, 2)), 0, 15)
GO
SET IDENTITY_INSERT [dbo].[ProductPrices] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (1, N'Food3', N'Food3', N'High-performance laptop', N'https://product.hstatic.net/1000141988/product/banh_snack_cua_xanh_kinh_do_29_g__i0015950__293edc9f144247c19f4032e930003b98.png', 1)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (2, N'Food2', N'Food2', N'Latest model smartphone', N'https://product.hstatic.net/200000495609/product/snack-tom-cay-oishi-du-vi-goi-lon-68g-banh-keo-an-vat-imnuts_d3ff6a241a9e4bb28aea097f9eca7166_master.jpg', 1)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (4, N'Food1', N'Food', N'a', N'https://www.lottemart.vn/media/catalog/product/cache/0x0/8/9/8934803024883-1.jpg.webp', NULL)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (5, N'Food4', N'Món cuốn', N'string', N'string', 1)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (6, N'Bún Trộn', N'Bún', N'no', N'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhd6dgfk6Qn7U25tvgrxJYLUJ94S4V4iip77bN35P17d3JGLT8eoW7_Xjse6OgZV2leEiHaYIz89BC5fsBdrc6X5NVN8caqZMe1Z8fGdUo4r19Uyr62g17tP2ALGnJUf5c0l4F4g85BaIs/s800/94271CB2-5921-4180-B602-AC21E71F4BB7_1_102_o.jpeg', NULL)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (7, N'Phở Bò', N'Món nước', N'Món phở truyền thống với nước dùng bò đậm đà', N'https://example.com/images/pho-bo.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (8, N'Bánh Mì Thịt Nguội', N'Món ăn nhanh', N'Bánh mì giòn, nhân thịt nguội, pate và rau sống', N'https://example.com/images/banh-mi-thit.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (9, N'Gỏi Cuốn', N'Món cuốn', N'Cuốn tôm thịt tươi, ăn kèm nước chấm chua ngọt', N'https://example.com/images/goi-cuon.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (10, N'Bún Chả', N'Món nướng', N'Bún với thịt nướng và nước mắm chua ngọt', N'https://example.com/images/bun-cha.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (11, N'Cơm Tấm Sườn Nướng', N'Cơm', N'Cơm tấm ăn kèm sườn nướng, trứng, bì', N'https://example.com/images/com-tam.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (12, N'Com rang', N'Cơm', N'no', N'https://product.hstatic.net/1000141988/product/banh_snack_cua_xanh_kinh_do_29_g__i0015950__293edc9f144247c19f4032e930003b98.png', 1)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (13, N'Bun rieu', N'Bún', N'no', N'https://cdn.tgdd.vn/2020/08/CookProduct/Untitled-1-1200x676-10.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (14, N'Pho bo', N'Bún', N'123', N'https://plus.unsplash.com/premium_photo-1664478276162-46c39b3557c3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhvfGVufDB8fDB8fHww', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (15, N'string', N'string', N'string', N'string', 1)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductSales] ON 
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (1, 5, CAST(60000.00 AS Decimal(10, 2)), CAST(N'2025-04-15T17:00:00.000' AS DateTime), CAST(N'2026-04-15T17:00:00.000' AS DateTime), CAST(N'2025-04-16T13:38:21.487' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (2, 14, CAST(48000.00 AS Decimal(10, 2)), CAST(N'2025-04-16T08:51:00.000' AS DateTime), CAST(N'2025-04-26T08:51:00.000' AS DateTime), CAST(N'2025-04-16T15:52:22.483' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (3, 15, CAST(0.00 AS Decimal(10, 2)), CAST(N'2025-04-16T16:17:31.363' AS DateTime), CAST(N'2025-04-16T16:17:31.363' AS DateTime), CAST(N'2025-04-16T23:17:32.807' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ProductSales] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Customer')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (1, N'John', N'Doe', N'john.doe@example.com', N'123456789', N'hashed_password', N'123 Street', N'New York', N'10001', 2, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (2, N'Jane', N'Smith', N'jane.smith@example.com', N'987654321', N'hashed_password', N'456 Avenue', N'Los Angeles', N'90001', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (5, N'ad', N'ad', N'admin@gmail.com', N'123123123', N'lsrjXOipsCRBeL8o5JZsLOG4OFcjqWprg4hYzdbKCh4=', N'111', N'11', N'11', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (8, N'ha', N'ha', N'anh2001httttt@gmail.com', N'0123456789', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'123123', 2, N'', 1)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (10, N'ha', N'ha', N'anh2001htttt12t@gmail.com', N'0123456789', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'123123', 2, N'fb558a75-3d4d-40ae-b7a4-d87668ef1add', 0)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (11, N'Nguyen', N'Anh', N'admin12@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'98c3cd65-629b-4df0-ad64-68984a2dc938', 1)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (12, N'Nguyen', N'Anh', N'admin123@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'63abd2ab-ce0d-4a39-a353-f3de7ffbdaa9', 1)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (13, N'Nguyen', N'Anh', N'admin1234@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'5cb25354-a029-4036-a615-8892b1e6a899', 1)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (14, N'123', N'123', N'12admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'71224243-5eb7-4beb-aa2f-3415d152c245', 1)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (17, N'123', N'123', N'122admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'b59ef008-a101-43e3-b621-e1ffd0a26264', 1)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (18, N'123', N'123', N'1212admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'516fc55f-5c2c-4075-93d2-88713d5f26aa', 1)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (19, N'Nguyen', N'Anh', N'121212in@gmail.com', N'0944924978', N'uCK7k5Bam9izoMCBaMQnaWQ2z4vzftSrjr9BoHZC7Rw=', N'string', N'string', N'string', 2, N'4836a57d-1596-4896-a11f-a96ee22be46c', 1)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated]) VALUES (20, N'123123123', N'123123', N'ad231231min@gmail.com', N'0944924978', N'PhHpc+yAvoMlMPeSLhCxmtQAXCfNBjPGe+hTyqv/+S0=', N'string', N'string', N'string', 2, N'bd5a388e-1476-4b37-94b1-0e831b4b7220', 1)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Discount__A25C5AA793CB0AF0]    Script Date: 17/4/2025 12:42:10 AM ******/
ALTER TABLE [dbo].[Discount] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B616029394D67]    Script Date: 17/4/2025 12:42:10 AM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D105341AA49753]    Script Date: 17/4/2025 12:42:10 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Discount] ADD  DEFAULT ((0)) FOR [UsedCount]
GO
ALTER TABLE [dbo].[Discount] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Discount] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ProductSales] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([ProductPriceID])
REFERENCES [dbo].[ProductPrices] ([ProductPriceID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductPrices]  WITH CHECK ADD  CONSTRAINT [FK__ProductPr__Produ__2D27B809] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductPrices] CHECK CONSTRAINT [FK__ProductPr__Produ__2D27B809]
GO
ALTER TABLE [dbo].[ProductSales]  WITH CHECK ADD FOREIGN KEY([ProductPriceID])
REFERENCES [dbo].[ProductPrices] ([ProductPriceID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD CHECK  (([DiscountType]='FixedAmount' OR [DiscountType]='Percentage'))
GO
USE [master]
GO
ALTER DATABASE [Demo_3] SET  READ_WRITE 
GO
