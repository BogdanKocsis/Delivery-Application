USE [master]
GO
/****** Object:  Database [food]    Script Date: 23/05/2020 08:38:56 ******/
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
ALTER DATABASE [food] SET RECOVERY SIMPLE 
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
/****** Object:  Table [dbo].[Allergens]    Script Date: 23/05/2020 08:38:56 ******/
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
/****** Object:  Table [dbo].[Basket]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Basket](
	[IDOrder] [int] NOT NULL,
	[NameProduc_Menu] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Basket] PRIMARY KEY CLUSTERED 
(
	[IDOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[IDCategory] [numeric](5, 0) NOT NULL,
	[Name] [varchar](30) NOT NULL,
 CONSTRAINT [PK__kategori__749DC5C873D41026] PRIMARY KEY CLUSTERED 
(
	[IDCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 23/05/2020 08:38:56 ******/
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
/****** Object:  Table [dbo].[Menu_Product]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu_Product](
	[IDMenu] [int] NOT NULL,
	[IDProduct] [int] NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[IDOrder] [int] IDENTITY(1,1) NOT NULL,
	[IDUser] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[Total] [float] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[IDOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 23/05/2020 08:38:56 ******/
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
/****** Object:  Table [dbo].[Product_Allergen]    Script Date: 23/05/2020 08:38:56 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 23/05/2020 08:38:56 ******/
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
/****** Object:  Table [dbo].[variasi]    Script Date: 23/05/2020 08:38:56 ******/
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
/****** Object:  Table [dbo].[warung]    Script Date: 23/05/2020 08:38:56 ******/
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
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[Basket]  WITH CHECK ADD FOREIGN KEY([IDOrder])
REFERENCES [dbo].[Orders] ([IDOrder])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([IDUser])
REFERENCES [dbo].[Users] ([IDUser])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Product__IDCateg__72C60C4A] FOREIGN KEY([IDCategory])
REFERENCES [dbo].[Category] ([IDCategory])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Product__IDCateg__72C60C4A]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Product__IDCateg__75A278F5] FOREIGN KEY([IDCategory])
REFERENCES [dbo].[Category] ([IDCategory])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Product__IDCateg__75A278F5]
GO
ALTER TABLE [dbo].[Product_Allergen]  WITH CHECK ADD FOREIGN KEY([IDAllergen])
REFERENCES [dbo].[Allergens] ([IDAllergen])
GO
ALTER TABLE [dbo].[Product_Allergen]  WITH CHECK ADD FOREIGN KEY([IDProduct])
REFERENCES [dbo].[Product] ([IDProduct])
GO
ALTER TABLE [dbo].[variasi]  WITH CHECK ADD  CONSTRAINT [FK__variasi__id_menu__3F466844] FOREIGN KEY([id_menu])
REFERENCES [dbo].[Product] ([IDProduct])
GO
ALTER TABLE [dbo].[variasi] CHECK CONSTRAINT [FK__variasi__id_menu__3F466844]
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddUser]
@name nvarchar(50), @phoneNo nvarchar(50), @address nvarchar(50), @email nvarchar(50), @password nvarchar(50)
AS
insert into Users (Name, PhoneNo,Address,Email,Password) values (@name,@phoneNo,@address,@email,@password);
GO
/****** Object:  StoredProcedure [dbo].[GetAllergens]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetAllergens]
@IDProduct int
AS
SELECT Allergens.Name from Allergens INNER JOIN Product_Allergen on Allergens.IDAllergen= Product_Allergen.IDAllergen INNER JOIN Product on Product_Allergen.IDProduct=Product.IDProduct where Product.IDProduct=@IDProduct;
GO
/****** Object:  StoredProcedure [dbo].[GetCategories]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetCategories]
AS
SELECT * FROM Category
GO
/****** Object:  StoredProcedure [dbo].[GetMealPrice_Quantity]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetMealPrice_Quantity]
@IDMenu int
AS
SELECT Product.Price, Product.Meal_Quantity from Product left join Menu_Product on Product.IDProduct = Menu_Product.IDProduct where IDMenu = @IDMenu;
GO
/****** Object:  StoredProcedure [dbo].[GetMenu]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetMenu]
@IDCategory int
AS
SELECT * from Product where IDCategory = @IDCategory
GO
/****** Object:  StoredProcedure [dbo].[GetMenuWithSearch]    Script Date: 23/05/2020 08:38:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProductWithoutAllergen]    Script Date: 23/05/2020 08:38:56 ******/
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
/****** Object:  StoredProcedure [dbo].[LogIn]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[LogIn]
@Username nvarchar(50), @Password nvarchar(50)
AS
SELECT COUNT(1) from Users Where Email=@Username AND Password=@Password;
GO
/****** Object:  StoredProcedure [dbo].[SelectDetailProduct]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SelectDetailProduct]
@IDProduct int
AS
SELECT m.*, c.Name [Category] from Product m JOIN Category c on m.IDCategory = c.IDCategory where IDProduct = @IDProduct;
GO
/****** Object:  StoredProcedure [dbo].[SetAllergens]    Script Date: 23/05/2020 08:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SetAllergens]
@IDMenu int,  @allergens nvarchar(50)	
AS
UPDATE Product set  Allergens=@allergens where IDProduct = @IDMenu;
GO
USE [master]
GO
ALTER DATABASE [food] SET  READ_WRITE 
GO
