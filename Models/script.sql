USE [master]
GO
/****** Object:  Database [Demo_3]    Script Date: 05-May-25 5:44:16 PM ******/
CREATE DATABASE [Demo_3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Demo_3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Demo_3.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Demo_3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Demo_3_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Demo_3] SET COMPATIBILITY_LEVEL = 160
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
ALTER DATABASE [Demo_3] SET QUERY_STORE = OFF
GO
USE [Demo_3]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 05-May-25 5:44:16 PM ******/
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
/****** Object:  Table [dbo].[OrderItems]    Script Date: 05-May-25 5:44:16 PM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 05-May-25 5:44:16 PM ******/
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
/****** Object:  Table [dbo].[ProductAddOns]    Script Date: 05-May-25 5:44:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAddOns](
	[ProductAddOnID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[AddOnProductID] [int] NOT NULL,
	[AddOnPrice] [decimal](18, 2) NOT NULL,
	[AddOnQuantity] [int] NOT NULL,
	[IsOptional] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductAddOnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 05-May-25 5:44:16 PM ******/
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
/****** Object:  Table [dbo].[ProductPrices]    Script Date: 05-May-25 5:44:16 PM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 05-May-25 5:44:17 PM ******/
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
/****** Object:  Table [dbo].[ProductSales]    Script Date: 05-May-25 5:44:17 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 05-May-25 5:44:17 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 05-May-25 5:44:17 PM ******/
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
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (1, CAST(N'2025-03-30T17:13:25.413' AS DateTime), CAST(1599.98 AS Decimal(10, 2)), N'Processing', 1)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (2, CAST(N'2025-04-22T23:56:32.840' AS DateTime), CAST(1000.00 AS Decimal(10, 2)), N'Processing', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (3, CAST(N'2025-04-23T00:00:24.800' AS DateTime), CAST(1000.00 AS Decimal(10, 2)), N'Processing', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (4, CAST(N'2025-04-23T00:05:23.650' AS DateTime), CAST(1000.00 AS Decimal(10, 2)), N'Processing', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (5, CAST(N'2025-04-23T00:09:40.643' AS DateTime), CAST(100.00 AS Decimal(10, 2)), N'Shipped', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (6, CAST(N'2025-04-23T00:10:38.007' AS DateTime), CAST(100.00 AS Decimal(10, 2)), N'Shipped', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (7, CAST(N'2025-04-23T00:16:49.253' AS DateTime), CAST(100.00 AS Decimal(10, 2)), N'Shipped', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (10, CAST(N'2025-04-27T23:49:27.750' AS DateTime), CAST(99000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (11, CAST(N'2025-04-28T00:00:11.463' AS DateTime), CAST(99000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (12, CAST(N'2025-04-28T00:07:34.737' AS DateTime), CAST(99000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (20, CAST(N'2025-04-28T00:33:29.007' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (21, CAST(N'2025-04-28T00:33:30.637' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (22, CAST(N'2025-04-28T00:34:24.553' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (23, CAST(N'2025-04-28T00:35:40.217' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (24, CAST(N'2025-04-28T00:40:57.023' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (25, CAST(N'2025-04-28T00:44:15.703' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (26, CAST(N'2025-04-28T00:44:35.607' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (27, CAST(N'2025-04-28T00:47:25.343' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (28, CAST(N'2025-04-28T00:47:47.353' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (29, CAST(N'2025-04-28T00:50:08.847' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (30, CAST(N'2025-04-28T00:55:07.457' AS DateTime), CAST(99000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (31, CAST(N'2025-04-28T00:56:26.467' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (32, CAST(N'2025-04-28T01:10:06.590' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (33, CAST(N'2025-04-28T01:29:14.390' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (34, CAST(N'2025-04-28T01:29:27.573' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (35, CAST(N'2025-04-28T01:31:09.393' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (36, CAST(N'2025-04-28T01:32:07.077' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Paid', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (37, CAST(N'2025-04-28T01:40:04.933' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (38, CAST(N'2025-04-28T01:51:15.917' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (39, CAST(N'2025-04-28T01:51:26.213' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (40, CAST(N'2025-04-28T01:53:45.180' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (41, CAST(N'2025-04-28T01:53:45.567' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (42, CAST(N'2025-04-28T01:53:56.873' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (43, CAST(N'2025-04-28T01:55:10.207' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (44, CAST(N'2025-04-28T01:55:14.713' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (45, CAST(N'2025-04-28T01:56:23.050' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (46, CAST(N'2025-04-28T01:56:27.807' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (47, CAST(N'2025-04-28T01:56:56.870' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (48, CAST(N'2025-04-28T01:57:27.740' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (49, CAST(N'2025-04-28T01:58:43.163' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Paid', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (50, CAST(N'2025-04-28T02:02:24.080' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Paid', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (51, CAST(N'2025-04-28T02:05:39.130' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (52, CAST(N'2025-04-28T02:05:41.927' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Paid', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (53, CAST(N'2025-04-28T02:07:34.547' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (54, CAST(N'2025-04-28T02:07:48.063' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Paid', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (55, CAST(N'2025-04-28T02:10:44.597' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (56, CAST(N'2025-04-28T02:16:40.357' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (57, CAST(N'2025-04-28T02:16:43.413' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Paid', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (58, CAST(N'2025-04-28T02:21:42.660' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Paid', 8)
GO
INSERT [dbo].[Orders] ([OrderID], [DateTime], [TotalPrice], [Status], [UserID]) VALUES (59, CAST(N'2025-04-28T02:34:29.360' AS DateTime), CAST(149000.00 AS Decimal(10, 2)), N'Pending', 8)
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductAddOns] ON 
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID], [AddOnPrice], [AddOnQuantity], [IsOptional]) VALUES (3, 20, 21, CAST(10000.00 AS Decimal(18, 2)), 1, 1)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID], [AddOnPrice], [AddOnQuantity], [IsOptional]) VALUES (4, 20, 22, CAST(8000.00 AS Decimal(18, 2)), 1, 1)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID], [AddOnPrice], [AddOnQuantity], [IsOptional]) VALUES (5, 20, 23, CAST(5000.00 AS Decimal(18, 2)), 1, 1)
GO
SET IDENTITY_INSERT [dbo].[ProductAddOns] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (7, 13, N'https://fullofplants.com/wp-content/uploads/2023/10/how-to-make-vegan-bun-rieu-chay-vietnamese-crab-noodle-soup-thumb.jpg')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (8, 14, N'https://images.unsplash.com/photo-1511910849309-0dffb8785146?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGhvfGVufDB8fDB8fHww')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (16, 20, N'https://file.hstatic.net/1000394081/article/lau-thai_2aedea543c194e93948def3c260e8eb9.jpg')
GO
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL]) VALUES (17, 20, N'https://maythucphamgoma.vn/wp-content/uploads/2024/10/thai-tc1-4-6ng.png')
GO
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductPrices] ON 
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (13, CAST(50000.00 AS Decimal(10, 2)), 100, 13)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (14, CAST(49000.00 AS Decimal(10, 2)), 0, 14)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (19, CAST(150000.00 AS Decimal(10, 2)), 1, 20)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (20, CAST(10000.00 AS Decimal(10, 2)), 1, 21)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (21, CAST(8000.00 AS Decimal(10, 2)), 1, 22)
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [Price], [Quantity], [ProductID]) VALUES (22, CAST(5000.00 AS Decimal(10, 2)), 1, 23)
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
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (21, N'Bò viên', N'Topping', N'Bò viên dai tươi ngon', NULL, 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (22, N'Nấm kim châm', N'Topping', N'Nấm tươi ngon', NULL, 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Type], [Description], [ImageURL], [IsDelete]) VALUES (23, N'Trứng gà', N'Topping', N'Trứng gà ta', NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
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
/****** Object:  Index [UQ__Discount__A25C5AA775894E3C]    Script Date: 05-May-25 5:44:17 PM ******/
ALTER TABLE [dbo].[Discount] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B6160496FC8C3]    Script Date: 05-May-25 5:44:17 PM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534737981D5]    Script Date: 05-May-25 5:44:17 PM ******/
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
ALTER TABLE [dbo].[ProductAddOns] ADD  DEFAULT ((1)) FOR [AddOnQuantity]
GO
ALTER TABLE [dbo].[ProductAddOns] ADD  DEFAULT ((1)) FOR [IsOptional]
GO
ALTER TABLE [dbo].[ProductSales] ADD  CONSTRAINT [DF__ProductSa__Creat__5EBF139D]  DEFAULT (getdate()) FOR [CreatedAt]
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
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD CHECK  (([DiscountType]='FixedAmount' OR [DiscountType]='Percentage'))
GO
ALTER TABLE [dbo].[ProductAddOns]  WITH CHECK ADD  CONSTRAINT [CHK_ProductAddOns_NoSelfReference] CHECK  (([ProductID]<>[AddOnProductID]))
GO
ALTER TABLE [dbo].[ProductAddOns] CHECK CONSTRAINT [CHK_ProductAddOns_NoSelfReference]
GO
USE [master]
GO
ALTER DATABASE [Demo_3] SET  READ_WRITE 
GO
