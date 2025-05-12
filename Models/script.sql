USE [master]
GO
/****** Object:  Database [Demo_3]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[Discount]    Script Date: 12/5/2025 11:33:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountId] [int] NOT NULL,
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
/****** Object:  Table [dbo].[OrderItems]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[ProductAddOns]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[ProductImages]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[ProductPrices]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[ProductSales]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[ShippingAddress]    Script Date: 12/5/2025 11:33:51 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 12/5/2025 11:33:51 PM ******/
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
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (19, N'3', 21, N'giam10pt', N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(248000.00 AS Decimal(10, 2)), CAST(252200.00 AS Decimal(10, 2)), CAST(N'2025-05-12T21:38:26.913' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (20, N'2', 21, NULL, N'home', CAST(39000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(248000.00 AS Decimal(10, 2)), CAST(287000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T22:09:50.610' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (21, N'1', 21, N'giam50k', N'home', CAST(29000.00 AS Decimal(10, 2)), N'cod', N'50', CAST(248000.00 AS Decimal(10, 2)), CAST(227000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T22:45:40.587' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (22, N'6', 21, NULL, N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'100', CAST(436000.00 AS Decimal(10, 2)), CAST(441750.00 AS Decimal(10, 2)), CAST(N'2025-05-12T22:55:49.920' AS DateTime), N'')
GO
INSERT [dbo].[Orders] ([OrderID], [Status], [UserID], [DiscountCode], [ShippingMethod], [ShippingFee], [PaymentMethod], [VnpayOption], [Subtotal], [FinalTotal], [DateTime], [Note]) VALUES (23, N'6', 21, N'giam50k', N'home', CAST(29000.00 AS Decimal(10, 2)), N'vnpay', N'50', CAST(436000.00 AS Decimal(10, 2)), CAST(415000.00 AS Decimal(10, 2)), CAST(N'2025-05-12T23:04:51.200' AS DateTime), N'')
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductAddOns] ON 
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (6, 14, 23)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (8, 20, 24)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (11, 20, 21)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (12, 20, 22)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (13, 20, 23)
GO
SET IDENTITY_INSERT [dbo].[ProductAddOns] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (7, 13, N'https://fullofplants.com/wp-content/uploads/2023/10/how-to-make-vegan-bun-rieu-chay-vietnamese-crab-noodle-soup-thumb.jpg')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (8, 14, N'https://images.unsplash.com/photo-1511910849309-0dffb8785146?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGhvfGVufDB8fDB8fHww')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (18, 20, N'https://file.hstatic.net/1000394081/article/lau-thai_2aedea543c194e93948def3c260e8eb9.jpg')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (19, 20, N'https://maythucphamgoma.vn/wp-content/uploads/2024/10/thai-tc1-4-6ng.png')
GO
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductPrices] ON 
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (13, CAST(50000.00 AS Decimal(10, 2)), 100, 13)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (14, CAST(49000.00 AS Decimal(10, 2)), 0, 14)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (19, CAST(150000.00 AS Decimal(10, 2)), 20, 20)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (20, CAST(10000.00 AS Decimal(10, 2)), 1, 21)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (21, CAST(8000.00 AS Decimal(10, 2)), 1, 22)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (22, CAST(5000.00 AS Decimal(10, 2)), 1, 23)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (23, CAST(15000.00 AS Decimal(10, 2)), 100, 24)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (24, CAST(35000.00 AS Decimal(10, 2)), 100, 26)
GO
SET IDENTITY_INSERT [dbo].[ProductPrices] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (13, N'Bun rieu', N'Bún', N'no', N'https://cdn.tgdd.vn/2020/08/CookProduct/Untitled-1-1200x676-10.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (14, N'Pho bo', N'Bún', N'123', N'https://plus.unsplash.com/premium_photo-1664478276162-46c39b3557c3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhvfGVufDB8fDB8fHww', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (20, N'Lẩu Thái', N'Lẩu', N'Lẩu Thái tôm chua cay', N'https://sgtt.thesaigontimes.vn/wp-content/uploads/2025/01/2024_1_23_638416491645237808_mach-ban-cach-nau-lau-thai-bang-goi-gia-vi_960.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (21, N'Bò viên', N'Topping', N'Bò viên dai tươi ngon', N'https://mastermeats.com.vn/wp-content/uploads/2023/12/bo-vien-nau-gi-ngon-1.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (22, N'Nấm kim châm', N'Topping', N'Nấm tươi ngon', N'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTl1i_2x_jwtuzVagdNwj4EwKNJsgyR0kazHbO3I1wmu4g-6Eu976diT_L0_JzIvOjieBGazHRw4Iw4Yt3cFDDWIQ', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (23, N'Trứng gà', N'Topping', N'Trứng gà ta', N'https://bynature.vn/wp-content/uploads/2023/11/bynature-why-free-range-eggs-blog.jpg', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (24, N'Rau muống ', N'Topping', N'no', N'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRDqYWKDC0cZil0kCu02yPUV03hHYJMvs4fR6zYvcsReC1eZ120KPD_sVbtINvbN900ml9il0VGdhFdifqxqiYy2w', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (25, N'C1', N'Cơm chay', N'no', N'no', 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (26, N'Cơm chay 1', N'Cơm chay', N'No', N'https://down-cvs-vn.img.susercontent.com/vn-11134513-7r98o-lsv6w1kz1kex61@resize_ss640x400!@crop_w640_h400_cT', 0)
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
INSERT [dbo].[ProductSales] ([SaleID], [ProductPriceID], [SalePrice], [SaleStartDate], [SaleEndDate], [CreatedAt]) VALUES (8, 19, NULL, NULL, NULL, CAST(N'2025-05-06T23:18:21.320' AS DateTime))
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
SET IDENTITY_INSERT [dbo].[ShippingAddress] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (5, N'ad', N'ad', N'admin@gmail.com', N'123123123', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (8, N'ha', N'ha', N'anh2001httttt@gmail.com', N'0123456789', N'5nbRh/kGr7sOfL+N1ufteWKc7fsdJsHm0Mw1GZ3eSwg=', 2, N'', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (10, N'ha', N'ha', N'anh2001htttt12t@gmail.com', N'0123456789', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'fb558a75-3d4d-40ae-b7a4-d87668ef1add', 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (11, N'Nguyen', N'Anh', N'admin12@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'98c3cd65-629b-4df0-ad64-68984a2dc938', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (12, N'Nguyen', N'Anh', N'admin123@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'63abd2ab-ce0d-4a39-a353-f3de7ffbdaa9', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (13, N'Nguyen', N'Anh', N'admin1234@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'5cb25354-a029-4036-a615-8892b1e6a899', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (14, N'123', N'123', N'12admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'71224243-5eb7-4beb-aa2f-3415d152c245', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (17, N'123', N'123', N'122admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'b59ef008-a101-43e3-b621-e1ffd0a26264', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (18, N'123', N'123', N'1212admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'516fc55f-5c2c-4075-93d2-88713d5f26aa', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (19, N'Nguyen', N'Anh', N'121212in@gmail.com', N'0944924978', N'uCK7k5Bam9izoMCBaMQnaWQ2z4vzftSrjr9BoHZC7Rw=', 2, N'4836a57d-1596-4896-a11f-a96ee22be46c', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (20, N'123123123', N'123123', N'ad231231min@gmail.com', N'0944924978', N'PhHpc+yAvoMlMPeSLhCxmtQAXCfNBjPGe+hTyqv/+S0=', 2, N'bd5a388e-1476-4b37-94b1-0e831b4b7220', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (21, N'Nguyen', N'Anh', N'anh2001htttt@gmail.com', N'0944924978', N'5nbRh/kGr7sOfL+N1ufteWKc7fsdJsHm0Mw1GZ3eSwg=', 2, N'', 1, N'', CAST(N'2025-05-11T23:17:01.587' AS DateTime), 3440, N'13010', N'dinh thon')
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry], [DistrictID], [WardCode], [AddressDetail]) VALUES (29, N'Nguyen', N'Anh', N'anhnhhe153131@fpt.edu.vn', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', 2, N'', 1, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Discount__A25C5AA7F18C4242]    Script Date: 12/5/2025 11:33:51 PM ******/
ALTER TABLE [dbo].[Discount] ADD  CONSTRAINT [UQ__Discount__A25C5AA7F18C4242] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B6160DED04910]    Script Date: 12/5/2025 11:33:51 PM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D105340A96D1D5]    Script Date: 12/5/2025 11:33:51 PM ******/
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
ALTER TABLE [dbo].[ProductSales] ADD  CONSTRAINT [DF__ProductSa__Creat__5EBF139D]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Orders]
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
ALTER DATABASE [Demo_3] SET  READ_WRITE 
GO
