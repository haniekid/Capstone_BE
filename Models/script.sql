USE [master]
GO
/****** Object:  Database [Demo_3]    Script Date: 07-May-25 6:00:09 PM ******/
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
/****** Object:  Table [dbo].[Discount]    Script Date: 07-May-25 6:00:09 PM ******/
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
/****** Object:  Table [dbo].[OrderItems]    Script Date: 07-May-25 6:00:10 PM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 07-May-25 6:00:10 PM ******/
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
	[DiscountID] [int] NOT NULL,
 CONSTRAINT [PK__Orders__C3905BAFDF6C44B7] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductAddOns]    Script Date: 07-May-25 6:00:10 PM ******/
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
/****** Object:  Table [dbo].[ProductImages]    Script Date: 07-May-25 6:00:10 PM ******/
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
/****** Object:  Table [dbo].[ProductPrices]    Script Date: 07-May-25 6:00:10 PM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 07-May-25 6:00:10 PM ******/
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
/****** Object:  Table [dbo].[ProductSales]    Script Date: 07-May-25 6:00:10 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 07-May-25 6:00:10 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 07-May-25 6:00:10 PM ******/
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
	[ResetPasswordToken] [nvarchar](100) NULL,
	[ResetTokenExpiry] [datetime] NULL,
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
SET IDENTITY_INSERT [dbo].[Discount] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductAddOns] ON 
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (3, 20, 21)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (4, 20, 22)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (6, 14, 23)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (8, 20, 24)
GO
INSERT [dbo].[ProductAddOns] ([ProductAddOnID], [ProductID], [AddOnProductID]) VALUES (9, 20, 23)
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
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (5, N'ad', N'ad', N'admin@gmail.com', N'123123123', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'111', N'11', N'11', 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (8, N'ha', N'ha', N'anh2001httttt@gmail.com', N'0123456789', N'5nbRh/kGr7sOfL+N1ufteWKc7fsdJsHm0Mw1GZ3eSwg=', N'string', N'string', N'123123', 2, N'', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (10, N'ha', N'ha', N'anh2001htttt12t@gmail.com', N'0123456789', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'123123', 2, N'fb558a75-3d4d-40ae-b7a4-d87668ef1add', 0, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (11, N'Nguyen', N'Anh', N'admin12@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'98c3cd65-629b-4df0-ad64-68984a2dc938', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (12, N'Nguyen', N'Anh', N'admin123@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'63abd2ab-ce0d-4a39-a353-f3de7ffbdaa9', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (13, N'Nguyen', N'Anh', N'admin1234@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'5cb25354-a029-4036-a615-8892b1e6a899', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (14, N'123', N'123', N'12admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'71224243-5eb7-4beb-aa2f-3415d152c245', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (17, N'123', N'123', N'122admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'b59ef008-a101-43e3-b621-e1ffd0a26264', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (18, N'123', N'123', N'1212admin@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'516fc55f-5c2c-4075-93d2-88713d5f26aa', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (19, N'Nguyen', N'Anh', N'121212in@gmail.com', N'0944924978', N'uCK7k5Bam9izoMCBaMQnaWQ2z4vzftSrjr9BoHZC7Rw=', N'string', N'string', N'string', 2, N'4836a57d-1596-4896-a11f-a96ee22be46c', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (20, N'123123123', N'123123', N'ad231231min@gmail.com', N'0944924978', N'PhHpc+yAvoMlMPeSLhCxmtQAXCfNBjPGe+hTyqv/+S0=', N'string', N'string', N'string', 2, N'bd5a388e-1476-4b37-94b1-0e831b4b7220', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (21, N'Nguyen', N'Anh', N'anh2001htttt@gmail.com', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'24131655-f5a1-4c32-9108-8c1d671c5521', 1, NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [Phone], [PasswordHash], [Address], [City], [PostalCode], [RoleID], [ActivationToken], [IsActivated], [ResetPasswordToken], [ResetTokenExpiry]) VALUES (29, N'Nguyen', N'Anh', N'anhnhhe153131@fpt.edu.vn', N'0944924978', N'ky88G1YlfOhTmsJp16q0JVDaz4gY0HXwvfGZBWKq4+8=', N'string', N'string', N'string', 2, N'', 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Discount__A25C5AA775894E3C]    Script Date: 07-May-25 6:00:10 PM ******/
ALTER TABLE [dbo].[Discount] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B6160496FC8C3]    Script Date: 07-May-25 6:00:10 PM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534737981D5]    Script Date: 07-May-25 6:00:10 PM ******/
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
ALTER TABLE [dbo].[ProductSales] ADD  CONSTRAINT [DF__ProductSa__Creat__5EBF139D]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK__OrderItem__Order__5FB337D6] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK__OrderItem__Order__5FB337D6]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([ProductPriceID])
REFERENCES [dbo].[ProductPrices] ([ProductPriceID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__UserID__619B8048] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__UserID__619B8048]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Discount] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[Discount] ([DiscountId])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Discount]
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
