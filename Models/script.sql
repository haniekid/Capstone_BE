USE [master]
GO
/****** Object:  Database [Demo_6]    Script Date: 30-May-25 11:26:01 AM ******/
CREATE DATABASE [Demo_6]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Demo_6', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Demo_6.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Demo_6_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Demo_6_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Demo_6] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Demo_6].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Demo_6] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Demo_6] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Demo_6] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Demo_6] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Demo_6] SET ARITHABORT OFF 
GO
ALTER DATABASE [Demo_6] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Demo_6] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Demo_6] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Demo_6] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Demo_6] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Demo_6] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Demo_6] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Demo_6] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Demo_6] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Demo_6] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Demo_6] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Demo_6] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Demo_6] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Demo_6] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Demo_6] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Demo_6] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Demo_6] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Demo_6] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Demo_6] SET  MULTI_USER 
GO
ALTER DATABASE [Demo_6] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Demo_6] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Demo_6] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Demo_6] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Demo_6] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Demo_6] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Demo_6] SET QUERY_STORE = ON
GO
ALTER DATABASE [Demo_6] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Demo_6]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 30-May-25 11:26:01 AM ******/
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
 CONSTRAINT [PK__Discount__E43F6D964DEFDDAD] PRIMARY KEY CLUSTERED 
