USE [master]
GO
/****** Object:  Database [food]    Script Date: 28/05/2020 20:37:33 ******/
CREATE DATABASE [food]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'food', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\food.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'food_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\food_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [food] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [food].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [food] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [food] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [food] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [food] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [food] SET ARITHABORT OFF 
GO
ALTER DATABASE [food] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [food] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [food] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [food] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [food] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [food] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [food] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [food] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [food] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [food] SET  DISABLE_BROKER 
GO
ALTER DATABASE [food] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [food] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [food] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [food] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [food] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [food] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [food] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [food] SET RECOVERY FULL 
GO
ALTER DATABASE [food] SET  MULTI_USER 
GO
ALTER DATABASE [food] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [food] SET DB_CHAINING OFF 
GO
ALTER DATABASE [food] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [food] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [food] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [food] SET QUERY_STORE = OFF
GO
USE [food]
GO
/****** Object:  Table [dbo].[Allergens]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Allergens](
	[IDAllergen] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Allergens] PRIMARY KEY CLUSTERED 
(
	[IDAllergen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Basket]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Basket](
	[IDOrder] [int] NOT NULL,
	[IDProduct_Menu] [int] NOT NULL,
	[Quantity] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[IDCategory] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
 CONSTRAINT [PK__kategori__749DC5C873D41026] PRIMARY KEY CLUSTERED 
(
	[IDCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[IDMenu] [int] IDENTITY(1,1) NOT NULL,
	[IDCategory] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Price] [float] NOT NULL,
	[ImagePath] [nvarchar](50) NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[IDMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu_Product]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu_Product](
	[IDMenu] [int] NOT NULL,
	[IDProduct] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[IDOrder] [int] IDENTITY(1,1) NOT NULL,
	[IDUser] [int] NOT NULL,
	[OrderDate] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[Total] [float] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[IDOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[IDProduct] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[ImagePath] [varchar](100) NOT NULL,
	[Description] [text] NOT NULL,
	[Price] [numeric](6, 0) NULL,
	[Total_Quantity] [numeric](5, 0) NULL,
	[Portion_Quantity] [numeric](5, 0) NULL,
	[IDCategory] [numeric](5, 0) NOT NULL,
	[Meal_Quantity] [varchar](50) NULL,
	[Allergens] [nvarchar](50) NULL,
 CONSTRAINT [PK__menu__68A1D9DB8D65BC00] PRIMARY KEY CLUSTERED 
(
	[IDProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Allergen]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Allergen](
	[IDProduct] [int] NOT NULL,
	[IDAllergen] [int] NOT NULL,
 CONSTRAINT [PK_Product_Allergen] PRIMARY KEY CLUSTERED 
(
	[IDProduct] ASC,
	[IDAllergen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[IDUser] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[PhoneNo] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[IsAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[variasi]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[variasi](
	[id_variasi] [numeric](5, 0) NOT NULL,
	[nama] [varchar](30) NOT NULL,
	[keterangan] [text] NOT NULL,
	[harga_tambahan] [numeric](7, 0) NOT NULL,
	[id_menu] [int] NULL,
 CONSTRAINT [PK__variasi__0B24FE084D285862] PRIMARY KEY CLUSTERED 
(
	[id_variasi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[warung]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[warung](
	[id_warung] [numeric](5, 0) NOT NULL,
	[nama] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_warung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Allergens] ON 

INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (1, N'Celery')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (2, N'Gluten')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (3, N'Crustaceans')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (4, N'Eggs')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (5, N'Fish')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (6, N'Milk')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (7, N'Molluscs')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (8, N'Mustard')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (9, N'Nuts')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (10, N'Peanuts')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (11, N'Sesame Seeds')
INSERT [dbo].[Allergens] ([IDAllergen], [Name]) VALUES (12, N'Soya')
SET IDENTITY_INSERT [dbo].[Allergens] OFF
GO
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (42, 5, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (30, 48, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (34, 37, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (34, 39, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (34, 38, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (35, 43, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (35, 6, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (35, 7, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (36, 3, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (37, 4, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (38, 13, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (38, 14, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (39, 57, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (40, 4, 1)
INSERT [dbo].[Basket] ([IDOrder], [IDProduct_Menu], [Quantity]) VALUES (41, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([IDCategory], [Name]) VALUES (CAST(1 AS Numeric(5, 0)), N'Noodles')
INSERT [dbo].[Category] ([IDCategory], [Name]) VALUES (CAST(2 AS Numeric(5, 0)), N'Snack')
INSERT [dbo].[Category] ([IDCategory], [Name]) VALUES (CAST(3 AS Numeric(5, 0)), N'Soup')
INSERT [dbo].[Category] ([IDCategory], [Name]) VALUES (CAST(4 AS Numeric(5, 0)), N'Rice')
INSERT [dbo].[Category] ([IDCategory], [Name]) VALUES (CAST(5 AS Numeric(5, 0)), N'Dessert')
INSERT [dbo].[Category] ([IDCategory], [Name]) VALUES (CAST(6 AS Numeric(5, 0)), N'Drinks')
INSERT [dbo].[Category] ([IDCategory], [Name]) VALUES (CAST(7 AS Numeric(5, 0)), N'Menu')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([IDMenu], [IDCategory], [Name], [Price], [ImagePath]) VALUES (1, 1, N'Menu 1', 25, N'img.png')
INSERT [dbo].[Menu] ([IDMenu], [IDCategory], [Name], [Price], [ImagePath]) VALUES (2, 1, N'Menu 2', 30, N'img.png')
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO
INSERT [dbo].[Menu_Product] ([IDMenu], [IDProduct]) VALUES (47, 1)
INSERT [dbo].[Menu_Product] ([IDMenu], [IDProduct]) VALUES (47, 2)
INSERT [dbo].[Menu_Product] ([IDMenu], [IDProduct]) VALUES (57, 19)
INSERT [dbo].[Menu_Product] ([IDMenu], [IDProduct]) VALUES (57, 36)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (30, 1010, N'2020-05-26 11:44:43', N'Delivered', N'cash', 21600)
INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (34, 1, N'2020-05-27 17:40:29', N'Delivered', N'cash', 15)
INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (35, 1, N'2020-05-27 17:40:49', N'Registered', N'cash', 30030)
INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (36, 1, N'2020-05-27 17:42:20', N'Registered', N'cash', 15000)
INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (37, 1, N'2020-05-27 17:42:37', N'Registered', N'cash', 15000)
INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (38, 1, N'2020-05-27 17:42:53', N'Delivered', N'cash', 15)
INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (39, 1, N'2020-05-28 13:40:44', N'Delivered', N'cash', 15)
INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (40, 1, N'2020-05-28 14:12:42', N'Inregistrata', N'e-money', 15000)
INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (41, 1, N'2020-05-28 15:21:18', N'Inregistrata', N'cash', 15000)
INSERT [dbo].[Orders] ([IDOrder], [IDUser], [OrderDate], [Status], [PaymentMethod], [Total]) VALUES (42, 1, N'2020-05-28 15:33:19', N'Inregistrata', N'e-money', 15000)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (1, N'Nasi Goreng Ayam', N'nasigorengmerah.png', N'Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso', CAST(15000 AS Numeric(6, 0)), CAST(600 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(1 AS Numeric(5, 0)), N'200', N'Gluten,')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (2, N'Mie Ayam', N'mie ayam bakso.png', N'Mie ayam dengan bumbu special, dengan campuran ayam bumbu manis', CAST(10000 AS Numeric(6, 0)), CAST(1350 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(1 AS Numeric(5, 0)), N'200', N' Fish,')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (3, N'Tumis Toge', N'tumis toge.png', N'Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso', CAST(15000 AS Numeric(6, 0)), CAST(1000 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(1 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (4, N'Indomie Goreng', N'indomie goreng.png', N'Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso', CAST(15000 AS Numeric(6, 0)), CAST(1750 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(1 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (5, N'Indomie Rebus', N'indomie rebus.png', N'Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso', CAST(15000 AS Numeric(6, 0)), CAST(1750 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(1 AS Numeric(5, 0)), N'200', N'')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (6, N'Mie Nyemek', N'mie nyemek.png', N'Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso', CAST(15000 AS Numeric(6, 0)), CAST(2250 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(1 AS Numeric(5, 0)), N'200', N'')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (7, N'Mie Seafood', N'mie seafood.png', N'Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso', CAST(15000 AS Numeric(6, 0)), CAST(2250 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(1 AS Numeric(5, 0)), N'200', N'Gluten,Crustaceans,')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (8, N'Es Dawet', N'es dawet.png', N'Va urma', CAST(25 AS Numeric(6, 0)), CAST(2450 AS Numeric(5, 0)), CAST(150 AS Numeric(5, 0)), CAST(6 AS Numeric(5, 0)), N'100', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (10, N'Es Jeruk', N'es jeruk.png', N'va urma', CAST(25 AS Numeric(6, 0)), CAST(2350 AS Numeric(5, 0)), CAST(150 AS Numeric(5, 0)), CAST(6 AS Numeric(5, 0)), N'100', N'')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (12, N'Es Teh', N'es teh.png', N'5', CAST(25 AS Numeric(6, 0)), CAST(2450 AS Numeric(5, 0)), CAST(150 AS Numeric(5, 0)), CAST(6 AS Numeric(5, 0)), N'100', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (13, N'Jahe', N'jahe.png', N'lol', CAST(15 AS Numeric(6, 0)), CAST(1900 AS Numeric(5, 0)), CAST(150 AS Numeric(5, 0)), CAST(6 AS Numeric(5, 0)), N'100', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (14, N'Lemon Tea', N'lemon tea.png', N'lol', CAST(10 AS Numeric(6, 0)), CAST(2100 AS Numeric(5, 0)), CAST(150 AS Numeric(5, 0)), CAST(6 AS Numeric(5, 0)), N'100', N'')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (15, N'Soda Gembira', N'soda gembira.png', N'lol', CAST(20 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(150 AS Numeric(5, 0)), CAST(6 AS Numeric(5, 0)), N'100', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (16, N'Coffee', N'kopi.png', N'lol', CAST(10 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(100 AS Numeric(5, 0)), CAST(6 AS Numeric(5, 0)), N'100', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (17, N'Gethuk', N'gethuk.png', N'lol;', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(100 AS Numeric(5, 0)), CAST(5 AS Numeric(5, 0)), N'100', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (19, N'Milkshake', N'milkshake.png', N'lol', CAST(20 AS Numeric(6, 0)), CAST(4800 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(5 AS Numeric(5, 0)), N'200', N'')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (20, N'Pisang Goreng', N'pisang goreng.png', N'lol', CAST(25 AS Numeric(6, 0)), CAST(2250 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(5 AS Numeric(5, 0)), N'200', N'')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (21, N'Bihun Kuah', N'bihun kuah.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (22, N'Daun Singkong', N'daun singkong.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (23, N'Tomyam', N'tomyam.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (24, N'Terong Tempe', N'terong tempe.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (25, N'Sup Zuppa', N'sup zuppa.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (26, N'Sup Kacang Merah', N'sup kacang merah.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (27, N'Sup Jamur', N'sup jamur.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (28, N'Sup Jagung', N'sup jagung.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (30, N'Sup Ikan', N'sup ikan.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (32, N'Sup buah', N'sup buah.png', N'supa', CAST(15 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(3 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (34, N'Bakso Goreng', N'bakso goreng.png', N'snack', CAST(20 AS Numeric(6, 0)), CAST(2500 AS Numeric(5, 0)), CAST(250 AS Numeric(5, 0)), CAST(2 AS Numeric(5, 0)), N'200', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (36, N'French Fries', N'kentang goreng.png', N'snack', CAST(15 AS Numeric(6, 0)), CAST(2450 AS Numeric(5, 0)), CAST(300 AS Numeric(5, 0)), CAST(2 AS Numeric(5, 0)), N'250', N'')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (38, N'Tahu Bakso', N'tahu bakso.png', N'dessert', CAST(25 AS Numeric(6, 0)), CAST(2600 AS Numeric(5, 0)), CAST(100 AS Numeric(5, 0)), CAST(5 AS Numeric(5, 0)), N'250', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (39, N'Tempe Goreng', N'tempe goreng.png', N'snack', CAST(20 AS Numeric(6, 0)), CAST(2700 AS Numeric(5, 0)), CAST(300 AS Numeric(5, 0)), CAST(2 AS Numeric(5, 0)), N'250', N'')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (41, N'Segogudeg', N'segogudeg.png', N'rice', CAST(25 AS Numeric(6, 0)), CAST(3000 AS Numeric(5, 0)), CAST(300 AS Numeric(5, 0)), CAST(4 AS Numeric(5, 0)), N'250', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (42, N'Segouduk', N'segouduk.png', N'rice', CAST(20 AS Numeric(6, 0)), CAST(3000 AS Numeric(5, 0)), CAST(300 AS Numeric(5, 0)), CAST(4 AS Numeric(5, 0)), N'250', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (43, N'Segogoreng', N'segogoreng.png', N'rice', CAST(30 AS Numeric(6, 0)), CAST(2700 AS Numeric(5, 0)), CAST(300 AS Numeric(5, 0)), CAST(4 AS Numeric(5, 0)), N'250', N'')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (44, N'Segobalap', N'segobalap.png', N'rice', CAST(25 AS Numeric(6, 0)), CAST(3000 AS Numeric(5, 0)), CAST(300 AS Numeric(5, 0)), CAST(4 AS Numeric(5, 0)), N'250', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (47, N'Menu 1', N'img.png', N'a + b', CAST(17600 AS Numeric(6, 0)), CAST(3200 AS Numeric(5, 0)), CAST(0 AS Numeric(5, 0)), CAST(7 AS Numeric(5, 0)), N'200,200,', N' ')
INSERT [dbo].[Product] ([IDProduct], [Name], [ImagePath], [Description], [Price], [Total_Quantity], [Portion_Quantity], [IDCategory], [Meal_Quantity], [Allergens]) VALUES (57, N'Menu 2', N'img.png', N'a+b', CAST(25 AS Numeric(6, 0)), CAST(3550 AS Numeric(5, 0)), CAST(0 AS Numeric(5, 0)), CAST(7 AS Numeric(5, 0)), N'200,250,', N'')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[Product_Allergen] ([IDProduct], [IDAllergen]) VALUES (1, 2)
INSERT [dbo].[Product_Allergen] ([IDProduct], [IDAllergen]) VALUES (2, 5)
INSERT [dbo].[Product_Allergen] ([IDProduct], [IDAllergen]) VALUES (7, 2)
INSERT [dbo].[Product_Allergen] ([IDProduct], [IDAllergen]) VALUES (7, 3)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1, N'Kocsis Bogdan', N'0756687554', N'L.C.Babes Nr.2', N'admin', N'admin', 1)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (2, N'Andrei', N'0756687554', N'Calea Buc', N'andrei@yahoo.com', N'abcd1234', 0)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1002, N'a', N'a', N'a', N'a', N'a', 0)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1003, N'2', N'2', N'2', N'2', N'2', 0)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1004, N'2', N'2', N'2', N'2', N'2', 0)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1005, N'valentin', N'0756687554', N'minervei', N'valentinif@yahoo.com', N'bogdi', 0)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1006, N'ada', N'ada', N'ada', N'ada', N'ada', 0)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1007, N'bogidfy', N'bogidfy', N'bogidfy', N'bogidfy', N'bogidfy', 0)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1008, N'l', N'l', N'l', N'l', N'l', 0)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1009, N'l', N'l', N'l', N'l', N'l', 0)
INSERT [dbo].[Users] ([IDUser], [Name], [PhoneNo], [Address], [Email], [Password], [IsAdmin]) VALUES (1010, N'adi', N'000', N'asda', N'abcd', N'abcd', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
INSERT [dbo].[variasi] ([id_variasi], [nama], [keterangan], [harga_tambahan], [id_menu]) VALUES (CAST(1 AS Numeric(5, 0)), N'extra telur', N'jangan pakai kobis', CAST(3000 AS Numeric(7, 0)), 1)
INSERT [dbo].[variasi] ([id_variasi], [nama], [keterangan], [harga_tambahan], [id_menu]) VALUES (CAST(2 AS Numeric(5, 0)), N'extra bakso', N'jangan pakai sawi', CAST(4000 AS Numeric(7, 0)), 2)
INSERT [dbo].[variasi] ([id_variasi], [nama], [keterangan], [harga_tambahan], [id_menu]) VALUES (CAST(3 AS Numeric(5, 0)), N'extra cabe', N'jangan pakai kobis', CAST(500 AS Numeric(7, 0)), 1)
INSERT [dbo].[variasi] ([id_variasi], [nama], [keterangan], [harga_tambahan], [id_menu]) VALUES (CAST(4 AS Numeric(5, 0)), N'extra ayam', N'jangan pakai saus', CAST(3000 AS Numeric(7, 0)), 2)
GO
INSERT [dbo].[warung] ([id_warung], [nama]) VALUES (CAST(1 AS Numeric(5, 0)), N'Warung Bu Tini')
INSERT [dbo].[warung] ([id_warung], [nama]) VALUES (CAST(2 AS Numeric(5, 0)), N'Warung Pak Jono')
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[Basket]  WITH CHECK ADD FOREIGN KEY([IDOrder])
REFERENCES [dbo].[Orders] ([IDOrder])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Menu_Product]  WITH CHECK ADD FOREIGN KEY([IDMenu])
REFERENCES [dbo].[Product] ([IDProduct])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([IDUser])
REFERENCES [dbo].[Users] ([IDUser])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Product__IDCateg__0169315C] FOREIGN KEY([IDCategory])
REFERENCES [dbo].[Category] ([IDCategory])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Product__IDCateg__0169315C]
GO
ALTER TABLE [dbo].[Product_Allergen]  WITH CHECK ADD FOREIGN KEY([IDAllergen])
REFERENCES [dbo].[Allergens] ([IDAllergen])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Allergen]  WITH CHECK ADD FOREIGN KEY([IDProduct])
REFERENCES [dbo].[Product] ([IDProduct])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[variasi]  WITH CHECK ADD  CONSTRAINT [FK__variasi__id_menu__3F466844] FOREIGN KEY([id_menu])
REFERENCES [dbo].[Product] ([IDProduct])
GO
ALTER TABLE [dbo].[variasi] CHECK CONSTRAINT [FK__variasi__id_menu__3F466844]
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddUser]
@name nvarchar(50), @phoneNo nvarchar(50), @address nvarchar(50), @email nvarchar(50), @password nvarchar(50)
AS
INSERT INTO Users (Name, PhoneNo,Address,Email,Password) VALUES (@name,@phoneNo,@address,@email,@password);
GO
/****** Object:  StoredProcedure [dbo].[CreateMeal]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CreateMeal]
@idmeal int,@name nvarchar(50)
as
insert into Menu_Product select @idmeal,IDProduct from Product where Product.Name=@name;
GO
/****** Object:  StoredProcedure [dbo].[DeleteAllergen]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[DeleteAllergen]
@name nvarchar(50)
as
delete  Allergens where Name =@name;
GO
/****** Object:  StoredProcedure [dbo].[DeleteCategory]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteCategory]
@name nvarchar(50)
as
delete  Category where Name =@name;
GO
/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteOrder]
@idorder int
as
delete Orders  where Orders.IDOrder=@idorder;
GO
/****** Object:  StoredProcedure [dbo].[DeleteProduct]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteProduct]
@name nvarchar(50)
as
delete  Product where Name =@name;
GO
/****** Object:  StoredProcedure [dbo].[GetActiveOrders]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetActiveOrders]
@username nvarchar(50)
as
select * from Orders inner join Users on Orders.IDUser = Users.IDUser where Users.Email=@username and not (Orders.Status = 'Canceled' or  Orders.Status = 'Delivered') order by Orders.OrderDate desc;
GO
/****** Object:  StoredProcedure [dbo].[GetActiveOrdersForAdmin]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetActiveOrdersForAdmin]
as
select * from Orders  where not  (Status = 'Canceled' or Status = 'Delivered') order by OrderDate desc;
GO
/****** Object:  StoredProcedure [dbo].[GetAllergenID]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllergenID]
@name nvarchar(50), @id int output
as
Select @id= IDAllergen from Allergens where Name= @name;
GO
/****** Object:  StoredProcedure [dbo].[GetAllergens]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetAllergens]
@IDProduct int
AS
SELECT Allergens.Name from Allergens INNER JOIN Product_Allergen on Allergens.IDAllergen= Product_Allergen.IDAllergen INNER JOIN Product on Product_Allergen.IDProduct=Product.IDProduct where Product.IDProduct=@IDProduct;
GO
/****** Object:  StoredProcedure [dbo].[GetCategories]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetCategories]
AS
SELECT * FROM Category
GO
/****** Object:  StoredProcedure [dbo].[GetCategory]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetCategory]
@name nvarchar(50), @idcategory int output
as
select @idcategory=IDCategory from Category where Name=@name;
GO
/****** Object:  StoredProcedure [dbo].[GetHistory]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetHistory]
as
select * from Orders  inner join Users on Orders.IDUser = Users.IDUser where (Orders.Status='Canceled' or  Orders.Status='Delivered') order by Orders.OrderDate desc;;
GO
/****** Object:  StoredProcedure [dbo].[GetIDProduct]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetIDProduct]
@name nvarchar(50), @id int output
as
select @id = IDProduct from Product where Name = @name;
GO
/****** Object:  StoredProcedure [dbo].[GetIDUser]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetIDUser]
@name nvarchar(50)
as
select IDUser from Users where Users.Email=@name;
GO
/****** Object:  StoredProcedure [dbo].[GetMealPrice_Quantity]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetMealPrice_Quantity]
@IDMenu int
AS
SELECT Product.Price, Product.Meal_Quantity from Product inner join Menu_Product on Product.IDProduct = Menu_Product.IDProduct where IDMenu = @IDMenu;
GO
/****** Object:  StoredProcedure [dbo].[GetMenu]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetMenu]
@IDCategory int
AS
SELECT * from Product where IDCategory = @IDCategory
GO
/****** Object:  StoredProcedure [dbo].[GetMenuWithSearch]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetMenuWithSearch]
@IDCategory int, @SearchField varchar(20)
AS
SELECT @SearchField = '%'+ RTRIM(@SearchField) + '%';  
SELECT * from Product where IDCategory = @IDCategory AND Product.Name like @SearchField;
GO
/****** Object:  StoredProcedure [dbo].[GetProductFromMenu]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetProductFromMenu]
@IDMenu int
AS
SELECT * from Product inner join Menu_Product on Product.IDProduct = Menu_Product.IDProduct where IDMenu = @IDMenu;
GO
/****** Object:  StoredProcedure [dbo].[GetProducts]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetProducts]
@idorder int
as
select t1.Name, t2.Quantity from Product t1 inner join Basket t2 on t1.IDProduct=t2.IDProduct_Menu  inner join Orders on Orders.IDOrder = t2.IDOrder inner join Users on Users.IDUser= Orders.IDUser where (Orders.IDOrder=@idorder);
;
GO
/****** Object:  StoredProcedure [dbo].[GetProductStock]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetProductStock]
@value int
as
select Name, Total_Quantity from Product where Total_Quantity<=@value;
GO
/****** Object:  StoredProcedure [dbo].[GetProductWithoutAllergen]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetProductWithoutAllergen]
@IDCategory int, @AllergenFiend varchar(20)
AS
SELECT @AllergenFiend = '%'+ RTRIM(@AllergenFiend) + '%';  
SELECT * from Product where IDCategory = @IDCategory AND Product.Allergens not like @AllergenFiend;
GO
/****** Object:  StoredProcedure [dbo].[GetUserHistory]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetUserHistory]
@username nvarchar(50)
as
select * from Orders  inner join Users on Orders.IDUser = Users.IDUser where Users.Email = @username and (Orders.Status  = 'Canceled' or  Orders.Status = 'Delivered');
GO
/****** Object:  StoredProcedure [dbo].[GetUserProducts]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetUserProducts]
@username nvarchar(50), @idorder int
as
select t1.Name, t2.Quantity from Product t1 inner join Basket t2 on t1.IDProduct=t2.IDProduct_Menu  inner join Orders on Orders.IDOrder = t2.IDOrder inner join Users on Users.IDUser= Orders.IDUser where (Users.Email=@username and Orders.IDOrder=@idorder);
;
GO
/****** Object:  StoredProcedure [dbo].[InsertAllergen]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertAllergen]
@name nvarchar(50)
as
insert into Allergens values(@name);
GO
/****** Object:  StoredProcedure [dbo].[InsertCategory]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertCategory]
@name nvarchar(50)
as
insert into Category values(@name);
GO
/****** Object:  StoredProcedure [dbo].[InsertInBasket]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertInBasket]
@iduser int, @idproduct int, @qty int
as
insert into Basket ( IDOrder, IDProduct_Menu, Quantity) values (@iduser, @idproduct, @qty);
GO
/****** Object:  StoredProcedure [dbo].[InsertOrder]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertOrder]
@iduser int, @date nvarchar(50), @status nvarchar(50), @payment nvarchar(50), @total float, @idorder int output
as insert into Orders(IDUser,OrderDate,Status,PaymentMethod,Total) values (@iduser,@date,@status,@payment,@total)
select @idorder = SCOPE_IDENTITY();
GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertProduct]
@name nvarchar(50),@imagepath nvarchar(50),@description nvarchar(50), @price numeric(6,0), @totalqty int, @portionqty int, @category int, @mealqty int, @idproduct int output
as
insert into Product(Name,ImagePath,Description,Price,Total_Quantity,Portion_Quantity,IDCategory,Meal_Quantity) values (@name,@imagepath,@description,@price,@totalqty,@portionqty,@category,@mealqty)
select @idproduct = SCOPE_IDENTITY();;
GO
/****** Object:  StoredProcedure [dbo].[InsertProductAllergen]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertProductAllergen]
@idproduct int, @idallergen int
as
insert into Product_Allergen values(@idproduct, @idallergen);
GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertUser]
@name nvarchar(50), @phoneNo nvarchar(50), @address nvarchar(50), @email nvarchar(50), @password nvarchar(50)
AS
INSERT 	INTO [dbo].[Users] (Name, PhoneNo, Address, Email, Password) values (@name, @phoneNo, @address, @email,@password);
GO
/****** Object:  StoredProcedure [dbo].[LogIn]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[LogIn]
@Username nvarchar(50), @Password nvarchar(50), @isadmin bit output, @isTrue int output
AS
SELECT @isadmin = IsAdmin  from  Users Where Email=@Username AND Password=@Password ;
set @isTrue = @@ROWCOUNT;
GO
/****** Object:  StoredProcedure [dbo].[LoyalUsers]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[LoyalUsers]
@iduser int, @users int output,
@Start date = '2020-05-25 08:00:00' ,
@End date = '2020-05-26 23:59:00'
as
select Orders.OrderDate from Orders where (IDUser=@iduser and convert(date,OrderDate,120) between convert(date,@Start,120) and convert(date,@End,120));
select @users = @@ROWCOUNT;
GO
/****** Object:  StoredProcedure [dbo].[SelectDetailProduct]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SelectDetailProduct]
@IDProduct int
AS
SELECT m.*, c.Name [Category] from Product m JOIN Category c on m.IDCategory = c.IDCategory where IDProduct = @IDProduct;
GO
/****** Object:  StoredProcedure [dbo].[SetAllergens]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SetAllergens]
@IDMenu int,  @allergens nvarchar(50)	
AS
UPDATE Product set  Allergens=@allergens where IDProduct = @IDMenu;
GO
/****** Object:  StoredProcedure [dbo].[SetMealPrice_Quantity]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SetMealPrice_Quantity]
@iditem int, @qty nvarchar(50), @price float
as
update Product set Meal_Quantity = @qty, Price=@price where IDProduct= @iditem;
GO
/****** Object:  StoredProcedure [dbo].[Test]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Test]
as
Select Orders.IDOrder,Orders.IDUser,Orders.OrderDate,Orders.Status,Orders.PaymentMethod,Orders.Total,Users.Name,Users.PhoneNo,Users.Address  from Orders inner join Users on Orders.IDUser = Users.IDUser where (Orders.Status='Canceled' or  Orders.Status='Delivered') order by Orders.OrderDate desc;
GO
/****** Object:  StoredProcedure [dbo].[Test2]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Test2]
as
Select Orders.IDOrder,Orders.IDUser,Orders.OrderDate,Orders.Status,Orders.PaymentMethod,Orders.Total,Users.Name,Users.PhoneNo,Users.Address  from Orders inner join Users on Orders.IDUser = Users.IDUser  where not  (Status = 'Canceled' or Status = 'Delivered') order by OrderDate desc;
GO
/****** Object:  StoredProcedure [dbo].[UpdateMealQuantity]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[UpdateMealQuantity]
@iditem int, @total int
as
update Product set Total_Quantity = Total_Quantity-(@total*Meal_Quantity) where IDProduct=@iditem;
GO
/****** Object:  StoredProcedure [dbo].[UpdatePrice]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdatePrice]
@price float(50), @name nvarchar(50)
as
update Product  set Price= @price where Name = @name;
GO
/****** Object:  StoredProcedure [dbo].[UpdateQuantity]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateQuantity]
@iditem int, @total int
as
update Product set Total_Quantity = Total_Quantity-(@total*Portion_Quantity) where IDProduct=@iditem;
GO
/****** Object:  StoredProcedure [dbo].[UpdateQuantity2]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateQuantity2]
@iditem int, @qty int
as
update Product set Total_Quantity = Total_Quantity-@qty where IDProduct=@iditem;
GO
/****** Object:  StoredProcedure [dbo].[UpdateStatus]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateStatus]
@idorder int, @state nvarchar(50)
as
update Orders set Status=@state where IDOrder=@idorder;
GO
/****** Object:  StoredProcedure [dbo].[UpdateTotalQuantity]    Script Date: 28/05/2020 20:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateTotalQuantity]
@qty int, @name nvarchar(50)
as
update Product  set Total_Quantity = @qty where Name = @name;
GO
USE [master]
GO
ALTER DATABASE [food] SET  READ_WRITE 
GO
