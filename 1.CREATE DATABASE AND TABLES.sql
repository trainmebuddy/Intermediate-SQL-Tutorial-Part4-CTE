USE [master]
GO
/****** Object:  Database [MyStoreDB]    Script Date: 3/31/2023 9:58:07 AM ******/
CREATE DATABASE [MyStoreDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyStoreDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MyStoreDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyStoreDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MyStoreDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MyStoreDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyStoreDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyStoreDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyStoreDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyStoreDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyStoreDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyStoreDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyStoreDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyStoreDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyStoreDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyStoreDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyStoreDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyStoreDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyStoreDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyStoreDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyStoreDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyStoreDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MyStoreDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyStoreDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyStoreDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyStoreDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyStoreDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyStoreDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyStoreDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyStoreDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MyStoreDB] SET  MULTI_USER 
GO
ALTER DATABASE [MyStoreDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyStoreDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyStoreDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyStoreDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MyStoreDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MyStoreDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyStoreDB', N'ON'
GO
ALTER DATABASE [MyStoreDB] SET QUERY_STORE = OFF
GO
USE [MyStoreDB]
GO
/****** Object:  Table [dbo].[AverageSalaryByDept]    Script Date: 3/31/2023 9:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AverageSalaryByDept](
	[DepartmentID] [int] NULL,
	[DepartmentName] [varchar](50) NULL,
	[AvgSalary] [decimal](38, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/31/2023 9:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Street] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[ZipCode] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 3/31/2023 9:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] NULL,
	[DepartmentName] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 3/31/2023 9:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](25) NULL,
	[Active] [int] NULL,
	[StoreID] [int] NULL,
	[ManagerID] [int] NULL,
	[Salary] [decimal](10, 2) NULL,
	[SalaryType] [char](1) NULL,
	[DepartmentID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/31/2023 9:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] NULL,
	[ProductName] [varchar](50) NULL,
	[ProductCategory] [varchar](50) NULL,
	[ItemPrice] [decimal](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 3/31/2023 9:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[InvoiceID] [int] NULL,
	[CustomerID] [int] NULL,
	[SalesDate] [date] NULL,
	[StoreID] [int] NULL,
	[EmployeeID] [int] NULL,
	[SalesAmount] [decimal](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesDetails]    Script Date: 3/31/2023 9:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesDetails](
	[InvoiceID] [int] NULL,
	[LineID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[ItemPrice] [decimal](10, 2) NULL,
	[Discount] [decimal](10, 2) NULL,
	[LineTotal] [decimal](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store]    Script Date: 3/31/2023 9:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[StoreID] [nvarchar](50) NULL,
	[StoreName] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Street] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[ZipCode] [varchar](10) NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [MyStoreDB] SET  READ_WRITE 
GO