(
	[DiscountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 30-May-25 11:26:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderItemID] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[TotalPrice] [decimal](10, 2) NOT NULL,
	[OrderID] [int] NULL,
	[ProductName] [nvarchar](50) NULL,
 CONSTRAINT [PK__OrderIte__57ED06A1ACF9116A] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 30-May-25 11:26:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[UserID] [int] NOT NULL,
	[DiscountCode] [nvarchar](50) NULL,
	[ShippingMethod] [nvarchar](50) NOT NULL,
	[ShippingFee] [decimal](10, 2) NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[VnpayOption] [nvarchar](50) NOT NULL,
	[Subtotal] [decimal](10, 2) NOT NULL,
	[FinalTotal] [decimal](10, 2) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Note] [nvarchar](50) NULL,
 CONSTRAINT [PK__Orders__C3905BAFDF6C44B7] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductAddOns]    Script Date: 30-May-25 11:26:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAddOns](
	[ProductAddOnID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[AddOnProductID] [int] NOT NULL,
 CONSTRAINT [PK__ProductA__16AF8ABBDEE2A16E] PRIMARY KEY CLUSTERED 
(
	[ProductAddOnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 30-May-25 11:26:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 30-May-25 11:26:01 AM ******/
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
/****** Object:  Table [dbo].[ProductPrices]    Script Date: 30-May-25 11:26:01 AM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 30-May-25 11:26:01 AM ******/
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
	[CategoryId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSales]    Script Date: 30-May-25 11:26:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSales](
	[SaleID] [int] IDENTITY(1,1) NOT NULL,
	[ProductPriceID] [int] NOT NULL,
	[SalePrice] [decimal](10, 2) NULL,
	[SaleStartDate] [datetime] NULL,
	[SaleEndDate] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK__ProductS__1EE3C41F9A3D3E1C] PRIMARY KEY CLUSTERED 
(
	[SaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 30-May-25 11:26:01 AM ******/
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
/****** Object:  Table [dbo].[ShippingAddress]    Script Date: 30-May-25 11:26:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingAddress](
	[ShippingAddressId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[Province] [nvarchar](100) NULL,
	[DistrictId] [nvarchar](20) NULL,
	[DistrictName] [nvarchar](100) NULL,
	[WardCode] [nvarchar](20) NULL,
	[WardName] [nvarchar](100) NULL,
	[AddressDetail] [nvarchar](255) NULL,
 CONSTRAINT [PK__Shipping__EC10DC39064BC6AD] PRIMARY KEY CLUSTERED 
(
	[ShippingAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 30-May-25 11:26:01 AM ******/
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
	[RoleID] [int] NOT NULL,
	[ActivationToken] [nvarchar](50) NULL,
	[IsActivated] [bit] NULL,
	[ResetPasswordToken] [nvarchar](100) NULL,
	[ResetTokenExpiry] [datetime] NULL,
	[DistrictID] [int] NULL,
	[WardCode] [nvarchar](50) NULL,
	[AddressDetail] [nvarchar](255) NULL,
 CONSTRAINT [PK__Users__1788CCAC071E26BB] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Discount] ON 
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (1, N'Giam10pt', N'giam 10%', N'Percentage', CAST(10.00 AS Decimal(10, 2)), CAST(N'2000-01-01T00:00:00.000' AS DateTime), CAST(N'2030-01-01T00:00:00.000' AS DateTime), 100, 0, 1, CAST(N'2025-04-03T20:47:41.260' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (3, N'Giam50k', N'giam13', N'Percentage', CAST(13.00 AS Decimal(10, 2)), CAST(N'1999-12-31T00:00:00.000' AS DateTime), CAST(N'2029-12-31T00:00:00.000' AS DateTime), 100, 0, 1, CAST(N'2025-04-03T20:48:17.017' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (6, N'SUMMER20', N'20% off summer sale', N'Percentage', CAST(20.00 AS Decimal(10, 2)), CAST(N'2025-05-28T00:00:00.000' AS DateTime), CAST(N'2025-08-27T00:00:00.000' AS DateTime), 100, 0, 1, CAST(N'2025-04-03T20:50:34.427' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (7, N'WELCOME10', N'10% off for new users', N'Percentage', CAST(12.00 AS Decimal(10, 2)), CAST(N'2024-12-31T00:00:00.000' AS DateTime), CAST(N'2025-12-30T00:00:00.000' AS DateTime), NULL, 0, 1, CAST(N'2025-04-03T20:50:34.427' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (11, N'HOLIDAY25', N'25% off for the holiday season', N'Percentage', CAST(25.00 AS Decimal(10, 2)), CAST(N'2025-12-15T00:00:00.000' AS DateTime), CAST(N'2026-01-05T00:00:00.000' AS DateTime), 150, 0, 1, CAST(N'2025-04-03T20:50:34.427' AS DateTime))
GO
INSERT [dbo].[Discount] ([DiscountId], [Code], [Description], [DiscountType], [DiscountValue], [StartDate], [EndDate], [UsageLimit], [UsedCount], [IsActive], [CreatedAt]) VALUES (12, N'HA20', N'20', N'Percentage', CAST(20.00 AS Decimal(10, 2)), CAST(N'2025-05-26T00:00:00.000' AS DateTime), NULL, NULL, 0, 1, CAST(N'2025-05-27T02:39:25.993' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Discount] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItems] ON 
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (2, NULL, 2, CAST(150000.00 AS Decimal(10, 2)), CAST(300000.00 AS Decimal(10, 2)), 2, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (3, NULL, 2, CAST(150000.00 AS Decimal(10, 2)), CAST(300000.00 AS Decimal(10, 2)), 3, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (4, NULL, 2, CAST(150000.00 AS Decimal(10, 2)), CAST(300000.00 AS Decimal(10, 2)), 4, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (5, NULL, 2, CAST(150000.00 AS Decimal(10, 2)), CAST(300000.00 AS Decimal(10, 2)), 5, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (6, NULL, 2, CAST(150000.00 AS Decimal(10, 2)), CAST(300000.00 AS Decimal(10, 2)), 6, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (7, NULL, 2, CAST(150000.00 AS Decimal(10, 2)), CAST(300000.00 AS Decimal(10, 2)), 7, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (8, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 8, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (9, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 9, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (10, NULL, 5, CAST(49000.00 AS Decimal(10, 2)), CAST(245000.00 AS Decimal(10, 2)), 9, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (11, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 10, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (12, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 11, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (13, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 12, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (14, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 13, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (15, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 14, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (16, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 15, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (17, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 16, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (18, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 17, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (19, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 18, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (20, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 19, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (21, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 19, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (22, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 20, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (23, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 20, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (24, NULL, 1, CAST(150000.00 AS Decimal(10, 2)), CAST(150000.00 AS Decimal(10, 2)), 21, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (25, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 21, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (26, NULL, 2, CAST(150000.00 AS Decimal(10, 2)), CAST(300000.00 AS Decimal(10, 2)), 22, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (27, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 22, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (28, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 22, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (29, NULL, 1, CAST(15000.00 AS Decimal(10, 2)), CAST(15000.00 AS Decimal(10, 2)), 22, N'Rau muống ')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (30, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 22, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (31, NULL, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 22, N'Bò viên')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (32, NULL, 2, CAST(150000.00 AS Decimal(10, 2)), CAST(300000.00 AS Decimal(10, 2)), 23, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (33, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 23, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (34, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 23, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (35, NULL, 1, CAST(15000.00 AS Decimal(10, 2)), CAST(15000.00 AS Decimal(10, 2)), 23, N'Rau muống ')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (36, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 23, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (37, NULL, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 23, N'Bò viên')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (38, NULL, 10, CAST(120000.00 AS Decimal(10, 2)), CAST(1200000.00 AS Decimal(10, 2)), 24, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (39, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 24, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (40, NULL, 1, CAST(49000.00 AS Decimal(10, 2)), CAST(49000.00 AS Decimal(10, 2)), 24, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (41, NULL, 8, CAST(120000.00 AS Decimal(10, 2)), CAST(960000.00 AS Decimal(10, 2)), 25, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (42, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 25, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (43, NULL, 1, CAST(49000.00 AS Decimal(10, 2)), CAST(49000.00 AS Decimal(10, 2)), 25, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (44, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 26, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (45, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 26, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (46, NULL, 1, CAST(49000.00 AS Decimal(10, 2)), CAST(49000.00 AS Decimal(10, 2)), 26, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (47, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 27, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (48, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 27, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (49, NULL, 1, CAST(49000.00 AS Decimal(10, 2)), CAST(49000.00 AS Decimal(10, 2)), 27, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (50, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 28, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (51, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 28, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (52, NULL, 1, CAST(49000.00 AS Decimal(10, 2)), CAST(49000.00 AS Decimal(10, 2)), 28, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (53, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 29, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (54, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 29, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (55, NULL, 1, CAST(49000.00 AS Decimal(10, 2)), CAST(49000.00 AS Decimal(10, 2)), 29, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (56, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 30, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (57, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 30, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (58, NULL, 1, CAST(49000.00 AS Decimal(10, 2)), CAST(49000.00 AS Decimal(10, 2)), 30, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (59, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 31, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (60, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 31, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (61, NULL, 1, CAST(49000.00 AS Decimal(10, 2)), CAST(49000.00 AS Decimal(10, 2)), 31, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (62, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 32, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (63, NULL, 2, CAST(5000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 32, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (64, NULL, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 32, N'Bò viên')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (65, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 32, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (66, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 32, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (67, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 33, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (68, NULL, 2, CAST(5000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 33, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (69, NULL, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 33, N'Bò viên')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (70, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 33, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (71, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 33, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (72, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 34, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (73, NULL, 2, CAST(5000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 34, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (74, NULL, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 34, N'Bò viên')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (75, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 34, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (76, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 34, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (77, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 35, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (78, NULL, 2, CAST(5000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 35, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (79, NULL, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 35, N'Bò viên')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (80, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 35, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (81, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 35, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (82, NULL, 2, CAST(49000.00 AS Decimal(10, 2)), CAST(98000.00 AS Decimal(10, 2)), 36, N'Pho bo')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (83, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 37, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (84, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 38, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (85, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 39, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (86, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 39, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (87, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 39, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (88, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 40, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (89, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 40, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (90, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 40, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (91, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 41, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (92, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 41, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (93, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 41, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (94, NULL, 1, CAST(120000.00 AS Decimal(10, 2)), CAST(120000.00 AS Decimal(10, 2)), 42, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (95, NULL, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 42, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (96, NULL, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 42, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (97, NULL, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 43, N'Bò viên')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (98, 21, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), 44, N'Bò viên')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (99, 22, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 45, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (100, 22, 1, CAST(8000.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), 46, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (101, 22, 2, CAST(8000.00 AS Decimal(10, 2)), CAST(16000.00 AS Decimal(10, 2)), 47, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (102, 26, 6, CAST(35000.00 AS Decimal(10, 2)), CAST(210000.00 AS Decimal(10, 2)), 48, N'Cơm chay ')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (103, 22, 2, CAST(8000.00 AS Decimal(10, 2)), CAST(16000.00 AS Decimal(10, 2)), 49, N'Nấm kim châm')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (104, 23, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 50, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (105, 23, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), 51, N'Trứng gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (106, 20, 2, CAST(150000.00 AS Decimal(10, 2)), CAST(300000.00 AS Decimal(10, 2)), 52, N'Lẩu Thái')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (107, 24, 3, CAST(15000.00 AS Decimal(10, 2)), CAST(45000.00 AS Decimal(10, 2)), 52, N'Rau muống ')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (108, 26, 1, CAST(35000.00 AS Decimal(10, 2)), CAST(35000.00 AS Decimal(10, 2)), 53, N'Cơm chay ')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (109, 27, 1, CAST(100000.00 AS Decimal(10, 2)), CAST(100000.00 AS Decimal(10, 2)), 54, N'Lẩu Gà')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (110, 24, 1, CAST(15000.00 AS Decimal(10, 2)), CAST(15000.00 AS Decimal(10, 2)), 55, N'Rau muống ')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (111, 26, 1, CAST(35000.00 AS Decimal(10, 2)), CAST(35000.00 AS Decimal(10, 2)), 56, N'Cơm chay ')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (112, 26, 1, CAST(35000.00 AS Decimal(10, 2)), CAST(35000.00 AS Decimal(10, 2)), 57, N'Cơm chay ')
GO
INSERT [dbo].[OrderItems] ([OrderItemID], [ProductId], [Quantity], [Price], [TotalPrice], [OrderID], [ProductName]) VALUES (113, 20, 6, CAST(150000.00 AS Decimal(10, 2)), CAST(900000.00 AS Decimal(10, 2)), 58, N'Lẩu Thái')
GO
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (2, N'0', 8, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(300000.00 AS Decimal(10, 2)), CAST(329000.00 AS Decimal(10, 2)), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (3, N'0', 8, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(300000.00 AS Decimal(10, 2)), CAST(329000.00 AS Decimal(10, 2)), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (4, N'0', 8, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(300000.00 AS Decimal(10, 2)), CAST(329000.00 AS Decimal(10, 2)), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (5, N'0', 8, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(300000.00 AS Decimal(10, 2)), CAST(329000.00 AS Decimal(10, 2)), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (6, N'0', 8, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(300000.00 AS Decimal(10, 2)), CAST(329000.00 AS Decimal(10, 2)), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (7, N'0', 8, NULL, N'store', CAST(0.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(300000.00 AS Decimal(10, 2)), CAST(285000.00 AS Decimal(10, 2)), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (8, N'0', 5, NULL, N'home', CAST(21000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(150000.00 AS Decimal(10, 2)), CAST(162450.00 AS Decimal(10, 2)), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (9, N'0', 5, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(395000.00 AS Decimal(10, 2)), CAST(402800.00 AS Decimal(10, 2)), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (10, N'0', 5, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(150000.00 AS Decimal(10, 2)), CAST(179000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T00:00:00.000' AS DateTime), N'as')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (11, N'0', 21, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(150000.00 AS Decimal(10, 2)), CAST(189000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (12, N'0', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(150000.00 AS Decimal(10, 2)), CAST(179000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (13, N'0', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(150000.00 AS Decimal(10, 2)), CAST(179000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (14, N'0', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(150000.00 AS Decimal(10, 2)), CAST(179000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (15, N'0', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(150000.00 AS Decimal(10, 2)), CAST(179000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (16, N'0', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(150000.00 AS Decimal(10, 2)), CAST(179000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (17, N'5', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(150000.00 AS Decimal(10, 2)), CAST(179000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (18, N'4', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(150000.00 AS Decimal(10, 2)), CAST(179000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T06:46:40.790' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (19, N'4', 21, N'giam10pt', N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(248000.00 AS Decimal(10, 2)), CAST(252200.00 AS Decimal(10, 2)), CAST(N'2025-05-12T21:38:26.913' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (20, N'2', 21, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(248000.00 AS Decimal(10, 2)), CAST(287000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T22:09:50.610' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (21, N'0', 21, N'giam50k', N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(248000.00 AS Decimal(10, 2)), CAST(227000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T22:45:40.587' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (22, N'6', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(436000.00 AS Decimal(10, 2)), CAST(441750.00 AS Decimal(10, 2)), CAST(N'2025-05-12T22:55:49.920' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (23, N'6', 21, N'giam50k', N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(436000.00 AS Decimal(10, 2)), CAST(415000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T23:04:51.200' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (24, N'2', 21, N'giam10pt', N'home', CAST(35000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(1254000.00 AS Decimal(10, 2)), CAST(1105420.00 AS Decimal(10, 2)), CAST(N'2025-05-15T22:23:55.597' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (25, N'2', 21, N'giam50k', N'home', CAST(35000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(1014000.00 AS Decimal(10, 2)), CAST(949050.00 AS Decimal(10, 2)), CAST(N'2025-05-15T22:27:25.280' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (26, N'0', 21, NULL, N'home', CAST(34000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(174000.00 AS Decimal(10, 2)), CAST(208000.00 AS Decimal(10, 2)), CAST(N'2025-05-15T22:31:38.620' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (27, N'2', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(174000.00 AS Decimal(10, 2)), CAST(203000.00 AS Decimal(10, 2)), CAST(N'2025-05-15T22:48:21.323' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (28, N'0', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(174000.00 AS Decimal(10, 2)), CAST(203000.00 AS Decimal(10, 2)), CAST(N'2025-05-15T22:49:49.153' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (29, N'0', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(174000.00 AS Decimal(10, 2)), CAST(203000.00 AS Decimal(10, 2)), CAST(N'2025-05-15T22:49:55.380' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (30, N'0', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(174000.00 AS Decimal(10, 2)), CAST(203000.00 AS Decimal(10, 2)), CAST(N'2025-05-15T22:58:07.910' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (31, N'0', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(174000.00 AS Decimal(10, 2)), CAST(203000.00 AS Decimal(10, 2)), CAST(N'2025-05-15T23:03:08.750' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (32, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(246000.00 AS Decimal(10, 2)), CAST(270750.00 AS Decimal(10, 2)), CAST(N'2025-05-25T00:57:23.030' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (33, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(246000.00 AS Decimal(10, 2)), CAST(270750.00 AS Decimal(10, 2)), CAST(N'2025-05-25T00:57:33.527' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (34, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(246000.00 AS Decimal(10, 2)), CAST(270750.00 AS Decimal(10, 2)), CAST(N'2025-05-25T00:57:46.540' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (35, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(246000.00 AS Decimal(10, 2)), CAST(270750.00 AS Decimal(10, 2)), CAST(N'2025-05-25T00:58:00.930' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (36, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(98000.00 AS Decimal(10, 2)), CAST(137000.00 AS Decimal(10, 2)), CAST(N'2025-05-25T00:59:05.510' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (37, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(120000.00 AS Decimal(10, 2)), CAST(159000.00 AS Decimal(10, 2)), CAST(N'2025-05-26T23:33:26.150' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (38, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(120000.00 AS Decimal(10, 2)), CAST(159000.00 AS Decimal(10, 2)), CAST(N'2025-05-26T23:34:49.310' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (39, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(133000.00 AS Decimal(10, 2)), CAST(172000.00 AS Decimal(10, 2)), CAST(N'2025-05-26T23:41:58.530' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (40, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(133000.00 AS Decimal(10, 2)), CAST(172000.00 AS Decimal(10, 2)), CAST(N'2025-05-26T23:50:04.873' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (41, N'1', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(133000.00 AS Decimal(10, 2)), CAST(172000.00 AS Decimal(10, 2)), CAST(N'2025-05-26T23:50:58.283' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (42, N'1', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(133000.00 AS Decimal(10, 2)), CAST(172000.00 AS Decimal(10, 2)), CAST(N'2025-05-26T23:52:44.430' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (43, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(10000.00 AS Decimal(10, 2)), CAST(46550.00 AS Decimal(10, 2)), CAST(N'2025-05-27T00:44:58.477' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (44, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(10000.00 AS Decimal(10, 2)), CAST(46550.00 AS Decimal(10, 2)), CAST(N'2025-05-27T00:48:47.837' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (45, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(8000.00 AS Decimal(10, 2)), CAST(47000.00 AS Decimal(10, 2)), CAST(N'2025-05-27T00:53:09.553' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (46, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(8000.00 AS Decimal(10, 2)), CAST(47000.00 AS Decimal(10, 2)), CAST(N'2025-05-27T00:58:26.573' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (47, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(16000.00 AS Decimal(10, 2)), CAST(55000.00 AS Decimal(10, 2)), CAST(N'2025-05-27T01:05:45.893' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (48, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(210000.00 AS Decimal(10, 2)), CAST(249000.00 AS Decimal(10, 2)), CAST(N'2025-05-27T01:36:36.413' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (49, N'1', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(16000.00 AS Decimal(10, 2)), CAST(55000.00 AS Decimal(10, 2)), CAST(N'2025-05-27T01:52:48.160' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (50, N'2', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(5000.00 AS Decimal(10, 2)), CAST(44000.00 AS Decimal(10, 2)), CAST(N'2025-05-27T02:22:21.270' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (51, N'2', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(5000.00 AS Decimal(10, 2)), CAST(44000.00 AS Decimal(10, 2)), CAST(N'2025-05-27T02:23:08.940' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (52, N'2', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(345000.00 AS Decimal(10, 2)), CAST(384000.00 AS Decimal(10, 2)), CAST(N'2025-05-27T02:30:15.563' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (53, N'0', 31, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(35000.00 AS Decimal(10, 2)), CAST(74000.00 AS Decimal(10, 2)), CAST(N'2025-05-28T17:35:46.593' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (54, N'0', 5, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(100000.00 AS Decimal(10, 2)), CAST(139000.00 AS Decimal(10, 2)), CAST(N'2025-05-28T17:46:23.207' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (55, N'1', 5, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(15000.00 AS Decimal(10, 2)), CAST(54000.00 AS Decimal(10, 2)), CAST(N'2025-05-28T17:47:57.613' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (56, N'0', 5, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(35000.00 AS Decimal(10, 2)), CAST(74000.00 AS Decimal(10, 2)), CAST(N'2025-05-28T18:57:35.667' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (57, N'1', 5, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(35000.00 AS Decimal(10, 2)), CAST(74000.00 AS Decimal(10, 2)), CAST(N'2025-05-28T18:58:38.030' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (58, N'1', 31, NULL, N'store', CAST(0.00 AS Decimal(10, 2)), N'cod', N'100', CAST(900000.00 AS Decimal(10, 2)), CAST(900000.00 AS Decimal(10, 2)), CAST(N'2025-05-28T21:32:46.030' AS DateTime), N'')
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategories] ON 
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (1, N'Mâm giết sâu bọ 5.5', N'Thực đơn gia đình', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (2, N'Mâm cơm 3-4 người ăn', N'Thực đơn gia đình', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (3, N'Mâm cơm 5-6 người ăn', N'Thực đơn gia đình', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (4, N'Mâm cỗ chay ngày rằm', N'Thực đơn gia đình', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (5, N'Mâm cỗ mặn ngày rằm', N'Thực đơn gia đình', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (6, N'Lẩu Thái Eat House', N'Lẩu', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (12, N'Lẩu Riêu Cua', N'Lẩu', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (13, N'Lẩu Kim Chi', N'Lẩu', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (14, N'Lẩu Nấm', N'Lẩu', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (15, N'Đồ gọi thêm lẩu', N'Lẩu', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (16, N'Món khai vị', N'Lẩu', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (17, N'Nước lẩu và sốt chấm', N'Lẩu', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (18, N'Nước ép', N'Đồ uống', 1)
GO
INSERT [dbo].[ProductCategories] ([CategoryId], [CategoryName], [Description], [IsActive]) VALUES (19, N'Nước đóng chai', N'Đồ uống', 1)
GO
SET IDENTITY_INSERT [dbo].[ProductCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductPrices] ON 
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (13, CAST(80000.00 AS Decimal(10, 2)), 100, 13)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (14, CAST(420000.00 AS Decimal(10, 2)), 0, 14)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (19, CAST(290000.00 AS Decimal(10, 2)), 11, 20)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (20, CAST(290000.00 AS Decimal(10, 2)), 100, 21)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (21, CAST(300000.00 AS Decimal(10, 2)), 0, 22)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (22, CAST(420000.00 AS Decimal(10, 2)), 10, 23)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (23, CAST(290000.00 AS Decimal(10, 2)), 96, 24)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (24, CAST(350000.00 AS Decimal(10, 2)), 99, 26)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (25, CAST(350000.00 AS Decimal(10, 2)), 8, 27)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (26, CAST(1150000.00 AS Decimal(10, 2)), 22, 28)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (27, CAST(350000.00 AS Decimal(10, 2)), 10, 29)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (28, CAST(290000.00 AS Decimal(10, 2)), 0, 30)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (29, CAST(290000.00 AS Decimal(10, 2)), 10, 31)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (30, CAST(1150000.00 AS Decimal(10, 2)), 10, 32)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (31, CAST(60000.00 AS Decimal(10, 2)), 8, 33)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (32, CAST(50000.00 AS Decimal(10, 2)), 10, 34)
GO
SET IDENTITY_INSERT [dbo].[ProductPrices] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (13, N'Ba chỉ bò', N'Đồ gọi thêm lẩu', N' 200g Ba chỉ bò', N'https://laungontainha.com/wp-content/uploads/2018/10/Ba-chi-bo-L.jpg', 0, 15)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (14, N'Lẩu Riêu Cua Thập Cẩm', N'Lẩu Riêu Cua', N'Set lẩu bao gồm: nước lẩu riêu cua – ba chỉ bò mỹ – bắp bò – gầu hoa bò – gà ta- sụn heo tươi- giò tai – nấm kim – nấm đùi –  bún( hoặc mỳ tôm) – rau hỗn hợp – ngô ngọt – đậu phụ chiên – riêu cua – váng đậu – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-rieu-cua-thap-cam-4-6-1-510x510.jpg', 0, 12)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (20, N'Lẩu Kim Chi Ba Chỉ Bò Mỹ', N'Lẩu Kim Chi', N'Set lẩu bao gồm: nước lẩu – ba chỉ bò mỹ – đậu hũ pm – viên tôm hùm – nấm kim – nấm đùi gà – mỳ tôm – rau hỗn hợp – ngô ngọt – đậu phụ – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-kim-chi-ba-chi-bo-set-4-6-1.jpg', 0, 13)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (21, N'Lẩu Thái Bò', N'Lẩu Thái Eat House', N'👉 Set lẩu bao gồm: nước lẩu thái tomyum – bắp bò – ba chỉ bò – gầu hoa bò – đậu hũ phomai – viên tôm hùm – nấm kim – nấm đùi gà – mỳ tôm – rau muống – cải ngọt – rau cần – cải thảo – ngô ngọt – đậu phụ – váng đậu – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-thai-bo-4-6-1-510x510.jpg', 0, 6)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (22, N'Lẩu Riêu Cua Bò', N'Lẩu Riêu Cua', N'👉 Set lẩu bao gồm: nước lẩu riêu cua – ba chỉ bò mỹ – bắp bò – gầu bò – giò tai – riêu cua – nấm kim – nấm đùi –  bún( hoặc mỳ tôm) – rau hỗn hợp – ngô ngọt – đậu phụ chiên – váng đậu – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-rieu-bo-1-510x510.jpg', 0, 12)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (23, N'Lẩu Nấm Thập Cẩm', N'Lẩu Nấm', N'Set lẩu bao gồm: nước lẩu – ba chỉ bò – bắp bò – gầu hoa bò – sụn – gà ta – đậu hũ phomai – viên tôm hùm – nấm kim – nấm đùi gà – Bún hoặc mỳ tôm – rau hỗn hợp – ngô ngọt – đậu phụ – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-nam-thap-cam-4-6-1.jpg', 0, 14)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (24, N'Lẩu Nấm Bò', N'Lẩu Nấm', N'Set lẩu bao gồm: nước lẩu – ba chỉ bò – bắp bò – gầu hoa bò – đậu hũ phomai – viên tôm hùm – nấm kim – nấm đùi gà – Bún hoặc mỳ tôm – rau hỗn hợp – ngô ngọt – đậu phụ – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-nam-bo-4-6-1.jpg', 0, 14)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (26, N'Lẩu Thái Ba Chỉ Bò Mỹ', N'Lẩu Thái Eat House', N'👉 Set lẩu bao gồm: nước lẩu – bò mỹ – đậu hũ phomai – viên tôm hùm – nấm kim – nấm đùi gà – mỳ tôm – rau hỗn hợp – ngô ngọt – đậu phụ – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-thai-ba-chi-bo-set-4-6-1-510x510.jpg', 0, 6)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (27, N'Lẩu Thái Thập Cẩm', N'Lẩu Thái Eat House', N'👉 Set lẩu bao gồm: nước lẩu – bò mỹ – sườn sụn – tôm – mực – ngao – viên tôm hùm – đậu hũ phomai – nấm kim – nấm đùi gà – mỳ tôm – đĩa rau hỗn hợp – ngô ngọt – đậu phụ – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-Thai-Thap-Cam-set-4-6-1-510x510.jpg', 0, 6)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (28, N'Combo Lẩu Riêu Cua Đoàn Viên (8 – 10 Người)', N'Lẩu Riêu Cua', N'Set Lẩu Bao Gồm: Nước Lẩu 4-4,5L, Ba chỉ bò 300g, 300g Gầu hoa bò, Sụn Tươi 300g, Ba Chỉ Bò Cuộn Nấm 300g, Má Đào Heo 300g, Bắp bò 300g, Tràng heo tươi 250g, Gà 500g, nước lẩu thái 3-3,5 lit, rau tổng hợp 1,5kg, nấm kim 300g, nấm đùi 150g, ngô ngọt 6-8 miếng, 1 Đĩa giò tai, 3 bìa đậu chiên,1 hộp váng đậu, 1 hộp Riêu cua, 1,3kg Bún hoặc 5 gói mỳ, 3 gói sốt chấm, 2 gói muối chấm, quất ớt (Khách có thể yêu cầu đổi món trong set lẩu sang món khác)', N'https://laungontainha.com/wp-content/uploads/2025/05/Lau-Doan-Vien-set-7-10ng-510x510.jpg', 0, 12)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (29, N'Lẩu Kim Chi Thập Cẩm', N'Lẩu Kim Chi', N'Set lẩu bao gồm: nước lẩu – bò mỹ – sườn sụn – tôm sú – mực ngao – đậu hũ pm – viên tôm hùm – nấm kim – nấm đùi gà – mỳ tôm – rau hỗn hợp – ngô ngọt – đậu phụ – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-kim-chi-thap-cam-set-4-6-1.jpg', 0, 13)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (30, N'Lẩu Kim Chi Bò', N'Lẩu Kim Chi', N'Set lẩu bao gồm: nước lẩu kim chi – bắp bò – ba chỉ bò – gầu bò – đậu hũ pm – viên tôm hùm – nấm kim – nấm đùi gà – mỳ tôm – rau hỗn hợp – ngô ngọt – đậu phụ – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-kim-chi-bo-4-6-1-510x510.jpg', 0, 13)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (31, N'Lẩu Riêu Cua Bắp Bò Sườn Sụn', N'Lẩu Riêu Cua', N'👉 Set lẩu bao gồm: nước lẩu riêu cua – bắp bò – sườn sụn – giò tai – nấm kim – nấm đùi –  bún( hoặc mỳ tôm) – rau hỗn hợp – ngô ngọt – đậu phụ chiên – riêu cua – váng đậu – gia vị lẩu', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-rieu-bap-bo-suon-sun-4-6-1-510x510.jpg', 0, 12)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (32, N'Combo Lẩu Thái Sum Vầy (8 – 10 Người)', N'Lẩu Thái Eat House', N'Set Lẩu Bao Gồm: Nước Lẩu 4-4,5L, Ba chỉ bò 300g, 300g Gầu hoa bò, Sụn Tươi 300g, Tôm 7-8 con, 300g tuộc, 300g mực, Tràng heo tươi 250g, Gà 500g, nước lẩu thái 3-3,5 lit, rau tổng hợp 1,5kg, nấm kim 300g, nấm đùi 150g, ngô ngọt 6-8 miếng, 6 viên đậu hũ pm, 5 viên tôm hùm, 3 bìa đậu trắng,1 hộp váng đậu, 5 gói mỳ tôm, 3 gói sốt chấm, 2 gói muối chấm, quất ớt (Khách có thể yêu cầu đổi món trong set lẩu sang món khác )', N'https://laungontainha.com/wp-content/uploads/2022/04/Lau-Thai-Thap-Cam-set-7-10ng-510x510.jpg', 0, 6)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (33, N'Sụn heo tươi', N'Đồ gọi thêm lẩu', N'200g Sụn heo tươi', N'https://laungontainha.com/wp-content/uploads/2018/10/Sun-heo-tuoi-L.jpg', 0, 15)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete], [CategoryId]) VALUES (34, N'Ba chỉ heo', N'Đồ gọi thêm lẩu', N'200g Ba chỉ heo', N'https://laungontainha.com/wp-content/uploads/2018/10/ba-chi-heo-L.jpg', 0, 15)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductSales] ON 
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (5, 20, NULL, NULL, NULL, CAST(N'2025-05-06T14:22:23.307' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (6, 21, NULL, NULL, NULL, CAST(N'2025-05-06T14:23:05.853' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (7, 22, NULL, NULL, NULL, CAST(N'2025-05-06T14:23:35.900' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (8, 19, CAST(130000.00 AS Decimal(10, 2)), CAST(N'2025-05-27T09:51:00.000' AS DateTime), CAST(N'2025-06-07T09:51:00.000' AS DateTime), CAST(N'2025-05-06T23:18:21.320' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (9, 26, NULL, NULL, NULL, CAST(N'2025-05-13T23:05:43.247' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (10, 27, NULL, NULL, NULL, CAST(N'2025-05-13T23:44:33.287' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (11, 25, NULL, NULL, NULL, CAST(N'2025-05-13T23:44:52.140' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (12, 24, NULL, NULL, NULL, CAST(N'2025-05-15T23:52:53.157' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (13, 30, NULL, NULL, NULL, CAST(N'2025-05-30T11:04:56.277' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (14, 29, NULL, NULL, NULL, CAST(N'2025-05-30T11:08:30.330' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (15, 14, NULL, NULL, NULL, CAST(N'2025-05-30T11:10:27.653' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (16, 28, NULL, NULL, NULL, CAST(N'2025-05-30T11:14:18.423' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (17, 23, NULL, NULL, NULL, CAST(N'2025-05-30T11:17:12.830' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (18, 13, NULL, NULL, NULL, CAST(N'2025-05-30T11:21:01.263' AS DateTime))
GO
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (19, 32, NULL, NULL, NULL, CAST(N'2025-05-30T11:23:14.580' AS DateTime))
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
SET IDENTITY_INSERT [dbo].[ShippingAddress] ON 
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (1, 2, N'Hà Nội', N'3303', N'Huyện Thường Tín', N'1B2716', N'Xã Ninh Sở', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (2, 3, N'Hà Nội', N'3303', N'Huyện Thường Tín', N'1B2716', N'Xã Ninh Sở', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (3, 4, N'Hà Nội', N'3303', N'Huyện Thường Tín', N'1B2716', N'Xã Ninh Sở', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (4, 5, N'Hà Nội', N'3303', N'Huyện Thường Tín', N'1B2716', N'Xã Ninh Sở', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (5, 6, N'Hà Nội', N'3303', N'Huyện Thường Tín', N'1B2716', N'Xã Ninh Sở', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (6, 7, N'Hà Nội', N'3255', N'Huyện Phú Xuyên', N'1B2816', N'Xã Phú Yên', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (7, 8, N'Hà Nội', N'3440', N'Quận Nam Từ Liêm', N'13010', N'Phường Xuân Phương', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (8, 9, N'Hà Nội', N'3303', N'Huyện Thường Tín', N'1B2718', N'Xã Tân Minh', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (9, 10, N'Hà Nội', N'3303', N'Huyện Thường Tín', N'1B2716', N'Xã Ninh Sở', N'asa')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (10, 11, N'Hà Nội', N'1915', N'Huyện Chương Mỹ', N'1B2131', N'Xã Trường Yên', N'AAA')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (11, 12, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (12, 13, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (13, 14, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (14, 15, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (15, 16, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (16, 17, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (17, 18, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (18, 19, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (19, 20, N'Hà Nội', N'1915', N'Huyện Chương Mỹ', N'1B2131', N'Xã Trường Yên', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (20, 21, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (21, 22, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (22, 23, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (23, 24, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (24, 25, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (25, 26, N'Hà Nội', N'3440', N'', N'13010', N'', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (26, 27, N'Hà Nội', N'3440', N'', N'13010', N'', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (27, 28, N'Hà Nội', N'3440', N'', N'13010', N'', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (28, 29, N'Hà Nội', N'3440', N'', N'13010', N'', N'')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (29, 30, N'Hà Nội', N'3440', N'', N'13010', N'', N'aa')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (30, 31, N'Hà Nội', N'3440', N'Quận Nam Từ Liêm', N'13010', N'Phường Xuân Phương', N'dinh thon')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (31, 32, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (32, 33, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (33, 34, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (34, 35, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (35, 36, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (36, 37, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (37, 38, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (38, 39, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (39, 40, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (40, 41, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (41, 42, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (42, 43, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (43, 44, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (44, 45, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (45, 46, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (46, 47, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (47, 48, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (48, 49, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (49, 50, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (50, 51, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (51, 52, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (52, 53, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (53, 54, N'Hà Nội', N'1804', N'Huyện Đan Phượng', N'1B2210', N'Xã Song Phượng', N'nga sơn đồng thịnh 1')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (54, 55, N'Hà Nội', N'3255', N'Huyện Phú Xuyên', N'1B2815', N'Xã Phú Túc', N'sdfsdfs')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (55, 56, N'Hà Nội', N'2004', N'Huyện Quốc Oai', N'1B2007', N'Xã Đông Yên', N'4556')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (56, 57, N'Hà Nội', N'3255', N'Huyện Phú Xuyên', N'800214', N'Xã Nam Tiến', N'45+6')
GO
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [OrderId], [Province], [DistrictId], [DistrictName], [WardCode], [WardName], [AddressDetail]) VALUES (57, 58, N'Hà Nội', N'1803', N'Huyện Ba Vì', N'1B1718', N'Xã Phú Phương', N'HN')
GO
SET IDENTITY_INSERT [dbo].[ShippingAddress] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (5, N'ad', N'ad', N'admin@gmail.com', N'123123123', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 1, N'', 1, NULL, NULL, NULL, N'', NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (8, N'Nguyen', N'Anh', N'anh2001httttt@gmail.com', N'0944924978', N'', 2, N'', 1, N'', CAST(N'2025-05-15T12:03:29.757' AS DateTime), 1703, N'1A1210', N'NA')
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (10, N'ha', N'ha', N'anh2001htttt12t@gmail.com', N'0123456789', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'fb558a75-3d4d-40ae-b7a4-d87668ef1add', 1, NULL, NULL, NULL, N'', NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (11, N'Nguyen', N'Anh', N'admin12@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'98c3cd65-629b-4df0-ad64-68984a2dc938', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (12, N'Nguyen', N'Anh', N'admin123@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'63abd2ab-ce0d-4a39-a353-f3de7ffbdaa9', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (13, N'Nguyen', N'Anh', N'admin1234@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'5cb25354-a029-4036-a615-8892b1e6a899', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (14, N'123', N'123', N'12admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'71224243-5eb7-4beb-aa2f-3415d152c245', 1, NULL, NULL, NULL, N'', NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (17, N'123', N'123', N'122admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'b59ef008-a101-43e3-b621-e1ffd0a26264', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (18, N'123', N'123', N'1212admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'516fc55f-5c2c-4075-93d2-88713d5f26aa', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (19, N'Nguyen', N'Anh', N'121212in@gmail.com', N'0944924978', N'uCK7k5Bam9izoMCBaMQnaWQ2z4vzftSrjr9BoHZC7Rw=', 2, N'4836a57d-1596-4896-a11f-a96ee22be46c', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (20, N'123123123', N'123123', N'ad231231min@gmail.com', N'0944924978', N'PhHpc+yAvoMlMPeSLhCxmtQAXCfNBjPGe+hTyqv/+S0=', 2, N'bd5a388e-1476-4b37-94b1-0e831b4b7220', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (21, N'Nguyen', N'Anh', N'anh2001htttttt@gmail.com', N'0944924978', N'5nbRh/kGr7sOfL+N1ufteWKc7fsdJsHm0Mw1GZ3eSwg=', 2, N'', 1, N'', CAST(N'2025-05-11T23:17:01.587' AS DateTime), 3440, N'13010', N'dinh thon')
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (29, N'Nguyen', N'Anh', N'anhnhhe153131@fpt.edu.vn', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (30, N'thu', N'hà', N'thuharosy2003@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'', 1, N'', CAST(N'2025-05-13T14:37:10.867' AS DateTime), 3255, N'1B2816', N'ha nội')
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (31, N'Nguyen', N'Anh', N'anh2001htttt@gmail.com', N'0944924978', N'PQiRq6MxHLsSRszMhbdjgBcNxQU4vYzcsxYlXeTiFu8=', 2, N'', 1, N'', CAST(N'2025-05-24T17:31:02.407' AS DateTime), 1803, N'1B1718', N'HN')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Discount__A25C5AA7F18C4242]    Script Date: 30-May-25 11:26:01 AM ******/
ALTER TABLE [dbo].[Discount] ADD  CONSTRAINT [UQ__Discount__A25C5AA7F18C4242] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B616097FD18A4]    Script Date: 30-May-25 11:26:01 AM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D105340A96D1D5]    Script Date: 30-May-25 11:26:01 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ__Users__A9D105340A96D1D5] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Discount] ADD  CONSTRAINT [DF__Discount__UsedCo__38996AB5]  DEFAULT ((0)) FOR [UsedCount]
GO
ALTER TABLE [dbo].[Discount] ADD  CONSTRAINT [DF__Discount__IsActi__398D8EEE]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Discount] ADD  CONSTRAINT [DF__Discount__Create__3A81B327]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ProductCategories] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ProductSales] ADD  CONSTRAINT [DF__ProductSa__Creat__5EBF139D]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Orders]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_ProductPrices] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductPrices] ([ProductPriceID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_ProductPrices]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Discount] FOREIGN KEY([DiscountCode])
REFERENCES [dbo].[Discount] ([Code])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Discount]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[ProductAddOns]  WITH CHECK ADD  CONSTRAINT [FK_ProductAddOns_AddOnProduct] FOREIGN KEY([AddOnProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductAddOns] CHECK CONSTRAINT [FK_ProductAddOns_AddOnProduct]
GO
ALTER TABLE [dbo].[ProductAddOns]  WITH CHECK ADD  CONSTRAINT [FK_ProductAddOns_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductAddOns] CHECK CONSTRAINT [FK_ProductAddOns_Product]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductPrices]  WITH CHECK ADD  CONSTRAINT [FK__ProductPr__Produ__2D27B809] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductPrices] CHECK CONSTRAINT [FK__ProductPr__Produ__2D27B809]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_ProductCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[ProductCategories] ([CategoryId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_ProductCategory]
GO
ALTER TABLE [dbo].[ProductSales]  WITH CHECK ADD  CONSTRAINT [FK__ProductSa__Produ__6477ECF3] FOREIGN KEY([ProductPriceID])
REFERENCES [dbo].[ProductPrices] ([ProductPriceID])
GO
ALTER TABLE [dbo].[ProductSales] CHECK CONSTRAINT [FK__ProductSa__Produ__6477ECF3]
GO
ALTER TABLE [dbo].[ShippingAddress]  WITH CHECK ADD  CONSTRAINT [FK_ShippingAddress_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShippingAddress] CHECK CONSTRAINT [FK_ShippingAddress_Order]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK__Users__RoleID__44FF419A] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK__Users__RoleID__44FF419A]
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD  CONSTRAINT [CK__Discount__Discou__45F365D3] CHECK  (([DiscountType]='FixedAmount' OR [DiscountType]='Percentage'))
GO
ALTER TABLE [dbo].[Discount] CHECK CONSTRAINT [CK__Discount__Discou__45F365D3]
GO
ALTER TABLE [dbo].[ProductAddOns]  WITH CHECK ADD  CONSTRAINT [CHK_ProductAddOns_NoSelfReference] CHECK  (([ProductID]<>[AddOnProductID]))
GO
ALTER TABLE [dbo].[ProductAddOns] CHECK CONSTRAINT [CHK_ProductAddOns_NoSelfReference]
GO
USE [master]
GO
ALTER DATABASE [Demo_6] SET  READ_WRITE 
GO
